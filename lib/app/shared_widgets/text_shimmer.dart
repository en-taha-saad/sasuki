import 'package:flutter/material.dart';
import 'package:sasuki/app/resources/values_manager/app_size.dart';
import 'package:sasuki/app/shared_widgets/shimmer_widget.dart';

class ShimmerText extends StatelessWidget {
  final Color? baseColor;
  final Color? highlightColor;
  final double? width;
  const ShimmerText({
    Key? key,
    required this.baseColor,
    required this.highlightColor,
    required this.width,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ShimmerWidget(
      baseColor: baseColor,
      highlightColor: highlightColor,
      child: Container(
        height: AppSize.s4,
        width: width,
        decoration: const BoxDecoration(
          color: Colors.grey,
          shape: BoxShape.rectangle,
        ),
      ),
    );
  }
}
