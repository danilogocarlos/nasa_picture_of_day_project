import 'package:flutter/material.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:nasa_picture_of_day_project/modules/search_pictures/presenter/search_picturtes_page.dart';
import 'package:nasa_picture_of_day_project/modules/search_pictures/presenter/serch_pictures_binding.dart';
import 'package:get_storage/get_storage.dart';

void main() async {
  await GetStorage.init();

  runApp(
    GetMaterialApp(
      initialBinding: SearchPicturesBinding(),
      home: SearchPicturesPage(),
    ),
  );
}
