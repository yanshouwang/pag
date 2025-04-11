import 'dart:typed_data';

import 'package:pag_platform_interface/pag_platform_interface.dart';

import 'pag_file_impl.dart';
import 'pag_view_impl.dart';

abstract final class PAGDarwinPlugin extends PAGPlugin {
  @override
  PAGFile newPAGAsset(String asset) {
    return PAGFileImpl.asset(asset);
  }

  @override
  PAGFile newPAGFile(String file) {
    return PAGFileImpl.file(file);
  }

  @override
  PAGFile newPAGMemory(Uint8List memory) {
    return PAGFileImpl.memory(memory);
  }
}

final class PAGiOSPlugin extends PAGDarwinPlugin {
  static void registerWith() {
    PAGPlugin.instance = PAGiOSPlugin();
  }

  @override
  PAGView newPAGView() {
    return PAGViewImpl.iOS();
  }
}

final class PAGmacOSPlugin extends PAGDarwinPlugin {
  static void registerWith() {
    PAGPlugin.instance = PAGmacOSPlugin();
  }

  @override
  PAGView newPAGView() {
    return PAGViewImpl.macOS();
  }
}
