import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:sasuki/app/resources/other_managers/assets_manager.dart';
import 'package:sasuki/app/resources/other_managers/color_manager.dart';
import 'package:sasuki/app/resources/other_managers/styles_manager.dart';
import 'package:sasuki/app/resources/values_manager/app_size.dart';
import 'package:sasuki/app/shared_widgets/custome_expansion_tile.dart';

class ExpandableReports extends StatefulWidget {
  const ExpandableReports({this.listOfReports, this.title, super.key});
  final String? title;
  final List<SingleReport>? listOfReports;

  @override
  State<ExpandableReports> createState() => _ExpandableReportsState();
}

class _ExpandableReportsState extends State<ExpandableReports> {
  bool isExpanded = false;
  @override
  Widget build(BuildContext context) {
    return CustomeExpansionTile(
      maintainState: true,
      onExpansionChanged: (value) => setState(() => isExpanded = value),
      trailing: SvgPicture.asset(
        isExpanded ? IconsAssets.minus : IconsAssets.add,
        height: 16,
        width: 16,
      ),
      title: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          SvgPicture.asset(
            IconsAssets.reports,
            height: 16,
            width: 16,
          ),
          const SizedBox(width: AppSize.s20),
          Text(
            widget.title!,
            style: StylesManager.getRegularStyle(
              color: ColorManager.whiteNeutral,
              fontSize: 16,
            ),
          ),
        ],
      ),
      children: [
        Container(
          width: double.infinity,
          decoration: const BoxDecoration(
            color: ColorManager.primaryshade3,
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: (widget.listOfReports
                ?.map(
                  (e) => InkWell(
                    onTap: e.action,
                    child: Container(
                      width: double.infinity,
                      margin: EdgeInsets.only(
                        bottom: e.title == "Manager Journal"
                            ? AppSize.s15
                            : AppSize.s10,
                        top: AppSize.s10,
                        left: AppSize.s60,
                      ),
                      child: Text(
                        e.title!,
                        style: StylesManager.getRegularStyle(
                          color: ColorManager.whiteNeutral,
                          fontSize: 14,
                        ),
                      ),
                    ),
                  ),
                )
                .toList())!,
          ),
        ),
      ],
    );
  }
}

class SingleReport {
  SingleReport({
    this.title,
    this.action,
  });
  String? title;
  void Function()? action;
}
