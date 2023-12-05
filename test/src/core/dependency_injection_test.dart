import 'dart:async';

import 'package:flutter_test/flutter_test.dart';
import 'package:dev_tools/src/core/core.dart';

void main() {
  group("runWithDevTools Tests", () {
    test('runWithDevTools runs the provided function in a zone', () {
      var executed = false;

      runWithDevTools(() {
        executed = true;
      });

      expect(executed, isTrue);
    });

    test('runWithDevTools sets networkCollector in the zone values', () {
      final networkCollector = NetworkCollector();

      runWithDevTools(() {
        final collectorInZone = Zone.current[#networkCollector];

        expect(collectorInZone, equals(networkCollector));
      }, networkCollector: networkCollector);
    });

    test('runWithDevTools uses a default NetworkCollector if none is provided', () {
      runWithDevTools(() {
        var collectorInZone = Zone.current[#networkCollector];

        expect(collectorInZone, isA<NetworkCollector>());
      });
    });

    test('runWithDevTools propagates exceptions thrown in the body', () {
      expect(() => runWithDevTools(() => throw Exception('Test Exception')), throwsException);
    });

    test('runWithDevTools return result from callback', () {
      const result = 'result';

      expect(runWithDevTools(() => result), result);
    });
  });
}
