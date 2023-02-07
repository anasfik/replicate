import 'dart:convert';

import 'package:replicate/src/network/builder/headers.dart';

import '../exceptions/replicate_exception.dart';
import '../utils/logger.dart';

import 'package:http/http.dart' as http;

class ReplicateHttpClient {
  Future<T> get<T>({
    required T Function(Map<String, dynamic>) onSuccess,
    required String from,
  }) async {
    ReplicateLogger.logRequestStart(from);
    final response = await http.get(
      Uri.parse(from),
      headers: HeaderBuilder.build(),
    );
    ReplicateLogger.logRequestEnd(from);

    final decodedBody = jsonDecode(response.body) as Map<String, dynamic>;
    final error = decodedBody["error"];
    if (error != null) {
      return onSuccess(decodedBody);
    } else {
      throw ReplicateException(message: error, statsCode: response.statusCode);
    }
  }
}
