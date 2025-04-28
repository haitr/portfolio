import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:portfolio/utils/color.dart';
import 'package:portfolio/utils/context.dart';

import '../models/project.dart';
import '../provider/project.dart';
import '../service/asset.dart';
import '../service/url.dart';
import '../ui/ui.dart';
import '../utils/constants.dart';

class ProjectScreen extends ConsumerStatefulWidget {
  const ProjectScreen({super.key});

  @override
  ConsumerState<ProjectScreen> createState() => _ProjectScreenState();
}

class _ProjectScreenState extends ConsumerState<ProjectScreen> with SingleTickerProviderStateMixin {
  // late AnimationController _controller;
  // late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    // _controller = AnimationController(duration: const Duration(milliseconds: 150), vsync: this);
    // _animation = Tween<double>(begin: 0.0, end: 1.0).animate(_controller);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      backgroundColor: context.colorScheme.surface,
      appBar: AppBar(backgroundColor: Colors.transparent, elevation: 0, surfaceTintColor: Colors.transparent),
      body: SafeArea(
        child: SizedBox.expand(
          child: ref
              .watch(projectProvider)
              .maybeWhen(
                orElse: () => const LinearProgressIndicator(),
                data:
                    (projects) => SingleChildScrollView(
                      padding: const EdgeInsets.symmetric(vertical: 48, horizontal: 16),
                      child: Column(
                        children: [_projectSection(context, projects), h96, _openSourceSection(context, projects)],
                      ),
                    ),
              ),
        ),
      ),
    );
  }

  Widget _projectSection(BuildContext context, List<Project> project) {
    return LayoutBuilder(
      builder: (context, constraints) {
        return SizedBox(
          width: constraints.maxWidth.clamp(300, 500),
          child: Column(
            spacing: 24,
            children: [
              Text(
                '<applications>',
                style: context.textTheme.displaySmall!.copyWith(color: context.colorScheme.primary),
              ),
              h16,
              ...project
                  .where((project) => project.type == ProjectType.app)
                  .map((project) => _buildCard(context, project)),
            ],
          ),
        );
      },
    );
  }

  Widget _openSourceSection(BuildContext context, List<Project> project) {
    return LayoutBuilder(
      builder: (context, constraints) {
        return SizedBox(
          width: constraints.maxWidth.clamp(300, 500),
          child: Column(
            spacing: 24,
            children: [
              Text(
                '<open source>',
                style: context.textTheme.displaySmall!.copyWith(color: context.colorScheme.primary),
              ),
              h16,
              ...project
                  .where((project) => project.type == ProjectType.openSource)
                  .map((project) => _buildCard(context, project)),
            ],
          ),
        );
      },
    );
  }

  Widget _buildPreview(BuildContext context, Project project) {
    return switch (project.type) {
      ProjectType.app => Image.asset(imageMap[project.image]!),
      ProjectType.openSource => LayoutBuilder(
        builder: (context, constraints) {
          return Container(
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
                        project.typeDetail ?? '',
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
                        project.name,
                        style: context.textTheme.bodyLarge!.copyWith(color: context.colorScheme.primary),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        },
      ),
    };
  }

  Widget _buildCard(BuildContext context, Project project) {
    const iconSize = 32.0;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // preview
        _buildPreview(context, project),
        // project name
        h16,
        Text(project.name, style: context.textTheme.displaySmall),
        // project description
        h16,
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(8),
          color: context.colorScheme.secondary,
          child: Text(
            project.description,
            style: context.textTheme.bodyMedium!.copyWith(color: context.colorScheme.secondary.inverted),
          ),
        ),
        // project ref
        Row(
          spacing: 8,
          children:
              () sync* {
                yield Text(
                  'Reference: ',
                  style: context.textTheme.bodyMedium!.copyWith(color: context.colorScheme.primary),
                );
                if (project.link.github case var url?) {
                  yield IconButton(
                    onPressed: () {
                      openUrl(url);
                    },
                    icon: FaIcon(FontAwesomeIcons.github, size: iconSize),
                  );
                }
                if (project.link.appstore case var url?) {
                  yield IconButton(
                    onPressed: () {
                      openUrl(url);
                    },
                    icon: FaIcon(FontAwesomeIcons.apple, size: iconSize),
                  );
                }
                if (project.link.playstore case var url?) {
                  yield IconButton(
                    onPressed: () {
                      openUrl(url);
                    },
                    icon: FaIcon(FontAwesomeIcons.googlePlay, size: iconSize),
                  );
                }
                if (project.link.website case var url?) {
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
}
