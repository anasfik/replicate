import '../../base/predictions_base.dart';

class ReplicatePrediction implements ReplicatePredictionBase {
  @override
  Future cancel({
    required String id,
  }) {
    // TODO: implement cancel
    throw UnimplementedError();
  }

  @override
  Future create({
    required String version,
    required Map<String, dynamic> input,
  }) {
    // TODO: implement create
    throw UnimplementedError();
  }

  @override
  Future get({required String id}) {
    // TODO: implement get
    throw UnimplementedError();
  }

  @override
  Future<List> list() {
    // TODO: implement list
    throw UnimplementedError();
  }

  @override
  Stream createWithStream(
      {required String version, required Map<String, dynamic> input}) {
    // TODO: implement createWithStream
    throw UnimplementedError();
  }
}
