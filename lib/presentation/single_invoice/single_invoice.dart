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
import 'package:sasuki/app/shared_widgets/single_invoice_card.dart';
import 'package:intl/intl.dart' as intl;
import 'package:sasuki/domain/models/captcha/captcha.dart';

import '../../domain/models/managers_invoices/managers_invoices.dart';

class SingleInvoiceView extends StatefulWidget {
  const SingleInvoiceView({Key? key}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _SingleInvoiceViewState createState() => _SingleInvoiceViewState();
}

class _SingleInvoiceViewState extends State<SingleInvoiceView> {
  ManagersInvoiceData? _argument;
  Captcha? _captcha;
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _argument = (ModalRoute.of(context)?.settings.arguments
            as TransferredDataBetweenInvoiceScreen)
        .invoice;
    _captcha = (ModalRoute.of(context)?.settings.arguments
            as TransferredDataBetweenInvoiceScreen)
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
                              IconsAssets.reciepttext,
                            theme: const SvgTheme(
                              currentColor: ColorManager.whiteNeutral,
                            ),
                            // ignore: deprecated_member_use
                            color: ColorManager.whiteNeutral,
                          ),
                        ),
                        Text(
                            _argument?.invoiceNumber ?? Constants.dash,
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
                    child: _getSingleInvoice(_argument),
                  ),
                ],
              ),
            ),
          ),
        ),
        Container(
          height: 64,
          margin: EdgeInsets.only(top: MediaQuery.of(context).viewPadding.top),
          child: getCustomAppBar(context, AppStrings.drawerReportsInvoices, true),
        ),
      ],
    );
  }

  _getSingleInvoice(ManagersInvoiceData? argument) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
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
                AppStrings.userOverviewInvoiceNo,
                argument?.invoiceNumber ?? Constants.dash,
              ),
              _getSingleLabeledData(
                context,
                AppStrings.userNameType,
                argument?.type ?? Constants.dash,
              ),
              _getSingleLabeledData(
                context,
                AppStrings.manager,
                argument?.ownerDetails?.username ?? Constants.dash,
              ),
              _getSingleLabeledData(
                context,
                "Amount",
                "${_captcha?.data?.siteCurrency} ${intl.NumberFormat.decimalPattern().format(double.parse((argument?.amount)!))}",
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
          margin: const EdgeInsets.only(
            bottom: AppMargin.m25,
          ),
          child: Column(
            children: [
              _getSingleLabeledData(
                context,
                "Issued By",
                argument?.issuerDetails?.username ?? Constants.dash,
              ),
              _getSingleLabeledData(
                context,
                "Payment Method",
                argument?.paymentMethod ?? Constants.dash,
              ),
              Container(
                margin: const EdgeInsets.only(
                  bottom: AppMargin.m15,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      "Paid",
                      maxLines: 3,
                      softWrap: true,
                      textAlign: TextAlign.start,
                      style: StylesManager.getMediumStyle(
                        fontSize: FontSize.sCaption1,
                        color: ColorManager.greyNeutral,
                      ),
                    ),
                    SvgPicture.asset(IconsAssets.paid),
                  ],
                ),
              ),
              _getSingleLabeledData(
                context,
                "Date",
                formatDateTime(argument?.createdAt ?? Constants.dash),
              ),
            ],
          ),
        ),

        ///
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
                  IconsAssets.messagetext1,
                  // ignore: deprecated_member_use
                  color: ColorManager.greyNeutral,
                  theme: const SvgTheme(
                    currentColor: ColorManager.greyNeutral,
                  ),
                ),
              ),
              Text(
                "Description",
                style: StylesManager.getMediumStyle(
                  fontSize: FontSize.sBody3,
                  color: ColorManager.greyNeutral,
                ),
              ),
            ],
          ),
        ),
        Text(
          argument?.description != "" &&
                  argument?.description != Constants.nullValue
              ? (argument?.description)!
              : "No description added",
          maxLines: 3,
          textAlign: TextAlign.start,
          softWrap: true,
          style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                color: ColorManager.whiteNeutral,
              ),
        ),
        Divider(
          color: ColorManager.greyNeutral.withOpacity(
            AppSize.s0point25,
          ),
        ),

        ///
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
                  IconsAssets.messages2,
                  // ignore: deprecated_member_use
                  color: ColorManager.greyNeutral,
                  theme: const SvgTheme(
                    currentColor: ColorManager.greyNeutral,
                  ),
                ),
              ),
              Text(
                "Comment",
                style: StylesManager.getMediumStyle(
                  fontSize: FontSize.sBody3,
                  color: ColorManager.greyNeutral,
                ),
              ),
            ],
          ),
        ),
        Text(
          argument?.comments != "" &&
                  argument?.comments != Constants.nullValue
              ? (argument?.comments)!
              : "No comment added",
          maxLines: 3,
          textAlign: TextAlign.start,
          softWrap: true,
          style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                color: ColorManager.whiteNeutral,
              ),
        ),
        Container(
          margin: const EdgeInsets.only(bottom: AppMargin.m15),
          child: Divider(
            color: ColorManager.greyNeutral.withOpacity(
              AppSize.s0point25,
            ),
          ),
        ),
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
          SizedBox(
            width: MediaQuery.of(context).size.width - 200,
            child: Text(
              value!,
              maxLines: 3,
              textAlign: TextAlign.end,
              softWrap: true,
              style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                    color: ColorManager.whiteNeutral,
                  ),
            ),
          ),
        ],
      ),
    );
  }
}
