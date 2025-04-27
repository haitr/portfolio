import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:portfolio/utils/color.dart';
import 'package:portfolio/utils/context.dart';
import 'package:portfolio/widgets/leading_circle_button.dart';
import 'package:responsive_framework/responsive_framework.dart';

import '../models/project.dart';
import '../service/asset.dart';
import '../service/url.dart';
import '../utils/constants.dart';
import 'ui.dart';

class RecentProjectSection extends StatefulWidget {
  final List<Project> projects;
  const RecentProjectSection({super.key, required this.projects});

  @override
  State<RecentProjectSection> createState() => _RecentProjectSectionState();
}

class _RecentProjectSectionState extends State<RecentProjectSection> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 500,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: 24,
        children: [
          // title
          Text(
            '<recent projects>',
            style: context.textTheme.displaySmall!.copyWith(color: context.colorScheme.primary),
          ),
          // recent projects
          ...widget.projects.expandIndexed(
            (index, project) => [RecentProjectCard(project: project, index: index + 1), h16],
          ),
          // view all projects
          LeadingCircleButton(
            onPressed: () => Navigator.of(context).pushNamed('/projects'),
            text: 'View My Works',
            width: 180,
            initPercentage: 0.32,
          ),
        ],
      ),
    );
  }
}

class RecentProjectCard extends StatefulWidget {
  final int index;
  final Project project;

  const RecentProjectCard({super.key, required this.project, required this.index});

  @override
  State<RecentProjectCard> createState() => _RecentProjectCardState();
}

