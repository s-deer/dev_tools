class Response {
  final Uri url;
  final int status;
  final Object? body;
  final Map<String, String> headers;

  const Response({
    required this.url,
    required this.status,
    this.body,
    this.headers = const {},
  });
}