import 'package:replicate/src/models/predictions/prediction.dart';
import 'package:replicate/src/network/builder/endpoint_url.dart';
import 'package:replicate/src/network/http_client.dart';

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
  Future<Prediction> create({
    required String version,
    required Map<String, dynamic> input,
    String? webhookCompleted,
  }) {
    return ReplicateHttpClient.post(
      to: EndpointUrlBuilder.build(['predictions']),
      body: {
        'version': version,
        'input': input,
        if (webhookCompleted != null) "webhook_completed": webhookCompleted,
      },
      onSuccess: (Map<String, dynamic> response) {
        return Prediction.fromJson(response);
      },
    );
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
