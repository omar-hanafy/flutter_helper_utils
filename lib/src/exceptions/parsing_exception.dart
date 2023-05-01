class ParsingException implements Exception {
  const ParsingException({
    required this.cause,
    required this.parsingInfo,
    this.stackTrace,
  });

  factory ParsingException.nullObject({
    required StackTrace stackTrace,
    required String parsingInfo,
  }) {
    return ParsingException(
      cause: 'Object Is Null',
      parsingInfo: parsingInfo,
      stackTrace: stackTrace,
    );
  }

  final String parsingInfo;
  final String cause;
  final StackTrace? stackTrace;

  @override
  String toString() {
    return 'ParsingException{parsingInfo: $parsingInfo, cause: $cause${stackTrace != null ? ', stackTrace: $stackTrace' : ''}';
  }
}
