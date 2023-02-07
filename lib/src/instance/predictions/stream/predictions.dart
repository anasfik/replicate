import 'dart:async';

import '../../../models/predictions/prediction.dart';

class PredictionStream {
  final _controller = StreamController<Prediction>();

  void addPrediction(Prediction prediction) {
    _controller.add(prediction);
  }

  Stream<Prediction> get stream => _controller.stream;
  void close() {
    _controller.close();
  }
}
