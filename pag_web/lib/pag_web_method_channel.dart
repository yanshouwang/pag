import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

import 'pag_web_platform_interface.dart';

/// An implementation of [PagWebPlatform] that uses method channels.
class MethodChannelPagWeb extends PagWebPlatform {
  /// The method channel used to interact with the native platform.
  @visibleForTesting
  final methodChannel = const MethodChannel('pag_web');

  @override
  Future<String?> getPlatformVersion() async {
    final version = await methodChannel.invokeMethod<String>('getPlatformVersion');
    return version;
  }
}
