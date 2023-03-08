import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:lottie/lottie.dart';
import 'package:sasuki/app/app_inits_funs/constants.dart';
import 'package:sasuki/app/resources/other_managers/assets_manager.dart';
import 'package:sasuki/app/resources/other_managers/color_manager.dart';
import 'package:sasuki/app/resources/other_managers/strings_manager.dart';
import 'package:sasuki/app/resources/other_managers/styles_manager.dart';
import 'package:sasuki/app/resources/routes_manager/nav_funcs.dart';
import 'package:sasuki/app/resources/values_manager/app_margin.dart';
import 'package:sasuki/app/resources/values_manager/app_padding.dart';
import 'package:sasuki/app/resources/values_manager/app_size.dart';
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

  Widget _getStateWidget(BuildContext context) {
    switch (stateRendererType) {
      case StateRendererType.popupLoadingState:
        return _getPopUpDialog(
          context,
          [_getAnimatedImage(JsonAssets.loading)],
        );
      case StateRendererType.popupErrorState:
        return _getPopUpDialog(
          context,
          [
            _getAnimatedImage(JsonAssets.error),
            _getMessage(message),
            _getRetryButton(AppStrings.ok, context),
          ],
        );
      case StateRendererType.popupSuccessState:
        return _getPopUpDialog(
          context,
          [
            _getAnimatedImage(JsonAssets.success),
            _getMessage(title),
            _getRetryButton(
              AppStrings.ok,
              context,
              title: title,
            ),
          ],
        );
      case StateRendererType.fullScreenLoadingState:
        return _getFullScreenLoadingWidget(mobileModuleScreen);
      case StateRendererType.toastErrorState:
        return _getSnackBarErrorWidget(
          context,
          [
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

  Widget _getPopUpDialog(BuildContext context, List<Widget> children) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: AppSize.radius10,
      ),
      elevation: AppSize.s1_5,
      backgroundColor: Colors.transparent,
      child: Container(
        decoration: BoxDecoration(
          color: ColorManager.whiteNeutral,
          shape: BoxShape.rectangle,
          borderRadius: AppSize.radius10,
          boxShadow: const [BoxShadow(color: Colors.black26)],
        ),
        child: _getDialogContent(context, children),
      ),
    );
  }

  Widget _getDialogContent(BuildContext context, List<Widget> children) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: children,
    );
  }

  Widget _getEmptyServersList(BuildContext context, String message) {
    return Container(
      margin: const EdgeInsets.only(top: AppMargin.m22),
      child: Center(
        child: Column(
          children: [
            SvgPicture.asset(
              ImageAssets.emptyState,
              height: AppSize.s37,
              width: AppSize.s37,
            ),
            const SizedBox(height: AppSize.s10),
            _getMessage(message, context),
          ],
        ),
      ),
    );
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
    return SizedBox(
      width: AppSize.s230,
      child: Text(
        message,
        style: Theme.of(context).textTheme.bodySmall,
        textAlign: TextAlign.left,
        softWrap: true,
        maxLines: 2,
      ),
    );
  }

  Widget _getMessage(String message, [BuildContext? context]) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(AppPadding.p8),
        child: Text(
          message,
          textAlign: TextAlign.center,
          style: context != null
              ? Theme.of(context).textTheme.titleLarge
              : StylesManager.getRegularStyle(
                  color: ColorManager.blackNeutral,
                  fontSize: AppSize.s18,
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
        style: TextButton.styleFrom(
          side: BorderSide.none,
          textStyle: StylesManager.getMediumStyle(
            color: ColorManager.primaryshade1,
            fontSize: AppSize.s12,
          ),
        ),
        onPressed: () {
          if (stateRendererType == StateRendererType.toastErrorState) {
            retryActionFunction.call();
          } else {
            Nav.popRoute(context);
            if (title == AppStrings.userDeletedSuccess ||
                title == AppStrings.managerDeletedSuccess) {
              Nav.popRoute(context);
            }
            if (title == AppStrings.userRenamedSuccess) {
              Nav.popRoute(context);
              Nav.popRoute(context);
            }
            if (title == AppStrings.userAddedSuccess) {
              Nav.popRoute(context);
              Nav.popRoute(context);
            }
            if (title == AppStrings.managerAddedSuccess) {
              Nav.popRoute(context);
              Nav.popRoute(context);
            }

            if (title == AppStrings.userEditedSuccess) {
              Nav.popRoute(context);
              Nav.popRoute(context);
            }

            if (title == AppStrings.userProfileChangedSuccess) {}
            if (title == AppStrings.userActivatedSuccessfully) {
              Nav.popRoute(context);
            }
            if (title == AppStrings.userExtendedSuccessfully) {
              Nav.popRoute(context);
            }
            if (title == AppStrings.amountAddedSuccessfully) {
              Nav.popRoute(context);
              Nav.popRoute(context);
            }
            if (title == AppStrings.amountDeductedSuccessfully) {
              Nav.popRoute(context);
              Nav.popRoute(context);
            }
            if (title == AppStrings.changeAppliedSuccessfully) {
              Nav.popRoute(context);
              Nav.popRoute(context);
            }
            if (title == AppStrings.addRewardPointsSuccessfully) {
              Nav.popRoute(context);
              Nav.popRoute(context);
            }
          }
        },
        child: Text(
          butonTitle,
          style: StylesManager.getMediumStyle(
            color: ColorManager.primaryshade1,
            fontSize: stateRendererType == StateRendererType.toastErrorState
                ? AppSize.s16
                : AppSize.s20,
          ),
        ),
      ),
    );
  }

  Widget _getFullScreenLoadingWidget(MobileModuleScreen? mobileModuleScreen) {
    // TODO : add shimmer loading for all screens
    // switch (mobileModuleScreen) {
    //   case MobileModuleScreen.dashboard:
    //     return DashboardShimmerLoading();
    //   case MobileModuleScreen.usersList:
    //     return const UserListShimmerLoading();
    //   case MobileModuleScreen.managersList:
    //     return const ManagerListShimmerLoading();
    //   case MobileModuleScreen.userDetails:
    //     return const UserDetailsShimmerLoading();
    //   case MobileModuleScreen.managerDetails:
    //     return const ManagerDetailsShimmerLoading();

    //   case MobileModuleScreen.activationInforms:
    //     return const UserActivationInformsShimmerLoading();

    //   default:
    //     return Container();
    // }
    return Container();
  }

  Widget _getSnackBarErrorWidget(BuildContext context, List<Widget> children) {
    return SizedBox(
      height: AppSize.s50,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: children,
      ),
    );
  }
}
