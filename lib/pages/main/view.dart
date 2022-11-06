import 'package:flutter/material.dart';
import 'package:garbage_collector/features/buttons/image_load_method_choice_button.dart';
import 'package:garbage_collector/navigation/routes.dart';
import 'package:get/get.dart';

import 'controller.dart';

class MainPageView extends GetView<MainPageController> {
  const MainPageView({super.key});

  void onCategoriesButtonPressed() {
    Get.toNamed(Paths.categories);
  }

  void onTakePhotoButtonPressed() {
    Get.toNamed(Paths.camera);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 40),
                  child: ImageLoadMethodChoiceButton(
                    onPressed: onCategoriesButtonPressed,
                      child: const Text("Browse categories manually",
                        style: TextStyle(
                          fontSize: 30,
                          fontWeight: FontWeight.bold
                        ),
                      )
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 40),
                  child: ImageLoadMethodChoiceButton(
                      onPressed: onTakePhotoButtonPressed,
                      child: const Text("Take photo",
                        style: TextStyle(
                            fontSize: 30,
                            fontWeight: FontWeight.bold
                        ),
                      )
                  ),
                )
              ],
          )
      ),
    );
  }
}
