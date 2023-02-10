class ReplicateModel {
  final String url;
  final String owner;
  final String name;
  final String description;
  final String? visibility;
  final String? githubUrl;
  final String? paperUrl;
  final String? licenseUrl;
  final Map<String, dynamic>? latestVersion;

  ReplicateModel({
    required this.url,
    required this.owner,
    required this.name,
    required this.description,
    required this.visibility,
    required this.githubUrl,
    required this.paperUrl,
    required this.licenseUrl,
    required this.latestVersion,
  });

  factory ReplicateModel.fromJson(Map<String, dynamic> json) {
    return ReplicateModel(
      url: json['url'],
      owner: json['owner'],
      name: json['name'],
      description: json['description'],
      visibility: json['visibility'],
      githubUrl: json['github_url'],
      paperUrl: json['paper_url'],
      licenseUrl: json['license_url'],
      latestVersion: json['latest_version'],
    );
  }
}
