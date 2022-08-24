import 'package:flutter_test/flutter_test.dart';
import 'package:pag_ios/pag_ios.dart';
import 'package:pag_ios/pag_ios_platform_interface.dart';
import 'package:pag_ios/pag_ios_method_channel.dart';
import 'package:plugin_platform_interface/plugin_platform_interface.dart';

class MockPagIosPlatform 
    with MockPlatformInterfaceMixin
    implements PagIosPlatform {

  @override
  Future<String?> getPlatformVersion() => Future.value('42');
}

void main() {
  final PagIosPlatform initialPlatform = PagIosPlatform.instance;

  test('$MethodChannelPagIos is the default instance', () {
    expect(initialPlatform, isInstanceOf<MethodChannelPagIos>());
  });

  test('getPlatformVersion', () async {
    PagIos pagIosPlugin = PagIos();
    MockPagIosPlatform fakePlatform = MockPagIosPlatform();
    PagIosPlatform.instance = fakePlatform;
  
    expect(await pagIosPlugin.getPlatformVersion(), '42');
  });
}
