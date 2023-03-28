import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:sasuki/app/app_inits_funs/constants.dart';
import 'package:sasuki/app/resources/other_managers/assets_manager.dart';
import 'package:sasuki/app/resources/other_managers/color_manager.dart';
import 'package:sasuki/app/resources/other_managers/opacity_manager.dart';
import 'package:sasuki/app/resources/other_managers/strings_manager.dart';
import 'package:sasuki/app/resources/other_managers/styles_manager.dart';
import 'package:sasuki/app/resources/routes_manager/nav_funcs.dart';
import 'package:sasuki/app/resources/values_manager/app_padding.dart';
import 'package:sasuki/app/resources/values_manager/app_radius.dart';
import 'package:sasuki/app/resources/values_manager/app_size.dart';
import 'package:sasuki/domain/models/choosing_server/server.dart';
import 'package:sasuki/presentation/choose_server/viewmodel/choose_server_viewmodel.dart';

// ignore: must_be_immutable
class DropDownComponent<T> extends StatefulWidget {
  final List<T> items;
  final String Function(dynamic) displayFn;
  final String? hintStr;
  final void Function(dynamic) doOtherThings;
  final bool isThisServersDropdown;
  final ChooseServerViewModel? viewModel;
  const DropDownComponent({
    Key? key,
    required this.items,
    required this.displayFn,
    required this.doOtherThings,
    required this.isThisServersDropdown,
    this.hintStr,
    this.viewModel,
  }) : super(key: key);

  @override
  State<DropDownComponent> createState() => _DropDownComponentState<T>();
}

class _DropDownComponentState<T> extends State<DropDownComponent> {
  T? _selectedItem;

  deleteServerDialog(Server? value, BuildContext context) {
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          shape: RoundedRectangleBorder(borderRadius: RadiusSizes.radius10),
          elevation: AppSize.s1_5,
          backgroundColor: Colors.transparent,
          child: Container(
            decoration: BoxDecoration(
              color: ColorManager.whiteNeutral,
              shape: BoxShape.rectangle,
              borderRadius: RadiusSizes.radius10,
              boxShadow: const [BoxShadow(color: Colors.black26)],
            ),
            child: _getDialogContent(value, context),
          ),
        );
      },
    );
  }

  Widget _getDialogContent(Server? value, BuildContext context0) {
    return Padding(
      padding: const EdgeInsets.all(AppPadding.p16),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            AppStrings.dialogTitle,
            textAlign: TextAlign.center,
            style: StylesManager.getMediumStyle(
              color: ColorManager.backgroundCenter,
              fontSize: AppSize.s16,
            ),
          ),
          const SizedBox(height: AppSize.s16),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              TextButton(
                style: TextButton.styleFrom(
                  foregroundColor: ColorManager.backgroundCenter,
                ),
                onPressed: () => Nav.popRoute(context),
                child: const Text(AppStrings.cancelButton),
              ),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: ColorManager.backgroundCenter,
                  foregroundColor: ColorManager.whiteNeutral,
                  textStyle: Theme.of(context).textTheme.titleMedium,
                ),
                onPressed: () => _deleteServer(value),
                child: const Text(AppStrings.deleteButton),
              ),
            ],
          ),
        ],
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
      items: widget.items
          .map<DropdownMenuItem<T>>(
            (item) => DropdownMenuItem<T>(
              value: item as T?,
              // alignment: Alignment.center,
              child: widget.isThisServersDropdown
                  ? Center(
                      child: Column(
                        children: [
                          Card(
                            color: ColorManager.transparent,
                            elevation: AppSize.s0,
                            margin: const EdgeInsets.symmetric(
                              horizontal: AppSize.s8,
                              vertical: AppSize.s4,
                            ),
                            clipBehavior: Clip.hardEdge,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  widget.displayFn(item),
                                  style: Theme.of(context).textTheme.bodyLarge,
                                ),
                                Opacity(
                                  opacity: AppOpacity.op30,
                                  child: IconButton(
                                    icon: const Icon(
                                      MdiIcons.delete,
                                      color: ColorManager.whiteNeutral,
                                    ),
                                    onPressed: () {
                                      deleteServerDialog(
                                          item as Server, context);
                                    },
                                  ),
                                ),
                              ],
                            ),
                          ),
                          if (widget.items.last != item)
                            Divider(
                              color: ColorManager.greyNeutral.withOpacity(
                                AppSize.s0point25,
                              ),
                              height: AppSize.s1,
                            ),
                        ],
                      ),
                    )
                  : Text(widget.displayFn(item)),
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
      hint: Text(widget.isThisServersDropdown
          ? AppStrings.dropDownHint
          : widget.hintStr ?? AppStrings.emptyString),
      alignment: Alignment.centerLeft,
      dropdownColor: ColorManager.backgroundCenter,
      style: Theme.of(context).textTheme.bodyLarge,
      elevation: Constants.zeroNum.toInt(),
      selectedItemBuilder: (context) {
        return widget.items
            .map(
              (e) => SizedBox(
                width: AppSize.s250,
                child: Text(
                  widget.displayFn(e),
                  style: Theme.of(context).textTheme.titleLarge,
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
