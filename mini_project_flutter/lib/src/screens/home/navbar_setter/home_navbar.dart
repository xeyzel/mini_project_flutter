import 'package:flutter/material.dart';
import 'package:mini_project_flutter/src/screens/bookmark/bookmark_screen.dart';
import 'package:mini_project_flutter/src/screens/home/home_screen.dart';
import 'package:mini_project_flutter/src/screens/home/navbar_setter/navbar_view_model.dart';
import 'package:mini_project_flutter/src/screens/news/news_screen.dart';
import 'package:mini_project_flutter/src/screens/sports/sport_type_screen.dart';
import 'package:mini_project_flutter/src/screens/widget/drawer_max.dart';
import 'package:provider/provider.dart';

class HomeNavbar extends StatefulWidget {
  static const route = '/navbar';
  const HomeNavbar({super.key});

  @override
  State<HomeNavbar> createState() => _HomeNavbarState();
}

class _HomeNavbarState extends State<HomeNavbar> {
  // int _selectedIndex = 0;

  void _onItemTap(int index) {
    context.read<NavbarViewModel>().tapIndex(index);
  }

  final _pages = const [
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
      body: Consumer<NavbarViewModel>(
        builder: (context, value, child) {
          return _pages.elementAt(value.index);
        },
      ),
      bottomNavigationBar: Consumer<NavbarViewModel>(
        builder: (context, value, child) {
          return Padding(
            padding: const EdgeInsets.only(
              left: 35,
              right: 35,
            ),
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
              onTap: _onItemTap,
              currentIndex: value.index,
            ),
          );
        },
      ),
    );
  }
}
