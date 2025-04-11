import 'package:plugin_platform_interface/plugin_platform_interface.dart';

abstract base class PAGComposition extends PlatformInterface {
  static final _token = Object();

  PAGComposition.impl() : super(token: _token);

  Future<int> getWidth();
  Future<int> getHeight();
}
