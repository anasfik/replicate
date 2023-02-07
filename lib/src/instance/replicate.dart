import '../exceptions/missing_api_key_exception.dart';
import 'predictions/predictions.dart';

class Replicate {
  /// This is an internal api key that is used to make requests to the Replicate API, can be set only with it's setter.
  static String? _internalApiKey;

  /// The api key that is used to make requests to the Replicate API, you can only set it's value.
  /// Example:
  /// ```dart
  /// Replicate.apiKey = <YOUR_API_KEY>
  /// ```
  static set apiKey(String apiKey) {
    _internalApiKey = apiKey;
  }

  /// This is the only allowed instance to be created by the [Replicate] class.
  /// You can access it with the public [instance] getter.
  static final Replicate _instance = Replicate._();
  static get instance {
    if (_internalApiKey == null) {
      throw MissingApiKeyException("""
      You must set the api key before accessing the instance of this class.
      Example:
      Replicate.apiKey = "Your API Key";
      """);
    }
    return _instance;
  }

  /// This is responsible for showing the logs about what is happening under the hood on this client library, by default it's set to true, so you can track what is when you call a method.
  /// But, if you want to disable it, you can set it to false.
  /// Example:
  /// ```dart
  /// Replicate.showLogs = false
  /// ```
  static set showLogs(bool newValue) {}

  /// This is the responsible member of the Replicate's predictions, where you can call the methods to create, get, list and cancel predictions.
  /// Example:
  /// ```dart
  /// Replicate.instance.predictions.create(...)
  ReplicatePrediction predictions() => ReplicatePrediction();

  // A private constructor. Allows us to create instance of Replicate only from within the Replicate class itself.
  Replicate._();
}
