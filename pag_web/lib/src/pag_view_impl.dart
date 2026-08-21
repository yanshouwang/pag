import 'dart:js_interop';

import 'package:flutter/widgets.dart';
import 'package:pag_platform_interface/pag_platform_interface.dart';

import 'js_interop.dart' as js;

final class PAGViewImpl extends PAGView {
  final js.PAGView api;

  PAGViewImpl() : api = js.PAGView(), super.impl();

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    throw UnimplementedError();
  }

  @override
  Future<PAGComposition> getComposition() async => api.getComposition();

  @override
  Future<double> getProgress() async => api.getProgress().toDouble();

  @override
  Future<int> getRepeatCount() async => api.repeatCount;

  @override
  Future<PAGScaleMode> getScaleMode() async => api.scaleMode();

  @override
  Future<bool> isPlaying() async => api.isPlaying;

  @override
  Future<void> pause() async => api.pause();

  @override
  Future<void> play() => api.play().toDart;

  @override
  Future<void> setCompositon(PAGComposition value) async =>
      api.setComposition(value);

  @override
  Future<void> setProgress(double value) async => api.setProgress(value);

  @override
  Future<void> setRepeatCount(int value) async => api.setRepeatCount(value);

  @override
  Future<void> setScaleMode(PAGScaleMode value) async =>
      api.setScaleMode(value);

  @override
  Future<void> stop() => api.stop().toDart;
}

extension PAGViewX on PAGView {
  js.PAGView get api {
    final impl = this;
    if (impl is! PAGViewImpl) {
      throw TypeError();
    }
    return impl.api;
  }
}
