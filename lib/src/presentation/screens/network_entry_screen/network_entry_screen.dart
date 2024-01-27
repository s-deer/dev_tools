import 'package:dev_tools/src/core/core.dart';
import 'package:flutter/material.dart';

class NetworkEntryScreen extends StatelessWidget {
  final Stream<NetworkEntry> stream;

  const NetworkEntryScreen({
    required this.stream,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Network Entry'),
      ),
      body: StreamBuilder<NetworkEntry>(
        stream: stream,
        builder: (BuildContext context, AsyncSnapshot<NetworkEntry> snapshot) {
          if (snapshot.hasError) {
            return Center(
              child: Text(snapshot.error.toString()),
            );
          }

          if (snapshot.hasData) {
            return SingleChildScrollView(
              padding: const EdgeInsets.all(10),
              child: Column(
                children: [
                  
                ],
              ),
            );
          }

          return const Center(
            child: CircularProgressIndicator(),
          );
        },
      ),
    );
  }
}
