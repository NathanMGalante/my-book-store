import 'package:flutter/material.dart';
import 'package:mybookstore/shared/utils/color_utils.dart';
import 'package:mybookstore/shared/utils/navigation_utils.dart';

class NavigationBar extends StatelessWidget {
  NavigationBar({super.key}) : _routes = getNavigationRoutes();

  final List<NavigationItem> _routes;

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: NavigationController.of(context).currentIndex,
      builder: (context, currentIndex, _) {
        return BottomNavigationBar(
          currentIndex: NavigationController.of(context).currentIndex.value,
          onTap: (newIndex) {
            NavigationController.of(context).changePage(context, newIndex);
          },
          backgroundColor: bgColor,
          selectedItemColor: darkColor,
          unselectedItemColor: placeholderColor,
          items: [
            for (var item in _routes)
              BottomNavigationBarItem(
                label: item.label,
                icon: Image.asset(
                  item.icon,
                  scale: 2.5,
                  color:
                      _routes[currentIndex] == item
                          ? darkColor
                          : placeholderColor,
                ),
              ),
          ],
        );
      },
    );
  }
}
