import 'package:collection/collection.dart';
import 'package:meta/meta.dart';
import 'sub_models/metrics.dart';
import 'sub_models/urls.dart';

export 'sub_models/urls.dart';

enum PredictionStatus {
  starting,
  processing,
  succeeded,
  failed,
  cancelled,
}

@immutable
class Prediction {
  final String id;
  final String version;
  final PredictionUrls urls;
  final DateTime createdAt;
  final DateTime? startedAt;
  final DateTime? completedAt;
  final PredictionStatus status;
  final Map<String, dynamic> input;
  final dynamic output;
  final String? error;
  final String logs;
  final PredictionMetrics? metrics;

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

  static PredictionStatus _predictionStatus(String status) {
    return PredictionStatus.values.firstWhere(
      (statusEnum) => statusEnum.name.toLowerCase() == status.toLowerCase(),
    );
  }

  bool get isTerminated {
    return status == PredictionStatus.succeeded ||
        status == PredictionStatus.failed ||
        status == PredictionStatus.cancelled;
  }

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
      status: _predictionStatus(json['status']),
      input: json['input'],
      output: json['output'],
      error: json['error'],
      logs: json['logs'],
      metrics: PredictionMetrics.fromJson(json['metrics']),
    );
  }

  @override
  String toString() {
    return 'Prediction(id: $id, version: $version, urls: $urls, createdAt: $createdAt, startedAt: $startedAt, completedAt: $completedAt, status: $status, input: $input, output: $output, error: $error, logs: $logs, metrics: $metrics)';
  }

  @override
  bool operator ==(covariant Prediction other) {
    if (identical(this, other)) return true;
    final mapEquals = const DeepCollectionEquality().equals;

    return other.id == id &&
        other.version == version &&
        other.urls == urls &&
        other.createdAt == createdAt &&
        other.startedAt == startedAt &&
        other.completedAt == completedAt &&
        other.status == status &&
        mapEquals(other.input, input) &&
        other.output == output &&
        other.error == error &&
        other.logs == logs &&
        mapEquals(other.metrics, metrics);
  }

  @override
  int get hashCode {
    return id.hashCode ^
        version.hashCode ^
        urls.hashCode ^
        createdAt.hashCode ^
        startedAt.hashCode ^
        completedAt.hashCode ^
        status.hashCode ^
        input.hashCode ^
        output.hashCode ^
        error.hashCode ^
        logs.hashCode ^
        metrics.hashCode;
  }
}
