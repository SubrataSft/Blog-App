import 'package:blog_apps/presentation/screen/widgets/custom_button.dart';
import 'package:blog_apps/presentation/screen/widgets/custom_textfiled.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../model/provider/provider.dart';

class UpDateProfileScreen extends StatefulWidget {
  const UpDateProfileScreen({super.key});

  @override
  State<UpDateProfileScreen> createState() => _UpDateProfileScreenState();
}

class _UpDateProfileScreenState extends State<UpDateProfileScreen> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController bioController = TextEditingController();

  @override
  void initState() {
    super.initState();
    final auth = Provider.of<AuthProvider>(context, listen: false);
    final user = auth.data;
    nameController.text = user?['name'] ?? "";
    emailController.text = user?['email'] ?? "";
    bioController.text = user?['bio'] ?? "";
  }

  @override
  Widget build(BuildContext context) {
    final auth = Provider.of<AuthProvider>(context);

    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor:  Colors.black,
        leading: IconButton(
          onPressed: () {
            print("BACK PRESSED");
            Navigator.pop(context);
          },
          icon: const Icon(Icons.arrow_back, color: Colors.white),
        ),
        title: Text(
          "Update Profile",
          style: TextStyle(color: Colors.white, fontSize: 18),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          children: [
            SizedBox(height: 40),

            CircleAvatar(radius: 60, backgroundImage: AssetImage("assets/images/Normal_Image.png")),
            SizedBox(height: 40),
            CustomTextField(
              controller: nameController,
              hintText: "Display Name",
            ),
            SizedBox(height: 20),
            CustomTextField(controller: emailController, hintText: "Email"),
            SizedBox(height: 20),
            CustomTextField(controller: bioController, hintText: "Bio",maxLines: 4,
            ),

            Spacer(),

            CustomButton(
              isLoading: auth.isLoading,
              onPressed: () async {
                bool success = await auth.updateProfile(
                  nameController.text.trim(),
                  emailController.text.trim(),
                  bioController.text.trim(),
                );

                if (success) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text("Profile updated successfully!"),
                    ),
                  );
                  Navigator.pop(context);
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text("Failed to update profile.")),
                  );
                }
              },
              text: "Save Changes",
            ),
          ],
        ),
      ),
    );
  }
}
