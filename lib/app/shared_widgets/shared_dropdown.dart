import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:sasuki/app/app_inits_funs/constants.dart';
import 'package:sasuki/app/resources/other_managers/assets_manager.dart';
import 'package:sasuki/app/resources/other_managers/color_manager.dart';
import 'package:sasuki/app/resources/other_managers/strings_manager.dart';
import 'package:sasuki/app/resources/routes_manager/nav_funcs.dart';
import 'package:sasuki/app/resources/values_manager/app_radius.dart';
import 'package:sasuki/app/resources/values_manager/app_size.dart';
import 'package:sasuki/app/shared_widgets/get_action_dialog_content.dart';
import 'package:sasuki/app/shared_widgets/showdialog.dart';
import 'package:sasuki/domain/models/choosing_server/server.dart';
import 'package:sasuki/presentation/choose_server/viewmodel/choose_server_viewmodel.dart';

// ignore: must_be_immutable
class DropDownComponent<T> extends StatefulWidget {
  final List<T> items;
  final String Function(dynamic) displayFn;
  final String? hintStr;
  final void Function(dynamic) doOtherThings;
  final bool isThisServersDropdown;
  final bool? isThisActionDropdown;
  final Color? textAndHintColor;
  final ChooseServerViewModel? viewModel;
  final Color? dropdownColor;
  final InputBorder? border;
  const DropDownComponent({
    Key? key,
    required this.items,
    required this.displayFn,
    required this.doOtherThings,
    required this.isThisServersDropdown,
    this.dropdownColor,
    this.border,
    this.hintStr,
    this.viewModel,
    this.isThisActionDropdown,
    this.textAndHintColor,
  }) : super(key: key);

  @override
  State<DropDownComponent> createState() => _DropDownComponentState<T>();
}

class _DropDownComponentState<T> extends State<DropDownComponent> {
  T? _selectedItem;

  deleteServerDialog(Server? value, BuildContext context) {
    return showActionDialog(
      context,
      getActionDialogContent(
        context,
        Text(
          "${AppStrings.dialogTitle} ${value?.name}?",
          style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                color: ColorManager.blackNeutral,
              ),
        ),
        AppStrings.userActionDelete,
        AppStrings.userActionDeleteDialogTitle,
        IconsAssets.trashUserAction,
        () => _deleteServer(value),
      ),
    );
  }

  void _deleteServer(Server? value) {
    if (widget.items.length == Constants.oneNum) {
      widget.viewModel?.inputIsNotSelectedServer.add(Constants.trueBool);
      widget.viewModel?.inputIsSelectedServer.add(Constants.falseBool);
    }
    widget.items.removeWhere(
      (element) => element == value,
    );
    _selectedItem =
        (widget.items.isNotEmpty) ? widget.items.first : Constants.nullValue;
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Nav.popRoute(context);
      setState(() {});
      if ((widget.items.length) >= Constants.zeroNum) {
        Nav.popRoute(context);
      }
    });
    widget.viewModel?.removeFromStorageServer((value?.name)!);
  }

  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField<T>(
      value: _selectedItem,
      onChanged: (val) {
        setState(() {
          _selectedItem = val;
        });
        widget.doOtherThings(val);
      },
      onTap: () {},
      items: widget.items
          .map<DropdownMenuItem<T>>(
            (item) => DropdownMenuItem<T>(
              value: item as T?,
              child: widget.isThisServersDropdown
                  ? Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          padding: const EdgeInsets.all(AppSize.s15),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              SizedBox(
                                width: MediaQuery.of(context).size.width * 0.7,
                                child: Text(
                                  widget.displayFn(item),
                                  softWrap: true,
                                  maxLines: 3,
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyLarge
                                      ?.copyWith(
                                        color: ColorManager.blackNeutral,
                                      ),
                                ),
                              ),
                              InkWell(
                                onTap: () => deleteServerDialog(
                                  item as Server,
                                  context,
                                ),
                                child: SvgPicture.asset(
                                  IconsAssets.trashUserAction,
                                  // ignore: deprecated_member_use
                                  color: ColorManager.blackNeutral,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Container(
                          margin: const EdgeInsets.only(
                            left: AppSize.s15,
                            right: AppSize.s15,
                          ),
                          decoration: BoxDecoration(
                            border: Border(
                              bottom: widget.items.last != item
                                  ? BorderSide(
                                      color:
                                          ColorManager.greyNeutral.withOpacity(
                                        AppSize.s0point25,
                                      ),
                                    )
                                  : BorderSide.none,
                            ),
                          ),
                        ),
                      ],
                    )
                  : Text(
                      widget.displayFn(item),
                      style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                            color: ColorManager.blackNeutral,
                          ),
                    ),
            ),
          )
          .toList(),
      borderRadius: RadiusSizes.radius12,
      icon: SvgPicture.asset(
        IconsAssets.dropdown,
        height: AppSize.s8,
        width: AppSize.s8,
      ),
      validator: (value) {
        if (value == Constants.nullValue) {
          return AppStrings.selectedDropdownError;
        }
        return Constants.nullValue;
      },
      alignment: Alignment.centerLeft,
      decoration: InputDecoration(
        fillColor: widget.dropdownColor,
        // border: widget.border,
        enabledBorder: widget.border,
        focusedBorder: widget.border,
        hintText: widget.isThisServersDropdown
            ? AppStrings.dropDownHint
            : widget.hintStr!,
        hintStyle: Theme.of(context).textTheme.bodyLarge?.copyWith(
              color: widget.textAndHintColor == ColorManager.whiteNeutral
                  ? ColorManager.greyNeutral3
                  : widget.textAndHintColor,
            ),
      ),
      dropdownColor: const Color(0xffDCDFE3),
      style: Theme.of(context).textTheme.bodyLarge?.copyWith(
            color: widget.textAndHintColor,
          ),
      elevation: Constants.zeroNum.toInt(),
      selectedItemBuilder: (context) {
        return widget.items
            .map(
              (e) => SizedBox(
                width: AppSize.s150,
                child: Text(
                  widget.displayFn(e),
                  style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                        color: widget.textAndHintColor,
                      ),
                  overflow: TextOverflow.fade,
                  textAlign: TextAlign.left,
                ),
              ),
            )
            .toList();
      },
    );
  }
}
