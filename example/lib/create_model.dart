import 'package:example/env/env.dart';
import 'package:replicate/replicate.dart';

Future<void> main() async {
  Replicate.apiKey = Env.apiKey;

  final model = await Replicate.instance.models.get(
    modelOwner: "replicate",
    modelName: "hello-world",
  );

  print(model.coverImageUrl);
  print(model.defaultExample?.id);
}
