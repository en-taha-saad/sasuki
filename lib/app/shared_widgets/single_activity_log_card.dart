import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:sasuki/app/resources/fonts_manager/fontsize.dart';
import 'package:sasuki/app/resources/other_managers/assets_manager.dart';
import 'package:sasuki/app/resources/other_managers/styles_manager.dart';
import 'package:sasuki/app/resources/values_manager/app_margin.dart';
import 'package:sasuki/app/resources/values_manager/app_size.dart';
import 'package:sasuki/domain/models/activity_log_list/activity_log_list.dart';

class SingleActivityLog extends StatelessWidget {
  const SingleActivityLog({super.key, this.activityLog});
  final ActivityLog? activityLog;
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: const Color(0xff21325E),
        borderRadius: BorderRadius.circular(AppSize.s12),
      ),
      padding: const EdgeInsets.symmetric(
        horizontal: AppMargin.m15,
        vertical: AppMargin.m10,
      ),
      margin: const EdgeInsets.only(
        left: AppMargin.m25,
        right: AppMargin.m25,
        bottom: AppMargin.m10,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            margin: const EdgeInsets.only(bottom: AppMargin.m10),
            child: Text(
              activityLog?.event ?? "",
              style: Theme.of(context).textTheme.bodyLarge,
            ),
          ),
          Container(
            margin: const EdgeInsets.only(bottom: AppMargin.m10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: AppSize.s3,
                  height: AppSize.s14,
                  margin: const EdgeInsets.only(right: AppMargin.m10),
                  decoration: const BoxDecoration(
                    color: Color(0xff096191),
                    borderRadius: BorderRadius.all(
                      Radius.circular(AppSize.s25),
                    ),
                  ),
                ),
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.6,
                  child: Text(
                    activityLog?.description ?? "",
                    softWrap: true,
                    maxLines: 3,
                    textAlign: TextAlign.start,
                    style: StylesManager.getRegularStyle(
                      fontSize: FontSize.sCaption1,
                    ),
                  ),
                ),
              ],
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    margin: const EdgeInsets.only(right: AppMargin.m5),
                    child: SvgPicture.asset(IconsAssets.calendar),
                  ),
                  Text(
                    activityLog?.createdAt ?? "",
                    style: StylesManager.getRegularStyle(
                      fontSize: FontSize.sCaption1,
                    ),
                  ),
                ],
              ),
              Row(
                children: [
                  Container(
                    margin: const EdgeInsets.only(right: AppMargin.m5),
                    child: SvgPicture.asset(IconsAssets.global),
                  ),
                  Text(
                    activityLog?.ip ?? "",
                    style: StylesManager.getRegularStyle(
                      fontSize: FontSize.sCaption1,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}
