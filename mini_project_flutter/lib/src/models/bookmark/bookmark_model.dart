class BookmarkModel {
  String author;
  String url;
  String title;
  String description;

  BookmarkModel({
    required this.author,
    required this.description,
    required this.title,
    required this.url,
  });

  factory BookmarkModel.fromMap(Map<String, dynamic> data) {
    return BookmarkModel(
      author: data['author'],
      description: data['description'],
      title: data['title'],
      url: data['url'],
    );
  }

  Map<String, dynamic> toMap() {
    final map = <String, dynamic>{};
    map['author'] = author;
    map['url'] = url;
    map['title'] = title;
    map['description'] = description;

    return map;
  }

  @override
  String toString() {
    return 'News={author=$author, title=$title, url=$url, description=$description}';
  }
}
