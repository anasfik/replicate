import 'package:replicate/replicate.dart';
import '../env/env.dart';

Future<void> main() async {
  Replicate.apiKey = Env.apiKey;

  final predictions = await Replicate.instance.predictions.list();

  for (final prediction in predictions.results) {
    print(prediction.id);
  }
}
