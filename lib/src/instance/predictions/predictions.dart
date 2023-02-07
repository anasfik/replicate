import 'package:meta/meta.dart';
import 'package:replicate/src/models/predictions/prediction.dart';
import 'package:replicate/src/network/builder/endpoint_url.dart';
import 'package:replicate/src/network/http_client.dart';

import '../../base/predictions_base.dart';
import '../../models/predictions_pagination/predictions_pagination.dart';

class ReplicatePrediction implements ReplicatePredictionBase {
  @override
  Future cancel({
    required String id,
  }) {
    return ReplicateHttpClient.post(
      to: EndpointUrlBuilder.build(['predictions', id, 'cancel']),
      onSuccess: (Map<String, dynamic> response) {
        return response;
      },
    );
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
  Future get({required String id}) async {
    return await ReplicateHttpClient.get(
      from: EndpointUrlBuilder.build(['predictions', id]),
      onSuccess: (Map<String, dynamic> response) {
        return Prediction.fromJson(response);
      },
    );
  }

  @internal
  Future<PredictionsPagination> listPredictionsFromApiLink({
    required String url,
  }) async {
    return await ReplicateHttpClient.get(
      from: url,
      onSuccess: (Map<String, dynamic> response) {
        return PredictionsPagination.fromJson(response);
      },
    );
  }

  @override
  Future<PredictionsPagination> list() async {
    return await listPredictionsFromApiLink(
      url: EndpointUrlBuilder.build(['predictions']),
    );
  }

  @override
  Stream createWithStream(
      {required String version, required Map<String, dynamic> input}) {
    // TODO: implement createWithStream
    throw UnimplementedError();
  }
}
