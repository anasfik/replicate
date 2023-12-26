import 'package:example/env/env.dart';
import 'package:replicate/replicate.dart';

Future<void> main(List<String> args) async {
  Replicate.apiKey = Env.apiKey;

//! This would delete the model version with the id "5c7d5dc6dd8bf75c1acaa8565735e7986bc5b66206b55cca93cb72c9bf15ccaa" since it is not mine.
  await Replicate.instance.models.delete(
    modelOwner: "Replicate",
    modelName: "hello-world",
    versionId:
        "5c7d5dc6dd8bf75c1acaa8565735e7986bc5b66206b55cca93cb72c9bf15ccaa",
  );
}
