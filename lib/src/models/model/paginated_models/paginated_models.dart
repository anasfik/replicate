import 'package:collection/collection.dart';
import 'package:replicate/replicate.dart';
import '../../../instance/models/models.dart';
import 'sub_models/pagination_model.dart';

/// This class lets you get a  paginated list of models, with the ability to fetch the next and previous pages if they exist.
class PaginatedModels {
  /// The API URL for the previous page of results.
  String? previousApiUrl;

  /// The API URL for the next page of results.
  String? nextApiUrl;

  /// The list of models.
  List<PaginationModel> results;

  /// This class lets you get a  paginated list of models, with the ability to fetch the next and previous pages if they exist.
  PaginatedModels({
    this.previousApiUrl,
    this.nextApiUrl,
    required this.results,
  });

  /// This method lets you get a paginated list of models, with the ability to fetch the next and previous pages if they exist.
  factory PaginatedModels.fromJson(Map<String, dynamic> json) {
    return PaginatedModels(
      previousApiUrl: json['previous'],
      nextApiUrl: json['next'],
      results: (json['results'] as List)
          .map((e) => PaginationModel.fromJson(e))
          .toList(),
    );
  }

  /// This can be used to check if there is a next page before calling [next].
  bool get hasNextPage => nextApiUrl != null;

  /// This can be used to check if there is a previous page before calling [previous].
  bool get hasPreviousPage => previousApiUrl != null;

  /// This method lets you get the next page of models.
  /// If there is no next page, it will throw a [NoNextPageException].
  /// If you want to check if there is a next page before calling this method, use [hasNextPage].
  ///
  /// ```dart
  /// final paginatedModels = await ReplicateModels().listModels();
  ///  if (paginatedModels.hasNextPage) {
  ///   final nextPage = await paginatedModels.next();
  ///  print(nextPage.results);
  /// }
  /// ```
  Future<PaginatedModels> next() async {
    if (!hasNextPage) {
      throw NoNextPageException();
    }

    assert(nextApiUrl != null, "No next page exists for this list");

    return await ReplicateModels().listModelsFromApiLink(nextApiUrl!);
  }

  /// This method lets you get the previous page of models.
  /// If there is no previous page, it will throw a [NoPreviousPageException].
  /// If you want to check if there is a previous page before calling this method, use [hasPreviousPage].
  /// ```dart
  /// final paginatedModels = await ReplicateModels().listModels();
  /// if (paginatedModels.hasPreviousPage) {
  ///  final previousPage = await paginatedModels.previous();
  /// print(previousPage.results);
  /// }
  /// ```
  Future<PaginatedModels> previous() async {
    if (!hasPreviousPage) {
      throw NoPreviousPageException();
    }

    assert(previousApiUrl != null, "No previous page exists for this list");

    return await ReplicateModels().listModelsFromApiLink(previousApiUrl!);
  }

  @override
  String toString() {
    return 'PaginatedModels(previousApiUrl: $previousApiUrl, nextApiUrl: $nextApiUrl, results: $results)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    final listEquals = const ListEquality<PaginationModel>().equals;

    return other is PaginatedModels &&
        other.previousApiUrl == previousApiUrl &&
        other.nextApiUrl == nextApiUrl &&
        listEquals(other.results, results);
  }

  @override
  int get hashCode {
    return previousApiUrl.hashCode ^ nextApiUrl.hashCode ^ results.hashCode;
  }
}
