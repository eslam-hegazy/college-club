class ResponseNewsModel {
  final String? author;
  final String? title;
  final String? description;
  final String? urlToImage;
  final String? url;
  final String? data;
  ResponseNewsModel({
    required this.author,
    required this.title,
    required this.description,
    required this.urlToImage,
    required this.url,
    required this.data,
  });
  factory ResponseNewsModel.fromJson(Map<String, dynamic> json) {
    return ResponseNewsModel(
      author: json['author'],
      title: json['title'],
      description: json['description'],
      urlToImage: json['urlToImage'],
      url: json['url'],
      data: json['publishedAt'],
    );
  }
}
