import 'dart:typed_data';

import 'package:flutter_web_plugins/flutter_web_plugins.dart';
import 'package:pag_platform_interface/pag_platform_interface.dart';

import 'pag_file_impl.dart';
import 'pag_view_impl.dart';

final class PAGWebPlugin extends PAGPlugin {
  static void registerWith(Registrar registrar) {
    PAGPlugin.instance = PAGWebPlugin();
  }

  @override
  PAGFile newPAGAsset(String asset) => PAGFile.asset(asset);

  @override
  PAGFile newPAGFile(String file) => PAGFile.file(file);

  @override
  PAGFile newPAGBytes(Uint8List bytes) => PAGFileImpl.bytes(bytes);

  @override
  PAGView newPAGView() => PAGViewImpl();
}
