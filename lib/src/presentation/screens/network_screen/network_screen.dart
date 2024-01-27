import 'package:flutter/material.dart';

import 'package:dev_tools/src/core/core.dart';

import '../../interactors/interactors.dart';
import '../network_entry_screen/network_entry_screen.dart';
import 'widgets/network_entry_card.dart';

class NetworkScreen extends StatefulWidget {
  const NetworkScreen({super.key});

  @override
  State<NetworkScreen> createState() => _NetworkScreenState();
}

class _NetworkScreenState extends State<NetworkScreen> {
  late final NetworkInteractor _interactor;

  @override
  void initState() {
    _interactor = NetworkInteractor(getNetworkCollector());
    super.initState();
  }

  void _handleTapOnEntry(NetworkEntry entry) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) {
          return NetworkEntryScreen(
            stream: _interactor.getEntryStream(entry.id),
          );
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Network'),
      ),
      body: StreamBuilder<List<NetworkEntry>>(
        stream: _interactor.entriesStream,
        builder: (BuildContext context, AsyncSnapshot<List<NetworkEntry>> snapshot) {
          if (snapshot.hasError) {
            return Center(
              child: Text(snapshot.error.toString()),
            );
          }

          if (snapshot.hasData) {
            final entries = snapshot.data!;

            return ListView.builder(
              itemCount: entries.length,
              itemBuilder: (BuildContext context, int index) {
                final entry = entries[index];

                return NetworkEntryCard(
                  entry: entry,
                  onTap: () => _handleTapOnEntry(entry),
                );
              },
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
