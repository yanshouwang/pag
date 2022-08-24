import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

import 'pag_android_platform_interface.dart';

/// An implementation of [PagAndroidPlatform] that uses method channels.
class MethodChannelPagAndroid extends PagAndroidPlatform {
  /// The method channel used to interact with the native platform.
  @visibleForTesting
  final methodChannel = const MethodChannel('pag_android');

  @override
  Future<String?> getPlatformVersion() async {
    final version = await methodChannel.invokeMethod<String>('getPlatformVersion');
    return version;
  }
}
