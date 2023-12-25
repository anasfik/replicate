import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import '../../utils/enum.dart';
import 'sub_models/urls.dart';

export 'sub_models/urls.dart';

@immutable
class Prediction extends Equatable {
  final String id;
  final String version;
  final PredictionUrls urls;
  final DateTime createdAt;
  final Map<String, dynamic> input;
  final String? error;
  final String logs;
  final String model;

  const Prediction({
    required this.id,
    required this.version,
    required this.urls,
    required this.createdAt,
    required this.input,
    required this.error,
    required this.logs,
    required this.model,
  });

  factory Prediction.fromJson(Map<String, dynamic> json) {
    return Prediction(
      id: json['id'],
      version: json['version'],
      model: json['model'],
      input: json['input'],
      logs: json['logs'],
      error: json['error'],
      urls: PredictionUrls.fromJson(json['urls']),
      createdAt: DateTime.parse(json['created_at']),
    );
  }

  @override
  List<Object?> get props => [
        id,
        version,
        urls,
        createdAt,
        input,
        error,
        logs,
        model,
      ];
}
