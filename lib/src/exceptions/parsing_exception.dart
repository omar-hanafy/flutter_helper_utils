class ParsingException implements Exception {
  const ParsingException({
    required this.error,
    required this.parsingInfo,
    this.stackTrace,
  });

  factory ParsingException.nullObject({
    required StackTrace stackTrace,
    required String parsingInfo,
  }) {
    return ParsingException(
      error: 'Object Is Null',
      parsingInfo: parsingInfo,
      stackTrace: stackTrace,
    );
  }

  final String parsingInfo;
  final Object? error;
  final StackTrace? stackTrace;

  @override
  String toString() {
    return '''
ParsingException {
  parsingInfo: $parsingInfo,
  error: $error,
  ${stackTrace != null ? ', stackTrace: $stackTrace' : ''}
}
''';
  }
}
