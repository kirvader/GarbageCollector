import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:garbage_collector/features/canvas/camera_preview_widget.dart';
import 'package:get/get.dart';

import 'controller.dart';


class CameraPageView extends GetView<CameraPageController> {
  const CameraPageView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder(
          future: availableCameras(),
          builder: (BuildContext context,
              AsyncSnapshot<List<CameraDescription>> snapshot) {
            if (!snapshot.hasData || snapshot.hasError) {
              return const Text("Loading maybe");
            }
            return Obx(() {
              return Column(
                  children: [
                    Text(controller.info.value),
                    CameraView(resultsCallback: controller.updateInfo)
                  ]
              );
            });
          }
      ),
    );
  }
}