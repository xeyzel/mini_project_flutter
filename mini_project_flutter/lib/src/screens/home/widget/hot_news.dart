import 'package:flutter/material.dart';
import 'package:mini_project_flutter/src/screens/detail/detail_news_web_view.dart';
import 'package:mini_project_flutter/src/screens/news/news_view_model.dart';
import 'package:mini_project_flutter/src/screens/widget/custom_tag.dart';
import 'package:mini_project_flutter/src/screens/widget/image_container.dart';
import 'package:mini_project_flutter/src/screens/home/widget/welcome_section.dart';
import 'package:provider/provider.dart';

class HotNews extends StatelessWidget {
  const HotNews({
    Key? key,
    required this.widget,
    required this.newsIndex,
  }) : super(key: key);

  final WelcomeSection widget;
  final int newsIndex;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 8, right: 8),
      child: SizedBox(
        height: 280,
        child: ListView.builder(
          itemCount: 1,
          itemBuilder: (context, index) {
            final news = widget.sportNews.elementAt(newsIndex);
            return ImageContainer(
              height: MediaQuery.of(context).size.height * 0.30,
              width: double.infinity,
              padding: const EdgeInsets.all(10),
              imageUrl: news.urlToImage,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  CustomTag(
                    backgroundColor: Colors.redAccent.withAlpha(180),
                    children: [
                      Text(
                        news.source.name,
                        style: const TextStyle(
                            fontWeight: FontWeight.bold, color: Colors.black),
                      ),
                    ],
                  ),
                  const SizedBox(height: 50),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        news.title,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          height: 1.3,
                          fontSize: 18,
                          color: Colors.white,
                          shadows: newShadows,
                        ),
                      ),
                      TextButton(
                        onPressed: () async {
                          context.read<NewsViewModel>().selectedNews(news);
                          Navigator.push(
                            context,
                            PageRouteBuilder(
                              transitionsBuilder: (context, animation,
                                  secondaryAnimation, child) {
                                return SlideTransition(
                                  position: animation.drive(
                                    Tween(
                                        begin: const Offset(1.0, 0.0),
                                        end: Offset.zero),
                                  ),
                                  child: child,
                                );
                              },
                              pageBuilder:
                                  (context, animation, secondaryAnimation) {
                                return const NewsWebViewScreen();
                              },
                            ),
                          );
                        },
                        style: TextButton.styleFrom(padding: EdgeInsets.zero),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(
                              'Pelajari Lebih lanjut',
                              style: TextStyle(
                                color: Colors.white,
                                shadows: newShadows,
                              ),
                            ),
                            const SizedBox(width: 15),
                            Icon(
                              Icons.keyboard_double_arrow_right,
                              color: Colors.white,
                              shadows: newShadows,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }

  List<Shadow> get newShadows {
    return [
      const Shadow(
        offset: Offset(-1.5, -1.5),
        color: Colors.black26,
      ),
      const Shadow(
        offset: Offset(1.5, -1.5),
        color: Colors.black26,
      ),
      const Shadow(
        offset: Offset(1.5, 1.5),
        color: Colors.black26,
      ),
      const Shadow(
        offset: Offset(-1.5, 1.5),
        color: Colors.black26,
      ),
    ];
  }
}
