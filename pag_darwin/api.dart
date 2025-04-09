// Run with `dart run pigeon --input api.dart`.

import 'package:pigeon/pigeon.dart';

@ConfigurePigeon(
  PigeonOptions(
    dartOut: 'lib/src/api.g.dart',
    dartOptions: DartOptions(),
    swiftOut: 'darwin/Classes/PAGApi.g.swift',
    swiftOptions: SwiftOptions(
      errorClassName: 'PAGError',
    ),
  ),
)
@ProxyApi(
  swiftOptions: SwiftProxyApiOptions(
    name: 'PAGView',
    import: 'libpag',
  ),
)
abstract class PAGViewApi {
  PAGViewApi();

  PAGCompositionApi getComposition();
  void setCompositon(PAGCompositionApi value);

  int getRepeatCount();
  void setRepeatCount(int value);

  PAGScaleModeApi getScaleMode();
  void setScaleMode(PAGScaleModeApi value);

  double getProgress();
  void setProgress(double value);

  bool isPlaying();
  void play();
  void pause();
  void stop();
}

@ProxyApi(
  swiftOptions: SwiftProxyApiOptions(
    name: 'PAGComposition',
    import: 'libpag',
  ),
)
abstract class PAGCompositionApi {
  int getWidth();
  int getHeight();
}

@ProxyApi(
  swiftOptions: SwiftProxyApiOptions(
    name: 'PAGFile',
    import: 'libpag',
  ),
)
abstract class PAGFileApi extends PAGCompositionApi {
  PAGFileApi.asset(String asset);
  PAGFileApi.file(String file);
  PAGFileApi.memory(Uint8List memory);
}

enum PAGScaleModeApi {
  none,
  stretch,
  letterBox,
  zoom,
}
