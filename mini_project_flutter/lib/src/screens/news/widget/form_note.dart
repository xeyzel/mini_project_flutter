import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:mini_project_flutter/src/models/bookmark/bookmark_model.dart';
import 'package:mini_project_flutter/src/models/news/news_model.dart';
import 'package:mini_project_flutter/src/screens/bookmark/bookmark_view_model.dart';
import 'package:mini_project_flutter/src/screens/home/navbar_setter/navbar_view_model.dart';
import 'package:provider/provider.dart';

class FormNote extends StatefulWidget {
  final NewsModel newsModel;
  const FormNote({super.key, required this.newsModel});

  @override
  State<FormNote> createState() => _FormNoteState();
}

class _FormNoteState extends State<FormNote> {
  final _notes = TextEditingController();
  late final NewsModel news;

  _initial() {
    news = widget.newsModel;
  }

  @override
  void initState() {
    super.initState();
    _initial();
  }

  void _clearScreen() {
    _notes.clear();
    context.read<BookmarkViewModel>().notes('');
  }

  @override
  void dispose() {
    _notes.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 400,
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text(
              'Write here!',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            TextFormField(
              controller: _notes,
              onChanged: (value) {
                context.read<BookmarkViewModel>().notes(value);
              },
              decoration: InputDecoration(
                hintText: "Read later...",
                label: const Text('Note'),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(25.0),
                  borderSide: const BorderSide(
                    color: Colors.blue,
                  ),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(25.0),
                  borderSide: const BorderSide(
                    color: Colors.red,
                    width: 2.0,
                  ),
                ),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const SizedBox(width: 10),
                TextButton(
                  onPressed: () {
                    if (_notes.text.isEmpty) return;
                    Navigator.of(context).pop();
                    final BookmarkModel bookmark = BookmarkModel(
                      author: news.author,
                      description: news.description,
                      title: news.title,
                      url: news.url,
                      note:
                          _notes.text.isEmpty ? news.description : _notes.text,
                    );

                    context.read<BookmarkViewModel>().createNote(bookmark);
                    _clearScreen();
                    context.read<NavbarViewModel>().tapIndex(3);
                  },
                  child: const Text('Save'),
                ),
              ],
            ),
            Center(
              child: SizedBox(
                width: 200,
                child: SvgPicture.asset(
                  'assets/svg/add_notes.svg',
                  width: 200,
                  height: 200,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
