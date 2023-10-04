import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:new_app/helper/routes/app_pages.dart';

void main() {
  runApp(
    GetMaterialApp(
      title: "Application",
      initialRoute: AppPages.INITIAL,
      getPages: AppPages.routes,
    ),
  );
}
