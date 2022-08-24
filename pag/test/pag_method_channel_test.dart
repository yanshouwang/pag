import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:pag/pag_method_channel.dart';

void main() {
  MethodChannelPag platform = MethodChannelPag();
  const MethodChannel channel = MethodChannel('pag');

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
