import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:sasuki/app/app_inits_funs/constants.dart';
import 'package:sasuki/app/resources/other_managers/assets_manager.dart';
import 'package:sasuki/app/resources/other_managers/color_manager.dart';
import 'package:sasuki/app/resources/other_managers/strings_manager.dart';
import 'package:sasuki/app/resources/values_manager/app_size.dart';
import 'package:sasuki/app/shared_widgets/app_background.dart';
import 'package:sasuki/app/shared_widgets/get_custome_appbar.dart';
import 'package:sasuki/app/shared_widgets/single_journal_card.dart';

class ManagersJournalShimmerLoading extends StatelessWidget {
  const ManagersJournalShimmerLoading({super.key});

  @override
  Widget build(BuildContext context) {
    return AppBackground(
      isSecondAppBackground: Constants.falseBool,
      child: _getContentWidget(context),
    );
  }

  Widget _getContentWidget(context) {
    return Container(
      color: ColorManager.secondary,
      child: Column(
        children: [
          Container(
            color: ColorManager.primaryshade1,
            child: Column(
              children: [
                AppSize.statusBarHeight(context),
                getCustomAppBar(context, AppStrings.drawerReports, true),
              ],
            ),
          ),
          Container(
            color: ColorManager.whiteNeutral.withOpacity(0.2),
            padding: const EdgeInsets.symmetric(
              horizontal: AppSize.s20,
              vertical: AppSize.s10,
            ),
            margin: const EdgeInsets.only(
              bottom: AppSize.s20,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      margin: const EdgeInsets.only(right: AppSize.s10),
                      child: SvgPicture.asset(
                        IconsAssets.reciept1,
                        theme: const SvgTheme(
                          currentColor: ColorManager.whiteNeutral,
                        ),
                        // ignore: deprecated_member_use
                        color: ColorManager.whiteNeutral,
                      ),
                    ),
                    Text(
                      Constants.dash,
                      style:
                          Theme.of(context).textTheme.headlineMedium?.copyWith(
                                color: ColorManager.whiteNeutral,
                              ),
                    ),
                  ],
                ),
                Container(),
              ],
            ),
          ),
          Expanded(
            child: _getInvoiceListContent(),
          ),
        ],
      ),
    );
  }

  Widget _getInvoiceListContent() {
    return SingleChildScrollView(
      child: Column(
        children: [
          _singleInvoice(),
          _singleInvoice(),
          _singleInvoice(),
          _singleInvoice(),
          _singleInvoice(),
          _singleInvoice(),
          _singleInvoice(),
          _singleInvoice(),
          _singleInvoice(),
          _singleInvoice(),
        ],
      ),
    );
  }

  Widget _singleInvoice() {
    return const SingleJournalCard(
      isShimmer: Constants.trueBool,
    );
  }
}
