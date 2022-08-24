import 'package:flutter_test/flutter_test.dart';
import 'package:pag_web/pag_web.dart';
import 'package:pag_web/pag_web_platform_interface.dart';
import 'package:pag_web/pag_web_method_channel.dart';
import 'package:plugin_platform_interface/plugin_platform_interface.dart';

class MockPagWebPlatform 
    with MockPlatformInterfaceMixin
    implements PagWebPlatform {

  @override
  Future<String?> getPlatformVersion() => Future.value('42');
}

void main() {
  final PagWebPlatform initialPlatform = PagWebPlatform.instance;

  test('$MethodChannelPagWeb is the default instance', () {
    expect(initialPlatform, isInstanceOf<MethodChannelPagWeb>());
  });

  test('getPlatformVersion', () async {
    PagWeb pagWebPlugin = PagWeb();
    MockPagWebPlatform fakePlatform = MockPagWebPlatform();
    PagWebPlatform.instance = fakePlatform;
  
    expect(await pagWebPlugin.getPlatformVersion(), '42');
  });
}
