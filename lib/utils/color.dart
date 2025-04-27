import 'dart:math';
import 'dart:ui';

extension ColorInverse on Color {
  Color get inverted => Color.from(alpha: a, red: 255 - r, green: 255 - g, blue: 255 - b);

  Color get random {
    final random = Random();
    final newR = random.nextDouble() * 255;
    // final newG = random.nextDouble() * 255;
    final newB = random.nextDouble() * 255;
    return Color.from(alpha: a, red: newR, green: g, blue: newB);
  }
}