class _RecentProjectCardState extends State<RecentProjectCard> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;
  late Color _numberColor;
  var _isColorInitialized = false;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(duration: const Duration(milliseconds: 150), vsync: this);
    _animation = Tween<double>(begin: 0.0, end: 1.0).animate(_controller);
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (!_isColorInitialized) {
      _numberColor = context.colorScheme.primary.random;
      _isColorInitialized = true;
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final actualWidget = AnimatedBuilder(
      animation: _animation,
      builder:
          (_, child) => Stack(
            clipBehavior: Clip.none,
            children: [
              Transform.translate(
                offset: Offset(-36 * (1 - _animation.value), 0),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    // experience number
                    Opacity(opacity: 1 - _animation.value, child: _buildNumber(context, widget.index)),
                    // spacing
                    w32,
                    // experience details
                    Expanded(
                      child: switch (widget.project.type) {
                        ProjectType.app => _buildAppStyle(context),
                        ProjectType.openSource => _buildLibraryStyle(context),
                      },
                    ),
                  ],
                ),
              ),
              Positioned(
                left: 8 * (1 - _animation.value),
                top: 16,
                child: Opacity(opacity: _animation.value, child: _projectDetails(context)),
              ),
            ],
          ),
    );
    final needAnimation = ResponsiveBreakpoints.of(context).breakpoint.name != kSmallBreakPoint;
    if (!needAnimation) {
      _controller.value = 1.0;
      return actualWidget;
    }
    return MouseRegion(
      onEnter: (_) {
        if (needAnimation) _controller.forward();
      },
      onExit: (_) {
        if (needAnimation) _controller.reverse();
      },
      child: actualWidget,
    );
  }

  Widget _projectDetails(BuildContext context) {
    const iconSize = 20.0;
    return Column(
      spacing: 8,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          widget.index.toString().padLeft(2, '0'),
          style: context.textTheme.headlineSmall!.copyWith(color: _numberColor),
        ),
        Text(
          widget.project.name,
          style: context.textTheme.headlineMedium!.copyWith(color: context.colorScheme.primary),
        ),
        Container(
          padding: const EdgeInsets.all(8),
          width: 200,
          color: context.colorScheme.secondary,
          child: Text(
            widget.project.description,
            style: context.textTheme.bodyMedium!.copyWith(color: context.colorScheme.secondary.inverted),
          ),
        ),
        Row(
          spacing: 8,
          children:
              () sync* {
                if (widget.project.link.github case var url?) {
                  yield IconButton(
                    onPressed: () {
                      openUrl(url);
                    },
                    icon: FaIcon(FontAwesomeIcons.github, size: iconSize),
                  );
                }
                if (widget.project.link.appstore case var url?) {
                  yield IconButton(
                    onPressed: () {
                      openUrl(url);
                    },
                    icon: FaIcon(FontAwesomeIcons.apple, size: iconSize),
                  );
                }
                if (widget.project.link.playstore case var url?) {
                  yield IconButton(
                    onPressed: () {
                      openUrl(url);
                    },
                    icon: FaIcon(FontAwesomeIcons.googlePlay, size: iconSize),
                  );
                }
                if (widget.project.link.website case var url?) {
                  yield IconButton(
                    onPressed: () {
                      openUrl(url);
                    },
                    icon: FaIcon(FontAwesomeIcons.link, size: iconSize),
                  );
                }
              }().toList(),
        ),
      ],
    );
  }

  Widget _buildNumber(BuildContext context, int index) {
    final indexString = index.toString().padLeft(2, '0');
    return Row(
      children: [
        Transform.translate(
          offset: const Offset(0.0, 12.0),
          child: Text("//", style: context.textTheme.headlineSmall!.copyWith(color: _numberColor)),
        ),
        SizedBox(
          width: 50,
          child: FittedBox(
            child: Text(indexString, style: context.textTheme.headlineSmall!.copyWith(color: _numberColor)),
          ),
        ),
      ],
    );
  }

  Widget _buildAppStyle(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // image
        LayoutBuilder(
          builder: (context, constraints) {
            return Stack(
              fit: StackFit.loose,
              children: [
                Positioned.fill(
                  child: Opacity(
                    opacity: 1 - _animation.value,
                    child: Container(
                      decoration: BoxDecoration(
                        border: Border.all(color: context.colorScheme.primary, style: BorderStyle.solid),
                      ),
                      transform: Matrix4.translationValues(8, 8, 0),
                    ),
                  ),
                ),
                DecoratedBox(
                  decoration: BoxDecoration(color: context.colorScheme.surface),
                  child: Image.asset(imageMap[widget.project.image]!),
                ),
                Positioned(
                  left: 0,
                  right: constraints.maxWidth * (1 - _animation.value),
                  top: 0,
                  bottom: 0,
                  child: Container(color: context.colorScheme.surface.withValues(alpha: 0.5)),
                ),
              ],
            );
          },
        ),
        // project name
        h16,
        Text(widget.project.name, style: context.textTheme.displaySmall),
      ],
    );
  }

  Widget _buildLibraryStyle(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        return Stack(
          children: [
            Opacity(
              opacity: 1 - _animation.value,
              child: Container(
                height: packageCardHeight,
                decoration: BoxDecoration(
                  border: Border.all(color: context.colorScheme.primary, style: BorderStyle.solid),
                ),
                transform: Matrix4.translationValues(8, 8, 0),
              ),
            ),
            Container(
              height: packageCardHeight,
              color: Color.alphaBlend(context.colorScheme.primary.withValues(alpha: 0.1), context.colorScheme.surface),
              child: Stack(
                children: [
                  Positioned(
                    left: 8,
                    top: 8,
                    child: Row(
                      spacing: 4,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        FaIcon(FontAwesomeIcons.dartLang, size: 12, color: context.colorScheme.primary),
                        Text(
                          widget.project.typeDetail ?? '',
                          style: context.textTheme.bodySmall!.copyWith(color: context.colorScheme.primary),
                        ),
                      ],
                    ),
                  ),
                  Positioned(
                    left: constraints.maxWidth / 2 + 16,
                    bottom: 8,
                    child: Row(
                      spacing: 8,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        ShaderMask(
                          shaderCallback:
                              (bounds) => LinearGradient(
                                colors: [
                                  context.colorScheme.primary.withValues(alpha: 0.5),
                                  context.colorScheme.primary.withValues(alpha: 0.3),
                                ],
                              ).createShader(bounds),
                          child: FaIcon(FontAwesomeIcons.at, size: 56),
                        ),
                        Text(
                          widget.project.name,
                          style: context.textTheme.bodyLarge!.copyWith(color: context.colorScheme.primary),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Positioned(
              child: Container(
                height: packageCardHeight,
                width: constraints.maxWidth * _animation.value,
                color: context.colorScheme.surface.withValues(alpha: 0.5),
              ),
            ),
          ],
        );
      },
    );
  }
}
