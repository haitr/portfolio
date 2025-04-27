import 'package:animated_theme_switcher/animated_theme_switcher.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:portfolio/screens/home.dart';
import 'package:portfolio/screens/loading.dart';
import 'package:responsive_framework/responsive_framework.dart';

import 'screens/project.dart';
import 'service/theme.dart';
import 'utils/constants.dart';

void main() {
  runApp(ProviderScope(child: const PortfolioApp()));
}

class PortfolioApp extends StatelessWidget {
  const PortfolioApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ThemeProvider(
      initTheme: ThemeService.instance.theme,
      builder: (_, theme) {
        return MaterialApp(
          title: 'Portfolio',
          theme: theme,
          debugShowCheckedModeBanner: false,
          initialRoute: '/',
          onGenerateRoute: (settings) {
            switch (settings.name) {
              case '/':
                return MaterialPageRoute(builder: (_) => const LoadingScreen(), settings: settings);
              case '/home':
                return MaterialPageRoute(builder: (_) => const HomePage(), settings: settings);
              case '/projects':
                return MaterialPageRoute(builder: (_) => const ProjectScreen(), settings: settings);
              default:
                return MaterialPageRoute(builder: (_) => const LoadingScreen(), settings: settings);
            }
          },
          builder: (context, child) {
            return ResponsiveBreakpoints.builder(
              breakpoints: [
                Breakpoint(start: 0, end: 800, name: kSmallBreakPoint),
                Breakpoint(start: 801, end: double.infinity, name: kLargeBreakPoint),
              ],
              child: child!,
            );
          },
        );
      },
    );
  }
}

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return ResponsiveBreakpoints.of(context).breakpoint.name == kSmallBreakPoint
        ? const HomeMobile()
        : const HomeDesktop();
  }
}
