import 'dart:core';

import 'package:equatable/equatable.dart';

abstract class RequestBody {}

class RawRequestBody extends Equatable {
  final String data;

  const RawRequestBody({
    required this.data,
  });
  
  @override

  List<Object?> get props => [data];
}

class MultiPartRequestBody extends Equatable {
  final List<PartValue> parts;

  const MultiPartRequestBody(this.parts);
  
  @override
  List<Object?> get props => [parts];
}

class PartValue<T> extends Equatable {
  final String name;
  final T? value;

  const PartValue({
    required this.name,
    this.value,
  });
  
  @override
  List<Object?> get props => [name, value];
}

class PartValueFile extends PartValue<MultiPartFile> {
  const PartValueFile({
    required super.name,
    super.value,
  });
}

class MultiPartFile extends Equatable {
  final String fileName;
  final int length;
  final String contentType;

  const MultiPartFile({
    required this.fileName,
    this.length = 0,
    this.contentType = '',
  });
  
  @override
  List<Object?> get props => [fileName, length, contentType];
}
