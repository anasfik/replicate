import 'package:equatable/equatable.dart';

class ReplicateModelVersion extends Equatable {
  final String id;
  final String? createdAt;
  final String? cogVersion;
  final Map<String, dynamic>? openApiSchema;

  const ReplicateModelVersion({
    required this.id,
    required this.createdAt,
    required this.cogVersion,
    required this.openApiSchema,
  });

  factory ReplicateModelVersion.fromJson(Map<String, dynamic> json) {
    return ReplicateModelVersion(
      id: json['id'],
      createdAt: json['created_at'],
      cogVersion: json['cog_version'],
      openApiSchema: json['openapi_schema'],
    );
  }

  @override
  List<Object?> get props => [
        id,
        createdAt,
        cogVersion,
        openApiSchema,
      ];
}
