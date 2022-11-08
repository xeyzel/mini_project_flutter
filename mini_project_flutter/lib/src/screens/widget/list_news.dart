import 'package:flutter/material.dart';
import 'package:mini_project_flutter/src/models/bookmark/bookmark_model.dart';
import 'package:mini_project_flutter/src/models/news/news_model.dart';
import 'package:mini_project_flutter/src/screens/bookmark/bookmark_view_model.dart';
import 'package:mini_project_flutter/src/screens/news/news_view_model.dart';
import 'package:mini_project_flutter/src/screens/detail/detail_news_web_view.dart';
import 'package:mini_project_flutter/src/screens/widget/components/custom_tag.dart';
import 'package:mini_project_flutter/src/screens/widget/components/image_container.dart';
import 'package:provider/provider.dart';

class ListNews extends StatefulWidget {
  final Iterable<NewsModel> sportNews;
  const ListNews({super.key, required this.sportNews});

  @override
  State<ListNews> createState() => _ListNewsState();
}

class _ListNewsState extends State<ListNews> {
  bool isAdd = false;

  @override
  Widget build(BuildContext context) {
    return Consumer<NewsViewModel>(builder: (context, value, child) {
      return ListView.separated(
        physics: const BouncingScrollPhysics(),
        itemBuilder: (context, index) {
          final news = widget.sportNews.elementAt(index);
          return ImageContainer(
            height: MediaQuery.of(context).size.height * 0.45,
            width: double.infinity,
            margin: const EdgeInsets.only(left: 10, right: 10),
            padding: const EdgeInsets.all(12),
            imageUrl: news.urlToImage,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    CustomTag(
                      backgroundColor: Colors.grey.withAlpha(200),
                      children: [
                        Text(
                          news.source.name,
                        ),
                      ],
                    ),
                    IconButton(
                      onPressed: () async {
                        final markNews = BookmarkModel(
                          author: news.author,
                          description: news.description,
                          title: news.title,
                          url: news.url,
                        );
                        final affectedRows = await context
                            .read<BookmarkViewModel>()
                            .createNews(markNews);
                        if (affectedRows != 1) return;
                        print(affectedRows);

                        final snackBar = SnackBar(
                          content: const Text('Article Saved'),
                          action: SnackBarAction(
                            label: 'Close',
                            onPressed: () {},
                          ),
                        );
                        ScaffoldMessenger.of(context).showSnackBar(snackBar);
                      },
                      icon: Icon(
                        Icons.bookmark_add,
                        color: Colors.amber,
                        shadows: shadows,
                        size: 35,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 10),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      news.title,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        height: 1.3,
                        fontSize: 20,
                        color: Colors.white,
                        shadows: shadows,
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
                        mainAxisAlignment: MainAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            'Pelajari Lebih lanjut',
                            style: TextStyle(
                              color: Colors.white,
                              shadows: shadows,
                            ),
                          ),
                          const SizedBox(
                            width: 15,
                          ),
                          Icon(
                            Icons.keyboard_double_arrow_right,
                            color: Colors.white,
                            shadows: shadows,
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
        separatorBuilder: (context, index) => const Divider(),
        itemCount: widget.sportNews.length,
      );
    });
  }

  List<Shadow> get shadows {
    return [
      const Shadow(
        offset: Offset(-1.5, -1.5),
        color: Colors.black38,
      ),
      const Shadow(
        offset: Offset(1.5, -1.5),
        color: Colors.black38,
      ),
      const Shadow(
        offset: Offset(1.5, 1.5),
        color: Colors.black38,
      ),
      const Shadow(
        offset: Offset(-1.5, 1.5),
        color: Colors.black38,
      ),
    ];
  }
}
