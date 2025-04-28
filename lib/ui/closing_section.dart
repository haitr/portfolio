import 'package:flutter/material.dart';
import 'package:portfolio/service/url.dart';
import 'package:portfolio/ui/ui.dart';
import 'package:portfolio/utils/color.dart';
import 'package:portfolio/utils/context.dart';
import 'package:portfolio/widgets/leading_circle_button.dart';

class ClosingSection extends StatelessWidget {
  const ClosingSection({super.key});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final width = constraints.maxWidth.clamp(300, 500);
        return SizedBox(
          width: width.toDouble(),
          height: 500,
          child: Column(
            children: [
              SizedBox(
                height: 200,
                child: Stack(
                  children: [
                    Positioned(
                      right: 0,
                      child: ClipOval(
                        child: CustomPaint(
                          // painter: StripePainter(stripeColor: context.colorScheme.primary, stripeWidth: 1, gapWidth: 8),
                          child: Container(
                            width: 200,
                            height: 200,
                            decoration: BoxDecoration(color: context.colorScheme.primary),
                          ),
                        ),
                      ),
                    ),
                    Center(
                      child: ShaderMask(
                        blendMode: BlendMode.srcIn,
                        shaderCallback: (Rect bounds) {
                          final percentage = width * 0.00124;
                          // Define the gradient.  The stops control where the colors change.
                          return LinearGradient(
                            begin: Alignment.centerLeft,
                            end: Alignment.centerRight,
                            colors: [context.colorScheme.primary, context.colorScheme.primary.inverted],
                            stops: [
                              percentage, // Adjusted stop to start the black part
                              percentage, // Adjusted stop to end the black part
                            ],
                          ).createShader(bounds);
                        },
                        child: Text(
                          "Looking forward to working with you.",
                          style: context.textTheme.titleLarge!.copyWith(color: context.colorScheme.onSurface),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              h32,
              Text(
                "Collaborate with me to create something exceptional.",
                style: context.textTheme.bodyLarge!.copyWith(color: context.colorScheme.onSurface),
                textAlign: TextAlign.center,
              ),
              h16,
              LeadingCircleButton(
                onPressed: () => launchEmail('nghai89@gmail.com'),
                text: 'Say Hello',
                width: 200,
                initPercentage: 0.28,
              ),
            ],
          ),
        );
      },
    );
  }
}
