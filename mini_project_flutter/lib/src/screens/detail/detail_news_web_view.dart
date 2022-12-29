import 'package:flutter/material.dart';
import 'package:mini_project_flutter/src/screens/news/news_view_model.dart';

import 'package:provider/provider.dart';
import 'package:webviewx/webviewx.dart';

class NewsWebViewScreen extends StatefulWidget {
  const NewsWebViewScreen({super.key});

  @override
  State<NewsWebViewScreen> createState() => _NewsWebViewScreenState();
}

class _NewsWebViewScreenState extends State<NewsWebViewScreen> {
  @override
  Widget build(BuildContext context) {
    final newsList = Provider.of<NewsViewModel>(context, listen: false);

    return Scaffold(
      appBar: AppBar(
        title: Text(newsList.news!.title),
      ),
      body: WebViewX(
        initialContent: newsList.news!.url,
        height: double.infinity,
        width: double.infinity,
      ),
    );
  }
}
