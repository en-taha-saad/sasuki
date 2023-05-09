import 'package:flutter/material.dart';
import 'package:sasuki/app/app_inits_funs/constants.dart';
import 'package:sasuki/app/resources/other_managers/color_manager.dart';
import 'package:sasuki/app/resources/other_managers/strings_manager.dart';
import 'package:sasuki/app/resources/values_manager/app_margin.dart';
import 'package:sasuki/app/resources/values_manager/app_radius.dart';

Widget getActionTextFieldInput(
  String? hintText,
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
                color: ColorManager.blackNeutral,
              ),
        ),
      ),
      TextFormField(
        controller: controller,
        keyboardType: keyboardType ?? TextInputType.text,
        autofocus: autoFocus ?? Constants.falseBool,
        decoration: InputDecoration(
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: ColorManager.greyNeutral.withOpacity(0.25),
            ),
            borderRadius: RadiusSizes.radius12,
          ),
          fillColor: ColorManager.greyNeutral.withOpacity(0.25),
          errorText: isRequiredValidation != Constants.nullValue &&
                  isRequiredValidation != Constants.trueBool
              ? AppStrings.inputIsEmpty
              : Constants.nullValue,
          hintText: hintText,
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
