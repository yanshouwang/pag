import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:pag_platform_interface/pag_platform_interface.dart' as i;

import 'pag_controller.dart';

const _kRepeatCount = 1;
const _kScaleMode = i.PAGScaleMode.stretch;
const _kProgress = 0.0;

class PAGView extends StatefulWidget {
  final PAGController controller;
  final i.PAGFile file;
  final int repeatCount;
  final i.PAGScaleMode scaleMode;
  final double progress;

  PAGView.asset(
    String asset, {
    required this.controller,
    this.repeatCount = _kRepeatCount,
    this.scaleMode = _kScaleMode,
    this.progress = _kProgress,
    super.key,
  }) : file = i.PAGFile.asset(asset);

  PAGView.file(
    String file, {
    required this.controller,
    this.repeatCount = _kRepeatCount,
    this.scaleMode = _kScaleMode,
    this.progress = _kProgress,
    super.key,
  }) : file = i.PAGFile.file(file);

  PAGView.memory(
    Uint8List memory, {
    required this.controller,
    this.repeatCount = _kRepeatCount,
    this.scaleMode = _kScaleMode,
    this.progress = _kProgress,
    super.key,
  }) : file = i.PAGFile.memory(memory);

  @override
  State<PAGView> createState() => _PAGViewState();
}

class _PAGViewState extends State<PAGView> {
  i.PAGView get view => widget.controller.view;

  @override
  void initState() {
    super.initState();
    view
      ..setCompositon(widget.file)
      ..setRepeatCount(widget.repeatCount)
      ..setScaleMode(widget.scaleMode)
      ..setProgress(widget.progress);
  }

  @override
  Widget build(BuildContext context) {
    return view.build(context);
  }

  @override
  void didUpdateWidget(covariant PAGView oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.file != oldWidget.file) {
      view.setCompositon(widget.file);
    }
    if (widget.repeatCount != oldWidget.repeatCount) {
      view.setRepeatCount(widget.repeatCount);
    }
    if (widget.scaleMode != oldWidget.scaleMode) {
      view.setScaleMode(widget.scaleMode);
    }
    if (widget.progress != oldWidget.progress) {
      view.setProgress(widget.progress);
    }
  }
}
