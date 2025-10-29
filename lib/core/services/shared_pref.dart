class SharedPrefException implements Exception {
  final String message;
  SharedPrefException(this.message);

  @override
  String toString() => 'SharedPrefException: $message';
}