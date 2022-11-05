import 'package:get/get.dart';

import 'controller.dart';

class CameraBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<CameraPageController>(() => CameraPageController());
  }
}