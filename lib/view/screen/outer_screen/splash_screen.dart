import 'dart:async';

import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

import '../../../core/color.dart';
import '../PageNavigation/PageFare.dart';
import '../inner_screen/Main_page.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<StatefulWidget> createState() {
    return SplashScreenState();
  }
}

class SplashScreenState extends State<SplashScreen> {

  Timer? timer;
  void startTime() {
    timer = Timer(const Duration(seconds: 2), () {
      Navigator.of(context).pushReplacement(PageFadeAnimation(Main()));
    });
  }

  @override
  void initState() {
    super.initState();
    startTime();
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.sizeOf(context).height;
    double width = MediaQuery.sizeOf(context).width;
    return Scaffold(
      backgroundColor: AppColors.c1,
      body: Center(
          child: Lottie.asset("lottie/logo.json", height: height / 2.7, width: width / 1.2)),
    );
  }

  @override
  void dispose() {
    timer?.cancel();
    super.dispose();
  }
}
