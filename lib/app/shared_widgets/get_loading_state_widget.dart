import 'package:flutter/material.dart';

import 'package:sasuki/app/resources/other_managers/color_manager.dart';


Center getLoadingStateWidget() {
  return const Center(
    child: CircularProgressIndicator(
      valueColor: AlwaysStoppedAnimation<Color>(
        ColorManager.whiteNeutral,
      ),
    ),
  );
}
