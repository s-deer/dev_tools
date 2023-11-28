import 'package:equatable/equatable.dart';

class Response extends Equatable {
  final int status;
  final Object? body;
  final Map<String, String> headers;

  const Response({
    required this.status,
    this.body,
    this.headers = const {},
  });
  
  @override
  List<Object?> get props => [status, body, headers];
}