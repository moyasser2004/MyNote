import 'package:flutter/cupertino.dart';

class PageFadeAnimation extends PageRouteBuilder {
  final dynamic page;

  PageFadeAnimation(this.page) : super(pageBuilder: (buildContext, animation, animationTwo) {
          return page;
        },
      transitionsBuilder: (buildContext, animation, animationTwo, child) {
          return Align(
            alignment: Alignment.center,
            child: FadeTransition(
              opacity: animation,
              child: child,
            ),
          );
        }
    );
}
