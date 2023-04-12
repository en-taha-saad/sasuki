import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:sasuki/app/app_inits_funs/constants.dart';
import 'package:sasuki/app/resources/fonts_manager/fontsize.dart';
import 'package:sasuki/app/resources/other_managers/assets_manager.dart';
import 'package:sasuki/app/resources/other_managers/color_manager.dart';
import 'package:sasuki/app/resources/other_managers/strings_manager.dart';
import 'package:sasuki/app/resources/other_managers/styles_manager.dart';
import 'package:sasuki/app/resources/routes_manager/nav_funcs.dart';
import 'package:sasuki/app/resources/values_manager/app_padding.dart';
import 'package:sasuki/app/resources/values_manager/app_radius.dart';
import 'package:sasuki/app/resources/values_manager/app_size.dart';
import 'package:sasuki/presentation/common/loading_shimmers_screens/dashboard_shimmer_loading.dart';
import 'package:sasuki/presentation/common/loading_shimmers_screens/userlist_shimmer_loading.dart';
import 'package:sasuki/presentation/common/state_render/states/mobile_module_screen.dart';
import 'package:sasuki/presentation/common/state_render/states/state_renderer_type.dart';

// ignore: must_be_immutable
class StateRenderer extends StatelessWidget {
  StateRendererType stateRendererType;
  MobileModuleScreen? mobileModuleScreen;
  String message;
  String title;
  Function retryActionFunction;
  StateRenderer({
    super.key,
    required this.stateRendererType,
    this.mobileModuleScreen,
    this.message = AppStrings.loading,
    this.title = 'Success',
    required this.retryActionFunction,
  });

  @override
  Widget build(BuildContext context) => _getStateWidget(context);

  _showPopupWidget(
    Widget child, {
    double? height,
    double? width,
  }) {
    return Dialog(
      child: Container(
        padding: const EdgeInsets.symmetric(
          horizontal: AppPadding.p15,
          vertical: AppPadding.p30,
        ),
        height: height ?? 245,
        width: width ?? double.infinity - 50,
        decoration: BoxDecoration(
          color: ColorManager.whiteNeutral,
          shape: BoxShape.rectangle,
          borderRadius: RadiusSizes.radius16,
        ),
        child: child,
      ),
    );
  }

  Widget _getStateWidget(BuildContext context) {
    switch (stateRendererType) {
      case StateRendererType.popupLoadingState:
        return _showPopupWidget(
          Column(children: [_getAnimatedImage(JsonAssets.loading)]),
          height: 160,
          width: 150,
        );
      case StateRendererType.popupErrorState:
        return _showPopupWidget(
          Column(
            children: [
              _getAnimatedImage(JsonAssets.error),
              _getMessage(message),
              _getRetryButton(AppStrings.ok, context),
            ],
          ),
        );
      case StateRendererType.popupSuccessState:
        return _showPopupWidget(
          Column(
            children: [
              _getAnimatedImage(JsonAssets.success),
              _getMessage(title),
              _getRetryButton(
                AppStrings.ok,
                context,
                title: title,
              ),
            ],
          ),
        );
      case StateRendererType.fullScreenLoadingState:
        return _getFullScreenLoadingWidget(mobileModuleScreen);
      case StateRendererType.toastErrorState:
        return Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            _getSnackBarMessage(message, context),
            _getRetryButton(AppStrings.retryAgain, context),
          ],
        );
      case StateRendererType.fullScreenEmptyState:
        return _getEmptyServersList(context, message);
      case StateRendererType.contentState:
        return Container();
      default:
        return Container();
    }
  }

  Widget _getEmptyServersList(BuildContext context, String message) {
    return Center(child: _getMessage(message));
  }

  Widget _getAnimatedImage(String animationName) {
    return SizedBox(
      height: AppSize.s100,
      width: AppSize.s100,
      child: Lottie.asset(
        animationName,
        repeat: animationName != JsonAssets.loading
            ? Constants.falseBool
            : Constants.trueBool,
      ),
    );
  }

  Widget _getSnackBarMessage(String message, BuildContext context) {
    return Text(
      message,
      style: StylesManager.getRegularStyle(
        color: ColorManager.blackNeutral,
        fontSize: FontSize.sSubtitle5,
      ),
      softWrap: true,
      maxLines: 2,
    );
  }

  Widget _getMessage(String message) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(AppPadding.p8),
        child: Text(
          message,
          textAlign: TextAlign.center,
          style: StylesManager.getRegularStyle(
            fontSize: FontSize.sBody3,
            color: message == AppStrings.servNoServersFound
                ? ColorManager.whiteNeutral
                : ColorManager.blackNeutral,
          ),
        ),
      ),
    );
  }

  Widget _getRetryButton(
    String butonTitle,
    BuildContext context, {
    String? title,
  }) {
    return Center(
      child: TextButton(
        style: TextButton.styleFrom(side: BorderSide.none),
        onPressed: () {
          if (stateRendererType == StateRendererType.toastErrorState) {
            retryActionFunction.call();
          } else {
            Nav.popRoute(context);
            if (title == AppStrings.userDeletedSuccess ||
                title == AppStrings.managerDeletedSuccess ||
                title == AppStrings.userActivatedSuccessfully ||
                title == AppStrings.userExtendedSuccessfully) {
              Nav.popRoute(context);
            }
            if (title == AppStrings.userRenamedSuccess ||
                title == AppStrings.userAddedSuccess ||
                title == AppStrings.managerAddedSuccess ||
                title == AppStrings.userEditedSuccess ||
                title == AppStrings.amountAddedSuccessfully ||
                title == AppStrings.amountDeductedSuccessfully ||
                title == AppStrings.changeAppliedSuccessfully ||
                title == AppStrings.addRewardPointsSuccessfully) {
              Nav.popRoute(context);
              Nav.popRoute(context);
            }

            if (title == AppStrings.userProfileChangedSuccess) {}
          }
        },
        child: Text(
          butonTitle,
          textAlign: stateRendererType == StateRendererType.toastErrorState
              ? TextAlign.right
              : TextAlign.center,
          style: StylesManager.getMediumStyle(
            color: ColorManager.secondary,
            fontSize: AppSize.s14,
          ),
        ),
      ),
    );
  }

  Widget _getFullScreenLoadingWidget(MobileModuleScreen? mobileModuleScreen) {
    // TODO : add shimmer loading for all screens
    switch (mobileModuleScreen) {
      case MobileModuleScreen.dashboard:
        return const DashboardShimmerLoading();
      case MobileModuleScreen.usersList:
        return const UserListShimmerLoading();
      // case MobileModuleScreen.managersList:
      //   return const ManagerListShimmerLoading();
      // case MobileModuleScreen.userDetails:
      //   return const UserDetailsShimmerLoading();
      // case MobileModuleScreen.managerDetails:
      //   return const ManagerDetailsShimmerLoading();

      // case MobileModuleScreen.activationInforms:
      //   return const UserActivationInformsShimmerLoading();

      default:
        return Container();
    }
  }
}
