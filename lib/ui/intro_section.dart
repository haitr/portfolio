import 'package:flutter/material.dart';
import 'package:portfolio/service/url.dart';
import 'package:portfolio/utils/context.dart';
import 'package:portfolio/widgets/leading_circle_button.dart';

import 'ui.dart';

class IntroSection extends StatelessWidget {
  const IntroSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // title
        Text('<hello there>', style: context.textTheme.displaySmall!.copyWith(color: context.colorScheme.primary)),
        h24,
        // heading
        Text("I'm Howard.", style: context.textTheme.displayLarge),
        h16,
        // subtitle
        SizedBox(
          width: 500,
          child: Text(
            "I specialize in Mobile Technologies and highly passionate about developing quality applications, open-source works and AI.",
            style: context.textTheme.bodyLarge,
          ),
        ),
        h16,
        // button
        LeadingCircleButton(
          onPressed: () => openUrl("https://github.com/haitr"),
          text: "View My GitHub",
          width: 200,
          initPercentage: 0.28,
        ),
      ],
    );
  }
}
