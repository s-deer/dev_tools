import 'package:flutter/material.dart';

import '../../../../core/core.dart';

class NetworkEntryCard extends StatelessWidget {
  final NetworkEntry entry;
  final VoidCallback onTap;

  const NetworkEntryCard({
    required this.entry,
    required this.onTap,
    super.key,
  });

  String _getMethodText(Method method) {
    return switch (method) {
      Method.delete => 'DELETE',
      Method.get => 'GET',
      Method.post => 'POST',
      Method.put => 'PUT',
      Method.patch => 'PATCH',
      Method.head => 'HEAD',
    };
  }

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: onTap,
      leading: Builder(
        builder: (BuildContext context) {
          if (entry.isFailed) {
            return const Icon(Icons.error_outline);
          }

          if (entry.isProcessing) {
            return const Icon(Icons.sync);
          }

          return const Icon(Icons.check);
        },
      ),
      title: Row(
        children: [
          Text(_getMethodText(entry.request.method)),
          const SizedBox(width: 10),
          Flexible(
            child: Text(
              entry.request.url.path,
              maxLines: 1,
            ),
          ),
        ],
      ),
      subtitle: Builder(
        builder: (BuildContext context) {
          if (entry.error != null) {
            return Text(entry.error!.toString());
          }

          if (entry.response != null) {
            return Text('Status: ${entry.response!.status.toString()}');
          }

          return const Text('Processing');
        },
      ),
    );
  }
}
