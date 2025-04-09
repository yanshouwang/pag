import 'dart:typed_data';

import 'package:pag_platform_interface/pag_platform_interface.dart';

import 'api.g.dart';
import 'pag_composition_impl.dart';

final class PAGFileImpl extends PAGFile with PAGCompositionImpl {
  @override
  final PAGFileApi api;

  PAGFileImpl(this.api) : super.impl();

  PAGFileImpl.asset(String asset)
      : api = PAGFileApi.asset(asset: asset),
        super.impl();

  PAGFileImpl.file(String file)
      : api = PAGFileApi.file(file: file),
        super.impl();

  PAGFileImpl.memory(Uint8List memory)
      : api = PAGFileApi.memory(memory: memory),
        super.impl();
}
