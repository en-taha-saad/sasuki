import 'package:flutter/material.dart';
import 'package:sasuki/app/app_inits_funs/constants.dart';
import 'package:sasuki/app/resources/values_manager/app_margin.dart';

Widget getActionTextFieldInput(
  context,
  controller,
  Function(String)? onFieldSubmitted,
  String textFieldLabel, [
  bool? autoFocus,
  TextInputType? keyboardType,
]) {
  return Column(
    mainAxisAlignment: MainAxisAlignment.start,
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Container(
        margin: const EdgeInsets.only(bottom: AppMargin.m10),
        child: Text(
          textFieldLabel,
          style: Theme.of(context).textTheme.labelLarge,
        ),
      ),
      TextFormField(
        controller: controller,
        keyboardType: keyboardType ?? TextInputType.text,
        autofocus: autoFocus ?? Constants.falseBool,
        onEditingComplete: () => FocusScope.of(context).unfocus(),
        onFieldSubmitted: onFieldSubmitted,
        style: Theme.of(context).textTheme.bodyLarge,
      ),
    ],
  );
}
