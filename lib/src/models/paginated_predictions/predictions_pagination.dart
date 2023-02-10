import 'package:collection/collection.dart';
import 'package:replicate/src/instance/predictions/predictions.dart';

import '../../exceptions/no_next_page_exception.dart';
import '../../exceptions/no_previous_page_exception.dart';
import 'predictions_pagination.dart';
export 'sub_models/pagination_prediction.dart';

class PaginatedPredictions {
  final String? previousApiUrl;
  final String? nextApiUrl;
  final List<PaginationPrediction> results;

  PaginatedPredictions({
    this.previousApiUrl,
    this.nextApiUrl,
    required this.results,
  });

  factory PaginatedPredictions.fromJson(Map<String, dynamic> json) {
    return PaginatedPredictions(
      previousApiUrl: json['previous'],
      nextApiUrl: json['next'],
      results: (json['results'] as List)
          .map((e) => PaginationPrediction.fromJson(e))
          .toList(),
    );
  }

  @override
  String toString() =>
      'PaginatedPredictions(previousApiUrl: $previousApiUrl, nextApiUrl: $nextApiUrl, results: $results)';

  @override
  bool operator ==(covariant PaginatedPredictions other) {
    if (identical(this, other)) return true;
    final listEquals = const DeepCollectionEquality().equals;

    return other.previousApiUrl == previousApiUrl &&
        other.nextApiUrl == nextApiUrl &&
        listEquals(other.results, results);
  }

  bool get hasNextPage {
    return nextApiUrl != null;
  }

  bool get hasPreviousPage {
    return previousApiUrl != null;
  }

  Future<PaginatedPredictions> previous() async {
    if (!hasPreviousPage) {
      throw NoPreviousPageException();
    }
    assert(previousApiUrl != null, "No previous page exists for this list");
    return await ReplicatePrediction().listPredictionsFromApiLink(
      url: previousApiUrl!,
    );
  }

  Future<PaginatedPredictions> next() async {
    if (!hasNextPage) {
      throw NoNextPageException();
    }
    assert(nextApiUrl != null, "No next page exists for this list");
    return await ReplicatePrediction().listPredictionsFromApiLink(
      url: nextApiUrl!,
    );
  }

  @override
  int get hashCode =>
      previousApiUrl.hashCode ^ nextApiUrl.hashCode ^ results.hashCode;
}
