class PaginationModel {
  String? id;
  String? createdAt;
  String? cogVersion;
  Map<String, dynamic>? openApiSchema;

  PaginationModel({
    this.id,
    this.createdAt,
    this.cogVersion,
    this.openApiSchema,
  });

  factory PaginationModel.fromJson(Map<String, dynamic> json) {
    return PaginationModel(
      id: json['id'],
      createdAt: json['created_at'],
      cogVersion: json['cog_version'],
      openApiSchema: json['openapi_schema'],
    );
  }
}
