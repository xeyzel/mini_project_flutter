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
    return {
      'author': author,
      'url': url,
      'title': title,
      'description': description,
    };
  }

  @override
  String toString() {
    return 'News={author=$author, title=$title, url=$url, description=$description}';
  }
}
