import 'package:blog_apps/presentation/screen/register_screen.dart';
import 'package:blog_apps/presentation/screen/widgets/custom_appbar.dart';
import 'package:blog_apps/presentation/screen/widgets/custom_button.dart';
import 'package:blog_apps/presentation/screen/widgets/custom_textfiled.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../model/provider/provider.dart';
import 'bottom_navigation.dart';

class LogInScreen extends StatefulWidget {
  const LogInScreen({super.key});

  @override
  State<LogInScreen> createState() => _LogInScreenState();
}

class _LogInScreenState extends State<LogInScreen> {
  final TextEditingController _emailTEController = TextEditingController();
  final TextEditingController _passwordTEController = TextEditingController();
  bool _obscurePassword = true;


  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<AuthProvider>(context);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Text(
          "Log In",
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        centerTitle: true,
      ),
      backgroundColor: Colors.black,
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(height: 40),
              Text(
                'Welcome Back!',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              SizedBox(height: 24),
             CustomTextField(controller: _emailTEController, hintText: "email"),
              SizedBox(height: 16),
              CustomTextField(controller: _passwordTEController, hintText: "password",
               obscureText: _obscurePassword,

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
                text: "Login",
                isLoading: authProvider.isLoading,
                onPressed: () async {
                  final email = _emailTEController.text.trim();
                  final password = _passwordTEController.text.trim();

                  if (email.isEmpty || password.isEmpty) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text("Please fill all fields")),
                    );
                    return;
                  }

                  bool success = await authProvider.login(email, password);

                  if (success) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text("Login Successful")),
                    );
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (_) => const BottomNavBarScreen(),
                      ),
                    );
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text("Login Failed")),
                    );
                  }
                },
              ),


             Spacer(),

              Text(
                "Don't have an account?",
                style: TextStyle(fontSize: 14, color: Colors.white70),
              ),

              TextButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const RegisterScreen(),
                    ),
                  );
                },
                child: Text(
                  "Sign Up",
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w700,
                    color: Colors.brown,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
