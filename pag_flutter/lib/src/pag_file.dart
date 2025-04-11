import 'dart:typed_data';

import 'package:pag_platform_interface/pag_platform_interface.dart' as i;

import 'pag_composition.dart';

abstract final class PAGFile extends PAGComposition {
  PAGFile.impl();

  factory PAGFile.asset(String asset) = _PAGAssetImpl;

  factory PAGFile.file(String file) = _PAGFileImpl;

  factory PAGFile.memory(Uint8List memory) = _PAGMemoryImpl;
}

base mixin PAGFileImpl on PAGFile, PAGCompositionImpl {
  @override
  i.PAGFile get api;
}

final class _PAGAssetImpl extends PAGFile with PAGCompositionImpl, PAGFileImpl {
  final String asset;
  @override
  final i.PAGFile api;

  _PAGAssetImpl(this.asset)
      : api = i.PAGFile.asset(asset),
        super.impl();

  @override
  int get hashCode => asset.hashCode;

  @override
  bool operator ==(Object other) {
    return other is _PAGAssetImpl && other.asset == asset;
  }
}

final class _PAGFileImpl extends PAGFile with PAGCompositionImpl, PAGFileImpl {
  final String file;
  @override
  final i.PAGFile api;

  _PAGFileImpl(this.file)
      : api = i.PAGFile.file(file),
        super.impl();

  @override
  int get hashCode => file.hashCode;

  @override
  bool operator ==(Object other) {
    return other is _PAGFileImpl && other.file == file;
  }
}

final class _PAGMemoryImpl extends PAGFile
    with PAGCompositionImpl, PAGFileImpl {
  final Uint8List memory;
  @override
  final i.PAGFile api;

  _PAGMemoryImpl(this.memory)
      : api = i.PAGFile.memory(memory),
        super.impl();

  @override
  int get hashCode => memory.hashCode;

  @override
  bool operator ==(Object other) {
    return other is _PAGMemoryImpl && other.memory == memory;
  }
}
