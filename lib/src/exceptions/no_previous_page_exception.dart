class NoPreviousPageException implements Exception {
  const NoPreviousPageException();

  @override
  String toString() => "No previous page exists for this list";
}
