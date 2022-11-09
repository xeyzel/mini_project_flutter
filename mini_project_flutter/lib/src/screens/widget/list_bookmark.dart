import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:mini_project_flutter/src/models/bookmark/bookmark_model.dart';
import 'package:mini_project_flutter/src/screens/bookmark/bookmark_view_model.dart';
import 'package:mini_project_flutter/src/screens/detail/detail_bookmark.dart';
import 'package:provider/provider.dart';

Widget bookMarkList(Iterable<BookmarkModel> bookmark) {
  return ListView.separated(
    shrinkWrap: true,
    padding: EdgeInsets.zero,
    itemBuilder: (context, index) {
      final mark = bookmark.elementAt(index);
      return InkWell(
        onLongPress: () async {
          showDialog(
            context: context,
            builder: (context) => Dialog(
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: SizedBox(
                  width: double.infinity,
                  height: 80,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 6),
                      const Text(
                        'Anda ingin membuka berita?',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          TextButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            child: const Text('Tidak'),
                          ),
                          TextButton(
                            onPressed: () async {
                              Navigator.pop(context);

                              context
                                  .read<BookmarkViewModel>()
                                  .selectedNews(mark);
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
                                    return const DetailBookmark();
                                  },
                                ),
                              );
                            },
                            child: const Text(
                              'Ya',
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        },
        child: ListTile(
          title: Text(mark.title),
          subtitle: Text(
            mark.note.toString(),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
          trailing: IconButton(
            icon: const Icon(
              Icons.delete,
              color: Colors.red,
              size: 30,
            ),
            onPressed: () async {
              showDialog(
                context: context,
                builder: (context) => Dialog(
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: SizedBox(
                      width: double.infinity,
                      height: 200,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          const Text(
                            'Hapus dari bookmark?',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 18,
                            ),
                          ),
                          SizedBox(
                            width: 120,
                            child: Lottie.asset(
                              'assets/icons/recycling-bin.json',
                            ),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              TextButton(
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                                child: const Text('Tidak'),
                              ),
                              TextButton(
                                onPressed: () async {
                                  final affectedRows = await context
                                      .read<BookmarkViewModel>()
                                      .deleteNews(mark);
                                  print(affectedRows);
                                  final snackBar = SnackBar(
                                    content: const Text('Article Removed'),
                                    action: SnackBarAction(
                                      label: 'Close',
                                      onPressed: () {},
                                    ),
                                  );

                                  // ignore: use_build_context_synchronously
                                  ScaffoldMessenger.of(context)
                                      .showSnackBar(snackBar);
                                  // ignore: use_build_context_synchronously
                                  Navigator.pop(context);
                                },
                                child: const Text(
                                  'Ya',
                                  style: TextStyle(color: Colors.red),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      );
    },
    separatorBuilder: (context, index) => const Divider(height: 24),
    itemCount: bookmark.length,
  );
}
