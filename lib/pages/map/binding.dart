import 'package:get/get.dart';

import 'controller.dart';

class MapPageBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<MapPageController>(() => MapPageController());
  }
}