

class  News {
  final String title;
  final String description;
  final String imageUrl;
  final DateTime date;
  final String url;

  News({
    required this.title,
    required this.description,
    required this.imageUrl,
     required this.date,
    required this.url,
  });

  factory News.fromJson(Map<String, dynamic> json) {
    return News(
      title: json['title'] ?? '',
      description: json['description'] ?? '',
      imageUrl: json['urlToImage'] ?? '',
      date: DateTime.parse(json['publishedAt'] ?? DateTime.now().toString()),
      url: json['url'] ?? '',
    );
  }
}
