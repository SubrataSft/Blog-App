import 'package:blog_apps/presentation/screen/widgets/custom_button.dart';
import 'package:blog_apps/presentation/screen/widgets/custom_textfiled.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../model/provider/provider.dart';
import 'logIn_screen.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final TextEditingController _nameTEController = TextEditingController();
  final TextEditingController _emailTEController = TextEditingController();
  final TextEditingController _phoneTEController = TextEditingController();
  final TextEditingController _passwordTEController = TextEditingController();
  bool _obscurePassword = true;

  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<AuthProvider>(context);

    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        toolbarHeight: 80,
        backgroundColor: Colors.black,
        leading: IconButton(
          onPressed: () {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => LogInScreen()),
            );
          },
          icon: Icon(Icons.arrow_back, color: Colors.white),
        ),
        title: Text(
          "Create Account",
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.settings, color: Colors.white),
          ),
          SizedBox(width: 10),
        ],
      ),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 24),
            Text(
              "Username",
              style: TextStyle(fontSize: 10, color: Colors.white),
            ),
            SizedBox(height: 6),
            CustomTextField(controller: _nameTEController, hintText: "Enter your Name"),
            SizedBox(height: 16),
            Text(
              "Email",
              style: TextStyle(fontSize: 10, color: Colors.white),
            ),
            SizedBox(height: 6),
            CustomTextField(controller: _emailTEController, hintText: "Enter your Email"),
            SizedBox(height: 16),
            Text(
              "Phone",
              style: TextStyle(fontSize: 10, color: Colors.white),
            ),
            SizedBox(height: 6),
            CustomTextField(controller: _phoneTEController, hintText: "Enter your Phone"),
            SizedBox(height: 16),
            Text(
              "Password",
              style: TextStyle(fontSize: 10, color: Colors.white),
            ),
            SizedBox(height: 6),
            CustomTextField(controller: _passwordTEController, hintText: "Enter your Password",
              suffixWidget: IconButton(
                icon: Icon(
                  _obscurePassword
                      ? Icons.visibility_off
                      : Icons.visibility,
                  color: Colors.black,
                ),
                onPressed: () {
                  setState(() {
                    _obscurePassword = !_obscurePassword;
                  });
                },
              ),
            ),
            SizedBox(height: 24),
            CustomButton(
              text: "Register",
              isLoading: authProvider.isLoading,
              onPressed: () async {
                final name = _nameTEController.text.trim();
                final email = _emailTEController.text.trim();
                final password = _passwordTEController.text.trim();
                final phone = _phoneTEController.text.trim();

                if (name.isEmpty || email.isEmpty || password.isEmpty || phone.isEmpty) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text("Please fill all fields")),
                  );
                  return;
                }

                bool success = await authProvider.signUp(
                  name,
                  email,
                  password,
                  phone,
                );

                if (success) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text("Register Successful")),
                  );
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (_) => const LogInScreen()),
                  );
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text("Register Failed")),
                  );
                }
              },
            ),

            SizedBox(height: 16),
            Center(
              child: TextButton(
                onPressed: () {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (_) => const LogInScreen()),
                  );
                },
                child: const Text(
                  "Already have an account? Log In",
                  style: TextStyle(color: Colors.white70),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
