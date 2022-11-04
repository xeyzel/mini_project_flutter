class NewsModel {
  Source source;
  String author;
  String title;
  String description;
  String url;
  String urlToImage;
  DateTime publishedAt;
  String content;

  NewsModel({
    required this.source,
    required this.author,
    required this.title,
    required this.description,
    required this.url,
    required this.urlToImage,
    required this.publishedAt,
    required this.content,
  });

  factory NewsModel.fromJson(Map<String, dynamic> json) => NewsModel(
        source: Source.fromJson(json["source"]),
        author: json["author"] ?? "",
        title: json["title"],
        description: json["description"] ?? "",
        url: json["url"],
        urlToImage: json["urlToImage"] ?? "",
        publishedAt: DateTime.parse(json["publishedAt"]),
        content: json["content"] ?? "no content",
      );

  Map<String, dynamic> toMap() {
    final map = <String, dynamic>{};

    map["source"] = source.toJson();
    map["author"] = author;
    map["title"] = title;
    map["description"] = description;
    map["url"] = url;
    map["urlToImage"] = urlToImage;
    map["publishedAt"] = publishedAt.toIso8601String();
    map["content"] = content;
    return map;
  }

  Map<String, dynamic> toTable() {
    final map = <String, dynamic>{};

    map["sourceId"] = source.id;
    map["sourceName"] = source.name;
    map["author"] = author;
    map["title"] = title;
    map["description"] = description;
    map["url"] = url;
    map["urlToImage"] = urlToImage;
    map["publishedAt"] = publishedAt.toIso8601String();
    map["content"] = content;
    return map;
  }
}

class Source {
  Source({
    required this.id,
    required this.name,
  });

  dynamic id;
  String name;

  factory Source.fromJson(Map<String, dynamic> json) => Source(
        id: json["id"] ?? "",
        name: json["name"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
      };
}
