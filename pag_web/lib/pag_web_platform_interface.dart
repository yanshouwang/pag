import 'package:plugin_platform_interface/plugin_platform_interface.dart';

import 'pag_web_method_channel.dart';

abstract class PagWebPlatform extends PlatformInterface {
  /// Constructs a PagWebPlatform.
  PagWebPlatform() : super(token: _token);

  static final Object _token = Object();

  static PagWebPlatform _instance = MethodChannelPagWeb();

  /// The default instance of [PagWebPlatform] to use.
  ///
  /// Defaults to [MethodChannelPagWeb].
  static PagWebPlatform get instance => _instance;
  
  /// Platform-specific implementations should set this with their own
  /// platform-specific class that extends [PagWebPlatform] when
  /// they register themselves.
  static set instance(PagWebPlatform instance) {
    PlatformInterface.verifyToken(instance, _token);
    _instance = instance;
  }

  Future<String?> getPlatformVersion() {
    throw UnimplementedError('platformVersion() has not been implemented.');
  }
}
