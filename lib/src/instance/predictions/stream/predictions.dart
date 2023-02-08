import 'dart:async';

import 'package:replicate/src/utils/logger.dart';

import '../../../models/predictions/prediction.dart';

class PredictionStream {
  late final Timer timer;
  final _controller = StreamController<Prediction>();

  PredictionStatus? previousPredictionStatus;

  Stream<Prediction> get stream => _controller.stream;

  void addPrediction(Prediction prediction) {
    _controller.add(prediction);
  }

  void addError(Object error, [StackTrace? stackTrace]) {
    _controller.addError(error, stackTrace);
  }

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
