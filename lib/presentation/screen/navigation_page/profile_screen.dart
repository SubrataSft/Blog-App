import 'package:blog_apps/presentation/screen/widgets/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../model/provider/provider.dart';
import '../logIn_screen.dart';
import '../update_password_screen.dart';
import '../update_profile_screen.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() async {
      final authProvider = Provider.of<AuthProvider>(context, listen: false);

      if (authProvider.token != null && authProvider.data == null) {
        await authProvider.showProfile();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<AuthProvider>(context);
    final profileData = authProvider.data;
    final user = profileData?['user'];

    return Scaffold(
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
          "Profile",
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

      backgroundColor: Colors.black,

      body: Column(
        children: [
          authProvider.isLoading
              ? const Center(child: CircularProgressIndicator())
              : user == null
              ? const Center(
                  child: Text(
                    'No profile data found. Please log in',
                    style: TextStyle(color: Colors.white),
                  ),
                )
              : Padding(
                  padding: EdgeInsets.all(16),
                  child: Column(
                    children: [
                      SizedBox(height: 30),
                      const CircleAvatar(
                        radius: 70,
                        backgroundImage: AssetImage(
                          "assets/images/Subrata.png",
                        ),
                      ),
                      SizedBox(height: 20),
                      Text(
                        user['name'] ?? "No User",
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                      SizedBox(height: 10),
                      Text(
                        user['email'] ?? "No Email",
                        style: const TextStyle(
                          fontSize: 16,
                          color: Colors.white70,
                        ),
                      ),
                      SizedBox(height: 10),
                      Text(
                        user['phone'] ?? "No Bio",
                        style: const TextStyle(
                          fontSize: 16,
                          color: Colors.white70,
                        ),
                      ),
                      SizedBox(height: 40),
                      ListTile(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => UpDateProfileScreen(),
                            ),
                          );
                        },
                        leading: Icon(
                          Icons.edit,
                          color: Colors.white,
                          size: 30,
                        ),
                        title: Text(
                          "Edit Profile",
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.brown,
                          ),
                        ),
                      ),
                      SizedBox(height: 10),
                      ListTile(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => UpDatePassword(),
                            ),
                          );
                        },
                        leading: Icon(
                          Icons.lock,
                          color: Colors.white,
                          size: 30,
                        ),
                        title: Text(
                          "Change Password",
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.brown,
                          ),
                        ),
                      ),
                      SizedBox(height: 20),
                    ],
                  ),
                ),
          Spacer(),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: CustomButton(
              text: "Logout",
              isLoading: authProvider.isLoading,
              backgroundColor: Colors.grey,
              onPressed: () async {
                bool Success = await authProvider.logout();

                if (Success) {
                  Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(builder: (context) => LogInScreen()),
                    (route) => false,
                  );
                } else {
                  ScaffoldMessenger.of(
                    context,
                  ).showSnackBar(SnackBar(content: Text("Logout failed")));
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}
