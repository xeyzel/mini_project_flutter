import 'package:flutter/material.dart';
import 'package:mini_project_flutter/src/screens/bookmark/bookmark_screen.dart';
import 'package:mini_project_flutter/src/screens/home/home_screen.dart';
import 'package:mini_project_flutter/src/screens/news/news_screen.dart';
import 'package:mini_project_flutter/src/screens/sports/sport_type_screen.dart';
import 'package:mini_project_flutter/src/screens/widget/drawer_max.dart';

class HomeNavbar extends StatefulWidget {
  static const route = '/navbar';
  const HomeNavbar({super.key});

  @override
  State<HomeNavbar> createState() => _HomeNavbarState();
}

class _HomeNavbarState extends State<HomeNavbar> {
  int _selectedIndex = 0;

  static const List<Widget> pages = [
    HomeScreen(),
    NewsScreen(),
    SportTypeScreen(),
    BookmarkScreen(),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      endDrawer: const DrawerMax(),
      body: pages[_selectedIndex],
      bottomNavigationBar: bottomNavBar(),
    );
  }

  Widget bottomNavBar() {
    return Padding(
      padding: const EdgeInsets.only(left: 40, right: 40),
      child: BottomNavigationBar(
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.newspaper),
            label: 'News',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.menu_book_rounded),
            label: 'Knowledge',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.bookmark),
            label: 'Bookmark',
          ),
        ],
        showUnselectedLabels: false,
        selectedItemColor: Colors.black,
        unselectedItemColor: Colors.black.withAlpha(100),
        onTap: (index) {
          if (_selectedIndex != index) {
            setState(() {
              _selectedIndex = index;
            });
          }
        },
        currentIndex: _selectedIndex,
      ),
    );
  }
}
