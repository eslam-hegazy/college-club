class RequestImageModel {
  final String prompt;
  final int n;
  final String size;
  RequestImageModel({
    required this.prompt,
    required this.n,
    required this.size,
  });
  Map<String, dynamic> toMap() {
    return {
      "prompt": prompt,
      "n": n,
      "size": size,
    };
  }
}
