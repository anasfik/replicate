# Replicate Dart Client

A community-maintained Dart client package for Replicate.com, this package let you interact with Replicate.com APIs and create predictions from the available machine learning models.

## Key Features.

- Easy to call methods for creating, Getting, Cancelling one prediction, and getting a pagination lists of predictions used.
- `Stream` availability for listening to a predictions changes in realtime.
- Dynamic inputs for the possibility to use any model available on Replicate.com flexibly.
- Wrappers around response fields, for a better developer experience.
- Easy to configure, and set your settings using this library.

# Full Documentation

You can check the Full Documentation of this library [from here](https://pub.dev/documentation/replicate/latest/).

# Usage

### Authentication

Before making any requests, you should set your API key so it will be used to make requests to your account on `Replicate.com`.

```dart
  Replicate.apiKey = "<YOUR_API_KEY>";
```

###### **Recommendation**:

it's better to load your api key from a `.env` file, you can do this in Dart using [dotenv](https://pub.dev/packages/dotenv) package.

<br>

## Create Prediction

You can call this to start creating a new prediction for the version and input you will provide, since the models can take some time to run, This `output` will not be available immediately, it will return a `Prediction` with the returned response from Replicate.com, with a `status` set to the prediction status at this point:

```dart
Prediction prediction = await Replicate.instance.predictions.create(
    version: "<MODEL_VERSION>",
    input: {
      "field_name": "<field_value>",
    },
  );
```

Note that `input` takes a `Map<String, dynamic>` as a value since every model has its input accepted fields.

#### Experimental:

if you want to create a new prediction for a model that accepts a file field(s), you need just to set that field(s) value to a `File` object of your file when creating the `input` of the prediction.

<br>

## Get Prediction

if you need to get a Prediction at a specific point in time, you can call the `Replicate.instance.predictions.get()` method, it will return a new `Prediction` object with the requested prediction data:

```dart
Prediction prediction = await Replicate.instance.predictions.get(
    id: "<PREDICTION_ID>",
);

print(prediction); // ...
```

A `Prediction` object is a container for prediction progress data (status, logs, output, metrics... ) requested from your `Replicate.com` dashboard.

When a `Prediction` is Terminated, the `metrics` property will have a `predictTime` property with the amount of CPU or GPU time, in seconds, that this prediction used while running. This is the time you're billed for, and it doesn't include time waiting for the prediction to start.

A `Prediction` is considered terminated when the `status` property is one of :

- `PredictionStatus.succeeded`
- `PredictionStatus.canceled`
- `PredictionStatus.failed`

You might want to give a quick look over [Get Prediction](https://replicate.com/docs/reference/http#get-prediction).

<br>

## Cancel Prediction

You can cancel a running prediction by calling `Replicate.instance.predictions.cancel()` :

```dart
final canceledPrediction = await Replicate.instance.predictions.cancel(
  id: "<PREDICTION_ID>",
);
```

<br>

## Get list of predictions

You can get a paginated list of predictions that you've created with your account by calling :

```dart
PaginatedPredictions predictionsPageList = await Replicate.instance.predictions.list();

print(predictionsPageList.results); // ...
```

This includes predictions created from the API and the Replicate website. Returns 100 records per page.

You can check before requesting the next/previous pagination lists:

```dart
if (predictionsPageList.hasNextPage) {
  PaginatedPredictions next = await predictionsPageList.next();
  print(next.results); // ...
}
if (predictionsPageList.hasPreviousPage) {
  PaginatedPredictions prev = await predictionsPageList.previous();
  print(prev.results); // ...
}
```

<br>

## Listening to prediction changes.

After Creating a new prediction with [Create Prediction](#create-prediction), while it is running, you can get a `Stream` of its changes in real-time by calling:

```dart
Stream<Prediction> predictionStream = Replicate.instance.predictions.snapshots(
    id: "<PREDICTION_ID>",
);

predictionStream.listen((Prediction prediction) {
   print(prediction.status); // ...
});

```

By default, every time the status of the prediction changes, a new `Prediction` will be emitted to the `predictionStream`, but you can change and configure this behavior to meet your specific needs by specifying a `pollingInterval`, `shouldTriggerOnlyStatusChanges`, `stopPollingRequestsOnPredictionTermination`..

This functionality is based on polling request as it's recommended by [replicate from here](https://replicate.com/docs/reference/http#create-prediction).

<br>

## I don't want to listen to changes by `Stream`.

Well, Replicate.com offers also notifying with webhook feature.

while [creating a prediction](#create-prediction), you can set the `webhookCompleted` property to your HTTPS URL which will receive the response when the prediction is completed:

```dart
Prediction prediction = await Replicate.instance.predictions.create(
    version: "<MODEL_VERSION>",
    input: {
      "field_name": "<field_value>",
    },
    webhookCompleted: "<YOUR_HTTPS_URL>", // add this
  );
```

learn more about the webhook feature [from here](https://replicate.com/docs/reference/http#create-prediction--webhook_comple)

<br>

## Get Model

Gets a single model, based on it's owner and name, and returns it as a [ReplicateModel].

```dart
ReplicateModel model = await Replicate.instance.models.get(
  modelOwner: "replicate",
  modelNme: "hello-world",
);

print(model);  // ...
print(model.url);  // ...
print(model.owner); // replicate
```

<br>

## Get a list of model versions

Gets a model's versions as a paginated list, based on it's owner and name.

if you want to get a specific version, check [Get A Model Version](#get-a-model-version).

You can load the next and previous pagination list of a current on, by using `next()` and `previous()` method.

if no next or previous pages exists for a pagination list, a `NoNextPageException` or `NoPreviousPageException` will be thrown.

For avoiding those exceptions at all, you can check for the next and previos pages existence using the `hasNextPage` and `hasPreviousPage` :

```dart
PaginatedModels modelVersions = await Replicate.instance.model.versions(
 modelOwner: "replicate",
 modelNme: "hello-world",
);

print(modelVersions.results); // ...

// loads the next page if it exists
if (modelVersions.hasNextPage) {
 PaginatedModels nextPage = await modelVersions.next();

 print(nextPage.results); // ...
}
```

<br>

## Get A Model Version

Gets a single model version, based on it's owner, name, and version id.

if you want to get a list of versions, check [Get a list of model versions](#get-a-list-of-model-versions).

```dart
PaginationModel modelVersion = await Replicate.instance.models.version(
 modelOwner: "replicate",
 modelNme: "hello-world",
 versionId: "5c7d5dc6dd8bf75c1acaa8565735e7986bc5b66206b55cca93cb72c9bf15ccaa",
);

print(modelVersion.id); // ...
```

<br>

## Delete A Model.

Delete a model version and all associated predictions, including all output files.

```dart
await Replicate.instance.models.delete(
 modelOwner: "/* Owner */",
 modelNme: "/* Model Name */",
 versionId: "/* Version Id */",
);
```

if the file os deleted succefully, nothing will happen actually, so you should expect that the model is deleted if none happens in your code, However, when something goes wrong ( if you try to delete a model which you don't own, a `ReplicateException` will be thrown with the error message ).

<br>

## Get a collection of models.

Loads a collection of models.

```dart
ModelsCollection collection = await Replicate.instance.models.collection(
collectionSlug: "super-resolution",
);

  print(collection.name); // super resolution
  print(collection.models); // ...
```

<br>

# Error Handling

<br>

### ReplicateException

This exception will be thrown when there is an error from the replicate.com end, as example when you hit the rate limit you will get a `ReplicateException` with the message and the status code of the erorr:

```dart
try {
// ...

} on ReplicateException carch(e) {
print(e.message);
print(e.statusCode);
}
```

<br>

### NoNextPageException and NoPreviousPageException

These are special and limited exception when working with [Get A List Of Model Versions](#get-a-list-of-model-versions), when you try to get the `next()` or `previous()` of a pagintaed list that don't exist, one of those exceptions will be thrown, but the way to avoid them totally are included in the documentation.

```dart
try {
PaginatedModels firstPage = // ...
page.previous(); // obviously, there is no previous for first page, right?

} on NoPreviousPageException catch(e) {
print(// no next for this paginated list.);
}
```
