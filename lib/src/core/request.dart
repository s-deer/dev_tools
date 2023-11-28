import 'package:dev_tools/src/core/request_body.dart';
import 'package:equatable/equatable.dart';

class Request extends Equatable {
  final Uri url;
  final Method method;
  final Map<String, String> headers;
  final RequestBody? body;

  const Request({
    required this.url,
    required this.method,
    this.headers = const {},
    this.body,
  });
  
  @override
  List<Object?> get props => [url, method, headers, body];
}

enum Method {
  get,
  post,
  put,
  patch,
  delete,
  head,
}
