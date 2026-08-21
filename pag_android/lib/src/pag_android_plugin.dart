import 'dart:typed_data';

import 'package:pag_platform_interface/pag_platform_interface.dart';

import 'pag_file_impl.dart';
import 'pag_view_impl.dart';

final class PAGAndroidPlugin extends PAGPlugin {
  static void registerWith() {
    PAGPlugin.instance = PAGAndroidPlugin();
  }

  @override
  PAGFile newPAGAsset(String asset) {
    return PAGFileImpl.asset(asset);
  }

  @override
  PAGFile newPAGFile(String file) {
    return PAGFileImpl.file(file);
  }

  @override
  PAGFile newPAGBytes(Uint8List bytes) {
    return PAGFileImpl.bytes(bytes);
  }

  @override
  PAGView newPAGView() {
    return PAGViewImpl();
  }
}
