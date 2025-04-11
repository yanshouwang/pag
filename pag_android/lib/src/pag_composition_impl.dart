import 'package:pag_platform_interface/pag_platform_interface.dart';

import 'api.g.dart';

base mixin PAGCompositionImpl on PAGComposition {
  PAGCompositionApi get api;

  @override
  Future<int> getWidth() async {
    final value = await api.getWidth();
    return value;
  }

  @override
  Future<int> getHeight() async {
    final value = await api.getHeight();
    return value;
  }
}
