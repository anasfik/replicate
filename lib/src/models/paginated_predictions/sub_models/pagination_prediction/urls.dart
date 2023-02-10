class PredictionUrls {
  final String? get;
  final String? cancel;

  PredictionUrls({
    required this.get,
    required this.cancel,
  });

  factory PredictionUrls.fromJson(Map<String, dynamic> json) {
    return PredictionUrls(
      get: json['get'],
      cancel: json['cancel'],
    );
  }
}
