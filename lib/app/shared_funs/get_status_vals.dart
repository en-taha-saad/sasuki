import 'package:flutter/material.dart';
import 'package:sasuki/app/app_inits_funs/constants.dart';
import 'package:sasuki/app/resources/other_managers/color_manager.dart';
import 'package:sasuki/app/resources/other_managers/strings_manager.dart';

String getStatusString(status) {
  return status == Constants.nullValue
      ? Constants.emptyStr
      : status
          ? AppStrings.activeUsers
          : AppStrings.expiredUsers;
}

Color getStatusColor(String statusString) {
  return statusString == AppStrings.activeUsers
      ? ColorManager.greenAnnotations2
      : statusString == AppStrings.expiredUsers
          ? ColorManager.orangeAnnotations2
          : Colors.white;
}
