import '../../utils/enum.dart';
import 'prediction.dart';

class FetchedPrediction extends Prediction {
  final dynamic output;
  final PredictionStatus status;
  final DateTime? startedAt;
  final DateTime? completedAt;
  final Map<String, dynamic> metrics;

  FetchedPrediction({
    required super.id,
    required super.version,
    required super.urls,
    required super.createdAt,
    required super.input,
    required super.error,
    required super.logs,
    required super.model,
    required this.completedAt,
    required this.metrics,
    required this.output,
    required this.startedAt,
    required this.status,
  });

  factory FetchedPrediction.fromJson(Map<String, dynamic> json) {
    return FetchedPrediction(
      id: json['id'],
      version: json['version'],
      model: json['model'],
      input: json['input'],
      logs: json['logs'],
      error: json['error'],
      urls: PredictionUrls.fromJson(json['urls']),
      createdAt: DateTime.parse(json['created_at']),
      completedAt: json['completed_at'] != null
          ? DateTime.parse(json['completed_at'])
          : null,
      startedAt: json['started_at'] != null
          ? DateTime.parse(json['started_at'])
          : null,
      metrics: json['metrics'],
      output: json['output'],
      status: PredictionStatus.fromResponseField(json['status']),
    );
  }

  @override
  List<Object?> get props => [
        ...super.props,
        completedAt,
        metrics,
        output,
        startedAt,
        status,
      ];
}
