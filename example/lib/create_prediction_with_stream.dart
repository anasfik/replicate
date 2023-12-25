import 'package:replicate/replicate.dart';

import 'env/env.dart';

void main() async {
  // Setting your API key.
  Replicate.apiKey = Env.apiKey;

  // Setting showLogs to true will print all the requests and responses to the console.
  Replicate.showLogs = true;

  // Creating a prediction.
  Prediction firstPrediction = await Replicate.instance.predictions.create(
    version: "50adaf2d3ad20a6f911a8a9e3ccf777b263b8596fbd2c8fc26e8888f8a0edbb5",
    input: {
      "image": "https://i.stack.imgur.com/KEtWo.png",
    },
  );

  // getting the stream of that prediction with it's id after it's created.
  Stream<Prediction> firstPredictionStream =
      Replicate.instance.predictions.snapshots(
    id: firstPrediction.id,
    pollingInterval: Duration(seconds: 2),
  );

  // listening to the stream and printing the output when the prediction is done.
  firstPredictionStream.listen((Prediction prediction) {
    if (prediction.status == PredictionStatus.succeeded) {
      print("first prediction output: ${prediction.output}");
    }
  });
}
