import 'package:flutter/material.dart';
import 'package:mybookstore/bookmark/pages/bookmark_page.dart';
import 'package:mybookstore/home/pages/home_page.dart';
import 'package:mybookstore/profile/pages/profile_page.dart';
import 'package:mybookstore/shared/utils/color_utils.dart';
import 'package:mybookstore/shared/utils/image_path_utils.dart';

class EmployeeNavigationWrapper extends StatefulWidget {
  const EmployeeNavigationWrapper({super.key});

  @override
  State<EmployeeNavigationWrapper> createState() =>
      _EmployeeNavigationWrapperState();
}

class _EmployeeNavigationWrapperState extends State<EmployeeNavigationWrapper> {
  int _currentIndex = 0;

  final List<Widget> _pages = [
    const HomePage(),
    const BookMarkPage(),
    const ProfilePage(),
  ];

  void changePage(index) => setState(() => _currentIndex = index);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_currentIndex],
      extendBody: true,
      bottomSheet: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: changePage,
        backgroundColor: bgColor,
        selectedItemColor: darkColor,
        unselectedItemColor: placeholderColor,
        items: [
          BottomNavigationBarItem(
            icon: Image.asset(
              homeIconImage,
              scale: 2.5,
              color: _currentIndex == 0 ? darkColor : placeholderColor,
            ),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Image.asset(
              bookmarkIconImage,
              scale: 2.5,
              color: _currentIndex == 1 ? darkColor : placeholderColor,
            ),
            label: 'Salvos',
          ),
          BottomNavigationBarItem(
            icon: Image.asset(
              profileIconImage,
              scale: 2.5,
              color: _currentIndex == 2 ? darkColor : placeholderColor,
            ),
            label: 'Meu pefil',
          ),
        ],
      ),
    );
  }
}
