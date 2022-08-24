import 'package:plugin_platform_interface/plugin_platform_interface.dart';

import 'pag_core_method_channel.dart';

abstract class PagCorePlatform extends PlatformInterface {
  /// Constructs a PagCorePlatform.
  PagCorePlatform() : super(token: _token);

  static final Object _token = Object();

  static PagCorePlatform _instance = MethodChannelPagCore();

  /// The default instance of [PagCorePlatform] to use.
  ///
  /// Defaults to [MethodChannelPagCore].
  static PagCorePlatform get instance => _instance;
  
  /// Platform-specific implementations should set this with their own
  /// platform-specific class that extends [PagCorePlatform] when
  /// they register themselves.
  static set instance(PagCorePlatform instance) {
    PlatformInterface.verifyToken(instance, _token);
    _instance = instance;
  }

  Future<String?> getPlatformVersion() {
    throw UnimplementedError('platformVersion() has not been implemented.');
  }
}
