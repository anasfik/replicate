import '../../replicate.dart';

abstract class ReplicatePredictionBase
    implements
        CreatePrediction,
        CreatePredictionStream,
        ListPredictions,
        GetPrediction,
        CancelPrediction {}

abstract class CreatePredictionStream {
  Stream createWithStream({
    required String version,
    required Map<String, dynamic> input,
  });
}

abstract class CancelPrediction {
  Future cancel({
    required String id,
  });
}

abstract class GetPrediction {
  Future get({
    required String id,
  });
}

abstract class ListPredictions {
  Future<PredictionsPagination> list();
}

abstract class CreatePrediction {
  Future create({
    required String version,
    required Map<String, dynamic> input,
  });
}
