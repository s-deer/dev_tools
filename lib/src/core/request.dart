import 'package:dev_tools/src/core/request_body.dart';

class Request {
  final Object id;
  final Uri url;
  final Method method;
  final Map<String, String> headers;
  final RequestBody? body;

  Request({
    required this.id,
    required this.url,
    required this.method,
    this.headers = const {},
    this.body,
  });
}

enum Method {
  get,
  post,
  put,
  patch,
  delete,
  head,
}
