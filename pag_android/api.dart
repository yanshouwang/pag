// Run with `dart run pigeon --input api.dart`.

import 'package:pigeon/pigeon.dart';

@ConfigurePigeon(
  PigeonOptions(
    dartOut: 'lib/src/api.g.dart',
    dartOptions: DartOptions(),
    kotlinOut: 'android/src/main/kotlin/dev/hebei/pag_android/PAGApi.g.kt',
    kotlinOptions: KotlinOptions(
      package: 'dev.hebei.pag_android',
      errorClassName: 'PAGError',
    ),
  ),
)
@ProxyApi(
  kotlinOptions: KotlinProxyApiOptions(
    fullClassName: 'org.libpag.PAGView',
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
  kotlinOptions: KotlinProxyApiOptions(
    fullClassName: 'org.libpag.PAGComposition',
  ),
)
abstract class PAGCompositionApi {
  int getWidth();
  int getHeight();
}

@ProxyApi(
  kotlinOptions: KotlinProxyApiOptions(
    fullClassName: 'org.libpag.PAGFile',
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
