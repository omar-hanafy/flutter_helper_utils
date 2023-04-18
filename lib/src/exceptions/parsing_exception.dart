class ParsingExceptions implements Exception {
  const ParsingExceptions({
    required this.cause,
    required this.parsingInfo,
    this.stackTrace,
  });

  factory ParsingExceptions.nullObject({
    required StackTrace stackTrace,
    required String parsingInfo,
  }) {
    return ParsingExceptions(
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
