import 'package:meta/meta.dart';
import 'package:replicate/src/models/paginated_models/paginated_models.dart';
import 'package:replicate/src/models/paginated_models/sub_models/pagination_model.dart';
import 'package:replicate/src/network/builder/endpoint_url.dart';
import 'package:replicate/src/network/http_client.dart';

import '../../base/models_base.dart';
import '../../models/model/model.dart';

class ReplicateModels implements ReplicateModelsBase {
  /// Gets a single model, based on it's owner and name, and returns it as a [ReplicateModel].
  ///
  ///
  /// [modelOwner] is the username of the model owner.
  ///
  ///
  /// [modelNme] is the name of the model.
  ///
  /// ```dart
  /// ReplicateModel model = await Replicate.instance.models.get(
  ///  modelOwner: "replicate",
  /// modelNme: "hello-world",
  /// );
  /// print(model);
  /// ```
  @override
  Future<ReplicateModel> get({
    required String modelOwner,
    required String modelNme,
  }) async {
    return await ReplicateHttpClient.get<ReplicateModel>(
        from: EndpointUrlBuilder.build(["models", modelOwner, modelNme]),
        onSuccess: (Map<String, dynamic> response) {
          return ReplicateModel.fromJson(response);
        });
  }

  /// Gets a paginated list of models, based on an api link.
  ///
  /// [apiUrl] is the api link to get the models from.
  @internal
  @protected
  Future<PaginatedModels> listModelsFromApiLink(String apiUrl) async {
    return await ReplicateHttpClient.get<PaginatedModels>(
      from: apiUrl,
      onSuccess: (Map<String, dynamic> response) {
        return PaginatedModels.fromJson(response);
      },
    );
  }

  /// Gets a model's versions as a paginated list, based on it's owner and name.
  /// if you want to get a specific version, use [version].
  ///
  ///
  /// [modelOwner] is the username of the model owner.
  ///
  ///
  /// [modelNme] is the name of the model.
  ///
  /// ```dart
  /// final modelVersions = await ReplicateModels().versions(
  /// modelOwner: "replicate",
  /// modelNme: "hello-world",
  /// );
  /// print(modelVersions.results);
  ///
  /// if (modelVersions.hasNextPage) {
  ///  final nextPage = await modelVersions.next();
  ///  print(nextPage.results);
  /// }
  /// ```
  @override
  Future<PaginatedModels> versions({
    required String modelOwner,
    required String modelNme,
  }) async {
    return await listModelsFromApiLink(
      EndpointUrlBuilder.build(["models", modelOwner, modelNme, "versions"]),
    );
  }

  @override
  Future<List> collection({
    required String collectionSlug,
  }) {
    // TODO: implement collection
    throw UnimplementedError();
  }

  @override
  Future<void> delete(
      {required String modelOwner,
      required String modelNme,
      required String versionId}) async {
    return await ReplicateHttpClient.delete(
      from: EndpointUrlBuilder.build(
          ["models", modelOwner, modelNme, "versions", versionId]),
      onSuccess: () {
        return;
      },
    );
  }

  @override
  Future<PaginationModel> version({
    required String modelOwner,
    required String modelNme,
    required String versionId,
  }) async {
    return await ReplicateHttpClient.get<PaginationModel>(
      from: EndpointUrlBuilder.build(
          ["models", modelOwner, modelNme, "versions", versionId]),
      onSuccess: (Map<String, dynamic> response) {
        return PaginationModel.fromJson(response);
      },
    );
  }
}
