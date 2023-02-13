import '../../../replicate.dart';

class ModelsCollection {
  /// The name of the collection.
  final String name;

  /// The slug of the collection.
  final String slug;

  /// The description of the collection.
  final String description;

  /// The models list in the collection, as a [List] of [ReplicateModel].
  final List<ReplicateModel> models;

  ModelsCollection({
    required this.name,
    required this.slug,
    required this.description,
    required this.models,
  });

  factory ModelsCollection.fromJson(Map<String, dynamic> json) {
    return ModelsCollection(
      name: json['name'],
      slug: json['slug'],
      description: json['description'],
      models: List.generate(
        json['models'].length,
        (index) => ReplicateModel.fromJson(json['models'][index]),
      ),
    );
  }
}
