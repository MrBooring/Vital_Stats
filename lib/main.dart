import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sqllitecrud/logic/bindings/initial_binding.dart';
import 'package:sqllitecrud/view/routes/routes.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      getPages: routes,
      initialRoute: "/",
      initialBinding: InitialBinding(),
      theme: ThemeData(
        fontFamily: "Ubuntu",
        primaryColor: Color(0xFF4F54BE),
      ),
    );
  }
}
