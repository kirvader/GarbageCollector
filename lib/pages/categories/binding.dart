import 'package:get/get.dart';

import 'controller.dart';

class CategoriesPageBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<CategoriesPageController>(() => CategoriesPageController());
  }
}