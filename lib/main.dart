import 'package:My_Note/core/color.dart';
import 'package:My_Note/view/screen/outer_screen/splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() {
  runApp(
      MaterialApp(
    debugShowCheckedModeBanner: false,
     theme: ThemeData(
        appBarTheme: const AppBarTheme(
            elevation: 0.0,
            color: AppColors.c1,
            systemOverlayStyle: SystemUiOverlayStyle(
              statusBarIconBrightness: Brightness.dark,
              statusBarBrightness: Brightness.light,
              statusBarColor: Color(0xffe5873f),
            ))),
     title: "MyNote",
    home: const SplashScreen(),
  ));
}
