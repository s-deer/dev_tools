import 'dart:async';

import 'core.dart';

R runWithDevTools<R>(
  R Function() body, {
  NetworkCollector? networkCollector,
}) {
  return runZoned(
    body,
    zoneValues: {
      #networkCollector: networkCollector ?? NetworkCollector(),
    },
  );
}
