import 'package:pag_platform_interface/pag_platform_interface.dart';

import 'api.g.dart';
import 'pag_file_impl.dart';
import 'pag_view_impl.dart';

extension PAGScaleModeX on PAGScaleMode {
  PAGScaleModeApi get api => PAGScaleModeApi.values[index];
}

extension PAGScaleModeApiX on PAGScaleModeApi {
  PAGScaleMode get impl => PAGScaleMode.values[index];
}

extension PAGViewX on PAGView {
  PAGViewApi get api {
    final controller = this;
    if (controller is! PAGViewImpl) {
      throw TypeError();
    }
    return controller.api;
  }
}

extension PAGCompositionX on PAGComposition {
  PAGCompositionApi get api {
    final file = this;
    if (file is! PAGFileImpl) {
      throw TypeError();
    }
    return file.api;
  }
}

extension PAGCompositionApiX on PAGCompositionApi {
  PAGComposition get impl {
    final api = this;
    if (api is! PAGFileApi) {
      throw TypeError();
    }
    return PAGFileImpl(api);
  }
}
