import 'package:flutter/material.dart';
import 'package:sasuki/app/resources/other_managers/color_manager.dart';
import 'package:sasuki/app/resources/other_managers/opacity_manager.dart';
import 'package:shimmer/shimmer.dart';

class ShimmerWidget extends StatelessWidget {
  final Widget? child;
  final Color? baseColor;
  final Color? highlightColor;
  const ShimmerWidget({
    Key? key,
    this.child,
    required this.baseColor,
    required this.highlightColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor:
          baseColor ?? ColorManager.greyNeutral.withOpacity(AppOpacity.op30),
      highlightColor: highlightColor ?? ColorManager.primaryshade1,
      enabled: true,
      child: child!,
    );
  }
}
