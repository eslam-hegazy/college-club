class ResponseImageModel {
  final String image;
  ResponseImageModel({
    required this.image,
  });
  factory ResponseImageModel.fromJson(Map<String, dynamic> json) {
    return ResponseImageModel(
      image: json['url'],
    );
  }
}
