import 'dart:async';

import '../../../models/predictions/prediction.dart';

class PredictionStream {
  late final Timer timer;

  final _controller = StreamController<Prediction>();

  Stream<Prediction> get stream => _controller.stream;

  void addPrediction(Prediction prediction) {
    _controller.add(prediction);
  }

  addError(Object error, [StackTrace? stackTrace]) {
    _controller.addError(error, stackTrace);
  }

  void close() {
    _controller.close();
    timer.cancel();
  }

  PredictionStream({
    required Future<Prediction> Function() pollingCallback,
    required Duration pollingInterval,
  }) {
    timer = Timer.periodic(
      pollingInterval,
      (Timer timer) async {
        try {
          Prediction prediction = await pollingCallback();
          addPrediction(prediction);
        } catch (e) {
          addError(e);
        }
      },
    );
  }
}
