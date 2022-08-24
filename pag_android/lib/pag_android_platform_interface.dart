import 'package:plugin_platform_interface/plugin_platform_interface.dart';

import 'pag_android_method_channel.dart';

abstract class PagAndroidPlatform extends PlatformInterface {
  /// Constructs a PagAndroidPlatform.
  PagAndroidPlatform() : super(token: _token);

  static final Object _token = Object();

  static PagAndroidPlatform _instance = MethodChannelPagAndroid();

  /// The default instance of [PagAndroidPlatform] to use.
  ///
  /// Defaults to [MethodChannelPagAndroid].
  static PagAndroidPlatform get instance => _instance;
  
  /// Platform-specific implementations should set this with their own
  /// platform-specific class that extends [PagAndroidPlatform] when
  /// they register themselves.
  static set instance(PagAndroidPlatform instance) {
    PlatformInterface.verifyToken(instance, _token);
    _instance = instance;
  }

  Future<String?> getPlatformVersion() {
    throw UnimplementedError('platformVersion() has not been implemented.');
  }
}
