import 'package:flutter/material.dart';

class ContentArea extends StatelessWidget {
  const ContentArea({super.key, required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) => Align(
    alignment: Alignment.topCenter,
    child: ConstrainedBox(
      constraints: const BoxConstraints(maxWidth: 900),
      child: Padding(padding: const EdgeInsets.all(24), child: child),
    ),
  );
}
