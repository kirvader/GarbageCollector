import 'package:get/get.dart';

import 'controller.dart';

class ObjectsPageBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ObjectsPageController>(() => ObjectsPageController());
  }
}
