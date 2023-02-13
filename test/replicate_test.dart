import 'package:replicate/replicate.dart';
import 'package:replicate/src/models/paginated_models/sub_models/pagination_model.dart';
import 'package:test/test.dart';

void main() {
  group('authentication', () {
    test('without setting a key', () {
      try {
        Replicate.instance;
        fail('should throw an exception');
      } catch (e) {
        expect(e, isA<MissingApiKeyException>());
      }
    });

    test('with setting a key', () {
      Replicate.apiKey = '<YOUR_API_KEY>';
      try {
        Replicate.instance;
        expect(Replicate.instance, isA<Replicate>());
      } catch (e) {
        fail('should not throw an exception');
      }
    });
  });

  group('predictions', () {
    String? examplePredictionId;

    test('create', () async {
      Prediction prediction = await Replicate.instance.predictions.create(
          version:
              "5c7d5dc6dd8bf75c1acaa8565735e7986bc5b66206b55cca93cb72c9bf15ccaa",
          input: {
            "text": "This is a test",
          });

      expect(prediction, isA<Prediction>());
      expect(prediction.id, isA<String>());

      examplePredictionId = prediction.id;
    });
    test('list', () async {
      PaginatedPredictions list = await Replicate.instance.predictions.list();

      expect(list, isA<PaginatedPredictions>());
      expect(list.results, isA<List<PaginationPrediction>>());
    });

    test('get', () async {
      Prediction prediction = await Replicate.instance.predictions.get(
        id: examplePredictionId!,
      );

      expect(prediction, isA<Prediction>());
      expect(prediction.id, examplePredictionId!);
    });

    test('snapshots', () {
      Stream<Prediction> stream = Replicate.instance.predictions.snapshots(
        id: examplePredictionId!,
        pollingInterval: Duration(seconds: 2),
        shouldTriggerOnlyStatusChanges: true,
        stopPollingRequestsOnPredictionTermination: true,
      );

      expect(stream, isA<Stream<Prediction>>());

      stream.listen((event) {
        expect(event, isA<Prediction>());
        expect(event.id, examplePredictionId!);
      }, onError: (e) {
        fail('should not throw an exception');
      }, onDone: () {
        print('done');
      });
    });

    test('cancel', () async {
      // ! Here I choosed a model version that take some time to run and finish, so I can cancel it before it even starts.
      Prediction prediction = await Replicate.instance.predictions.create(
          version:
              "f178fa7a1ae43a9a9af01b833b9d2ecf97b1bcb0acfd2dc5dd04895e042863f1",
          input: {
            "prompt": "monalisa",
          });

      await Replicate.instance.predictions.cancel(
        id: prediction.id,
      );
    });
  });
  group("models", () {
    test("get", () async {
      ReplicateModel model = await Replicate.instance.models.get(
        modelOwner: "replicate",
        modelNme: "hello-world",
      );

      expect(model, isA<ReplicateModel>());
      expect(model.name, "hello-world");
      expect(model.owner, "replicate");
    });
    test("list", () async {
      PaginatedModels models = await Replicate.instance.models.versions(
        modelOwner: "replicate",
        modelNme: "hello-world",
      );

      expect(models, isA<PaginatedModels>());
      expect(models.results, isA<List<PaginationModel>>());
      if (models.hasNextPage) {
        expect(models.nextApiUrl, isNotNull);
        expect(models.nextApiUrl, isA<String>());

        PaginatedModels nextModels = await models.next();
        expect(nextModels, isA<PaginatedModels>());
        expect(nextModels.results, isA<List<PaginationModel>>());
      }
    });
    test("get version", () async {
      PaginationModel model = await Replicate.instance.models.version(
        modelOwner: "replicate",
        modelNme: "hello-world",
        versionId:
            "5c7d5dc6dd8bf75c1acaa8565735e7986bc5b66206b55cca93cb72c9bf15ccaa",
      );

      expect(model, isA<PaginationModel>());
      expect(model.id, isA<String>());
    });

    test("delete", () async {
      // ! replace this parameters with your model's owner, name and version, so you can delete it.
      await Replicate.instance.models.delete(
        modelOwner: "/* OWNER */",
        modelNme: "/* NAME */",
        versionId: "/* YOUR VERSION */",
      );
    });
  });
}
