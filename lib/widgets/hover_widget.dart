import 'package:flutter/material.dart';

class HoverWidget extends StatefulWidget {
  final Widget child;
  final Offset transformOffset;
  const HoverWidget({super.key, required this.child, required this.transformOffset});

  @override
  State<HoverWidget> createState() => _HoverWidgetState();
}

class _HoverWidgetState extends State<HoverWidget> {
  // state variable
  bool isHovered = false;

  @override
  Widget build(BuildContext context) => MouseRegion(
    onEnter: (_) => setState(() => isHovered = true),
    onExit: (_) => setState(() => isHovered = false),
    child: AnimatedPadding(
      padding:
          isHovered
              ? EdgeInsets.only(left: widget.transformOffset.dx, bottom: widget.transformOffset.dy)
              : const EdgeInsets.only(bottom: 0.0),
      duration: const Duration(milliseconds: 300),
      child: widget.child,
    ),
  );
}
