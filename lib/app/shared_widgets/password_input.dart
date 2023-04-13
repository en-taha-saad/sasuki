import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:sasuki/app/app_inits_funs/constants.dart';
import 'package:sasuki/app/resources/other_managers/assets_manager.dart';
import 'package:sasuki/app/resources/other_managers/color_manager.dart';
import 'package:sasuki/app/resources/values_manager/app_margin.dart';
import 'package:sasuki/app/resources/values_manager/app_size.dart';

// ignore: must_be_immutable
class PasswordTextInput extends StatefulWidget {
  const PasswordTextInput({
    super.key,
    this.stream,
    this.controller,
    this.inputLabel,
    this.inputHint,
    this.errorText,
    this.autofocus,
    this.showPassword = Constants.falseBool,
    this.isRequired = Constants.falseBool,
    this.onTap,
    this.onFieldSubmitted,
  });
  final Function()? onTap;
  final Function(String)? onFieldSubmitted;
  final Stream<bool>? stream;
  final TextEditingController? controller;
  final String? inputLabel;
  final String? inputHint;
  final String? errorText;
  final bool? autofocus;
  final bool showPassword;
  final bool? isRequired;

  @override
  State<PasswordTextInput> createState() => _PasswordTextInputState();
}

class _PasswordTextInputState extends State<PasswordTextInput> {
  bool showHidePassword = Constants.falseBool;
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<bool>(
      stream: widget.stream,
      builder: (context, snapshot) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            widget.inputLabel != Constants.nullValue
                ? widget.isRequired != Constants.nullValue &&
                        widget.isRequired != Constants.falseBool
                    ? Row(
                        children: [
                          Text(
                            "*",
                            style: Theme.of(context)
                                .textTheme
                                .labelLarge
                                ?.copyWith(
                                  color: ColorManager.orangeAnnotations2,
                                ),
                          ),
                          const SizedBox(width: AppSize.s5),
                          Text(
                            widget.inputLabel!,
                            style: Theme.of(context).textTheme.labelLarge,
                          ),
                        ],
                      )
                    : Text(
                        widget.inputLabel!,
                        style: Theme.of(context).textTheme.labelLarge,
                      )
                : Container(),
            widget.inputLabel != Constants.nullValue
                ? const SizedBox(height: AppSize.s10)
                : Container(),
            Stack(
              children: [
                TextFormField(
                  controller: widget.controller,
                  onTap: widget.onTap,
                  onFieldSubmitted: widget.onFieldSubmitted,
                  decoration: InputDecoration(
                    hintText: widget.inputHint,
                    errorText: (snapshot.data ?? Constants.trueBool)
                        ? Constants.nullValue
                        : widget.errorText,
                  ),
                  obscureText: widget.showPassword
                      ? showHidePassword
                      : Constants.falseBool,
                  autofocus: widget.autofocus!,
                ),
                widget.showPassword
                    ? Container(
                        margin: const EdgeInsets.only(
                          top: AppMargin.m12,
                          right: AppMargin.m12,
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(),
                            InkWell(
                              child: SvgPicture.asset(
                                showHidePassword
                                    ? IconsAssets.eyeslash
                                    : IconsAssets.eye,
                                theme: const SvgTheme(
                                  currentColor: ColorManager.whiteNeutral,
                                ),
                                // ignore: deprecated_member_use
                                color: ColorManager.whiteNeutral,
                              ),
                              onTap: () {
                                setState(() {
                                  showHidePassword = !showHidePassword;
                                });
                              },
                            ),
                          ],
                        ),
                      )
                    : Container(),
              ],
            ),
          ],
        );
      },
    );
  }
}
