
import 'pag_web_platform_interface.dart';

class PagWeb {
  Future<String?> getPlatformVersion() {
    return PagWebPlatform.instance.getPlatformVersion();
  }
}
