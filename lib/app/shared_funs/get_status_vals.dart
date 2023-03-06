import 'package:flutter/material.dart';
import 'package:sasuki/app/app_inits_funs/constants.dart';
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
      ? const Color.fromARGB(255, 126, 247, 130)
      : statusString == AppStrings.expiredUsers
          ? Colors.orange
          : Colors.white;
}
