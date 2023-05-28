import 'package:flutter/material.dart';
import 'package:sasuki/app/app_inits_funs/constants.dart';
import 'package:sasuki/app/resources/other_managers/color_manager.dart';
import 'package:sasuki/app/resources/other_managers/strings_manager.dart';
import 'package:sasuki/app/resources/values_manager/app_margin.dart';
import 'package:sasuki/app/resources/values_manager/app_size.dart';

Widget getAddEditTextFieldInput(
  context,
  controller,
  Function(String)? onFieldSubmitted,
  String textFieldLabel, [
  bool? autoFocus,
  TextInputType? keyboardType,
  bool? isRequiredValidation,
  bool isRequired = Constants.falseBool,
  bool isEnabled = Constants.trueBool,
  Color? fillColor,
  Color? textColor,
]) {
  return Column(
    mainAxisAlignment: MainAxisAlignment.start,
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Container(
        margin: const EdgeInsets.only(bottom: AppMargin.m10),
        child: isRequired
            ? Row(
                children: [
                  Text(
                    "*",
                    style: Theme.of(context).textTheme.titleLarge?.copyWith(
                          color: ColorManager.orangeAnnotations2,
                        ),
                  ),
                  const SizedBox(width: AppSize.s5),
                  Text(
                    textFieldLabel,
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                ],
              )
            : Text(
                textFieldLabel,
                style: Theme.of(context).textTheme.titleLarge,
              ),
      ),
      TextFormField(
        controller: controller,
        enabled: isEnabled,
        keyboardType: keyboardType ?? TextInputType.text,
        autofocus: autoFocus ?? Constants.falseBool,
        decoration: InputDecoration(
          errorText: isRequiredValidation != Constants.nullValue &&
                  isRequiredValidation != Constants.trueBool
              ? AppStrings.inputIsEmpty
              : Constants.nullValue,
          fillColor: fillColor,
        ),
        onEditingComplete: () => FocusScope.of(context).unfocus(),
        onFieldSubmitted: onFieldSubmitted,
        style: Theme.of(context).textTheme.bodyLarge?.copyWith(
              color: textColor ?? ColorManager.whiteNeutral,
            ),
      ),
    ],
  );
}
