import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:pag_android/pag_android_method_channel.dart';

void main() {
  MethodChannelPagAndroid platform = MethodChannelPagAndroid();
  const MethodChannel channel = MethodChannel('pag_android');

  TestWidgetsFlutterBinding.ensureInitialized();

  setUp(() {
    channel.setMockMethodCallHandler((MethodCall methodCall) async {
      return '42';
    });
  });

  tearDown(() {
    channel.setMockMethodCallHandler(null);
  });

  test('getPlatformVersion', () async {
    expect(await platform.getPlatformVersion(), '42');
  });
}
