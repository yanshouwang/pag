import 'package:plugin_platform_interface/plugin_platform_interface.dart';

abstract base class PAGController extends PlatformInterface {
  static final _token = Object();

  PAGController.impl() : super(token: _token);

  Future<void> play();
  Future<void> pause();
  Future<void> stop();
}
