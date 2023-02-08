import 'dart:async';

import 'package:replicate/src/utils/logger.dart';

import '../../../models/predictions/prediction.dart';

/// This class is responsible for creating a stream that will be used to poll the prediction's status.
///
/// Example:
/// ```dart
/// PredictionStream(
///   pollingCallback: () => Replicate.instance.predictions.get(predictionId),
/// pollingInterval: Duration(seconds: 1),
/// shouldTriggerOnlyStatusChanges: true,
/// stopPollingRequestsOnPredictionTermination: true,
/// );
/// ```
///
/// The [pollingCallback] is a function that will be called every [pollingInterval] to get the prediction's status.
///
/// The [shouldTriggerOnlyStatusChanges] is a boolean that will be used to determine if the stream should trigger only when the prediction's status changes.
///
/// The [stopPollingRequestsOnPredictionTermination] is a boolean that will be used to determine if the stream should stop polling the prediction's status when it's terminated.
///
/// The [pollingInterval] is a [Duration] that will be used to determine how often the [pollingCallback] will be called.
class PredictionStream {
  /// This is the timer that will be used to poll the prediction's status periodically  every [pollingInterval].
  late final Timer timer;

  /// This is the stream controller that will be used to add new [Prediction] objects to the stream.
  final _controller = StreamController<Prediction>();

  /// This is the previous prediction's status that will be used to determine if the prediction's status changed.
  /// This is used only when [shouldTriggerOnlyStatusChanges] is set to true.
  /// This is set to null by default.
  PredictionStatus? previousPredictionStatus;

  /// This is the stream that will be used to listen to the prediction's status.
  Stream<Prediction> get stream => _controller.stream;

  /// This is the function that will be called every [pollingInterval] to add a new [Prediction] object to the stream.
  void addPrediction(Prediction prediction) {
    _controller.add(prediction);
  }

  /// This is the function that will be called to add an error to the stream.

  void addError(Object error, [StackTrace? stackTrace]) {
    _controller.addError(error, stackTrace);
  }

  /// This is the function that will be called to close the stream, cancel the timer and stop polling the prediction's status.
  void close() {
    _controller.close();
    timer.cancel();
  }

  bool _didPredictionStatusChanged(Prediction prediction) {
    return previousPredictionStatus != prediction.status;
  }

  void _setStatusForNextPolling(PredictionStatus predictionStatus) {
    previousPredictionStatus = predictionStatus;
  }

  /// This class is responsible for creating a stream that will be used to poll the prediction's status.
  ///
  /// Example:
  /// ```dart
  /// PredictionStream(
  ///   pollingCallback: () => Replicate.instance.predictions.get(predictionId),
  /// pollingInterval: Duration(seconds: 1),
  /// shouldTriggerOnlyStatusChanges: true,
  /// stopPollingRequestsOnPredictionTermination: true,
  /// );
  /// ```
  ///
  /// The [pollingCallback] is a function that will be called every [pollingInterval] to get the prediction's status.
  ///
  /// The [shouldTriggerOnlyStatusChanges] is a boolean that will be used to determine if the stream should trigger only when the prediction's status changes.
  ///
  /// The [stopPollingRequestsOnPredictionTermination] is a boolean that will be used to determine if the stream should stop polling the prediction's status when it's terminated.
  ///
  /// The [pollingInterval] is a [Duration] that will be used to determine how often the [pollingCallback] will be called.
  PredictionStream({
    required Future<Prediction> Function() pollingCallback,
    required Duration pollingInterval,
    required bool shouldTriggerOnlyStatusChanges,
    required bool stopPollingRequestsOnPredictionTermination,
  }) {
    timer = Timer.periodic(
      pollingInterval,
      (Timer timer) async {
        try {
          Prediction prediction = await pollingCallback();

          if (shouldTriggerOnlyStatusChanges) {
            if (_didPredictionStatusChanged(prediction)) {
              addPrediction(prediction);
              _setStatusForNextPolling(prediction.status);
            }
          } else {
            addPrediction(prediction);
          }

          if (prediction.isTerminated) {
            if (stopPollingRequestsOnPredictionTermination) {
              ReplicateLogger.logPredictionTermination(prediction.id);
              close();
            }
          }
        } catch (e) {
          addError(e);
        }
      },
    );
  }
}
