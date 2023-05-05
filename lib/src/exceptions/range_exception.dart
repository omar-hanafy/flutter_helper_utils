/// Represents a range exception.
class RException implements Exception {
  const RException(this.message);

  RException.steps() : message = 'The range must be more than 0';

  final String? message;

  @override
  String toString() {
    return 'RException: ${message ?? ''}';
  }
}
