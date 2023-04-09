import 'package:flutter/material.dart';
import 'package:sasuki/app/app_inits_funs/constants.dart';
import 'package:sasuki/app/resources/other_managers/color_manager.dart';
import 'package:sasuki/app/resources/other_managers/strings_manager.dart';
import 'package:sasuki/app/resources/values_manager/app_margin.dart';

Widget getActionTextFieldInput(
  context,
  controller,
  Function(String)? onFieldSubmitted,
  String textFieldLabel, [
  bool? autoFocus,
  TextInputType? keyboardType,
  bool? isRequiredValidation,
]) {
  
  return Column(
    mainAxisAlignment: MainAxisAlignment.start,
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Container(
        margin: const EdgeInsets.only(bottom: AppMargin.m10),
        child: Text(
          textFieldLabel,
          style: Theme.of(context).textTheme.labelLarge?.copyWith(
                    color: ColorManager.greyNeutral5,
              ),
        ),
      ),
      TextFormField(
        controller: controller,
        keyboardType: keyboardType ?? TextInputType.text,
        autofocus: autoFocus ?? Constants.falseBool,
        decoration: InputDecoration(
          fillColor: ColorManager.greyNeutral.withOpacity(0.25),
          errorText: isRequiredValidation != Constants.nullValue &&
                  isRequiredValidation != Constants.trueBool
              ? AppStrings.inputIsEmpty
              : Constants.nullValue,
        ),
        cursorColor: ColorManager.blackNeutral,
        onEditingComplete: () => FocusScope.of(context).unfocus(),
        onFieldSubmitted: onFieldSubmitted,
        style: Theme.of(context).textTheme.bodyLarge?.copyWith(
              color: ColorManager.blackNeutral,
            ),
      ),
    ],
  );
}
