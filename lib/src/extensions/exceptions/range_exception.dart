/// Represents a range exception.
class RException {
  RException(this.message);

  RException.steps() : message = 'The range must be more then 0';

  final String? message;

  @override
  String toString() {
    return 'RException: ${message ?? ''}';
  }
}
