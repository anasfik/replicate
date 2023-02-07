import 'package:meta/meta.dart';

abstract class ReplicateModelsBase
    implements
        GetModel,
        GetModelsVersions,
        GetModelVersion,
        DeleteModelVersion,
        GetCollectionsModels {}

abstract class GetCollectionsModels {
  Future<List> collection({
    required String collectionSlug,
  });
}

abstract class DeleteModelVersion {
  Future delete();
}

abstract class GetModelVersion {
  Future version();
}

abstract class GetModelsVersions {
  Future<List> versions();
}

abstract class GetModel {
  Future get({
    required String modelOwner,
    required String modelNme,
  });
}
