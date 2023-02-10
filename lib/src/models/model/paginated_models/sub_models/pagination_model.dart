class PaginationModel {
  String? id;
  String? createdAt;
  String? cogVersion;
  String? openapiSchema;

  PaginationModel({
    this.id,
    this.createdAt,
    this.cogVersion,
    this.openapiSchema,
  });

  factory PaginationModel.fromJson(Map<String, dynamic> json) {
    return PaginationModel(
      id: json['id'],
      createdAt: json['created_at'],
      cogVersion: json['cog_version'],
      openapiSchema: json['openapi_schema'],
    );
  }
}
