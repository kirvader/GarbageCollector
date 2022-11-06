import 'package:flutter/material.dart';
import 'package:garbage_collector/features/canvas/widget_box.dart';
import 'package:garbage_collector/features/utils/recognition_result.dart';

class BoundingBoxesView extends StatelessWidget {
  final List<Recognition> boxes;
  final Size cameraSize;
  final void Function(Map<String, dynamic>) navigateToInfo;
  const BoundingBoxesView({super.key, required this.boxes, required this.cameraSize, required this.navigateToInfo});

  @override
  Widget build(BuildContext context) {
    if (boxes == null) {
      return Container();
    }
    return Stack(
      children: boxes.map((e) => BoxWidget(
        result: e,
        cameraSize: cameraSize,
        navigateToInfo: navigateToInfo,
      ))
          .toList(),
    );
  }
}
