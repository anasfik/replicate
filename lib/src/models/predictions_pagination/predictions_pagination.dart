import 'package:collection/collection.dart';
import 'package:replicate/replicate.dart';
import 'sub_models/pagination_prediction.dart';

class PredictionsPagination {
  final String? previousApiUrl;
  final String? nextApiUrl;
  final List<PaginationPrediction> results;

  PredictionsPagination({
    this.previousApiUrl,
    this.nextApiUrl,
    required this.results,
  });

  factory PredictionsPagination.fromJson(Map<String, dynamic> json) {
    return PredictionsPagination(
      previousApiUrl: json['previous'],
      nextApiUrl: json['next'],
      results: (json['results'] as List)
          .map((e) => PaginationPrediction.fromJson(e))
          .toList(),
    );
  }

  @override
  String toString() =>
      'PredictionsPagination(previousApiUrl: $previousApiUrl, nextApiUrl: $nextApiUrl, results: $results)';

  @override
  bool operator ==(covariant PredictionsPagination other) {
    if (identical(this, other)) return true;
    final listEquals = const DeepCollectionEquality().equals;

    return other.previousApiUrl == previousApiUrl &&
        other.nextApiUrl == nextApiUrl &&
        listEquals(other.results, results);
  }

  bool hasNextPage() {
    return nextApiUrl != null;
  }

  bool hasPreviousPage() {
    return previousApiUrl != null;
  }

  Future<PredictionsPagination> previousPaginationList() async {
    assert(previousApiUrl != null, "No previous page exists for this list");
    return await Replicate.instance.predictions.listPredictionsFromApiLink(
      url: previousApiUrl!,
    );
  }

  Future<PredictionsPagination> nextPaginationList() async {
    assert(nextApiUrl != null, "No next page exists for this list");
    return await Replicate.instance.predictions.listPredictionsFromApiLink(
      url: nextApiUrl!,
    );
  }

  @override
  int get hashCode =>
      previousApiUrl.hashCode ^ nextApiUrl.hashCode ^ results.hashCode;
}
