import 'package:dev_tools/src/presentation/screens/network_screen/network_screen.dart';
import 'package:dev_tools/src/presentation/widgets/open_dev_tools_button.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import '../core/core.dart';

class DevTools extends StatefulWidget {
  final bool enabled;
  final Widget child;

  DevTools({
    required this.child,
    this.enabled = !kReleaseMode,
    super.key,
  }) {
    getNetworkCollector();
  }

  @override
  State<DevTools> createState() => _DevToolsState();
}

class _DevToolsState extends State<DevTools> {
  late Offset _buttonOffset;

  @override
  void initState() {
    super.initState();
    _buttonOffset = const Offset(50, 50);
  }

  void _handleTapOnButton() {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => const NetworkScreen(),
      ),
    );
  }

  void _handleDragEnd(DraggableDetails details) {
    setState(() {
      _buttonOffset = details.offset;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (!widget.enabled) {
      return widget.child;
    }

    return Stack(
      children: [
        Positioned.fill(child: widget.child),
        Positioned(
          left: _buttonOffset.dx,
          top: _buttonOffset.dy,
          child: Draggable(
            onDragEnd: _handleDragEnd,
            feedback: const Opacity(
              opacity: 0.5,
              child: OpenDevToolsButton(onTap: null),
            ),
            child: OpenDevToolsButton(onTap: _handleTapOnButton),
          ),
        ),
      ],
    );
  }
}
