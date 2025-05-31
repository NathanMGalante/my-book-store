import 'package:flutter/material.dart';
import 'package:mybookstore/shared/utils/color_utils.dart';
import 'package:mybookstore/shared/utils/navigation_utils.dart';

class NavigationWrapper extends StatelessWidget {
  NavigationWrapper({super.key}) : _routes = getNavigationRoutes();

  final List<NavigationItem> _routes;

  @override
  Widget build(BuildContext context) {
    debugPrint('NavigationWrapper');
    return ValueListenableBuilder(
      valueListenable: NavigationController.of(context).currentIndex,
      builder: (context, currentIndex, _) {
        return WillPopScope(
          onWillPop: () async {
            if (currentIndex == 0) {
              return true;
            }
            NavigationController.of(context).changePage(context, 0);
            return false;
          },
          child: SafeArea(
            child: Scaffold(
              bottomNavigationBar: BottomNavigationBar(
                currentIndex: currentIndex ?? 0,
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
                            _routes[currentIndex ?? 0] == item
                                ? darkColor
                                : placeholderColor,
                      ),
                    ),
                ],
              ),
              body: _routes[currentIndex ?? 0].page,
            ),
          ),
        );
      },
    );
  }
}
