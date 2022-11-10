class BookmarkModel {
  int? idFromTable;
  String author;
  String url;
  String title;
  String description;
  String? note;

  BookmarkModel({
    this.idFromTable,
    required this.author,
    required this.description,
    required this.title,
    required this.url,
    this.note,
  });

  factory BookmarkModel.fromMap(Map<String, dynamic> data) {
    return BookmarkModel(
      author: data['author'],
      description: data['description'],
      title: data['title'],
      url: data['url'],
      note: data['note'],
    );
  }

  factory BookmarkModel.fromMapWithId(Map<String, dynamic> data) {
    return BookmarkModel(
      idFromTable: data['idFromTable'],
      author: data['author'],
      description: data['description'],
      title: data['title'],
      url: data['url'],
      note: data['note'],
    );
  }

  Map<String, dynamic> toMap() {
    final map = <String, dynamic>{};
    map['idFromTable'] = idFromTable;
    map['author'] = author;
    map['url'] = url;
    map['title'] = title;
    map['description'] = description;
    map['note'] = note;

    return map;
  }

  @override
  String toString() {
    return 'News={author=$author, title=$title, url=$url, description=$description, note=$note}';
  }
}
