import 'package:flutter/material.dart';
import 'package:sasuki/app/resources/other_managers/color_manager.dart';

class CustomSwitch extends StatefulWidget {
  final bool value;
  final ValueChanged<bool> onChanged;

  const CustomSwitch({
    Key? key,
    required this.value,
    required this.onChanged,
  }) : super(key: key);

  @override
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
        width: 33,
        height: 18,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          color: const Color(0xff929EAE).withOpacity(0.25),
        ),
        child: AnimatedAlign(
          alignment: _value ? Alignment.centerRight : Alignment.centerLeft,
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeInOut,
          child: Container(
            width: 12,
            height: 12,
            margin: const EdgeInsets.all(3.0),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: _value
                  ? ColorManager.primaryshade1
                  : ColorManager.blackNeutral,
            ),
          ),
        ),
      ),
    );
  }
}
