import 'package:flutter_test/flutter_test.dart';
import 'package:pag_core/pag_core.dart';
import 'package:pag_core/pag_core_platform_interface.dart';
import 'package:pag_core/pag_core_method_channel.dart';
import 'package:plugin_platform_interface/plugin_platform_interface.dart';

class MockPagCorePlatform 
    with MockPlatformInterfaceMixin
    implements PagCorePlatform {

  @override
  Future<String?> getPlatformVersion() => Future.value('42');
}

void main() {
  final PagCorePlatform initialPlatform = PagCorePlatform.instance;

  test('$MethodChannelPagCore is the default instance', () {
    expect(initialPlatform, isInstanceOf<MethodChannelPagCore>());
  });

  test('getPlatformVersion', () async {
    PagCore pagCorePlugin = PagCore();
    MockPagCorePlatform fakePlatform = MockPagCorePlatform();
    PagCorePlatform.instance = fakePlatform;
  
    expect(await pagCorePlugin.getPlatformVersion(), '42');
  });
}
