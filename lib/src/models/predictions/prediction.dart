import 'package:meta/meta.dart';

import 'sub_models/urls.dart';

@immutable
class Prediction {
  final String id;
  final String version;
  final PredictionUrls urls;
  final DateTime createdAt;
  final DateTime? startedAt;
  final DateTime? completedAt;
  final String status;
  final Map<String, dynamic> input;
  final List output;
  final String? error;
  final String logs;
  final Map<String, dynamic>? metrics;

  const Prediction({
    required this.id,
    required this.version,
    required this.urls,
    required this.createdAt,
    required this.startedAt,
    required this.completedAt,
    required this.status,
    required this.input,
    required this.output,
    required this.error,
    required this.logs,
    required this.metrics,
  });

  factory Prediction.fromJson(Map<String, dynamic> json) {
    return Prediction(
      id: json['id'],
      version: json['version'],
      urls: PredictionUrls.fromJson(json['urls']),
      createdAt: DateTime.parse(json['created_at']),
      startedAt: json['started_at'] == null
          ? null
          : DateTime.parse(json['started_at']),
      completedAt: json['completed_at'] == null
          ? null
          : DateTime.parse(json['completed_at']),
      status: json['status'],
      input: json['input'],
      output: json['output'],
      error: json['error'],
      logs: json['logs'],
      metrics: json['metrics'],
    );
  }
}
