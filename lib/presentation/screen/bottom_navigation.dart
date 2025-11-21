import 'package:flutter/material.dart';
import 'navigation_page/home_screen.dart';
import 'navigation_page/book_marks_screen.dart';
import 'navigation_page/profile_screen.dart';

class BottomNavBarScreen extends StatefulWidget {
  const BottomNavBarScreen({super.key});

  @override
  State<BottomNavBarScreen> createState() => _BottomNavBarScreenState();
}

class _BottomNavBarScreenState extends State<BottomNavBarScreen> {
  int selectedIndex = 0;
  List<Widget> _page = [BlogScreen(), BookMarkScreen(), ProfileScreen()];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _page[selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.black,
        selectedItemColor: Colors.green,
        unselectedItemColor: Colors.brown,
        currentIndex: selectedIndex,
        onTap: (index) {
          setState(() {
            selectedIndex = index;
          });
        },
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.home_filled, color: Colors.grey, size: 30),
            label: "Blog",
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.bookmark_add_outlined,
              color: Colors.grey,
              size: 30,
            ),
            label: "BookMarks",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person, color: Colors.grey, size: 30),
            label: "Profile",
          ),
        ],
      ),
    );
  }
}
