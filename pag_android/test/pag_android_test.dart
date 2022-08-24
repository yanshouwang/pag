import 'package:flutter_test/flutter_test.dart';
import 'package:pag_android/pag_android.dart';
import 'package:pag_android/pag_android_platform_interface.dart';
import 'package:pag_android/pag_android_method_channel.dart';
import 'package:plugin_platform_interface/plugin_platform_interface.dart';

class MockPagAndroidPlatform 
    with MockPlatformInterfaceMixin
    implements PagAndroidPlatform {

  @override
  Future<String?> getPlatformVersion() => Future.value('42');
}

void main() {
  final PagAndroidPlatform initialPlatform = PagAndroidPlatform.instance;

  test('$MethodChannelPagAndroid is the default instance', () {
    expect(initialPlatform, isInstanceOf<MethodChannelPagAndroid>());
  });

  test('getPlatformVersion', () async {
    PagAndroid pagAndroidPlugin = PagAndroid();
    MockPagAndroidPlatform fakePlatform = MockPagAndroidPlatform();
    PagAndroidPlatform.instance = fakePlatform;
  
    expect(await pagAndroidPlugin.getPlatformVersion(), '42');
  });
}
