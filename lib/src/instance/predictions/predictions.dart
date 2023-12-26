import 'package:meta/meta.dart';
import 'package:replicate/src/instance/predictions/stream/predictions.dart';
import 'package:replicate/src/models/predictions/prediction.dart';
import 'package:replicate/src/network/builder/endpoint_url.dart';
import 'package:replicate/src/network/http_client.dart';

import '../../base/predictions_base.dart';
import '../../models/predictions/fetched_prediction.dart';

/// This is the responsible member of the Replicate's predictions API, where you can call the methods to create, get, list and cancel predictions.
class ReplicatePrediction implements ReplicatePredictionBase {
  /// This is a registry of all the predictions streams that are used, so we can manage each one of them.
  // final Map<String, PredictionStream> _predictionsStreamRegistry = {};

  /// Cancels a prediction by it's [id], this will stop the prediction from running.
  ///
  /// Example:
  /// ```dart
  /// Replicate.instance.predictions.cancel(id: "prediction-id");
  /// ```
  @override
  Future cancel({
    required String id,
  }) {
    return ReplicateHttpClient.post(
      to: EndpointUrlBuilder.build(['predictions', id, 'cancel']),
      onSuccess: (Map<String, dynamic> response) {
        return response;
      },
    );
  }

  /// Creates a prediction, this will start the prediction process based on the model [version] and the [input] provided, then it will return a [Prediction] object.
  ///
  /// set [webhookCompleted] to a HTTPS URLS where you want to receive a webhook
  /// when the prediction is completed.
  ///
  /// Example:
  /// ```dart
  /// Replicate.instance.predictions.create(
  ///  version: "version-id",
  /// input: {
  ///  "image": "https://example.com/image.jpg"
  /// },
  /// webhookCompleted: "https://example.com/webhook"
  /// );
  /// ```
  @override
  Future<Prediction> create({
    required String version,
    required Map<String, dynamic> input,
    String? webhook,
    List<String>? webhookEventsFilter,
  }) {
    return ReplicateHttpClient.post(
      to: EndpointUrlBuilder.build(['predictions']),
      body: {
        'version': version,
        'input': input,
      },
      onSuccess: (Map<String, dynamic> response) {
        return Prediction.fromJson(response);
      },
    );
  }

  /// Gets a prediction by it's id, this will return a [Prediction] object.
  /// Example:
  /// ```dart
  /// Replicate.instance.predictions.get(id: "prediction-id");
  /// ```
  @override
  Future<FetchedPrediction> get({required String id}) async {
    return await ReplicateHttpClient.get(
      from: EndpointUrlBuilder.build(['predictions', id]),
      onSuccess: (Map<String, dynamic> response) {
        return FetchedPrediction.fromJson(response);
      },
    );
  }

  /// Gets a stream of a prediction updates by it's id, this will return a stream of the [Prediction] object.
  /// This stream is based on polling, so it will poll the prediction status every [pollingInterval] seconds.
  ///
  /// by default, it will only trigger a new event if the prediction status changes, you can change this behavior by setting [shouldTriggerOnlyStatusChanges] to false.
  ///
  /// by default, it will stop polling the prediction status when the prediction is terminated, you can change this behavior by setting  [stopPollingRequestsOnPredictionTermination] to false.
  ///
  /// A prediction is considered terminated when it's status is [PredictionStatus.succeeded], [PredictionStatus.failed] or [PredictionStatus.cancelled].
  ///
  /// Example:
  /// ```dart
  /// Stream<Prediction> stream = Replicate.instance.predictions.snapshots(id: "prediction-id");
  ///
  /// stream.listen((prediction) {
  /// print(prediction);
  /// });
  /// ```
  ///
  /// Example with custom polling interval:
  /// ```dart
  /// Stream<Prediction> stream = Replicate.instance.predictions.snapshots(
  /// id: "prediction-id",
  /// pollingInterval: const Duration(seconds: 5),
  /// );
  ///
  /// stream.listen((prediction) {
  /// print(prediction);
  /// });
  /// ```
  ///
  /// Example with custom polling interval and shouldTriggerOnlyStatusChanges set to false:
  /// ```dart
  /// Stream<Prediction> stream = Replicate.instance.predictions.snapshots(
  /// id: "prediction-id",
  /// pollingInterval: const Duration(seconds: 5),
  /// shouldTriggerOnlyStatusChanges: false,
  /// );
  ///
  /// stream.listen((prediction) {
  /// print(prediction);
  /// });
  /// ```
  @override
  Stream<Prediction> snapshots({
    required String id,
    Duration pollingInterval = const Duration(seconds: 3),
    bool shouldTriggerOnlyStatusChanges = true,
    bool stopPollingRequestsOnPredictionTermination = true,
  }) {
    return Stream.empty();
    // if (_predictionsStreamRegistry.containsKey(id)) {
    //   return _predictionsStreamRegistry[id]!.stream;
    // } else {
    //   final predictionStream = PredictionStream(
    //     pollingCallback: () async {
    //       return await get(id: id);
    //     },
    //     pollingInterval: pollingInterval,
    //     shouldTriggerOnlyStatusChanges: shouldTriggerOnlyStatusChanges,
    //     stopPollingRequestsOnPredictionTermination:
    //         stopPollingRequestsOnPredictionTermination,
    //   );

    //   _predictionsStreamRegistry[id] = predictionStream;
    //   return predictionStream.stream;
    // }
  }

