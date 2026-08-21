import 'dart:typed_data';

import 'package:pag_platform_interface/pag_platform_interface.dart' as i;

import 'pag_composition.dart';

abstract final class PAGFile extends PAGComposition {
  PAGFile.impl();

  factory PAGFile.asset(String asset) = _AssetPAGFileImpl;

  factory PAGFile.file(String file) = _FilePAGFileImpl;

  factory PAGFile.bytes(Uint8List bytes) = _BytesPAGFileImpl;
}

base mixin PAGFileImpl on PAGFile, PAGCompositionImpl {
  @override
  i.PAGFile get api;
}

final class _AssetPAGFileImpl extends PAGFile
    with PAGCompositionImpl, PAGFileImpl {
  final String asset;
  @override
  final i.PAGFile api;

  _AssetPAGFileImpl(this.asset) : api = i.PAGFile.asset(asset), super.impl();

  @override
  int get hashCode => asset.hashCode;

  @override
  bool operator ==(Object other) {
    return other is _AssetPAGFileImpl && other.asset == asset;
  }
}

final class _FilePAGFileImpl extends PAGFile
    with PAGCompositionImpl, PAGFileImpl {
  final String file;
  @override
  final i.PAGFile api;

  _FilePAGFileImpl(this.file) : api = i.PAGFile.file(file), super.impl();

  @override
  int get hashCode => file.hashCode;

  @override
  bool operator ==(Object other) {
    return other is _FilePAGFileImpl && other.file == file;
  }
}

final class _BytesPAGFileImpl extends PAGFile
    with PAGCompositionImpl, PAGFileImpl {
  final Uint8List bytes;
  @override
  final i.PAGFile api;

  _BytesPAGFileImpl(this.bytes) : api = i.PAGFile.bytes(bytes), super.impl();

  @override
  int get hashCode => bytes.hashCode;

  @override
  bool operator ==(Object other) {
    return other is _BytesPAGFileImpl && other.bytes == bytes;
  }
}
