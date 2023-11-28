import 'package:dev_tools/src/core/core.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('NetworkCollector Tests', () {
    late NetworkCollector networkCollector;

    setUp(() {
      networkCollector = NetworkCollector();
    });

    test('Clear method should clear entries', () {
      networkCollector.request('1', Request(url: Uri(), method: Method.get));
      networkCollector.response('1', const Response(status: 200));

      networkCollector.clear();

      expect(networkCollector.stream, emits({}));
    });

    test('Request method should add request in entries', () {
      const requestId = '1';
      final request = Request(url: Uri(), method: Method.get);

      networkCollector.request(requestId, request);

      expectLater(
        networkCollector.stream,
        emits({requestId: NetworkEntry(id: requestId, request: request)}),
      );
    });

    test('Request method should update request in entries', () {
      const requestId = '1';
      final request = Request(url: Uri(), method: Method.get);
  

      networkCollector.request(requestId, Request(url: Uri(), method: Method.post));
      networkCollector.request(requestId, request);

      expectLater(
        networkCollector.stream,
        emits({requestId: NetworkEntry(id: requestId, request: request)}),
      );
    });

    test('Response method should add or update response in entries', () {
      const requestId = '1';
      const response = Response(status: 500);

      final request = Request(url: Uri(), method: Method.post);

      networkCollector.request(requestId, request);
      networkCollector.response(requestId, response);

      expect(
        networkCollector.stream,
        emits({
          requestId: NetworkEntry(
            id: requestId,
            request: request,
            response: response,
          )
        }),
      );
    });

    test('Response method should skip add if entry not exist', () {
      const requestId = '1';
      const response = Response(status: 500);

      networkCollector.response(requestId, response);

      expect(
        networkCollector.stream,
        emits({}),
      );
    });

    test('Response method should skip add if entry not exist', () {
      const requestId = '1';
      const response = Response(status: 500);

      networkCollector.response(requestId, response);

      expect(
        networkCollector.stream,
        emits({}),
      );
    });

    test('Response method should skip add if entry not exist #2', () {
      final entries = [
        NetworkEntry(
          id: '1',
          request: Request(
            method: Method.delete,
            url: Uri(),
          ),
        ),
        NetworkEntry(
          id: '2',
          request: Request(
            method: Method.get,
            url: Uri(),
          ),
        ),
        NetworkEntry(
          id: '3',
          request: Request(
            method: Method.get,
            url: Uri(),
          ),
        ),
      ];

      final map = <Object, NetworkEntry>{};

      for (final entry in entries) {
        networkCollector.request(entry.id, entry.request);
        map[entry.id] = entry;
      }

      networkCollector.response('12', const Response(status: 404));

      expect(
        networkCollector.stream,
        emits(map),
      );
    });

    test('Error method should add or update error in entries', () {
      const requestId = '12';
      const error = 'Some error';

      final request = Request(url: Uri(), method: Method.post);

      networkCollector.request(requestId, request);
      networkCollector.error(requestId, error);

      expect(
        networkCollector.stream,
        emits({requestId: NetworkEntry(id: requestId, request: request, error: error)}),
      );
    });

    test('Error method should skip add if entry not exist', () {
      const requestId = '1';

      networkCollector.error(requestId, "Error");

      expect(
        networkCollector.stream,
        emits({}),
      );
    });

    test('Error method should skip add if entry not exist #2', () {
      final entries = [
        NetworkEntry(
          id: '1',
          request: Request(
            method: Method.delete,
            url: Uri(),
          ),
        ),
        NetworkEntry(
          id: '2',
          request: Request(
            method: Method.get,
            url: Uri(),
          ),
        ),
        NetworkEntry(
          id: '3',
          request: Request(
            method: Method.get,
            url: Uri(),
          ),
        ),
      ];

      final map = <Object, NetworkEntry>{};

      for (final entry in entries) {
        networkCollector.request(entry.id, entry.request);
        map[entry.id] = entry;
      }

      networkCollector.error('12', "Error");

      expect(
        networkCollector.stream,
        emits(map),
      );
    });
  });
}
