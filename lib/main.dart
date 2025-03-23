import 'package:finans_takipp/core/app_bindings.dart';
import 'package:finans_takipp/modules/home/home_page.dart';
import 'package:finans_takipp/routes/app_pages_.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';


void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Flutter Demo',

      getPages: AppPages.pages,
      initialRoute: AppRoutes.INITAL,
      initialBinding: AppBindings(),
      theme: ThemeData(

        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      
    );
  }
}
