import '../../core/core.dart';

abstract class NetworkInteractor {
  Stream<List<NetworkEntry>> get entriesStream;

  Stream<NetworkEntry> getEntryStream(Object id);

  factory NetworkInteractor(NetworkCollector networkCollector) = _NetworkInteractor;
}

class _NetworkInteractor implements NetworkInteractor {
  final NetworkCollector _networkCollector;

  const _NetworkInteractor(NetworkCollector networkCollector) : _networkCollector = networkCollector;

  @override
  Stream<List<NetworkEntry>> get entriesStream {
    return _networkCollector.stream.map((event) => event.values.toList());
  }

  @override
  Stream<NetworkEntry> getEntryStream(Object id) {
    return _networkCollector.stream.map((event) => event[id]!);
  }
}
