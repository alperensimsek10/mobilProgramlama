import 'package:finans_takipp/core/app_bindings.dart';
import 'package:finans_takipp/routes/app_pages_.dart';
import 'package:finans_takipp/themes/app_theme.dart';
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
      debugShowCheckedModeBanner: false,
      initialRoute: AppRoutes.INITAL,
      darkTheme: AppTheme.darkTheme,
      theme: AppTheme.lightTheme,
      initialBinding: AppBindings(),

      
    );
  }
}
