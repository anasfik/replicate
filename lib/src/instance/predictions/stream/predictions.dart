import 'dart:async';

import '../../../models/predictions/prediction.dart';

class PredictionStream {
  late final Timer timer;
  PredictionStatus? previousPredictionStatus;
  final _controller = StreamController<Prediction>();

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

  PredictionStream({
    required Future<Prediction> Function() pollingCallback,
    required Duration pollingInterval,
    required bool triggerOnlyStatusChanges,
  }) {
    timer = Timer.periodic(
      pollingInterval,
      (Timer timer) async {
        try {
          Prediction prediction = await pollingCallback();

          if (triggerOnlyStatusChanges) {
            if (previousPredictionStatus != prediction.predictionStatus) {
              addPrediction(prediction);
              previousPredictionStatus = prediction.predictionStatus;
            }
          } else {
            addPrediction(prediction);
          }
        } catch (e) {
          addError(e);
        }
      },
    );
  }
}
