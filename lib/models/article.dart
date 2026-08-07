class Article {
  final String title;
  final String? description;
  final String? content;
  final String url;
  final String? imageUrl;
  final String sourceName;
  final DateTime? publishedAt;
  final String? author;

  Article({
    required this.title,
    this.description,
    this.content,
    required this.url,
    this.imageUrl,
    required this.sourceName,
    this.publishedAt,
    this.author,
  });

  factory Article.fromJson(Map<String, dynamic> json) {
    return Article(
      title: json['title'] ?? 'Untitled',
      description: json['description'],
      content: json['content'],
      url: json['url'] ?? '',
      imageUrl: json['urlToImage'],
      sourceName: (json['source'] != null ? json['source']['name'] : null) ??
          'Unknown source',
      publishedAt: json['publishedAt'] != null
          ? DateTime.tryParse(json['publishedAt'])
          : null,
      author: json['author'],
    );
  }
}
