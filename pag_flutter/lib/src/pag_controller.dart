import 'package:flutter/foundation.dart';
import 'package:pag_platform_interface/pag_platform_interface.dart' as i;

abstract base class PAGController extends ChangeNotifier {
  factory PAGController() => PAGControllerImpl();

  PAGController.impl();

  Future<void> play();
  Future<void> pause();
  Future<void> stop();
}

final class PAGControllerImpl extends PAGController {
  final i.PAGView api;

  PAGControllerImpl()
      : api = i.PAGView(),
        super.impl();

  @override
  Future<void> play() async {
    await api.play();
  }

  @override
  Future<void> pause() async {
    await api.pause();
  }

  @override
  Future<void> stop() async {
    await api.stop();
  }
}

extension PAGControllerX on PAGController {
  i.PAGView get api {
    final controller = this;
    if (controller is! PAGControllerImpl) {
      throw TypeError();
    }
    return controller.api;
  }
}
