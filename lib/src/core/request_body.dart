abstract class RequestBody {}

class RawRequestBody {
  final String data;

  const RawRequestBody({
    required this.data,
  });
}

class MultiPartRequestBody {
  final List<PartValue> parts;

  const MultiPartRequestBody(this.parts);
}

class PartValue<T> {
  final String name;
  final T? value;

  const PartValue({
    required this.name,
    this.value,
  });
}

class PartValueFile extends PartValue<MultiPartFile> {
  const PartValueFile({
    required super.name,
    super.value,
  });
}

class MultiPartFile {
  final String fileName;
  final int length;
  final String contentType;

  MultiPartFile({
    required this.fileName,
    this.length = 0,
    this.contentType = '',
  });
}
