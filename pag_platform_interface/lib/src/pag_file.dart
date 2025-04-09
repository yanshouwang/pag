import 'dart:typed_data';

import 'pag_composition.dart';
import 'pag_plugin.dart';

abstract base class PAGFile extends PAGComposition {
  factory PAGFile.asset(String asset) => PAGPlugin.instance.newPAGAsset(asset);
  factory PAGFile.file(String file) => PAGPlugin.instance.newPAGFile(file);
  factory PAGFile.memory(Uint8List memory) =>
      PAGPlugin.instance.newPAGMemory(memory);

  PAGFile.impl() : super.impl();
}
