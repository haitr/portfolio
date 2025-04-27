import 'package:animated_theme_switcher/animated_theme_switcher.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:portfolio/service/theme.dart';
import 'package:portfolio/ui/closing_section.dart';
import 'package:portfolio/utils/context.dart';
import 'package:portfolio/widgets/hover_widget.dart';

import '../provider/project.dart';
import '../service/url.dart';
import '../ui/intro_section.dart';
import '../ui/recent_project_section.dart';
import '../ui/skill_section.dart';
import '../ui/ui.dart';

part 'home.desktop.dart';
part 'home.mobile.dart';

Widget _myWorkButton() => ThemeSwitcher(
  builder: (context) {
    return IconButton(
      onPressed: () {
        Navigator.of(context).pushNamed('/projects');
      },
      icon: FaIcon(FontAwesomeIcons.briefcase),
    );
  },
);

Widget _themeSwitchButton() => ThemeSwitcher(
  builder: (context) {
    var icon = ThemeService.instance.isDark ? Icons.light_mode : Icons.dark_mode;
    return IconButton(
      onPressed: () {
        ThemeService.instance.setTheme(context, !ThemeService.instance.isDark);
        ThemeSwitcher.of(context).changeTheme(theme: ThemeService.instance.theme);
      },
      icon: Icon(icon),
    );
  },
);

Widget _footer() => Row(children: [Text('Copyright © 2025 Hai Nguyen. All rights reserved.')]);

Widget _title(BuildContext context) => RichText(
  text: TextSpan(
    children: [
      const TextSpan(text: "Created by ", style: TextStyle(color: Colors.grey)),
      TextSpan(
        text: "Flutter",
        style: TextStyle(color: context.colorScheme.primary, fontSize: 16, fontWeight: FontWeight.bold),
      ),
    ],
  ),
);

Widget _content(BuildContext context) {
  return Column(
    spacing: 64,
    children:
        [
          IntroSection(),
          SkillSection(),
          Consumer(builder: (context, ref, _) => RecentProjectSection(projects: ref.watch(importantProjectProvider))),
          ClosingSection(),
        ].columnToAnimatedList(),
  );
}

extension on List<Widget> {
  List<Widget> animatedSideBar() => AnimationConfiguration.toStaggeredList(
    duration: const Duration(milliseconds: 1500),
    childAnimationBuilder: (widget) {
      if (widget is Spacer) return widget;
      return SlideAnimation(verticalOffset: 200.0, child: FadeInAnimation(child: widget));
    },
    children: this,
  );

  List<Widget> animatedSideBarItem() =>
      map((e) => HoverWidget(transformOffset: const Offset(0, 10.0), child: e)).toList();

  List<Widget> columnToAnimatedList() => AnimationConfiguration.toStaggeredList(
    duration: const Duration(milliseconds: 1500),
    childAnimationBuilder: (widget) => SlideAnimation(verticalOffset: 200.0, child: FadeInAnimation(child: widget)),
    children: this,
  );
}
