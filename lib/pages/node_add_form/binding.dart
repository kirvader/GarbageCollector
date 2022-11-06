import 'package:get/get.dart';

import 'controller.dart';

class NodeAddFormPageBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<NodeAddFormPageController>(() => NodeAddFormPageController());
  }
}