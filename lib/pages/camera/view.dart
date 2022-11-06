import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:garbage_collector/features/canvas/bounding_boxes.dart';
import 'package:garbage_collector/features/canvas/camera_preview_widget.dart';
import 'package:get/get.dart';

import 'controller.dart';


class CameraPageView extends GetView<CameraPageController> {
  const CameraPageView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Chose item to scan')),
      body: FutureBuilder(
          future: availableCameras(),
          builder: (BuildContext context,
              AsyncSnapshot<List<CameraDescription>> snapshot) {
            if (!snapshot.hasData || snapshot.hasError) {
              return const Text("Loading maybe");
            }
            return Obx(() {

              Size sz = MediaQuery.of(context).size;
              return Stack(
                  children: [
                    CameraView(resultsCallback: controller.updateInfo, sizeChangedCallback: controller.updateSize),
                    BoundingBoxesView(boxes: controller.recognitions.value, cameraSize: sz),
                  ]
              );
            });
          }
      ),
    );
  }
}