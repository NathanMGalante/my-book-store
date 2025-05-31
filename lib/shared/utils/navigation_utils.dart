import 'package:flutter/material.dart';
import 'package:mybookstore/app/book_edit/pages/book_edit_page.dart';
import 'package:mybookstore/app/bookmark/pages/bookmark_page.dart';
import 'package:mybookstore/app/employee/pages/employee_page.dart';
import 'package:mybookstore/app/home/pages/guest_home_page.dart';
import 'package:mybookstore/app/home/pages/home_page.dart';
import 'package:mybookstore/app/profile/pages/profile_page.dart';
import 'package:mybookstore/auth/controller.dart';
import 'package:mybookstore/shared/utils/image_path_utils.dart';
import 'package:mybookstore/shared/utils/role_utils.dart';

Future<dynamic> goTo(BuildContext context, Widget page) {
  return Navigator.push(context, MaterialPageRoute(builder: (context) => page));
}

Future<dynamic> replacePage(BuildContext context, Widget page) {
  return Navigator.pushReplacement(
    context,
    MaterialPageRoute(builder: (context) => page),
  );
}

class NoTransitionsBuilder extends PageTransitionsBuilder {
  const NoTransitionsBuilder();

  @override
  Widget buildTransitions<T>(
    PageRoute<T> route,
    BuildContext context,
    Animation<double> animation,
    Animation<double> secondaryAnimation,
    Widget child,
  ) {
    return child;
  }
}

List<NavigationItem> getNavigationRoutes() {
  return _routes.where((route) {
    return AuthController().hasAnyAuthority(route.permissions);
  }).toList();
}

const List<NavigationItem> _routes = [
  NavigationItem(
    label: 'Home',
    permissions: [Role.admin, Role.employee],
    icon: homeIconImage,
    page: HomePage(),
  ),
  NavigationItem(
    label: 'Home',
    permissions: [Role.user],
    icon: homeIconImage,
    page: GuestHomePage(),
  ),
  NavigationItem(
    label: 'Funcionarios',
    permissions: [Role.admin],
    icon: searchIconImage,
    page: EmployeePage(),
  ),
  NavigationItem(
    label: 'Meu pefil',
    permissions: [Role.admin, Role.employee],
    icon: profileIconImage,
    page: ProfilePage(),
  ),
  NavigationItem(
    label: 'Biblioteca',
    permissions: [Role.admin],
    icon: scrollIconImage,
    page: BookEditPage(),
  ),
  NavigationItem(
    label: 'Salvos',
    permissions: [Role.employee],
    icon: searchIconImage,
    page: BookMarkPage(),
  ),
];

class NavigationItem {
  const NavigationItem({
    required this.label,
    required this.permissions,
    required this.icon,
    required this.page,
  });

  final String label;
  final List<Role> permissions;
  final String icon;
  final Widget page;
}

class NavigationController extends InheritedWidget {
  NavigationController({super.key, required super.child});

  final ValueNotifier<int?> currentIndex = ValueNotifier(null);

  Future<void> goToHome(BuildContext context) {
    return changePage(context, 0);
  }

  Future<void> changePage(BuildContext context, int index) async {
    if (currentIndex.value != null && currentIndex.value == index) return;
    // final lastIndex = currentIndex.value;
    // final routes = getNavigationRoutes();
    // final page = routes[index].page;
    // final pageBuilder = PageRouteBuilder(
    //   pageBuilder: (context, animation, secondaryAnimation) => page,
    //   transitionDuration: Duration.zero,
    //   reverseTransitionDuration: Duration.zero,
    // );
    // Future.delayed(Duration(milliseconds: 100), () {
      currentIndex.value = index;
    // });
    // if (lastIndex == 0) {
    //   await Navigator.push(context, pageBuilder);
    // } else {
    //   await Navigator.pushReplacement(context, pageBuilder);
    // }
    // Future.delayed(Duration(milliseconds: 100), () {
    //   currentIndex.value = lastIndex;
    // });
  }

  static NavigationController? maybeOf(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<NavigationController>();
  }

  static NavigationController of(BuildContext context) {
    final NavigationController? result = maybeOf(context);
    assert(result != null, 'No NavigationBarController found in context');
    return result!;
  }

  @override
  bool updateShouldNotify(NavigationController oldWidget) =>
      currentIndex != oldWidget.currentIndex;
}
