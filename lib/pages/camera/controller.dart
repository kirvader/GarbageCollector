import 'dart:ui';

import 'package:garbage_collector/features/utils/recognition_result.dart';
import 'package:garbage_collector/pages/camera/state.dart';
import 'package:get/get.dart';


class CameraPageController extends GetxController with StateMixin<CameraPageState> {
  var recognitions = <Recognition>[].obs;
  var cameraSize = Size(0.0, 0.0).obs;

  void updateSize(Size newSize) {
    cameraSize.value = newSize;
    cameraSize.refresh();
  }

  void updateInfo(List<Recognition> recognitions) {
    print(recognitions);

    Map<int, Recognition> mapping = {};
    for (var recognition in recognitions) {
      var clsId = recognition.id;
      if (!mapping.containsKey(clsId)) {
        mapping[clsId] = recognition;
      }
      if (mapping[clsId]!.score > recognition.score) {
        continue;
      }
      mapping[clsId] = recognition;
    }
    this.recognitions.value = mapping.values.toList();
    this.recognitions.refresh();
  }
}