  /// Gets a stream of a prediction status updates by it's id, this will return a stream of the [PredictionStatus] object.
  ///
  /// This stream is based on polling, so it will poll the prediction status every [pollingInterval] seconds.
  ///
  /// Example:
  /// ```dart
  /// Stream<PredictionStatus> statusStream = Replicate.instance.predictions.statusSnapshots(id: "prediction-id");
  ///
  /// statusStream.listen((status) {
  ///  print(status);
  /// });
  /// ```

  // Stream<PredictionStatus> statusSnapshots({
  //   required String id,
  //   Duration pollingInterval = const Duration(seconds: 3),
  // }) {
  //   return snapshots(
  //     id: id,
  //     pollingInterval: pollingInterval,
  //     shouldTriggerOnlyStatusChanges: true,
  //   ).asyncMap<PredictionStatus>((prediction) {
  //     return prediction.status;
  //   });
  // }

  /// Gets a stream of a prediction logs updates by it's id, this will return a stream of [String].
  ///
  /// This stream is based on polling, so it will poll the prediction status every [pollingInterval] seconds.
  ///
  /// by default, it will only trigger a new event if the prediction status changes, you can change this behavior by setting [shouldTriggerOnlyStatusChanges] to false.
  ///
  /// by default, it will stop polling the prediction status when the prediction is terminated, you can change this behavior by setting  [stopPollingRequestsOnPredictionTermination] to false.
  ///
  /// A prediction is considered terminated when it's status is [PredictionStatus.succeeded], [PredictionStatus.failed] or [PredictionStatus.cancelled].
  ///
  /// Example:
  /// ```dart
  /// Stream<String> logsStream = Replicate.instance.predictions.logsSnapshots(id: "prediction-id");
  ///
  /// logsStream.listen((logs) {
  /// print(logs);
  /// });
  /// ```
  ///
  /// Example with custom polling interval:
  /// ```dart
  /// Stream<String> logsStream = Replicate.instance.predictions.logsSnapshots(
  /// id: "prediction-id",
  /// pollingInterval: const Duration(seconds: 5),
  /// );
  ///
  /// logsStream.listen((logs) {
  /// print(logs);
  /// });
  /// ```
  ///
  /// Example with custom polling interval and shouldTriggerOnlyStatusChanges set to false:
  /// ```dart
  /// Stream<String> logsStream = Replicate.instance.predictions.logsSnapshots(
  /// id: "prediction-id",
  /// pollingInterval: const Duration(seconds: 5),
  /// shouldTriggerOnlyStatusChanges: false,
  /// );
  ///
  /// logsStream.listen((logs) {
  /// print(logs);
  /// });
  /// ```
  Stream<String> logsSnapshots({
    required String id,
    Duration pollingInterval = const Duration(seconds: 3),
    bool shouldTriggerOnlyStatusChanges = false,
    bool stopPollingRequestsOnPredictionTermination = true,
  }) {
    return Stream.empty();

    // return snapshots(
    // id: id,
    // pollingInterval: pollingInterval,
    // shouldTriggerOnlyStatusChanges: shouldTriggerOnlyStatusChanges,
    // stopPollingRequestsOnPredictionTermination:
    // stopPollingRequestsOnPredictionTermination,
    // ).asyncMap<String>((prediction) {
    // return prediction.logs;
    // });
  }
}
