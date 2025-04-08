import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:pag/src/api.g.dart';

class PAGView extends StatefulWidget {
  final PAGFileApi _file;

  PAGView.asset(
    String asset, {
    super.key,
  }) : _file = PAGFileApi.asset(assetName: asset);

  PAGView.file(
    String file, {
    super.key,
  }) : _file = PAGFileApi.file(filePath: file);

  PAGView.memory(
    Uint8List memory, {
    super.key,
  }) : _file = PAGFileApi.memory(bytes: memory);

  @override
  State<PAGView> createState() => _PAGViewState();
}

class _PAGViewState extends State<PAGView> {
  late final PAGViewApi _api;

  @override
  void initState() {
    super.initState();
    _api = PAGViewApi()
      ..setCompositon(widget._file)
      ..setRepeatCount(0)
      ..play();
  }

  @override
  Widget build(BuildContext context) {
    final id = _api.pigeon_instanceManager.getIdentifier(_api);
    return AndroidView(
      viewType: 'hebei.dev/PAGView',
      layoutDirection: TextDirection.ltr,
      creationParams: id,
      creationParamsCodec: const StandardMessageCodec(),
    );
  }

  // @override
  // void didUpdateWidget(covariant PAGView oldWidget) {
  //   super.didUpdateWidget(oldWidget);
  //   if (widget._file != oldWidget._file) {
  //     _api.setCompositon(widget._file);
  //   }
  // }
}
