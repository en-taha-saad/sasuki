import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:sasuki/app/app_inits_funs/constants.dart';
import 'package:sasuki/app/resources/other_managers/assets_manager.dart';
import 'package:sasuki/app/resources/other_managers/color_manager.dart';
import 'package:sasuki/app/resources/other_managers/strings_manager.dart';
import 'package:sasuki/app/resources/values_manager/app_radius.dart';
import 'package:sasuki/app/resources/values_manager/app_size.dart';
import 'package:sasuki/app/shared_funs/screen_width.dart';

// ignore: must_be_immutable
class DropDownComponent<T> extends StatefulWidget {
  final List<T> items;
  final String Function(dynamic) displayFn;
  final void Function() doOtherThings;
  final T? selectedItem;

  const DropDownComponent({
    Key? key,
    required this.selectedItem,
    required this.items,
    required this.displayFn,
    required this.doOtherThings,
  }) : super(key: key);

  @override
  State<DropDownComponent> createState() => _DropDownComponentState<T>();
}

class _DropDownComponentState<T> extends State<DropDownComponent> {
  // final ScrollController _scrollController = ScrollController();
  T? _selectedItem;

  @override
  void initState() {
    _selectedItem = widget.selectedItem;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField<T>(
      value: _selectedItem,
      onChanged: (val) {
        setState(() {
          _selectedItem = val;
        });
        widget.doOtherThings;
      },
      items: widget.items
          .map<DropdownMenuItem<T>>(
            (item) => DropdownMenuItem<T>(
              value: item,
              alignment: Alignment.center,
              child: Text(widget.displayFn(item)),
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
