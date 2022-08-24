import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:pag_core/pag_core_method_channel.dart';

void main() {
  MethodChannelPagCore platform = MethodChannelPagCore();
  const MethodChannel channel = MethodChannel('pag_core');

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
