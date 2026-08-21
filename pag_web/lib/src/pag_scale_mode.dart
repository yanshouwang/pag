import 'package:pag_platform_interface/pag_platform_interface.dart';

import 'js_interop.dart' as js;

extension PAGScaleModeX on PAGScaleMode {
  js.PAGScaleMode get api => switch (this) {
    .none => .none,
    .stretch => .stretch,
    .letterBox => .letterBox,
    .zoom => .zoom,
  };
}

extension JsPAGScaleModeX on js.PAGScaleMode {
  PAGScaleMode get impl => switch (this) {
    .none => .none,
    .stretch => .stretch,
    .letterBox => .letterBox,
    .zoom => .zoom,
    _ => throw ArgumentError.value(this, 'PAGScaleMode'),
  };
}
