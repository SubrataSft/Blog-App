import 'package:flutter/material.dart';

class CustomAppBar extends StatelessWidget{
  final String title;
  final IconData? leadingIcon;
  final VoidCallback? onPressed;
  final List<Widget>? actions;
  const CustomAppBar({
    super.key,
    required this.title,
    this.leadingIcon,
    this.onPressed,
    this.actions,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 45,
      child: AppBar(
        backgroundColor: Colors.black,
        automaticallyImplyLeading: false,
        title: Stack(
          alignment: Alignment.center,
          children: [
            Text(
              title,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 18,
                color: Colors.white,
              ),
            ),
            if (leadingIcon != null)
              Align(
                alignment: Alignment.centerLeft,
                child: IconButton(
                  icon: Icon(leadingIcon, color: Colors.white),
                  onPressed: onPressed ?? () => Navigator.pop(context),
                ),
              ),
          ],
        ),
        actions: actions,
      ),
    );
  }
}
