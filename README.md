# Replicate Dart Client

A community-maintained Dart client package for Replicate.com, this package let you interact with Replicate.com APIs and create predictions from the available machine learning models.

## Key Features:

- Easy to call `Future` methods for creating, Getting, Cancelling one prediction, and getting a pagination list of predictions used.
- `Stream` availability for listening to a predictions changes in realtime.
- Dynamic inputs for the possibility to use any model available on Replicate.com flexibly.
- Wrappers around response fields, for a better developer experience.
- Easy to configure, and set your settings using this library.

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

print(prediction);
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

## Get list of predictions

You can get a paginated list of predictions that you've created with your account by calling :

```dart
PredictionsPagination predictionsPageList = await Replicate.instance.predictions.list();

print(predictionsPageList.results);
```

This includes predictions created from the API and the Replicate website. Returns 100 records per page.

You can check before requesting the next/previous pagination lists:

```dart
if (predictionsPageList.hasNextPage) {
  PredictionsPagination next = await predictionsPageList.next();
  print(next.results);
}
if (predictionsPageList.hasPreviousPage) {
  PredictionsPagination prev = await predictionsPageList.previous();
  print(prev.results);
}
```

## Listening to prediction changes.

After Creating a new prediction with [Create Prediction](#create_prediction), while it is running, you can get a `Stream` of its changes in real-time by calling:

```dart
Stream<Prediction> predictionStream = Replicate.instance.predictions.snapshots(
    id: "<PREDICTION_ID>",
);

predictionStream.listen((Prediction prediction) {
   print(prediction.status);
});

```

By default, every time the status of the prediction changes, a new `Prediction` will be emitted to the `predictionStream`, but you can change and configure this behavior to meet your specific needs.

<br>

## I don't want to listen to changes by `Stream`.

Well, Replicate.com offers also a webhook feature.

while [creating a prediction](#create_prediction), you can set the `webhookCompleted` property to your HTTPS URL which will receive the response when the prediction is completed:

```dart
Prediction prediction = await Replicate.instance.predictions.create(
    version: "<MODEL_VERSION>",
    input: {
      "field_name": "<field_value>",
    },
    webhookCompleted: "<YOUR_HTTPS_URL>", // add this
  );
```

learn more about the webhook feature [from here](https://replicate.com/docs/reference/http#create-prediction--webhook_completed)
