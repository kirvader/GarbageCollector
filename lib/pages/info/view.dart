import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'controller.dart';

class InfoPageView extends GetView<InfoPageController> {
  const InfoPageView({super.key});

  @override
  Widget build(BuildContext context) {
    var arguments = Get.arguments as Map<String, String>;

    return Scaffold(
      body: SafeArea(
          child: FutureBuilder(
        future: () async {
          var objectsDescriptions =
              await loadJSON("assets/objects.json", context);
          var categoriesDescriptions =
              await loadJSON("assets/categories.json", context);

          String header;
          String categoryName;
          List<String> tags;
          if (arguments.containsKey('categoryName')) {
            categoryName = arguments['categoryName']!;
            header = categoryName;
            var listsOfTags = <List<String>>[];
            objectsDescriptions.forEach((String key, dynamic value) {
              List<String> valueTags = List<String>.from(value['tags']);
              if (value['category'] == categoryName) {
                listsOfTags.add(valueTags);
              }
            });
            var commonElements = listsOfTags.fold<Set<String>>(
                listsOfTags.first.toSet(), (a, b) => a.intersection(b.toSet()));
            tags = commonElements.toList();
          } else {
            var objectName = arguments['objectName']!;
            header = objectName;
            var objectData = objectsDescriptions[objectName];
            categoryName = objectData['category'];
            tags = objectData['tags'];
          }
          var categoryDescription = categoriesDescriptions[categoryName];

          return {
            'header': header,
            'categoryDescription': categoryDescription,
            'tags': tags
          };
        }(),
        builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
          if (!snapshot.hasData || snapshot.hasError) {
            print(snapshot.error);
            return Container();
          }
          var header = snapshot.data['header'];
          var categoryDescription = snapshot.data['categoryDescription'];
          var tags = snapshot.data['tags'];
          print("Tags: $tags");
          return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 40),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(header),
                  Text(categoryDescription),
                ],
              ));
        },
      )),
    );
  }

  dynamic loadJSON(String jsonPath, BuildContext context) async {
    String data = await DefaultAssetBundle.of(context).loadString(jsonPath);
    final jsonResult = jsonDecode(data);
    return jsonResult;
  }
}
