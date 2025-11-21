import 'package:blog_apps/presentation/screen/onboarding_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'model/provider/provider.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [ChangeNotifierProvider(create: (_) => AuthProvider())],
      child: BlogApps(),
    ),
  );
}

class BlogApps extends StatefulWidget {
  const BlogApps({super.key});

  @override
  State<BlogApps> createState() => _BlogAppsState();
}

class _BlogAppsState extends State<BlogApps> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: OnBoardingScreen(),
    );
  }
}

