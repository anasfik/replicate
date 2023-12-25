import 'package:example/env/env.dart';
import 'package:replicate/replicate.dart';

Future<void> main() async {
  Replicate.apiKey = Env.apiKey;

  await Replicate.instance.predictions.cancel(id: 'prediction_id');
}
