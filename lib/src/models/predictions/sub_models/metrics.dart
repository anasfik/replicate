class PredictionMetrics {
  final double? predictTime;

  const PredictionMetrics({
    this.predictTime,
  });

  factory PredictionMetrics.fromJson(Map<String, dynamic> json) {
    return PredictionMetrics(
      predictTime: json['predict_time'],
    );
  }

  @override
  String toString() => 'PredictionMetrics(predictTime: $predictTime)';

  @override
  bool operator ==(covariant PredictionMetrics other) {
    if (identical(this, other)) return true;

    return other.predictTime == predictTime;
  }

  @override
  int get hashCode => predictTime.hashCode;
}
