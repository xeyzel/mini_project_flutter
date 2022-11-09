import 'dart:async';

import 'package:flutter/material.dart';
import 'package:mini_project_flutter/src/models/news/news_model.dart';
import 'package:mini_project_flutter/src/screens/detail/detail_news_web_view.dart';
import 'package:mini_project_flutter/src/screens/home/navbar_setter/home_navbar.dart';
import 'package:mini_project_flutter/src/screens/home/navbar_setter/navbar_view_model.dart';
import 'package:mini_project_flutter/src/screens/news/news_screen.dart';
import 'dart:math';
import 'package:mini_project_flutter/src/screens/news/news_view_model.dart';

import 'package:mini_project_flutter/src/screens/widget/components/image_container.dart';
import 'package:mini_project_flutter/src/screens/widget/hot_news.dart';
import 'package:mini_project_flutter/src/screens/widget/list_news.dart';
import 'package:provider/provider.dart';

class WelcomeSection extends StatefulWidget {
  final Iterable<NewsModel> sportNews;

  const WelcomeSection({
    Key? key,
    required this.sportNews,
  }) : super(key: key);

  @override
  State<WelcomeSection> createState() => _WelcomeSectionState();
}

class _WelcomeSectionState extends State<WelcomeSection> {
  int newsIndex = 1;
  Timer? timer;

  void _changeNewsAuto() {
    timer = Timer.periodic(
      const Duration(milliseconds: 3500),
      (timer) {
        newsIndex = Random().nextInt(20);
        setState(() {});
      },
    );
  }

  @override
  void initState() {
    super.initState();
    _changeNewsAuto();
  }

  @override
  void dispose() {
    super.dispose();
    timer?.cancel();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<NewsViewModel>(
      builder: (context, value, child) {
        final newsPage = widget.sportNews.elementAt(newsIndex);
        return ListView(
          physics: const BouncingScrollPhysics(),
          children: [
            HotNews(widget: widget, newsIndex: newsIndex),
            const SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Padding(
                  padding: EdgeInsets.only(left: 8),
                  child: Text(
                    'Berita Terkini',
                    style: TextStyle(
                      fontSize: 25,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                TextButton(
                  onPressed: () {
                    context.read<NavbarViewModel>().tapIndex(1);
                  },
                  child: const Text('Lihat'),
                ),
              ],
            ),
            LatestNews(widget: widget),
            const SizedBox(height: 10),
            const Text(
              'Pelajari Macam-Macam Olahraga di Dunia',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 18,
              ),
              textAlign: TextAlign.center,
            ),
            const Text(
              'Klik Tombol Buku Pada Navbar',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 18,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        );
      },
    );
  }
}

class LatestNews extends StatelessWidget {
  const LatestNews({
    Key? key,
    required this.widget,
  }) : super(key: key);

  final WelcomeSection widget;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: SizedBox(
        height: 210,
        child: ListView.builder(
          physics: const BouncingScrollPhysics(),
          scrollDirection: Axis.horizontal,
          itemCount: 5,
          itemBuilder: (context, index) {
            final news = widget.sportNews.elementAt(index);
            return InkWell(
              onTap: () async {
                context.read<NewsViewModel>().selectedNews(news);
                Navigator.push(
                  context,
                  PageRouteBuilder(
                    transitionsBuilder:
                        (context, animation, secondaryAnimation, child) {
                      return SlideTransition(
                        position: animation.drive(
                          Tween(
                              begin: const Offset(1.0, 0.0), end: Offset.zero),
                        ),
                        child: child,
                      );
                    },
                    pageBuilder: (context, animation, secondaryAnimation) {
                      return const NewsWebViewScreen();
                    },
                  ),
                );
              },
              child: Container(
                width: MediaQuery.of(context).size.width * 0.5,
                margin: const EdgeInsets.only(right: 10, left: 10),
                child: Column(
                  children: [
                    ImageContainer(
                      height: 110,
                      width: MediaQuery.of(context).size.width * 0.5,
                      imageUrl: news.urlToImage,
                      child: const SizedBox(),
                    ),
                    const SizedBox(height: 10),
                    Text(
                      news.title,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(fontWeight: FontWeight.bold),
                      textAlign: TextAlign.left,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Text(
                          news.author,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style: Theme.of(context).textTheme.bodySmall,
                          textAlign: TextAlign.left,
                        ),
                      ],
                    ),
                    Text(
                      '${DateTime.now().difference(news.publishedAt).inHours} hours ago',
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: Theme.of(context).textTheme.bodySmall,
                      textAlign: TextAlign.left,
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
