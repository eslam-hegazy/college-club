class ResponseSearchModel {
  final String? title;
  final String? imageUrl;
  final String? thumbnailUrl;
  final String? source;
  final String? domain;
  final String? link;
  ResponseSearchModel({
    required this.title,
    required this.imageUrl,
    required this.thumbnailUrl,
    required this.source,
    required this.domain,
    required this.link,
  });

  factory ResponseSearchModel.fromJson(Map<String, dynamic> json) {
    return ResponseSearchModel(
      title: json['title'],
      imageUrl: json['imageUrl'],
      thumbnailUrl: json['thumbnailUrl'],
      source: json['source'],
      domain: json['domain'],
      link: json['link'],
    );
  }
}
