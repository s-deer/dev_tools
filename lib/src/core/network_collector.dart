import 'package:dev_tools/src/utils/behavior_subject.dart';

import 'core.dart';

typedef NetworkEntriesMap = Map<Object, NetworkEntry>;

abstract class NetworkCollector {
  void request(Object id, Request request);
  void response(Object id, Response response);
  void error(Object id, Object error);
  void clear();

  Stream<NetworkEntriesMap> get stream;

  factory NetworkCollector() = _NetworkCollectorImpl;
}

class _NetworkCollectorImpl implements NetworkCollector {
  late final NetworkEntriesMap _entries;

  late final BehaviorSubject<NetworkEntriesMap> _behaviorSubject;

  _NetworkCollectorImpl() {
    _entries = {};
    _behaviorSubject = BehaviorSubject(_entries);
  }

  @override
  Stream<NetworkEntriesMap> get stream => _behaviorSubject.stream;

  void _emitEntries() {
    _behaviorSubject.add(_entries);
  }

  @override
  void clear() {
    _entries.clear();
    _emitEntries();
  }

  @override
  void request(Object id, Request request) {
    if (_entries.containsKey(id)) {
      _entries[id] = _entries[id]!.copyWith(request: request);
    } else {
      _entries[id] = NetworkEntry(id: id, request: request);
    }

    _emitEntries();
  }

  @override
  void response(Object id, Response response) {
    if (_entries.containsKey(id)) {
      _entries[id] = _entries[id]!.copyWith(response: response);
      _emitEntries();
    }
  }

  @override
  void error(Object id, Object error) {
    if (_entries.containsKey(id)) {
      _entries[id] = _entries[id]!.copyWith(error: error);
      _emitEntries();
    }
  }
}
