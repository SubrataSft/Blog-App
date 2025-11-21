import 'package:blog_apps/presentation/screen/widgets/custom_button.dart';
import 'package:blog_apps/presentation/screen/widgets/custom_textfiled.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../model/provider/provider.dart';

class UpDatePassword extends StatefulWidget {
  const UpDatePassword({super.key});

  @override
  State<UpDatePassword> createState() => _UpDatePasswordState();
}

class _UpDatePasswordState extends State<UpDatePassword> {
  final TextEditingController currentPassController = TextEditingController();
  final TextEditingController newPassController = TextEditingController();
  bool _obscureText = true;
  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<AuthProvider>(context, listen: false);
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        toolbarHeight: 80,
        backgroundColor: Colors.black,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(Icons.arrow_back, color: Colors.white),
        ),
        title: Text(
          "UpDate password",
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 120),
            Text(
              "current password",
              style: TextStyle(fontSize: 10, color: Colors.white),
            ),
            SizedBox(height: 6),
            CustomTextField(controller: currentPassController, hintText: "Password",
              obscureText: _obscureText,
              suffixWidget: IconButton(
                onPressed: () => setState(() => _obscureText = !_obscureText),
                icon: Icon(
                  _obscureText ? Icons.visibility_off : Icons.visibility,
                  color: Colors.white70,
                ),
              ),
            ),
            SizedBox(height: 14),
            Text(
              "New password",
              style: TextStyle(fontSize: 10, color: Colors.white),
            ),
            SizedBox(height: 6),
           CustomTextField(controller: newPassController, hintText: "New password",
             obscureText: _obscureText,
             suffixWidget: IconButton(
               onPressed: () => setState(() => _obscureText = !_obscureText),
               icon: Icon(
                 _obscureText ? Icons.visibility_off : Icons.visibility,
                 color: Colors.white70,
               ),
             ),
           ),
            Spacer(),
            CustomButton(text: "Update password",
              onPressed: () async {
                final current = currentPassController.text.trim();
                final newPass = newPassController.text.trim();

                if (current.isEmpty || newPass.isEmpty) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text("Please fill both fields")),
                  );
                  return;
                }
                final response = await authProvider.changePassword(
                  current,
                  newPass,
                );
                if (response["success"] == true) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text("Password updated successfully")),
                  );
                  Navigator.pop(context);
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(
                        response["message"] ?? "Something wrong",
                      ),
                    ),
                  );
                }
              },
            ),
            SizedBox(height: 30,),
          ],
        ),
      ),
    );
  }
}
