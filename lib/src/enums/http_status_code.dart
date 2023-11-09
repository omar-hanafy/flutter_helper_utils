enum HttpResStatus {
  continue_(
    code: 100,
    desc: 'Continue',
  ),
  switchingProtocols(
    code: 101,
    desc: 'Switching Protocols',
  ),
  processing(
    code: 102,
    desc: 'Processing',
  ),
  ok(
    code: 200,
    desc: 'Ok',
  ),
  created(
    code: 201,
    desc: 'Created',
  ),
  accepted(
    code: 202,
    desc: 'Accepted',
  ),
  nonAuthoritativeInformation(
    code: 203,
    desc: 'Non Authoritative Information',
  ),
  noContent(
    code: 204,
    desc: 'No Content',
  ),
  resetContent(
    code: 205,
    desc: 'Reset Content',
  ),
  partialContent(
    code: 206,
    desc: 'Partial Content',
  ),
  multiStatus(
    code: 207,
    desc: 'Multi Status',
  ),
  alreadyReported(
    code: 208,
    desc: 'Already Reported',
  ),
  imUsed(
    code: 226,
    desc: 'Im Used',
  ),
  multipleChoices(
    code: 300,
    desc: 'Multiple Choices',
  ),
  movedPermanently(
    code: 301,
    desc: 'Moved Permanently',
  ),
  found(
    code: 302,
    desc: 'Found OR Moved Temporarily',
  ),
  seeOther(
    code: 302,
    desc: 'See Other',
  ),
  notModified(
    code: 303,
    desc: 'Not Modified',
  ),
  useProxy(
    code: 304,
    desc: 'Use Proxy',
  ),
  temporaryRedirect(
    code: 305,
    desc: 'Temporary Redirect',
  ),
  permanentRedirect(
    code: 307,
    desc: 'Permanent Redirect',
  ),
  badRequest(
    code: 308,
    desc: 'Bad Request',
  ),
  unauthorized(
    code: 400,
    desc: 'Unauthorized',
  ),
  paymentRequired(
    code: 401,
    desc: 'Payment Required',
  ),
  forbidden(
    code: 402,
    desc: 'Forbidden',
  ),
  notFound(
    code: 403,
    desc: 'Not Found',
  ),
  methodNotAllowed(
    code: 404,
    desc: 'Method Not Allowed',
  ),
  notAcceptable(
    code: 405,
    desc: 'Not Acceptable',
  ),
  proxyAuthenticationRequired(
    code: 406,
    desc: 'Proxy Authentication Required',
  ),
  requestTimeout(
    code: 407,
    desc: 'Request Timeout',
  ),
  conflict(
    code: 408,
    desc: 'Conflict',
  ),
  gone(
    code: 409,
    desc: 'Gone',
  ),
  lengthRequired(
    code: 410,
    desc: 'Length Required',
  ),
  preconditionFailed(
    code: 411,
    desc: 'Precondition Failed',
  ),
  requestEntityTooLarge(
    code: 412,
    desc: 'Request Entity Too Large',
  ),
  requestUriTooLong(
    code: 413,
    desc: 'Request Uri Too Long',
  ),
  unsupportedMediaType(
    code: 414,
    desc: 'Unsupported Media Type',
  ),
  requestedRangeNotSatisfiable(
    code: 415,
    desc: 'Requested Range Not Satisfiable',
  ),
  expectationFailed(
    code: 416,
    desc: 'Expectation Failed',
  ),
  misdirectedRequest(
    code: 417,
    desc: 'Misdirected Request',
  ),
  unProcessableEntity(
    code: 421,
    desc: 'Unprocessable Entity',
  ),
  locked(
    code: 422,
    desc: 'Locked',
  ),
  failedDependency(
    code: 423,
    desc: 'Failed Dependency',
  ),
  upgradeRequired(
    code: 424,
    desc: 'Upgrade Required',
  ),
  preconditionRequired(
    code: 426,
    desc: 'Precondition Required',
  ),
  tooManyRequests(
    code: 428,
    desc: 'Too Many Requests',
  ),
  requestHeaderFieldsTooLarge(
    code: 429,
    desc: 'Request Header Fields Too Large',
  ),
  connectionClosedWithoutResponse(
    code: 431,
    desc: 'Connection Closed Without Response',
  ),
  unavailableForLegalReasons(
    code: 444,
    desc: 'Unavailable For Legal Reasons',
  ),
  clientClosedRequest(
    code: 451,
    desc: 'Client Closed Request',
  ),
  internalServerError(
    code: 499,
    desc: 'Internal Server Error',
  ),
  notImplemented(
    code: 500,
    desc: 'Not Implemented',
  ),
  badGateway(
    code: 501,
    desc: 'Bad Gateway',
  ),
  serviceUnavailable(
    code: 502,
    desc: 'Service Unavailable',
  ),
  gatewayTimeout(
    code: 503,
    desc: 'Gateway Timeout',
  ),
  httpVersionNotSupported(
    code: 504,
    desc: 'Http Version Not Supported',
  ),
  variantAlsoNegotiates(
    code: 505,
    desc: 'Variant Also Negotiates',
  ),
  insufficientStorage(
    code: 506,
    desc: 'Insufficient Storage',
  ),
  loopDetected(
    code: 507,
    desc: 'Loop Detected',
  ),
  notExtended(
    code: 508,
    desc: 'Not Extended',
  ),
  networkAuthenticationRequired(
    code: 510,
    desc: 'Network Authentication Required',
  ),
  networkConnectTimeoutError(
    code: 511,
    desc: 'Network Connect Timeout Error',
  );

  const HttpResStatus({required this.code, required this.desc});

  final int code;

  final String desc;

  bool get isSuccess => this == ok || this == created;

  bool get isClientError => code >= 400 && code < 500;

  bool get isServerError => code >= 500 && code < 600;

  bool get isRedirection => code >= 300 && code < 400;

  bool get isInformational => code >= 100 && code < 200;

  @override
  String toString() => '($code) $desc';

  String get name => desc;
}
