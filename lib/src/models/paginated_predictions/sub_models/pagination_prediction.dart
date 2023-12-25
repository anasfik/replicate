import '../../../utils/enum.dart';
import '../../predictions/prediction.dart';

enum PredictionSource { api, web }

class PaginationPrediction {
  final String id;
  final String version;
  final PredictionUrls? urls;
  final DateTime createdAt;
  final DateTime? startedAt;
  final DateTime? completedAt;
  final PredictionSource source;
  final PredictionStatus status;

  PaginationPrediction({
    required this.id,
    required this.version,
    required this.urls,
    required this.createdAt,
    required this.startedAt,
    required this.completedAt,
    required this.source,
    required this.status,
  });

  static PredictionSource _predictionSource(String source) {
    return PredictionSource.values.firstWhere(
      (sourceEnum) => sourceEnum.name.toLowerCase() == source.toLowerCase(),
    );
  }

  factory PaginationPrediction.fromJson(Map<String, dynamic> json) {
    return PaginationPrediction(
      id: json['id'],
      version: json['version'],
      urls: PredictionUrls.fromJson(json['urls']),
      createdAt: DateTime.parse(json['created_at']),
      startedAt: DateTime.parse(json['started_at']),
      completedAt: DateTime.parse(json['completed_at']),
      source: _predictionSource(json['source']),
      status: PredictionStatus.fromResponseField(json['status']),
    );
  }

  @override
  String toString() {
    return 'PaginationPrediction(id: $id, version: $version, urls: $urls, createdAt: $createdAt, startedAt: $startedAt, completedAt: $completedAt, source: $source, status: $status)';
  }

  @override
  bool operator ==(covariant PaginationPrediction other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.version == version &&
        other.urls == urls &&
        other.createdAt == createdAt &&
        other.startedAt == startedAt &&
        other.completedAt == completedAt &&
        other.source == source &&
        other.status == status;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        version.hashCode ^
        urls.hashCode ^
        createdAt.hashCode ^
        startedAt.hashCode ^
        completedAt.hashCode ^
        source.hashCode ^
        status.hashCode;
  }
}
