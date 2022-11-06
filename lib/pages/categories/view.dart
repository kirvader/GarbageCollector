import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:garbage_collector/navigation/routes.dart';
import 'package:get/get.dart';

import 'controller.dart';

class CategoriesPageView extends GetView<CategoriesPageController> {
  const CategoriesPageView({super.key});

  @override
  Widget build(BuildContext context) {
    const title = 'Categories';
    const categories = [
      'hazardous waste',
      'plastic',
      'organic waste',
      'glass',
      'carton',
      'paper',
      'metal',
      'fabric/shoes',
      'residual waste',
      'electronic',
      'ee-waste',
      'bulky waste',
      'polystyrene',
      'fat'
    ];
    const colors = [
      Colors.blue,
      Colors.indigo,
      Colors.red,
      Colors.yellow,
      Colors.green,
      Colors.cyan,
      Colors.orange,
      Colors.brown,
      Colors.grey,
      Colors.pink,
      Colors.purple,
      Colors.teal,
      Colors.lime,
      Colors.amber,
    ];

    return MaterialApp(
      title: title,
      home: Scaffold(
        appBar: AppBar(
          title: const Text(title),
        ),
        body: GridView.count(
          crossAxisCount: 3,
          children: List.generate(categories.length, (categoryIndex) {
            final String categoryName = categories[categoryIndex].toUpperCase();
            final String iconName = categoryName
                .toLowerCase()
                .replaceAll(RegExp("[- /]"), "_");

            return GestureDetector(
              onTap: onTap,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Expanded(
                      child: SvgPicture.asset(
                          'assets/icons/$iconName.svg',
                          color: colors[categoryIndex],
                          semanticsLabel: categoryName,
                          fit: BoxFit.contain
                      )
                  ),
                  Align(
                      child: Text(
                        categoryName,
                        style: Theme.of(context).textTheme.headline5,
                        textAlign: TextAlign.center,
                      )
                  )
                ],
              ),
            );
          }),
        ),
      ),
    );
  }

  void onTap() {
    Get.toNamed(Paths.info);
  }
}
