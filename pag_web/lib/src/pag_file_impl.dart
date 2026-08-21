import 'dart:js_interop';
import 'dart:typed_data';

import 'package:pag_platform_interface/pag_platform_interface.dart';

import 'js_interop.dart' as js;
import 'pag_composition_impl.dart';

final class PAGFileImpl extends PAGFile with PAGCompositionImpl {
  @override
  final js.PAGFile api;

  PAGFileImpl(this.api) : super.impl();

  PAGFileImpl.asset(String asset)
    : api = js.PAGFile.loadFromBuffer(buffer),
      super.impl();

  PAGFileImpl.file(String file)
    : api = js.PAGFile.loadFromBuffer(buffer),
      super.impl();

  PAGFileImpl.bytes(Uint8List bytes)
    : api = js.PAGFile.loadFromBuffer(bytes.toJS),
      super.impl();
}
