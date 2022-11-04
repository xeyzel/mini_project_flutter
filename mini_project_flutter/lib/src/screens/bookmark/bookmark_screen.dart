import 'package:flutter/material.dart';
import 'package:mini_project_flutter/src/screens/sports/setting/setting.dart';

class BookmarkScreen extends StatelessWidget {
  const BookmarkScreen({super.key});

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
      body: const Center(
        child: Text('THIS WILL BE BOOKMARK SCREEN'),
      ),
    );
  }
}
