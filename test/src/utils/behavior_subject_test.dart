import 'package:dev_tools/src/utils/utils.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('BehaviorSubject Tests', () {
    test('Initial value is emitted upon subscription', () {
      final subject = BehaviorSubject<int>(42);

      expect(subject.stream, emits(42));
    });

    test('Values are emitted to stream after add', () {
      final subject = BehaviorSubject<int>(0);

      expectLater(subject.stream, emitsInOrder([0, 1, 2]));

      subject.add(1);
      subject.add(2);
    });

    test('Closing the subject completes the stream', () {
      final subject = BehaviorSubject<int>(0);

      expect(subject.stream, emits(0));
      expectLater(subject.stream, emitsDone);

      subject.close();
    });

    test('Adding values after closing has no effect', () {
      final subject = BehaviorSubject<int>(0);

      expectLater(subject.stream, emitsInOrder([0, emitsDone]));

      subject.close();
      
      try {
        subject.add(1);
      // ignore: empty_catches
      } catch (err) {}
    });

    test('Emit last value to new subscription', () {
      final subject = BehaviorSubject<int>(0);
      subject.add(12);

      expectLater(subject.stream, emitsInOrder([12]));
    });
  });
}
