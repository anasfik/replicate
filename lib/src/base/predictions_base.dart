import '../../replicate.dart';

abstract class ReplicatePredictionBase
    implements
        CreatePrediction,
        CreatePredictionStream,
        GetPrediction,
        CancelPrediction {}

abstract class CreatePredictionStream {
  Stream<Prediction> snapshots({
    required String id,
  });
}

abstract class CancelPrediction {
  Future cancel({
    required String id,
  });
}

abstract class GetPrediction {
  Future<Prediction> get({
    required String id,
  });
}

abstract class CreatePrediction {
  Future<Prediction> create({
    required String version,
    required Map<String, dynamic> input,
    String? webhook,
    List<String>? webhookEventsFilter,
  });
}
