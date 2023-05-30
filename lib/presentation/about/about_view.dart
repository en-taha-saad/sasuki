import 'package:flutter/material.dart';
import 'package:sasuki/app/resources/fonts_manager/fontsize.dart';
import 'package:sasuki/app/resources/other_managers/color_manager.dart';
import 'package:sasuki/app/resources/other_managers/strings_manager.dart';
import 'package:sasuki/app/resources/other_managers/styles_manager.dart';
import 'package:sasuki/app/resources/values_manager/app_margin.dart';
import 'package:sasuki/app/resources/values_manager/app_size.dart';
import 'package:sasuki/app/shared_widgets/get_custome_appbar.dart';
import 'package:sasuki/app/shared_widgets/small_logo.dart';

class AboutView extends StatelessWidget {
  const AboutView({super.key});

  @override
  Widget build(BuildContext context) => _getScreenView(context);

  Widget _getScreenView(context) {
    return Column(
      children: [
        AppSize.statusBarHeight(context),
        getCustomAppBar(context, AppStrings.aboutTitle, true),
        Expanded(
          child: Container(
            width: MediaQuery.of(context).size.width,
            color: ColorManager.secondary,
            child: _getAboutContent(),
          ),
        ),
      ],
    );
  }

  _getAboutContent() {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          const SizedBox(height: 50),
          Container(
            margin: const EdgeInsets.only(
              right: AppMargin.m25,
              left: AppMargin.m25,
            ),
            child: Center(
              child: getScreenSmallLogo(),
            ),
          ),
          const SizedBox(height: 35),
          Container(
            margin: const EdgeInsets.only(
              right: AppMargin.m25,
              left: AppMargin.m25,
            ),
            child: Text(
              "About SAS Radius",
              style: StylesManager.getMediumStyle(
                fontSize: FontSize.sSubtitle5,
              ),
            ),
          ),
          const SizedBox(height: 8),
          Container(
            margin: const EdgeInsets.only(
              right: AppMargin.m25,
              left: AppMargin.m25,
            ),
            width: 30,
            height: 5,
            decoration: BoxDecoration(
              color: const Color(0xff929EAE),
              borderRadius: BorderRadius.circular(100),
            ),
          ),
          const SizedBox(height: 15),
          Container(
            margin: const EdgeInsets.only(
              right: AppMargin.m25,
              left: AppMargin.m25,
            ),
            child: Text(
              "Introducing SAS Radius App, your mobile companion for the SAS4 ISP Billing System. This compact powerhouse allows seamless management of subscribers and resellers right from your device. Keep track of sales, maintain invoices, and activate users on-the-go with unrivaled ease.",
              style: StylesManager.getRegularStyle(
                fontSize: FontSize.sCaption1,
              ),
              softWrap: true,
            ),
          ),
          const SizedBox(height: 15),
          Container(
            padding: const EdgeInsets.symmetric(
              vertical: 15,
              horizontal: 25,
            ),
            decoration: const BoxDecoration(
              color: Color(0xff324677),
            ),
            child: Text(
              "SAS Radius is the epitome of convenience and control, transforming your billing system management experience for the better.",
              style: StylesManager.getRegularStyle(
                fontSize: FontSize.sCaption1,
              ),
              softWrap: true,
            ),
          ),
        ],
      ),
    );
  }
}
