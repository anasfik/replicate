import 'package:envied/envied.dart';

part 'env.g.dart';

@Envied()
abstract class Env {
  @EnviedField(varName: 'REPLICATE_API_KEY')
  static final String apiKey = _Env.apiKey;
}
