import 'package:animated_theme_switcher/animated_theme_switcher.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ThemeService {
  ThemeService._();

  static final _instance = ThemeService._();

  var _isDark = true;

  static ThemeService get instance => _instance;

  bool get isDark => _isDark;

  @Deprecated('Use setTheme instead')
  void toggle() => _isDark = !_isDark;

  void setTheme(BuildContext context, bool isDark) {
    _isDark = isDark;
    ThemeSwitcher.of(context).changeTheme(theme: theme);
  }

  ThemeData get theme => _isDark ? darkTheme : lightTheme;
}

// headline1 -> displayLarge
// headline2 -> displayMedium
// headline3 -> displaySmall
// headline4 -> headlineMedium
// headline5 -> headlineSmall
// headline6 -> titleLarge
// bodyText1 -> bodyLarge
// bodyText2 -> bodyMedium
// subtitle1 -> titleMedium

final _textTheme = TextTheme(
  // display
  displayLarge: GoogleFonts.victorMono(fontSize: 48.0, fontWeight: FontWeight.w700),
  displayMedium: GoogleFonts.victorMono(fontSize: 36.0, fontWeight: FontWeight.w700),
  displaySmall: GoogleFonts.victorMono(fontSize: 24.0, fontWeight: FontWeight.w700),

  // headline
  headlineLarge: GoogleFonts.victorMono(fontSize: 24.0, fontWeight: FontWeight.w700),
  headlineMedium: GoogleFonts.victorMono(fontSize: 18.0, fontWeight: FontWeight.w600),
  headlineSmall: GoogleFonts.victorMono(fontSize: 14.0, fontWeight: FontWeight.w500),

  // title
  titleLarge: GoogleFonts.josefinSans(fontSize: 48.0, fontWeight: FontWeight.w400),
  titleMedium: GoogleFonts.josefinSans(fontSize: 36.0, fontWeight: FontWeight.w400),
  titleSmall: GoogleFonts.josefinSans(fontSize: 24.0, fontWeight: FontWeight.w400),

  // body
  bodyLarge: GoogleFonts.spaceGrotesk(fontSize: 24.0, fontWeight: FontWeight.w500),
  bodyMedium: GoogleFonts.spaceGrotesk(fontSize: 14.0, fontWeight: FontWeight.w400),
  bodySmall: GoogleFonts.spaceGrotesk(fontSize: 12.0, fontWeight: FontWeight.w400),
);

final _scrollbarTheme = ScrollbarThemeData().copyWith(thumbColor: WidgetStateProperty.all(Color(0xFFE9B171)));

final lightTheme = ThemeData(
  visualDensity: VisualDensity.standard,
  useMaterial3: true,
  primaryColor: Color(0xFFE9B171),
  colorScheme: ColorScheme.fromSeed(
    seedColor: Color(0xFFE9B171),
    brightness: Brightness.light,
    secondary: Color(0xFF2A2A2A),
  ),
  scrollbarTheme: _scrollbarTheme,
  // text theme
  fontFamily: 'Josefin Sans',
  textTheme: _textTheme,
);

final darkTheme = ThemeData(
  visualDensity: VisualDensity.standard,
  useMaterial3: true,
  primaryColor: Color(0xFFE9B171),
  colorScheme: ColorScheme.fromSeed(seedColor: Color(0xFFE9B171), brightness: Brightness.dark, secondary: Colors.white),
  scrollbarTheme: _scrollbarTheme,
  // text theme
  fontFamily: 'Josefin Sans',
  textTheme: _textTheme,
);
