
import 'pag_platform_interface.dart';

class Pag {
  Future<String?> getPlatformVersion() {
    return PagPlatform.instance.getPlatformVersion();
  }
}
