import 'package:example/env/env.dart';
import 'package:replicate/replicate.dart';

Future<void> main() async {
  Replicate.apiKey = Env.apiKey;

  final predictionId = "j6amk5bbfnuknkbz3cr2bgk62i";

  final prediction = await Replicate.instance.predictions.get(
    id: predictionId,
  );

  print(prediction.urls);
}
