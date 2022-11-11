import 'package:flutter/material.dart';
import 'package:mini_project_flutter/src/screens/bookmark/bookmark_view_model.dart';
import 'package:mini_project_flutter/src/screens/home/home_screen.dart';
import 'package:mini_project_flutter/src/screens/home/navbar_setter/home_navbar.dart';
import 'package:mini_project_flutter/src/screens/home/navbar_setter/navbar_view_model.dart';
import 'package:mini_project_flutter/src/screens/news/news_screen.dart';
import 'package:mini_project_flutter/src/screens/news/news_view_model.dart';
import 'package:mini_project_flutter/src/screens/splash/splash_screen.dart';
import 'package:mini_project_flutter/src/screens/sports/sport_type_screen.dart';
import 'package:mini_project_flutter/src/screens/sports/sport_type_view_model.dart';
import 'package:provider/provider.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => SportViewModel()),
        ChangeNotifierProvider(create: (context) => NewsViewModel()),
        ChangeNotifierProvider(create: (context) => BookmarkViewModel()),
        ChangeNotifierProvider(create: (context) => NavbarViewModel()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'X-Sport',
        theme: ThemeData(
          primarySwatch: Colors.cyan,
          useMaterial3: true,
        ),
        home: const SplashScreen(),
        routes: {
          HomeNavbar.route: (context) => const HomeNavbar(),
          NewsScreen.route: (context) => const NewsScreen(),
          SportTypeScreen.route: (context) => const SportTypeScreen(),
          HomeScreen.route: (context) => const HomeScreen(),
        },
      ),
    );
  }
}
