import 'package:plugin_platform_interface/plugin_platform_interface.dart';

import 'pag_method_channel.dart';

abstract class PagPlatform extends PlatformInterface {
  /// Constructs a PagPlatform.
  PagPlatform() : super(token: _token);

  static final Object _token = Object();

  static PagPlatform _instance = MethodChannelPag();

  /// The default instance of [PagPlatform] to use.
  ///
  /// Defaults to [MethodChannelPag].
  static PagPlatform get instance => _instance;
  
  /// Platform-specific implementations should set this with their own
  /// platform-specific class that extends [PagPlatform] when
  /// they register themselves.
  static set instance(PagPlatform instance) {
    PlatformInterface.verifyToken(instance, _token);
    _instance = instance;
  }

  Future<String?> getPlatformVersion() {
    throw UnimplementedError('platformVersion() has not been implemented.');
  }
}
