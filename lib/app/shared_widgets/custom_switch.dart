import 'package:flutter/material.dart';
import 'package:sasuki/app/resources/other_managers/color_manager.dart';

class CustomSwitch extends StatefulWidget {
  final bool value;
  final ValueChanged<bool> onChanged;
  final Color? color;
  const CustomSwitch({
    Key? key,
    required this.value,
    required this.onChanged,
    this.color,
  }) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _CustomSwitchState createState() => _CustomSwitchState();
}

class _CustomSwitchState extends State<CustomSwitch> {
  late bool _value;

  @override
  void initState() {
    super.initState();
    _value = widget.value;
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        widget.onChanged(!_value);
        setState(() {
          _value = !_value;
        });
      },
      child: Container(
        width: 35,
        height: 20,
        decoration: BoxDecoration(
          border: Border.all(
            color: _value ? ColorManager.transparent : ColorManager.greyNeutral,
            width: 2,
          ),
          color: _value ? ColorManager.primaryshade1 : ColorManager.transparent,
          borderRadius: BorderRadius.circular(16),
        ),
        child: AnimatedAlign(
          alignment: _value ? Alignment.centerRight : Alignment.centerLeft,
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeInOut,
          child: Container(
            width: 10,
            height: 10,
            margin: const EdgeInsets.all(3.0),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: _value
                  ? ColorManager.whiteNeutral
                  : ColorManager.greyNeutral,
            ),
          ),
        ),
      ),
    );
  }
}
