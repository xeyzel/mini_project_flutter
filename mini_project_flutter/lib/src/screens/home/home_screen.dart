import 'package:flutter/material.dart';

import 'package:mini_project_flutter/src/screens/news/news_view_model.dart';

import 'package:mini_project_flutter/src/screens/widget/drawer_max.dart';
import 'package:mini_project_flutter/src/screens/widget/status/error_max.dart';
import 'package:mini_project_flutter/src/screens/widget/status/loading_max.dart';
import 'package:mini_project_flutter/src/screens/widget/welcome_section.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  static const route = '/home';
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          Builder(
            builder: (context) => IconButton(
              icon: const Icon(Icons.sports_outlined),
              onPressed: () => Scaffold.of(context).openEndDrawer(),
              tooltip: MaterialLocalizations.of(context).openAppDrawerTooltip,
            ),
          ),
        ],
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: const Text('X-Sport'),
      ),
      endDrawer: const DrawerMax(),
      body: Consumer<NewsViewModel>(
        builder: (context, value, child) {
          switch (value.state) {
            case ActionState.loading:
              return const LoadingMax();

            case ActionState.none:
              return WelcomeSection(
                sportNews: value.sportNews,
              );

            case ActionState.error:
              return const ErrorMax();
          }
        },
      ),
    );
  }
}
