import 'package:flutter/material.dart';
import 'package:mybookstore/auth/controller.dart';
import 'package:mybookstore/book_edit/pages/book_edit_page.dart';
import 'package:mybookstore/bookmark/pages/bookmark_page.dart';
import 'package:mybookstore/employee/pages/employee_page.dart';
import 'package:mybookstore/home/pages/home_page.dart';
import 'package:mybookstore/profile/pages/profile_page.dart';
import 'package:mybookstore/shared/utils/color_utils.dart';
import 'package:mybookstore/shared/utils/image_path_utils.dart';

class AdminNavigationWrapper extends StatefulWidget {
  const AdminNavigationWrapper({super.key});

  @override
  State<AdminNavigationWrapper> createState() => _AdminNavigationWrapperState();
}

class _AdminNavigationWrapperState extends State<AdminNavigationWrapper> {
  int _currentIndex = 0;

  final List<Widget> _pages = [
    const HomePage(),
    const EmployeePage(),
    const ProfilePage(),
    const BookEditPage(),
  ];

  void changePage(index) => setState(() => _currentIndex = index);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_currentIndex],
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
              searchIconImage,
              scale: 2.5,
              color: _currentIndex == 1 ? darkColor : placeholderColor,
            ),
            label: 'Funcionários',
          ),
          BottomNavigationBarItem(
            icon: Image.asset(
              scrollIconImage,
              scale: 2.5,
              color: _currentIndex == 3 ? darkColor : placeholderColor,
            ),
            label: 'Biblioteca',
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
