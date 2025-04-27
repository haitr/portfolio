import 'package:path/path.dart' as path;

const _imageUrls = [
  'assets/images/bookreco.jpg',
  'assets/images/device_shield.png',
  'assets/images/dingdongu_2.jpg',
  'assets/images/dingdongu.jpg',
  'assets/images/ecp.png',
  'assets/images/gongmap.jpg',
  'assets/images/kingjim_shotdocs.png',
  'assets/images/kurumaerabi.png',
  'assets/images/me.png',
  'assets/images/v_spacer.png',
  'assets/images/vijob.png',
];

final imageMap = Map.unmodifiable(
  Map.fromEntries(_imageUrls.map((url) => MapEntry(path.basenameWithoutExtension(url), url))),
);
