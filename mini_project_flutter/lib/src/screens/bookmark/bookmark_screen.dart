import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:mini_project_flutter/src/models/bookmark/bookmark_model.dart';
import 'package:mini_project_flutter/src/screens/bookmark/bookmark_view_model.dart';
import 'package:mini_project_flutter/src/screens/detail/detail_bookmark.dart';
import 'package:mini_project_flutter/src/screens/widget/drawer_max.dart';
import 'package:provider/provider.dart';

class BookmarkScreen extends StatefulWidget {
  const BookmarkScreen({super.key});

  @override
  State<BookmarkScreen> createState() => _BookmarkScreenState();
}

class _BookmarkScreenState extends State<BookmarkScreen> {
  final _noteController = TextEditingController();

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
  void dispose() {
    _noteController.dispose();
    super.dispose();
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
                    Consumer<BookmarkViewModel>(
                      builder: (context, viewModel, child) {
                        return Switch(
                          value: viewModel.isFilter,
                          onChanged: (value) {
                            viewModel.filterBy(value);
                          },
                        );
                      },
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: Consumer<BookmarkViewModel>(
                        builder: (context, viewModel, child) {
                          return TextFormField(
                            onChanged: (value) {
                              if (viewModel.isFilter) {
                                viewModel.searchNewsByNote(value);
                              } else {
                                context
                                    .read<BookmarkViewModel>()
                                    .searchNews(value, value);
                              }
                            },
                            decoration: const InputDecoration(
                              hintText: 'Search',
                              border: OutlineInputBorder(),
                            ),
                          );
                        },
                      ),
                    ),
                    const SizedBox(width: 16),
                    const Icon(
                      Icons.search,
                      size: 25,
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

  Widget bookMarkList(Iterable<BookmarkModel> bookmark) {
    return ListView.separated(
      shrinkWrap: true,
      padding: EdgeInsets.zero,
      itemBuilder: (context, index) {
        final mark = bookmark.elementAt(index);
        return InkWell(
          onTap: () {
            showDialog(
              context: context,
              builder: (context) {
                return Dialog(
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: SizedBox(
                      height: 150,
                      width: double.infinity,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text('Ubah Catatan ?'),
                          TextFormField(
                            controller: _noteController,
                            decoration: InputDecoration(
                              isDense: true,
                              hintText: mark.note.toString(),
                              border: const OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(10)),
                              ),
                            ),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              TextButton(
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                                child: const Text(
                                  'Tidak',
                                  style: TextStyle(color: Colors.red),
                                ),
                              ),
                              TextButton(
                                onPressed: () async {
                                  mark.note = _noteController.text;

                                  final affectedRows = await context
                                      .read<BookmarkViewModel>()
                                      .updateNote(mark);

                                  print(affectedRows);
                                  Navigator.pop(context);
                                },
                                child: const Text('Ya'),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            );
          },
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
                                    pageBuilder: (context, animation,
                                        secondaryAnimation) {
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
          child: Column(
            children: [
              ListTile(
                title: Text(mark.title),
                subtitle: Text(
                  "Note : ${mark.note}",
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
                                          content:
                                              const Text('Article Removed'),
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
            ],
          ),
        );
      },
      separatorBuilder: (context, index) => const Divider(height: 24),
      itemCount: bookmark.length,
    );
  }
}
