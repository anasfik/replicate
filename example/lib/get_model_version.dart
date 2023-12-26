import 'package:example/env/env.dart';
import 'package:replicate/replicate.dart';

Future<void> main(List<String> args) async {
  Replicate.apiKey = Env.apiKey;

  final modelVersion = await Replicate.instance.models.version(
    modelOwner: "replicate",
    modelName: "hello-world",
    versionId:
        "5c7d5dc6dd8bf75c1acaa8565735e7986bc5b66206b55cca93cb72c9bf15ccaa",
  );

  print(modelVersion.id);
  print(modelVersion.cogVersion);
}
