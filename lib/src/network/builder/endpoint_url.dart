class EndpointUrlBuilder {
  static const String _baseUrl = 'https://api.replicate.com';
  static const String _version = 'v1';

  static String build(List<String> paths) {
    final path = paths.join('/');
    return '$_baseUrl/$_version/$path';
  }
}
