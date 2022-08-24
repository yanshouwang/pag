import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:pag_ios/pag_ios_method_channel.dart';

void main() {
  MethodChannelPagIos platform = MethodChannelPagIos();
  const MethodChannel channel = MethodChannel('pag_ios');

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
