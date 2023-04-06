import 'package:flutter/material.dart';
import 'package:sasuki/app/app_inits_funs/constants.dart';
import 'package:sasuki/app/resources/other_managers/strings_manager.dart';
import 'package:sasuki/app/resources/values_manager/app_margin.dart';

Widget getAddEditTextFieldInput(
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
          style: Theme.of(context).textTheme.titleLarge,
        ),
      ),
      TextFormField(
        controller: controller,
        keyboardType: keyboardType ?? TextInputType.text,
        autofocus: autoFocus ?? Constants.falseBool,
        decoration: InputDecoration(
          errorText: isRequiredValidation != Constants.nullValue &&
                  isRequiredValidation != Constants.trueBool
              ? AppStrings.inputIsEmpty
              : Constants.nullValue,
        ),
        onEditingComplete: () => FocusScope.of(context).unfocus(),
        onFieldSubmitted: onFieldSubmitted,
        style: Theme.of(context).textTheme.bodyLarge,
      ),
    ],
  );
}
