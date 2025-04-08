// Run with `dart run pigeon --input api.dart`.

import 'package:pigeon/pigeon.dart';

@ConfigurePigeon(
  PigeonOptions(
    dartOut: 'lib/src/api.g.dart',
    dartOptions: DartOptions(),
    kotlinOut: 'android/src/main/kotlin/dev/hebei/pag/PAGApi.g.kt',
    kotlinOptions: KotlinOptions(
      package: 'dev.hebei.pag',
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
  void setCompositon(PAGCompositionApi newComposition);

  int repeatCount();
  void setRepeatCount(int repeatCount);

  PAGScaleModeApi scaleMode();
  void setScaleMode(PAGScaleModeApi value);

  double getProgress();
  void setProgress(double value);

  bool sync();
  void setSync(bool value);

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
  int width();
  int height();
}

@ProxyApi(
  kotlinOptions: KotlinProxyApiOptions(
    fullClassName: 'org.libpag.PAGFile',
  ),
)
abstract class PAGFileApi extends PAGCompositionApi {
  PAGFileApi.asset(String assetName);
  PAGFileApi.file(String filePath);
  PAGFileApi.memory(Uint8List bytes);
}

enum PAGScaleModeApi {
  none,
  stretch,
  letterBox,
  zoom,
}
