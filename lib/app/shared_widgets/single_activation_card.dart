import 'package:flutter/material.dart';
import 'package:sasuki/app/app_inits_funs/constants.dart';
import 'package:sasuki/app/resources/fonts_manager/fontsize.dart';
import 'package:sasuki/app/resources/other_managers/color_manager.dart';
import 'package:sasuki/app/resources/other_managers/strings_manager.dart';
import 'package:sasuki/app/resources/other_managers/styles_manager.dart';
import 'package:sasuki/app/resources/values_manager/app_margin.dart';
import 'package:sasuki/app/resources/values_manager/app_size.dart';
import 'package:sasuki/app/shared_widgets/text_shimmer.dart';
import 'package:sasuki/domain/models/activations_reports/activations_reports.dart';
import 'package:sasuki/domain/models/captcha/captcha.dart';
import 'package:intl/intl.dart' as intl;

class SingleActivationCard extends StatelessWidget {
  const SingleActivationCard({
    this.isShimmer,
    this.dataCaptcha,
    this.activation,
    Key? key,
  }) : super(key: key);
  final Activation? activation;
  final Captcha? dataCaptcha;
  final bool? isShimmer;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: AppMargin.m25),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _getSingleLabeledData(
                context,
                AppStrings.userOverviewusername,
                activation?.userDetails?.username ?? Constants.dash,
              ),
              isShimmer != Constants.nullValue &&
                      isShimmer != Constants.falseBool
                  ? const ShimmerText(
                      baseColor: ColorManager.whiteNeutral,
                      highlightColor: ColorManager.backgroundCenter,
                      width: AppSize.s50,
                    )
                  : Text(
                      "${dataCaptcha?.data?.siteCurrency} ${intl.NumberFormat.decimalPattern().format(double.parse((activation?.price)!))}",
                      style: StylesManager.getMediumStyle(
                        fontSize: FontSize.sSubtitle5,
                      ),
                    ),
            ],
          ),
          _getSingleLabeledData(
            context,
            AppStrings.userNameHint,
            activation?.userDetails?.firstname != Constants.nullValue
                ? "${activation?.userDetails?.firstname} ${activation?.userDetails?.lastname ?? Constants.dash}"
                : Constants.dash,
          ),
          Container(
            margin: const EdgeInsets.only(bottom: AppMargin.m10),
            child: _getSingleLabeledData(
              context,
              AppStrings.manager,
              activation?.managerDetails?.username ?? Constants.dash,
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                height: AppSize.s22,
                padding: const EdgeInsets.symmetric(
                  horizontal: AppMargin.m15,
                  vertical: 3.5,
                ),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(AppSize.s15),
                  color: ColorManager.greyNeutral,
                ),
                child: Center(
                  child: isShimmer != Constants.nullValue &&
                          isShimmer != Constants.falseBool
                      ? const ShimmerText(
                          baseColor: ColorManager.whiteNeutral,
                          highlightColor: ColorManager.backgroundCenter,
                          width: AppSize.s50,
                        )
                      : Text(
                          activation?.profileDetails?.name ?? Constants.dash,
                          style:
                              Theme.of(context).textTheme.labelSmall?.copyWith(
                                    color: ColorManager.blackNeutral,
                                  ),
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
                  : Text(
                      formatDateTime((activation?.createdAt)!),
                      style: StylesManager.getMediumStyle(
                        fontSize: FontSize.sCaption1,
                        color: ColorManager.greyNeutral,
                      ),
                    )
            ],
          ),
          Container(
            margin: const EdgeInsets.symmetric(vertical: AppMargin.m5),
            child: Divider(
              color: ColorManager.greyNeutral.withOpacity(
                AppSize.s0point25,
              ),
            ),
          ),
        ],
      ),
    );
  }

  String formatDateTime(String inputDateTime) {
    DateTime parsedDateTime = DateTime.parse(inputDateTime);
    intl.DateFormat outputFormat = intl.DateFormat('dd, MMMM yyyy | HH:mm:ss');
    String formattedDateTime = outputFormat.format(parsedDateTime);
    return formattedDateTime;
  }

  Widget _getSingleLabeledData(
    BuildContext context,
    String? label,
    String? value,
  ) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Container(
          margin: const EdgeInsets.only(right: AppMargin.m15),
          width: 60,
          child: Text(
            label!,
            style: StylesManager.getMediumStyle(
              fontSize: FontSize.sCaption1,
              color: ColorManager.greyNeutral2,
            ),
          ),
        ),
        SizedBox(
          width: MediaQuery.of(context).size.width * 0.4,
          child: isShimmer != Constants.nullValue &&
                  isShimmer != Constants.falseBool
              ? const ShimmerText(
                  baseColor: ColorManager.whiteNeutral,
                  highlightColor: ColorManager.backgroundCenter,
                  width: AppSize.s50,
                )
              : Text(
                  value!,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: Theme.of(context).textTheme.bodyLarge,
                ),
        ),
      ],
    );
  }
}

class TransferredDataBetweenActivationScreen {
  Activation? activation;
  Captcha? dataCaptcha;
  TransferredDataBetweenActivationScreen({this.activation, this.dataCaptcha});
}
