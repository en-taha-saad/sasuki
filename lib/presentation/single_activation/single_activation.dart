import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:sasuki/app/app_inits_funs/constants.dart';
import 'package:sasuki/app/resources/fonts_manager/fontsize.dart';
import 'package:sasuki/app/resources/other_managers/assets_manager.dart';
import 'package:sasuki/app/resources/other_managers/color_manager.dart';
import 'package:sasuki/app/resources/other_managers/strings_manager.dart';
import 'package:sasuki/app/resources/other_managers/styles_manager.dart';
import 'package:sasuki/app/resources/values_manager/app_margin.dart';
import 'package:sasuki/app/resources/values_manager/app_padding.dart';
import 'package:sasuki/app/resources/values_manager/app_size.dart';
import 'package:sasuki/app/shared_widgets/get_custome_appbar.dart';
import 'package:sasuki/app/shared_widgets/single_activation_card.dart';
import 'package:sasuki/domain/models/activations_reports/activations_reports.dart';
import 'package:intl/intl.dart' as intl;
import 'package:sasuki/domain/models/captcha/captcha.dart';

class SingleActivationView extends StatefulWidget {
  const SingleActivationView({Key? key}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _SingleActivationViewState createState() => _SingleActivationViewState();
}

class _SingleActivationViewState extends State<SingleActivationView> {
  Activation? _argument;
  Captcha? _captcha;
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _argument = (ModalRoute.of(context)?.settings.arguments
            as TransferredDataBetweenActivationScreen)
        .activation;
    _captcha = (ModalRoute.of(context)?.settings.arguments
            as TransferredDataBetweenActivationScreen)
        .dataCaptcha;
  }

  @override
  Widget build(BuildContext context) {
    return _getContentWidget();
  }

