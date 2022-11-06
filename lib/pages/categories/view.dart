import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:garbage_collector/navigation/routes.dart';
import 'package:garbage_collector/pages/info/view.dart';
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
      'fat',
      'fabric/shoes',
      'glass',
      'carton',
      'paper',
      'metal',
      'polystyrene',
      'electronic',
      'ee-waste',
      'bulky waste',
      'organic waste',
      'residual waste',
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
      Colors.lime,
      Colors.pink,
      Colors.purple,
      Colors.teal,
      Colors.amber,
      Colors.grey,
    ];

    return MaterialApp(
      title: title,
      home: Scaffold(
        appBar: AppBar(title: const Text('Categories'),
            leading: BackButton(
            color: Colors.white
        )),

        body: GridView.count(
          crossAxisCount: 3,
          children: List.generate(categories.length, (categoryIndex) {
            final String categoryName = categories[categoryIndex].toUpperCase();
            final String iconName = categoryName
                .toLowerCase()
                .replaceAll(RegExp("[- /]"), "_");

            return GestureDetector(
              onTap: () {
                onTap(categoryName.toLowerCase(), context );
              },
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

  Future<void> onTap(String categoryName, BuildContext context) async {
    var header = categoryName;

    var listsOfTags = <List<String>>[];
    var objectsDescriptions =
        await loadJSON("assets/objects.json", context);
    objectsDescriptions.forEach((String key, dynamic value) {
      List<String> valueTags = List<String>.from(value['tags']);
      if (value['category'] == categoryName) {
        listsOfTags.add(valueTags);
      }
    });
    print("Lists of tags: $listsOfTags");
    late List<String> tags;
    if (listsOfTags.isEmpty) {
      tags = [];
    }
    else {
      var commonElements = listsOfTags.fold<Set<String>>(
          listsOfTags.isNotEmpty ? listsOfTags.first.toSet() : Set(), (a, b) => a.union(b.toSet()));
      tags = commonElements.toList();
    }

    print({
      "categoryName": categoryName,
      "header": header,
      "tags": tags
    });

    Get.to(() => const InfoPageView(), arguments: {
      "categoryName": categoryName,
      "header": header,
      "tags": tags
    });
  }


  dynamic loadJSON(String jsonPath, BuildContext context) async {
    String data = await DefaultAssetBundle.of(context).loadString(jsonPath);
    final jsonResult = jsonDecode(data);
    return jsonResult;
  }
}
