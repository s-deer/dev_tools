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

NetworkCollector getNetworkCollector() {
  final collector = Zone.current[#networkCollector];

  assert(
    collector != null,
    "Error: NetworkCollector instance not found in the current zone"
    "It seems like you forgot to wrap your application with the 'runWithDevTools' function, or the 'NetworkCollector' instance is missing in the current zone."
    "To fix this issue:"
    "1. Ensure that your application is wrapped with the 'runWithDevTools' function."
    "   Example:"
    "   runWithDevTools(() {"
    "     // Your application code here"
    "   });",
  );

  if (collector == null) {
    throw const NetworkCollectorNotFoundException();
  }

  return collector;
}
