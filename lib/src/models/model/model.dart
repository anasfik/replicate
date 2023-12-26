import 'package:equatable/equatable.dart';
import 'package:replicate/src/models/predictions/fetched_prediction.dart';

class ReplicateModel extends Equatable {
  final String url;
  final String owner;
  final String name;
  final String description;
  final String? visibility;
  final String? githubUrl;
  final String? paperUrl;
  final String? licenseUrl;
  final Map<String, dynamic>? latestVersion;
  final int runCount;
  final String? coverImageUrl;
  final FetchedPrediction? defaultExample;

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
    required this.runCount,
    required this.coverImageUrl,
    required this.defaultExample,
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
      coverImageUrl: json['cover_image_url'],
      defaultExample: json['default_example'] != null
          ? FetchedPrediction.fromJson(json['default_example'])
          : null,
      runCount: json['run_count'],
    );
  }

  @override
  List<Object?> get props => [
        url,
        owner,
        name,
        description,
        visibility,
        githubUrl,
        paperUrl,
        licenseUrl,
        latestVersion,
      ];
}
