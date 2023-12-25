Note: This assumes that you have an open terminal in this directory (/example):

To set up this examples project:

1. rename the file `env.example` to `.env`

```bash
mv env.example .env
```

2. fill the `.env` file with your replicate API key:

```env
REPLICATE_API_KEY=<YOUR_API_KEY>
```

3. run:

```bash
# get packages
dart pub get

# loads your .env file and generates the env.g.dart at lib/env/env.g.dart
dart run build_runner build
```

4. run the examples:

```bash
# run the example
dart run lib/<example_file_name>
```

