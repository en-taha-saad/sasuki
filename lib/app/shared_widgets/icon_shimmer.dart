import 'package:flutter/material.dart';
import 'package:sasuki/app/shared_widgets/shimmer_widget.dart';

class ShimmerIcon extends StatelessWidget {
  const ShimmerIcon({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ShimmerWidget(
      baseColor: null,
      highlightColor: null,
      child: Container(
        height: 70,
        width: 70,
        decoration: const BoxDecoration(
          color: Colors.grey,
          shape: BoxShape.circle,
        ),
      ),
    );
  }
}
