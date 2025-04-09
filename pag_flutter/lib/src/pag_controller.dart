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
  final i.PAGView view;

  PAGControllerImpl()
      : view = i.PAGView(),
        super.impl();

  @override
  Future<void> play() async {
    await view.play();
  }

  @override
  Future<void> pause() async {
    await view.pause();
  }

  @override
  Future<void> stop() async {
    await view.stop();
  }
}

extension PagControllerX on PAGController {
  i.PAGView get view {
    final controller = this;
    if (controller is! PAGControllerImpl) {
      throw TypeError();
    }
    return controller.view;
  }
}
