import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

import 'pag_platform_interface.dart';

/// An implementation of [PagPlatform] that uses method channels.
class MethodChannelPag extends PagPlatform {
  /// The method channel used to interact with the native platform.
  @visibleForTesting
  final methodChannel = const MethodChannel('pag');

  @override
  Future<String?> getPlatformVersion() async {
    final version = await methodChannel.invokeMethod<String>('getPlatformVersion');
    return version;
  }
}
