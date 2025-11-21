import 'package:blog_apps/presentation/screen/widgets/custom_button.dart';
import 'package:flutter/material.dart';
import 'logIn_screen.dart';

class OnBoardingScreen extends StatefulWidget {
  const OnBoardingScreen({super.key});

  @override
  State<OnBoardingScreen> createState() => _OnBoardingScreenState();
}

class _OnBoardingScreenState extends State<OnBoardingScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(
            height: 320,
            width: double.infinity,
            child: Image.asset('assets/images/Depth.png', fit: BoxFit.cover),
          ),
          SizedBox(height: 16),
          Expanded(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                children: [
                  Text(
                    'Welcome to Your Personal\nBlog Space',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w700,
                      color: Colors.white,
                    ),
                  ),
                  SizedBox(height: 12),
                  Text(
                    'Discover articles, save your favorites, and engage\nwith the community.',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.white.withOpacity(0.85),
                      fontSize: 12,
                      height: 1.35,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  Spacer(),
                  CustomButton(
                    text: "Get Start",
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => LogInScreen()),
                      );
                    },
                  ),
                  SizedBox(height: 30,),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
