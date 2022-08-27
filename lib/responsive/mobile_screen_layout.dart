import 'package:flutter/material.dart';
import 'package:flutter_instagram_clone/utils/colors.dart';
import 'package:flutter_instagram_clone/utils/constants.dart';

class MobileScreenLayout extends StatefulWidget {
  const MobileScreenLayout({Key? key}) : super(key: key);

  @override
  State<MobileScreenLayout> createState() => _MobileScreenLayoutState();
}

class _MobileScreenLayoutState extends State<MobileScreenLayout> {
  int pageIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: mobileBackgroundColor,
      bottomNavigationBar: BottomNavigationBar(
        onTap: (index) => setState(() {
          pageIndex = index;
        }),
        showSelectedLabels: false,
        showUnselectedLabels: false,
        backgroundColor: mobileBackgroundColor,
        type: BottomNavigationBarType.fixed,
        selectedItemColor: purpleColor,
        unselectedItemColor: Colors.white,
        currentIndex: pageIndex,
        items: const [
          BottomNavigationBarItem(
              icon: Icon(
                Icons.home,
                size: 30,
              ),
              label: 'Home'),
          BottomNavigationBarItem(
              icon: Icon(
                Icons.search,
                size: 30,
              ),
              label: 'Search'),
          BottomNavigationBarItem(
              icon: Icon(
                Icons.add_circle,
                size: 30,
              ),
              label: 'Add'),
          BottomNavigationBarItem(
              icon: Icon(
                Icons.favorite,
                size: 30,
              ),
              label: ''),
          BottomNavigationBarItem(
              icon: Icon(
                Icons.person,
                size: 30,
              ),
              label: 'Profile'),
        ],
      ),
      body: pages[pageIndex],
    );
  }
}
