class RequestMessageModel {
  final String model;
  final String prompt;
  final double temperature;
  final int max_tokens;
  final int top_p;
  final int frequency_penalty;
  final int presence_penalty;

  RequestMessageModel(
      {required this.model,
      required this.prompt,
      required this.temperature,
      required this.max_tokens,
      required this.top_p,
      required this.frequency_penalty,
      required this.presence_penalty});

  Map<String, dynamic> toJson() {
    return {
      "model": model,
      "prompt": prompt,
      "temperature": temperature,
      "max_tokens": max_tokens,
      "top_p": top_p,
      "frequency_penalty": frequency_penalty,
      "presence_penalty": presence_penalty,
    };
  }
}
