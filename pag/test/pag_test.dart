import 'package:flutter_test/flutter_test.dart';
import 'package:pag/pag.dart';
import 'package:pag/pag_platform_interface.dart';
import 'package:pag/pag_method_channel.dart';
import 'package:plugin_platform_interface/plugin_platform_interface.dart';

class MockPagPlatform 
    with MockPlatformInterfaceMixin
    implements PagPlatform {

  @override
  Future<String?> getPlatformVersion() => Future.value('42');
}

void main() {
  final PagPlatform initialPlatform = PagPlatform.instance;

  test('$MethodChannelPag is the default instance', () {
    expect(initialPlatform, isInstanceOf<MethodChannelPag>());
  });

  test('getPlatformVersion', () async {
    Pag pagPlugin = Pag();
    MockPagPlatform fakePlatform = MockPagPlatform();
    PagPlatform.instance = fakePlatform;
  
    expect(await pagPlugin.getPlatformVersion(), '42');
  });
}
