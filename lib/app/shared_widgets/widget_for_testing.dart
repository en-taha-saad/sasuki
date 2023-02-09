import 'package:flutter/material.dart';
import 'package:sasuki/app/resources/other_managers/color_manager.dart';
import 'package:sasuki/app/resources/values_manager/app_radius.dart';
import 'package:sasuki/app/resources/values_manager/app_size.dart';
import 'package:sasuki/app/shared_funs/screen_width.dart';

// ignore: must_be_immutable
class TestingComponents extends StatefulWidget {
  const TestingComponents({Key? key}) : super(key: key);
  @override
  State<TestingComponents> createState() => _TestingComponentsState();
}

class _TestingComponentsState extends State<TestingComponents> {
  final ScrollController _scrollController = ScrollController();
  String? selectedItem = '';

  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField<dynamic>(
      items: [
        DropdownMenuItem<String>(
          child: Container(),
        ),
      ],
      selectedItemBuilder: (context) {
        return [];
      },
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
                    width: 1.0,
                  ),
                ),
                child: Material(
                  type: MaterialType.transparency,
                  child: Scrollbar(
                    thumbVisibility: true,
                    trackVisibility: true,
                    radius: const Radius.circular(25.0),
                    thickness: 5.0,
                    interactive: true,
                    controller: _scrollController,
                    child: ListView.builder(
                      controller: _scrollController,
                      itemCount: 20,
                      itemBuilder: (context, index) => InkWell(
                        onTap: () {
                          Navigator.pop(context);
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
      onChanged: (value) {
        setState(() {
          selectedItem = value;
        });
      },
    );
  }
}
