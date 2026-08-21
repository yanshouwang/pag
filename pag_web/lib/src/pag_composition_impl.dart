import 'dart:js_interop';

import 'package:pag_platform_interface/pag_platform_interface.dart';

import 'js_interop.dart' as js;
import 'pag_file_impl.dart';

base mixin PAGCompositionImpl on PAGComposition {
  js.PAGComposition get api;

  @override
  Future<int> getWidth() {
    final value = api.width().toInt();
    return Future.value(value);
  }

  @override
  Future<int> getHeight() {
    final value = api.height().toInt();
    return Future.value(value);
  }
}

extension PAGCompositionX on PAGComposition {
  js.PAGComposition get api {
    final impl = this;
    if (impl is! PAGFileImpl) {
      throw TypeError();
    }
    return impl.api;
  }
}

extension JsPAGCompositionX on js.PAGComposition {
  PAGComposition get impl {
    final api = this;
    final isPAGFile = api.isA<js.PAGFile>();
    if (!isPAGFile) {
      throw TypeError();
    }
    return PAGFileImpl(api as js.PAGFile);
  }
}
