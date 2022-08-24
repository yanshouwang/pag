import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

import 'pag_core_platform_interface.dart';

/// An implementation of [PagCorePlatform] that uses method channels.
class MethodChannelPagCore extends PagCorePlatform {
  /// The method channel used to interact with the native platform.
  @visibleForTesting
  final methodChannel = const MethodChannel('pag_core');

  @override
  Future<String?> getPlatformVersion() async {
    final version = await methodChannel.invokeMethod<String>('getPlatformVersion');
    return version;
  }
}
