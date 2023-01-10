import 'dart:io';

import 'package:image/image.dart';

const version = 'v4';
void main(List<String> arguments) {
  print(version);

  File input = File('../test.png');

  final image = decodeImage(input.readAsBytesSync());
  if (image == null) {
    print('$input could not be loaded.');
    exit(1);
  }

  for (var interpolation in Interpolation.values) {
    String suffix = interpolation.name;
    final newFile = copyResize(
      image,
      width: image.width ~/ 2,
      height: image.height ~/ 2,
      interpolation: interpolation,
    );

    final output = File('../output-$suffix-$version.png');
    output.createSync(recursive: true);
    output.writeAsBytesSync(encodePng(newFile));
  }
}
