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
  const DropDownComponent({
    required this.items,
    required this.itemText,
    this.onItemSelected,
    this.selectedItem,
    Key? key,
  }) : super(key: key);
  final List<T> items;
  final T Function(T) itemText;
  final Function(T?)? onItemSelected;
  final T? selectedItem;

  @override
  State<DropDownComponent> createState() => _DropDownComponentState<T>();
}

class _DropDownComponentState<T> extends State<DropDownComponent> {
  final ScrollController _scrollController = ScrollController();
  T? _selectedItem;

  @override
  void initState() {
    super.initState();
    _selectedItem = widget.selectedItem;
  }

  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField<T>(
      value: _selectedItem,
      onChanged: (value) {
        setState(() {
          _selectedItem = value;
        });
        if (widget.onItemSelected != null) {
          widget.onItemSelected!(value);
        }
      },
      items: widget.items
          .map<DropdownMenuItem<T>>(
            (item) => DropdownMenuItem<T>(
              value: item,
              child: Text(widget.itemText(item)),
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
      hint: const Text(
        AppStrings.dropDownHint,
      ),

      ///
      onTap: () {
        Navigator.pop(context);
        showDialog(
          context: context,
          barrierColor: Colors.transparent,
          builder: (context) {
            return Dialog(
              insetPadding: const EdgeInsets.symmetric(
                horizontal: AppSize.s25,
              ),
              child: Container(
                height: AppSize.s250,
                width: getScreenWidth(context),
                decoration: BoxDecoration(
                  color: ColorManager.secondary,
                  borderRadius: RadiusSizes.radius12,
                  border: Border.all(
                    color: ColorManager.whiteNeutral,
                    width: AppSize.s1,
                  ),
                ),
                child: Material(
                  type: MaterialType.transparency,
                  child: Scrollbar(
                    thumbVisibility: Constants.trueBool,
                    trackVisibility: Constants.trueBool,
                    radius: const Radius.circular(AppSize.s25),
                    thickness: AppSize.s5,
                    interactive: Constants.trueBool,
                    controller: _scrollController,
                    child: ListView.builder(
                      controller: _scrollController,
                      itemCount: widget.items.length,
                      itemBuilder: (context, index) => InkWell(
                        onTap: () {
                          Navigator.pop(context);
                          setState(() {});
                        },
                        child: DropdownMenuItem<String>(
                          value: 'Item $index',
                          child: Text(
                            'Item $index',
                            style: Theme.of(context).textTheme.bodyLarge,
                          ),
                        ),
                      ),
                      shrinkWrap: true,
                    ),
                  ),
                ),
              ),
            );
          },
        );
      },

      ///
      selectedItemBuilder: (context) {
        return widget.items
            .map(
              (e) => SizedBox(
                width: AppSize.s250,
                child: Text(
                  "$e",
                  // style: Theme.of(context).textTheme.titleLarge,
                  // overflow: TextOverflow.fade,
                  // textAlign: TextAlign.left,
                ),
              ),
            )
            .toList();
      },
    );
  }
}
