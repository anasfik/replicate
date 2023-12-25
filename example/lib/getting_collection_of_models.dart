import 'package:replicate/replicate.dart';

import 'env/env.dart';

void main() async {
  // Setting your API key.
  Replicate.apiKey = Env.apiKey;

  // Setting showLogs to true will print all the requests and responses to the console.
  Replicate.showLogs = true;

  // Getting a collection of models with the "super-resolution" collection slug.
  final collection = await Replicate.instance.models.collection(
    collectionSlug: "super-resolution",
  );

  // Printing the models in the collection.
  print(collection.models);

  // You can after that as example get a model from the collection, with more details.
  ReplicateModel model = await Replicate.instance.models.get(
    modelOwner: "replicate",
    modelNme: "hello-world",
  );

  // Printing the model's github url.
  print(model.githubUrl);
}
