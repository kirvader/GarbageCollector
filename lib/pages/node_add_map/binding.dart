import 'package:get/get.dart';

import 'controller.dart';

class NodeAddMapPageBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<NodeAddMapPageController>(() => NodeAddMapPageController());
  }
}