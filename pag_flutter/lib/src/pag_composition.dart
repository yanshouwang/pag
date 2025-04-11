import 'package:pag_platform_interface/pag_platform_interface.dart' as i;

abstract base class PAGComposition {
  Future<int> getWidth();
  Future<int> getHeight();
}

base mixin PAGCompositionImpl on PAGComposition {
  i.PAGComposition get api;

  @override
  Future<int> getWidth() => api.getWidth();
  @override
  Future<int> getHeight() => api.getHeight();
}

extension PAGCompositionX on PAGComposition {
  i.PAGComposition get api {
    final composition = this;
    if (composition is! PAGCompositionImpl) {
      throw TypeError();
    }
    return composition.api;
  }
}
