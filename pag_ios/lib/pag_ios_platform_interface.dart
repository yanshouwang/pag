import 'package:plugin_platform_interface/plugin_platform_interface.dart';

import 'pag_ios_method_channel.dart';

abstract class PagIosPlatform extends PlatformInterface {
  /// Constructs a PagIosPlatform.
  PagIosPlatform() : super(token: _token);

  static final Object _token = Object();

  static PagIosPlatform _instance = MethodChannelPagIos();

  /// The default instance of [PagIosPlatform] to use.
  ///
  /// Defaults to [MethodChannelPagIos].
  static PagIosPlatform get instance => _instance;
  
  /// Platform-specific implementations should set this with their own
  /// platform-specific class that extends [PagIosPlatform] when
  /// they register themselves.
  static set instance(PagIosPlatform instance) {
    PlatformInterface.verifyToken(instance, _token);
    _instance = instance;
  }

  Future<String?> getPlatformVersion() {
    throw UnimplementedError('platformVersion() has not been implemented.');
  }
}