  Widget _getContentWidget() {
    return Stack(
      alignment: AlignmentDirectional.topCenter,
      children: [
        Container(
          decoration: const BoxDecoration(
            color: ColorManager.secondary,
          ),
          child: SingleChildScrollView(
            physics: const AlwaysScrollableScrollPhysics(),
            child: Container(
              margin: EdgeInsets.only(
                bottom: AppMargin.m50,
                top: MediaQuery.of(context).viewPadding.top + 63,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Container(
                    color: ColorManager.whiteNeutral.withOpacity(0.2),
                    padding: const EdgeInsets.symmetric(
                      horizontal: AppSize.s25,
                      vertical: AppSize.s10,
                    ),
                    margin: const EdgeInsets.only(
                      bottom: AppSize.s20,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Container(
                          margin: const EdgeInsets.only(right: AppSize.s10),
                          child: SvgPicture.asset(
                            IconsAssets.person,
                            theme: const SvgTheme(
                              currentColor: ColorManager.whiteNeutral,
                            ),
                            // ignore: deprecated_member_use
                            color: ColorManager.whiteNeutral,
                          ),
                        ),
                        Text(
                          _argument?.userDetails?.username ?? Constants.dash,
                          style: Theme.of(context)
                              .textTheme
                              .headlineMedium
                              ?.copyWith(
                                color: ColorManager.whiteNeutral,
                              ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.only(
                      left: AppMargin.m25,
                      right: AppMargin.m25,
                    ),
                    child: _getSingleActivationData(_argument),
                  ),
                ],
              ),
            ),
          ),
        ),
        Container(
          height: 64,
          margin: EdgeInsets.only(top: MediaQuery.of(context).viewPadding.top),
          child: getCustomAppBar(context, AppStrings.activationReports, true),
        ),
      ],
    );
  }

  _getSingleActivationData(Activation? argument) {
    debugPrint("argument?.refunded ${argument?.refunded}");
    return Column(
      children: [
        Container(
          margin: const EdgeInsets.only(
            bottom: AppMargin.m10,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                margin: const EdgeInsets.only(
                  right: AppMargin.m5,
                ),
                child: SvgPicture.asset(
                  IconsAssets.information,
                  // ignore: deprecated_member_use
                  color: ColorManager.greyNeutral,
                  theme: const SvgTheme(
                    currentColor: ColorManager.greyNeutral,
                  ),
                ),
              ),
              Text(
                "Basic Info.",
                style: StylesManager.getMediumStyle(
                  fontSize: FontSize.sBody3,
                  color: ColorManager.greyNeutral2,
                ),
              ),
            ],
          ),
        ),
        Container(
          margin: const EdgeInsets.only(
            bottom: AppMargin.m25,
          ),
          decoration: BoxDecoration(
            color: const Color(0xff324677),
            borderRadius: BorderRadius.circular(AppSize.s12),
          ),
          padding: const EdgeInsets.only(
            top: AppPadding.p15,
            left: AppPadding.p15,
            right: AppPadding.p15,
          ),
          child: Column(
            children: [
              _getSingleLabeledData(
                context,
                "Username",
                argument?.userDetails?.username ?? Constants.dash,
              ),
              _getSingleLabeledData(
                context,
                "Full Name",
                "${argument?.userDetails?.firstname ?? Constants.dash} ${argument?.userDetails?.lastname ?? Constants.dash}",
              ),
              _getSingleLabeledData(
                context,
                "Manager",
                argument?.managerDetails?.username ?? Constants.dash,
              ),
              _getSingleLabeledData(
                context,
                "Profile",
                argument?.profileDetails?.name ?? Constants.dash,
              ),
            ],
          ),
        ),
        Container(
          margin: const EdgeInsets.only(
            bottom: AppMargin.m10,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                margin: const EdgeInsets.only(
                  right: AppMargin.m5,
                ),
                child: SvgPicture.asset(
                  IconsAssets.documenttext1,
                  // ignore: deprecated_member_use
                  color: ColorManager.greyNeutral,
                  theme: const SvgTheme(
                    currentColor: ColorManager.greyNeutral,
                  ),
                ),
              ),
              Text(
                "Details",
                style: StylesManager.getMediumStyle(
                  fontSize: FontSize.sBody3,
                  color: ColorManager.greyNeutral2,
                ),
              ),
            ],
          ),
        ),
        Container(
          decoration: BoxDecoration(
            color: const Color(0xff324677),
            borderRadius: BorderRadius.circular(AppSize.s12),
          ),
          padding: const EdgeInsets.only(
            top: AppPadding.p15,
            left: AppPadding.p15,
            right: AppPadding.p15,
          ),
          child: Column(
            children: [
              _getSingleLabeledData(
                context,
                "Price",
                "${_captcha?.data?.siteCurrency} ${argument?.price ?? Constants.dash}",
              ),
              _getSingleLabeledData(
                context,
                "Old Expiration",
                formatDateTime(argument?.oldExpiration ?? Constants.dash),
              ),
              _getSingleLabeledData(
                context,
                "New Expiration",
                formatDateTime(argument?.newExpiration ?? Constants.dash),
              ),
              _getSingleLabeledData(
                context,
                "Activation Method",
                argument?.activationMethod ?? Constants.dash,
              ),
              _getSingleLabeledData(
                context,
                "Acc. Count",
                argument?.userActivationsCount.toString() ?? Constants.dash,
              ),
              _getSingleLabeledData(
                context,
                "Status",
                _argument?.refunded == null ? "Ok" : "Cancelled",
              ),
              _getSingleLabeledData(
                context,
                "Date",
                formatDateTime(argument?.createdAt ?? Constants.dash),
              ),
            ],
          ),
        ),
        const SizedBox(height: 25),
      ],
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
    return Container(
      margin: const EdgeInsets.only(
        bottom: AppMargin.m15,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label!,
            maxLines: 3,
            softWrap: true,
            textAlign: TextAlign.start,
            style: StylesManager.getMediumStyle(
              fontSize: FontSize.sCaption1,
              color: ColorManager.greyNeutral3,
            ),
          ),
          label == "Profile"
              ? Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: AppMargin.m15,
                    vertical: 3.5,
                  ),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(AppSize.s15),
                    color: ColorManager.greyNeutral,
                  ),
                  child: Text(
                    value!,
                    maxLines: 3,
                    textAlign: TextAlign.end,
                    softWrap: true,
                    style: StylesManager.getMediumStyle(
                      fontSize: FontSize.sBadge2,
                      color: ColorManager.blackNeutral,
                    ),
                  ),
                )
              : SizedBox(
                  width: MediaQuery.of(context).size.width - 200,
                  child: Text(
                    value!,
                    maxLines: 3,
                    textAlign: TextAlign.end,
                    softWrap: true,
                    style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                          color: label == "Status"
                              ? value == "Ok"
                                  ? const Color(0xff23D7B5)
                                  : const Color(0xffF8AE6D)
                              : ColorManager.whiteNeutral,
                        ),
                  ),
                ),
        ],
      ),
    );
  }
}
