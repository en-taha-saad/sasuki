import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:sasuki/app/app_inits_funs/constants.dart';
import 'package:sasuki/app/resources/other_managers/assets_manager.dart';
import 'package:sasuki/app/resources/other_managers/color_manager.dart';
import 'package:sasuki/app/resources/other_managers/opacity_manager.dart';
import 'package:sasuki/app/resources/other_managers/strings_manager.dart';
import 'package:sasuki/app/resources/routes_manager/nav_funcs.dart';
import 'package:sasuki/app/resources/values_manager/app_padding.dart';
import 'package:sasuki/app/resources/values_manager/app_radius.dart';
import 'package:sasuki/app/resources/values_manager/app_size.dart';
import 'package:sasuki/domain/models/choosing_server/server.dart';

// ignore: must_be_immutable
class DropDownComponent<T> extends StatefulWidget {
  final List<T> items;
  final String Function(dynamic) displayFn;
  final void Function(dynamic) doOtherThings;
  final bool isThisServersDropdown;

  const DropDownComponent({
    Key? key,
    required this.items,
    required this.displayFn,
    required this.doOtherThings,
    required this.isThisServersDropdown,
  }) : super(key: key);

  @override
  State<DropDownComponent> createState() => _DropDownComponentState<T>();
}

class _DropDownComponentState<T> extends State<DropDownComponent> {
  // final ScrollController _scrollController = ScrollController();
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
          const Text(
            AppStrings.dialogTitle,
            textAlign: TextAlign.center,
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
                onPressed: () {
                  // if (serversList?.servers?.length == Constants.oneNum) {
                  //   _viewModel.inputIsNotSelectedServer.add(Constants.trueVal);
                  //   _viewModel.inputIsSelectedServer.add(Constants.falseVal);
                  // }
                  // serversList?.servers?.removeWhere(
                  //   (element) => element == value,
                  // );
                  // selectedServer = (serversList?.servers?.isNotEmpty)!
                  //     ? serversList?.servers?.first
                  //     : Constants.nullValue;
                  // WidgetsBinding.instance.addPostFrameCallback((_) {
                  //   Nav.popRoute(context);
                  //   setState(() {});
                  //   if ((serversList?.servers?.length)! >= Constants.zero) {
                  //     Nav.popRoute(context);
                  //   }
                  // });
                  // _viewModel.removeFromStorageServer((value?.name)!);
                },
                child: const Text(AppStrings.deleteButton),
              ),
            ],
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField<T>(
      value: _selectedItem,
      borderRadius: RadiusSizes.radius12,
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
                              color: ColorManager.whiteNeutral.withOpacity(
                                AppOpacity.op10,
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
      hint: const Text(AppStrings.dropDownHint),

      ///
      /*
      // onTap: () {
      //   Navigator.pop(context);
      //   showDialog(
      //     context: context,
      //     barrierColor: Colors.transparent,
      //     builder: (context) {
      //       return Dialog(
      //         insetPadding: const EdgeInsets.symmetric(
      //           horizontal: AppSize.s25,
      //         ),
      //         child: Container(
      //           height: AppSize.s250,
      //           width: getScreenWidth(context),
      //           decoration: BoxDecoration(
      //             color: ColorManager.secondary,
      //             borderRadius: RadiusSizes.radius12,
      //             border: Border.all(
      //               color: ColorManager.whiteNeutral,
      //               width: AppSize.s1,
      //             ),
      //           ),
      //           child: Material(
      //             type: MaterialType.transparency,
      //             child: Scrollbar(
      //               thumbVisibility: Constants.trueBool,
      //               trackVisibility: Constants.trueBool,
      //               radius: const Radius.circular(AppSize.s25),
      //               thickness: AppSize.s5,
      //               interactive: Constants.trueBool,
      //               controller: _scrollController,
      //               child: ListView.builder(
      //                 controller: _scrollController,
      //                 itemCount: widget.items.length,
      //                 itemBuilder: (context, index) => InkWell(
      //                   onTap: () {
      //                     _selectedItem = widget.items
      //                         .where((element) =>
      //                             widget.items.indexOf(element) ==
      //                             widget.items.indexOf(widget.items[index]))
      //                         .first;
      //                     widget.onChanged(widget.items[index]);
      //                     Navigator.pop(context);
      //                     debugPrint("_selectedItem: $_selectedItem");
      //                   },
      //                   child: Text(
      //                     '${widget.items[index]}',
      //                     style: Theme.of(context).textTheme.bodyLarge,
      //                   ),
      //                 ),
      //                 shrinkWrap: Constants.trueBool,
      //               ),
      //             ),
      //           ),
      //         ),
      //       );
      //     },
      //   );
      // },
      */
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
