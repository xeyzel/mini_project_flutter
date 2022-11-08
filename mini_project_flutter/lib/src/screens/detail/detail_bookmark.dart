import 'package:flutter/material.dart';
import 'package:mini_project_flutter/src/screens/bookmark/bookmark_view_model.dart';

import 'package:provider/provider.dart';
import 'package:webviewx/webviewx.dart';

class DetailBookmark extends StatefulWidget {
  const DetailBookmark({super.key});

  @override
  State<DetailBookmark> createState() => _DetailBookmarkState();
}

class _DetailBookmarkState extends State<DetailBookmark> {
  @override
  Widget build(BuildContext context) {
    final bookmark = Provider.of<BookmarkViewModel>(context, listen: false);

    return Scaffold(
      appBar: AppBar(
        title: const Text('NEWS'),
      ),
      body: WebViewX(
        initialContent: bookmark.mark!.url,
        height: double.infinity,
        width: double.infinity,
      ),
    );
  }
}
