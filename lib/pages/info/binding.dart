import 'package:get/get.dart';

import 'controller.dart';

class InfoPageBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<InfoPageController>(() => InfoPageController());
  }
}