import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:sasuki/app/resources/fonts_manager/fontsize.dart';
import 'package:sasuki/app/resources/other_managers/assets_manager.dart';
import 'package:sasuki/app/resources/other_managers/styles_manager.dart';
import 'package:sasuki/app/resources/values_manager/app_margin.dart';
import 'package:sasuki/app/resources/values_manager/app_size.dart';
import 'package:sasuki/domain/models/activity_log_list/activity_log_list.dart';
import 'package:sasuki/app/app_inits_funs/constants.dart';
import 'package:sasuki/app/resources/other_managers/color_manager.dart';
import 'package:sasuki/app/shared_widgets/text_shimmer.dart';
import 'package:intl/intl.dart' as intl;

class SingleActivityLog extends StatelessWidget {
  const SingleActivityLog({
    this.isShimmer,
    this.activityLog,
    Key? key,
  }) : super(key: key);
  final ActivityLog? activityLog;
  final bool? isShimmer;
  String formatDateTime(String inputDateTime) {
    DateTime parsedDateTime = DateTime.parse(inputDateTime);
    intl.DateFormat outputFormat = intl.DateFormat('dd, MMMM yyyy | HH:mm:ss');
    String formattedDateTime = outputFormat.format(parsedDateTime);
    return formattedDateTime;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: const Color(0xff2A4079),
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
          isShimmer != Constants.nullValue && isShimmer != Constants.falseBool
              ? const ShimmerText(
                  baseColor: ColorManager.whiteNeutral,
                  highlightColor: ColorManager.backgroundCenter,
                  width: AppSize.s50,
                )
              : Container(
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
              crossAxisAlignment: CrossAxisAlignment.center,
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
                isShimmer != Constants.nullValue &&
                        isShimmer != Constants.falseBool
                    ? const ShimmerText(
                        baseColor: ColorManager.whiteNeutral,
                        highlightColor: ColorManager.backgroundCenter,
                        width: AppSize.s50,
                      )
                    : SizedBox(
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
                  isShimmer != Constants.nullValue &&
                          isShimmer != Constants.falseBool
                      ? const ShimmerText(
                          baseColor: ColorManager.whiteNeutral,
                          highlightColor: ColorManager.backgroundCenter,
                          width: AppSize.s50,
                        )
                      : Text(
                          formatDateTime((activityLog?.createdAt)!),
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
                  isShimmer != Constants.nullValue &&
                          isShimmer != Constants.falseBool
                      ? const ShimmerText(
                          baseColor: ColorManager.whiteNeutral,
                          highlightColor: ColorManager.backgroundCenter,
                          width: AppSize.s50,
                        )
                      : Text(
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
