import 'package:findee/constants.dart';
import 'package:findee/home.dart';
import 'package:findee/categoryPage.dart';
import 'package:findee/screens/profile_screen.dart';
import 'package:flutter/material.dart';

class Navigation extends StatefulWidget {
  const Navigation({Key? key}) : super(key: key);

  @override
  State<Navigation> createState() => _NavigationState();
}

class _NavigationState extends State<Navigation> {
  DateTime? _currentBackPressTime;

  final _pageItem = [
    HomeScreen(),
    likedPage(fromProfile: false,),
    ProfileScreen(fromProfile: false,),
  ];
  int _selectedItem = 0;

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        onWillPop: () {
          DateTime now = DateTime.now();

          if (_currentBackPressTime == null || now.difference(_currentBackPressTime!) > Duration(seconds: 2)) {
            _currentBackPressTime = now;
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text('Press back again to exit'),
              ),
            );

            return Future.value(false);
          }
          return Future.value(true);
        },
        child: Scaffold(
          body: _pageItem[_selectedItem],
          bottomNavigationBar: BottomNavigationBar(
            type: BottomNavigationBarType.fixed,
            selectedIconTheme: IconThemeData(size: 30, opacity: 1),
            unselectedIconTheme: IconThemeData(size: 28, opacity: 0.5),
            selectedLabelStyle: TextStyle(fontSize: 14),
            unselectedLabelStyle: TextStyle(fontSize: 14),
            showUnselectedLabels: true,
            elevation: 40,
            selectedFontSize: 16,
            selectedItemColor: kActiveIconColor,
            items: [
              BottomNavigationBarItem(
                icon: Icon(Icons.dashboard_outlined, size: 30),
                activeIcon: Icon(Icons.dashboard, size: 30),
                label: "Home",
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.category_outlined, size: 30),
                activeIcon: Icon(Icons.category, size: 30),
                label: "Categories",
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.person_outline, size: 30),
                activeIcon: Icon(Icons.person, size: 30),
                label: "Account",
              ),
            ],
            currentIndex: _selectedItem,
            onTap: (setValue) {
              _selectedItem = setValue;
              setState(() {});
            },
          ),
        ));
  }
}
