import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:mini_project_flutter/src/models/bookmark/bookmark_model.dart';
import 'package:mini_project_flutter/src/screens/bookmark/bookmark_view_model.dart';
import 'package:mini_project_flutter/src/screens/detail/detail_bookmark.dart';

import 'package:mini_project_flutter/src/screens/widget/drawer_max.dart';
import 'package:mini_project_flutter/src/screens/widget/list_bookmark.dart';
import 'package:provider/provider.dart';

class BookmarkScreen extends StatefulWidget {
  const BookmarkScreen({super.key});

  @override
  State<BookmarkScreen> createState() => _BookmarkScreenState();
}

class _BookmarkScreenState extends State<BookmarkScreen> {
  void _initial() async {
    final news = await context.read<BookmarkViewModel>().getNews();
    if (!mounted) return;
    context.read<BookmarkViewModel>().reloadScreen(news.toString());
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      _initial();
    });
  }

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
      body: Consumer<BookmarkViewModel>(
        builder: (context, value, child) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(height: 10),
              const Text(
                'Search',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 25,
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Row(
                  children: [
                    const Icon(
                      Icons.search,
                      size: 25,
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: TextFormField(
                        onChanged: (value) {
                          context
                              .read<BookmarkViewModel>()
                              .searchNews(value, value);
                        },
                        decoration: const InputDecoration(
                          hintText: 'Search',
                          border: OutlineInputBorder(),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),
              const Text(
                'Saved Articles',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 30,
                ),
              ),
              const SizedBox(height: 20),
              _screenValidator(value.news),
            ],
          );
        },
      ),
    );
  }

  Widget _screenValidator(Iterable<BookmarkModel> bookmarkModel) {
    if (bookmarkModel.isEmpty) {
      return const Center(
        child: Text("You haven't saved any articles yet!"),
      );
    }
    return Expanded(
      child: bookMarkList(bookmarkModel),
    );
  }
}
