import 'package:replicate/replicate.dart';

void main() async {
  // Setting your API key.
  Replicate.apiKey = "<YOUR_API_KEY_HERE>";

  // Setting showLogs to true will print all the requests and responses to the console.
  Replicate.showLogs = true;

  // Creating a prediction.
  Prediction firstPrediction = await Replicate.instance.predictions.create(
    version: "50adaf2d3ad20a6f911a8a9e3ccf777b263b8596fbd2c8fc26e8888f8a0edbb5",
    input: {
      "image": "https://i.stack.imgur.com/KEtWo.png",
    },
  );

  // printing the status of the prediction, at this point.
  print(firstPrediction.status);

  // canceling the prediction.
  await Replicate.instance.predictions.cancel(
    id: firstPrediction.id,
  );

  // getting the prediction again.
  Prediction firstPredictionWithId = await Replicate.instance.predictions.get(
    id: firstPrediction.id,
  );

  // printing the status of the prediction, at this point.
  print(firstPredictionWithId.status);
}
