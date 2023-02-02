import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:sasuki/app/resources/other_managers/assets_manager.dart';
import 'package:sasuki/app/resources/other_managers/color_manager.dart';
import 'package:sasuki/app/resources/values_manager/app_radius.dart';
import 'package:sasuki/app/resources/values_manager/app_size.dart';
import 'package:sasuki/app/shared_funs/screen_width.dart';

class TestingComponents extends StatelessWidget {
  const TestingComponents({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField<String>(
      items: const [
        DropdownMenuItem<String>(
          value: 'Item 1',
          child: Text('Item 1'),
        ),
        DropdownMenuItem<String>(
          value: 'Item 2',
          child: Text('Item 2'),
        ),
      ],
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
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        ListTile(
                          title: const Text('Item 1'),
                          onTap: () {
                            // handle value change
                            Navigator.of(context).pop();
                          },
                        ),
                        ListTile(
                          title: const Text('Item 2'),
                          onTap: () {
                            // handle value change
                            Navigator.of(context).pop();
                          },
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            );
          },
        );
      },
      onChanged: (value) {},
    );
    DropdownButtonFormField(
      // validator: ,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      hint: const Text('hint'),
      icon: SvgPicture.asset(
        IconsAssets.dropdown,
        height: AppSize.s10,
        width: AppSize.s10,
      ),
      menuMaxHeight: AppSize.s250,

      // onSaved: ,
      // selectedItemBuilder: ,
      // style: ,
      decoration: const InputDecoration(),

      dropdownColor: ColorManager.secondary,

      items: const [
        DropdownMenuItem(
          value: 1,
          child: Text('Option 0'),
        ),
        DropdownMenuItem(
          value: 2,
          child: Text('Option 1'),
        ),
        DropdownMenuItem(
          value: 3,
          child: Text('Option 2'),
        ),
        DropdownMenuItem(
          value: 4,
          child: Text('Option 3'),
        ),
        DropdownMenuItem(
          value: 5,
          child: Text('Option 4'),
        ),
      ],
      onChanged: (value) {},
      value: null,
    );
  }
}
