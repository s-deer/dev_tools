import 'package:flutter/material.dart';

class OpenDevToolsButton extends StatelessWidget {
  final VoidCallback? onTap;

  const OpenDevToolsButton({
    required this.onTap,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: onTap,
      icon: const DecoratedBox(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(10)),
          color: Colors.grey,
        ),
        child:  Padding(
          padding: EdgeInsets.all(8),
          child: Icon(
            Icons.bug_report_outlined,
          ),
        ),
      ),
    );
  }
}
