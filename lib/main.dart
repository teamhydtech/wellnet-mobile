import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wellnet/routes/app_pages.dart';
import 'package:wellnet/routes/app_routes.dart';

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
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),

      initialRoute: AppRoutes.selfAssesment,
      getPages: AppPages.routes,
      //home: WelcomeScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}

