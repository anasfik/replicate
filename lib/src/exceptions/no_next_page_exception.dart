class NoNextPageException implements Exception {
  const NoNextPageException();

  @override
  String toString() => "No next page exists for this list";
}
