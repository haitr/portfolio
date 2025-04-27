import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:portfolio/utils/color.dart';
import 'package:portfolio/utils/context.dart';
import 'package:responsive_framework/responsive_framework.dart';

import '../utils/constants.dart';

class LeadingCircleButton extends StatefulWidget {
  final VoidCallback onPressed;
  final String text;
  final double width;
  final double initPercentage;
  const LeadingCircleButton({
    super.key,
    required this.onPressed,
    required this.text,
    required this.width,
    this.initPercentage = 0.0,
  });

  @override
  State<LeadingCircleButton> createState() => _LeadingCircleButtonState();
}

class _LeadingCircleButtonState extends State<LeadingCircleButton> with SingleTickerProviderStateMixin {
  bool isHovered = false;
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(duration: const Duration(milliseconds: 200), vsync: this);
    _animation = Tween<double>(begin: 0.0, end: 1.0).animate(_controller);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final needAnimation = ResponsiveBreakpoints.of(context).breakpoint.name != kSmallBreakPoint;
    if (!needAnimation) {
      return ElevatedButton(onPressed: widget.onPressed, child: Text(widget.text));
    }
    final duration = const Duration(milliseconds: 200);
    final height = 60.0;
    return MouseRegion(
      onEnter: (_) {
        setState(() => isHovered = true);
        _controller.forward();
      },
      onExit: (_) {
        setState(() => isHovered = false);
        _controller.reverse();
      },
      child: AnimatedPadding(
        duration: duration,
        padding: EdgeInsets.only(left: isHovered ? 8 : 0),
        child: GestureDetector(
          onTap: widget.onPressed,
          child: SizedBox(
            height: height,
            child: Stack(
              alignment: Alignment.center,
              children: [
                Positioned(
                  left: 0,
                  child: AnimatedContainer(
                    duration: duration,
                    height: height,
                    width: isHovered ? widget.width : height,
                    decoration: BoxDecoration(
                      shape: BoxShape.rectangle,
                      borderRadius: BorderRadius.circular(height / 2),
                      color: context.colorScheme.primary,
                    ),
                  ),
                ),
                // Text and arrow
                SizedBox(
                  width: widget.width,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: AnimatedBuilder(
                      animation: _animation,
                      builder: (context, child) {
                        final percentage = _animation.value + widget.initPercentage;
                        return ShaderMask(
                          blendMode: BlendMode.srcIn,
                          shaderCallback: (bounds) {
                            return LinearGradient(
                              begin: Alignment.centerLeft,
                              end: Alignment.centerRight,
                              colors: [context.colorScheme.primary.inverted, context.colorScheme.primary],
                              stops: [percentage, percentage],
                            ).createShader(bounds);
                          },
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                widget.text.toUpperCase(),
                                style: context.textTheme.bodyMedium!.copyWith(
                                  color: context.colorScheme.inversePrimary,
                                ),
                              ),
                              FaIcon(
                                FontAwesomeIcons.arrowRightLong,
                                color: context.colorScheme.inversePrimary,
                                size: 16,
                              ),
                            ],
                          ),
                        );
                      },
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
