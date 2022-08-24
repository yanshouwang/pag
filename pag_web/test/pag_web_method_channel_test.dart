import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:pag_web/pag_web_method_channel.dart';

void main() {
  MethodChannelPagWeb platform = MethodChannelPagWeb();
  const MethodChannel channel = MethodChannel('pag_web');

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
