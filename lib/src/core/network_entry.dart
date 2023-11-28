import 'package:dev_tools/src/core/core.dart';
import 'package:equatable/equatable.dart';

class NetworkEntry extends Equatable {
  final Object id;
  final Request request;
  final Response? response;
  final Object? error;

  const NetworkEntry({
    required this.id,
    required this.request,
    this.response,
    this.error,
  });

  NetworkEntry copyWith({
    Object? id,
    Request? request,
    Response? response,
    Object? error,
  }) {
    return NetworkEntry(
      id: id ?? this.id,
      request: request ?? this.request,
      response: response ?? this.response,
      error: error ?? this.error,
    );
  }
  
  @override
  List<Object?> get props => [id, request, response, error];
}
