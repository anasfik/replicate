import 'dart:async';

import '../../../models/predictions/prediction.dart';

class PredictionStream {
  PredictionStream(Future<Prediction> Function() callback) {
    final timer = Timer.periodic(
      Duration(seconds: 3),
      (Timer timer) {
        callback().then(
          (prediction) {
            addPrediction(prediction);
          },
        );
      },
    );
  }
  final _controller = StreamController<Prediction>();

  void addPrediction(Prediction prediction) {
    _controller.add(prediction);
  }

  addError(Object error, [StackTrace? stackTrace]) {
    _controller.addError(error, stackTrace);
  }

  Stream<Prediction> get stream => _controller.stream;

  void close() {
    _controller.close();
  }
}
