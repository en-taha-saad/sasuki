import 'package:flutter/material.dart';
import 'package:sasuki/app/app_inits_funs/constants.dart';
import 'package:sasuki/app/resources/fonts_manager/fontsize.dart';
import 'package:sasuki/app/resources/other_managers/color_manager.dart';
import 'package:sasuki/app/resources/other_managers/strings_manager.dart';
import 'package:sasuki/app/resources/other_managers/styles_manager.dart';
import 'package:sasuki/app/resources/values_manager/app_margin.dart';
import 'package:sasuki/app/resources/values_manager/app_size.dart';
import 'package:sasuki/app/shared_widgets/text_shimmer.dart';
import 'package:sasuki/domain/models/captcha/captcha.dart';
import 'package:intl/intl.dart' as intl;
import 'package:sasuki/domain/models/managers_invoices/managers_invoices.dart';

class SingleInvoiceCard extends StatelessWidget {
  const SingleInvoiceCard({
    this.isShimmer,
    this.dataCaptcha,
    this.invoice,
    Key? key,
  }) : super(key: key);
  final ManagersInvoiceData? invoice;
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
                AppStrings.userOverviewInvoiceNo,
                invoice?.invoiceNumber ?? Constants.dash,
              ),
              isShimmer != Constants.nullValue &&
                      isShimmer != Constants.falseBool
                  ? const ShimmerText(
                      baseColor: ColorManager.whiteNeutral,
                      highlightColor: ColorManager.backgroundCenter,
                      width: AppSize.s50,
                    )
                  : Text(
                      "${dataCaptcha?.data?.siteCurrency} ${intl.NumberFormat.decimalPattern().format(double.parse((invoice?.amount)!))}",
                      style: StylesManager.getMediumStyle(
                        fontSize: FontSize.sSubtitle5,
                      ),
                    ),
            ],
          ),
          _getSingleLabeledData(
            context,
            AppStrings.userNameType,
            invoice?.type ?? Constants.dash,
          ),
          Container(
            margin: const EdgeInsets.only(bottom: AppMargin.m10),
            child: _getSingleLabeledData(
              context,
              AppStrings.manager,
              invoice?.ownerDetails?.username ?? Constants.dash,
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(),
              isShimmer != Constants.nullValue &&
                      isShimmer != Constants.falseBool
                  ? const ShimmerText(
                      baseColor: ColorManager.whiteNeutral,
                      highlightColor: ColorManager.backgroundCenter,
                      width: AppSize.s50,
                    )
                  : Text(
                      formatDateTime((invoice?.createdAt)!),
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
          width: 65,
          child: Text(
            label!,
            style: StylesManager.getMediumStyle(
              fontSize: FontSize.sCaption1,
              color: ColorManager.greyNeutral2,
            ),
          ),
        ),
        isShimmer != Constants.nullValue && isShimmer != Constants.falseBool
            ? const ShimmerText(
                baseColor: ColorManager.whiteNeutral,
                highlightColor: ColorManager.backgroundCenter,
                width: AppSize.s50,
              )
            : SizedBox(
              width:label == "Manager"?  MediaQuery.of(context).size.width * 0.6: null,
              child: Text(
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

class TransferredDataBetweenInvoiceScreen {
  ManagersInvoiceData? invoice;
  Captcha? dataCaptcha;
  TransferredDataBetweenInvoiceScreen({this.invoice, this.dataCaptcha});
}
