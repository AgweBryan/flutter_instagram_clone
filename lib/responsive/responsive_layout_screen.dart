import 'package:flutter/material.dart';
import 'package:flutter_instagram_clone/utils/dimensions.dart';

class ResponsiveLayout extends StatelessWidget {
  final Widget webScreenLayout;
  final Widget mobileScreenLayout;
  const ResponsiveLayout(
      {Key? key,
      required this.mobileScreenLayout,
      required this.webScreenLayout})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: ((context, constraints) {
      if (constraints.maxHeight > webScreenSize) {
        // Web screen
        return webScreenLayout;
      }
      // Mobile screen
      return mobileScreenLayout;
    }));
  }
}
