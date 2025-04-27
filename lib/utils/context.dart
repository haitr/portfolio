import 'package:flutter/material.dart';

extension ColorSchemeExt<T extends StatefulWidget> on State<T> {
  ColorScheme get colorScheme => Theme.of(context).colorScheme;
}

extension ColorSchemeBuildContextExt on BuildContext {
  ColorScheme get colorScheme => Theme.of(this).colorScheme;
}

extension TextThemeBuildContextExt on BuildContext {
  TextTheme get textTheme => Theme.of(this).textTheme;
}
