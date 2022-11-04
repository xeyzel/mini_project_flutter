import 'package:flutter/material.dart';
import 'package:mini_project_flutter/src/screens/detail/detail_news_web_view.dart';
import 'package:mini_project_flutter/src/screens/news/news_view_model.dart';
import 'package:mini_project_flutter/src/screens/widget/components/custom_tag.dart';
import 'package:mini_project_flutter/src/screens/widget/components/image_container.dart';
import 'package:mini_project_flutter/src/screens/widget/welcome_section.dart';
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
              padding: const EdgeInsets.all(16),
              imageUrl: news.urlToImage,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  CustomTag(
                    backgroundColor: Colors.red.withAlpha(150),
                    children: [
                      Text(
                        news.source.name,
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),
                  Text(
                    news.title,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      height: 1.3,
                      fontSize: 18,
                      color: Colors.white,
                      shadows: [
                        Shadow(
                            offset: Offset(-1.5, -1.5), color: Colors.black26),
                        Shadow(
                          offset: Offset(1.5, -1.5),
                          color: Colors.black26,
                        ),
                        Shadow(
                          offset: Offset(1.5, 1.5),
                          color: Colors.black26,
                        ),
                        Shadow(
                          offset: Offset(-1.5, 1.5),
                          color: Colors.black26,
                        ),
                      ],
                    ),
                  ),
                  TextButton(
                    onPressed: () async {
                      context.read<NewsViewModel>().selectedNews(news);
                      Navigator.push(
                        context,
                        PageRouteBuilder(
                          transitionsBuilder:
                              (context, animation, secondaryAnimation, child) {
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
                      children: const [
                        Text(
                          'Pelajari Lebih lanjut',
                          style: TextStyle(
                            color: Colors.white,
                            shadows: [
                              Shadow(
                                offset: Offset(-1.5, -1.5),
                                color: Colors.black26,
                              ),
                              Shadow(
                                offset: Offset(1.5, -1.5),
                                color: Colors.black26,
                              ),
                              Shadow(
                                offset: Offset(1.5, 1.5),
                                color: Colors.black26,
                              ),
                              Shadow(
                                offset: Offset(-1.5, 1.5),
                                color: Colors.black26,
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          width: 15,
                        ),
                        Icon(
                          Icons.keyboard_double_arrow_right,
                          color: Colors.white,
                          shadows: [
                            Shadow(
                              offset: Offset(-1.5, -1.5),
                              color: Colors.black26,
                            ),
                            Shadow(
                              offset: Offset(1.5, -1.5),
                              color: Colors.black26,
                            ),
                            Shadow(
                              offset: Offset(1.5, 1.5),
                              color: Colors.black26,
                            ),
                            Shadow(
                              offset: Offset(-1.5, 1.5),
                              color: Colors.black26,
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
