import 'package:flutter/material.dart';
import 'package:garbage_collector/features/canvas/widget_box.dart';
import 'package:garbage_collector/features/utils/recognition_result.dart';

class BoundingBoxesView extends StatelessWidget {
  final List<Recognition> boxes;
  final Size cameraSize;
  const BoundingBoxesView({super.key, required this.boxes, required this.cameraSize});

  @override
  Widget build(BuildContext context) {
    if (boxes == null) {
      return Container();
    }
    return Stack(
      children: boxes.map((e) => BoxWidget(
        result: e,
        cameraSize: this.cameraSize
      ))
          .toList(),
    );
  }
}
