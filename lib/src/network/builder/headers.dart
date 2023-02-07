class HeaderBuilder {
  static String? _internalApiKey;

  static Map<String, String> build([bool includeContentType = false]) {
    final Map<String, String> map = {};

    map.addEntries({
      _buildAuthorizationsHeader(),
      if (includeContentType) _buildContentType(),
    });

    return map;
  }

  static MapEntry<String, String> _buildAuthorizationsHeader() {
    final String authorizationValue = "Token $_internalApiKey";
    return MapEntry("Authorization", authorizationValue);
  }

  static MapEntry<String, String> _buildContentType() {
    return MapEntry("Content-Type", "application/json");
  }

  HeaderBuilder._();
}
