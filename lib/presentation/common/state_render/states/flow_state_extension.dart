import 'package:flutter/material.dart';
import 'package:sasuki/app/app_inits_funs/app_prefs.dart';
import 'package:sasuki/app/app_inits_funs/constants.dart';
import 'package:sasuki/app/init_screens_dependencies/init_app_module.dart';
import 'package:sasuki/app/init_screens_dependencies/init_choose_server_module.dart';
import 'package:sasuki/app/init_screens_dependencies/init_login_module.dart';
import 'package:sasuki/app/resources/other_managers/color_manager.dart';
import 'package:sasuki/app/resources/other_managers/strings_manager.dart';
import 'package:sasuki/app/resources/routes_manager/nav_funcs.dart';
import 'package:sasuki/app/resources/routes_manager/routes.dart';
import 'package:sasuki/app/resources/values_manager/app_padding.dart';
import 'package:sasuki/app/resources/values_manager/app_size.dart';
import 'package:sasuki/presentation/common/state_render/state_renderer.dart';
import 'package:sasuki/presentation/common/state_render/states/content_state.dart';
import 'package:sasuki/presentation/common/state_render/states/empty_state.dart';
import 'package:sasuki/presentation/common/state_render/states/error_state.dart';
import 'package:sasuki/presentation/common/state_render/states/flow_state.dart';
import 'package:sasuki/presentation/common/state_render/states/loading_state.dart';
import 'package:sasuki/presentation/common/state_render/states/state_renderer_type.dart';

final AppPreferences _appPrefs = instance<AppPreferences>();

extension FlowStateExtension on FlowState {
  Widget getScreenWidget(
    BuildContext context,
    Widget contentScreenWidget,
    Function retryActionFunction,
  ) {
    switch (runtimeType) {
      case LoadingState:
        if (getStateRendererType() == StateRendererType.popupLoadingState) {
          // show popup loading
          showPopup(
            context,
            getStateRendererType(),
            getMessage(),
          );
          // show content screen
          return contentScreenWidget;
        } else if (getStateRendererType() ==
            StateRendererType.popupSuccessState) {
          // show popup success
          if (getMessage() == AppStrings.userDeletedSuccess ||
              getMessage() == AppStrings.managerDeletedSuccess) {
            dismissDialog(context);
          } else {
            WidgetsBinding.instance.addPostFrameCallback(
              (_) {
                dismissDialog(context);
              },
            );
          }
          showPopup(
            context,
            getStateRendererType(),
            getMessage(),
            title: getMessage(),
          );
          // show content screen
          return contentScreenWidget;
        } else {
          // show full screen loading
          return StateRenderer(
            mobileModuleScreen: getMobileModuleScreen(),
            stateRendererType: getStateRendererType(),
            message: getMessage(),
            retryActionFunction: retryActionFunction,
          );
        }
      case EmptyState:
        // show full screen empty
        return StateRenderer(
          stateRendererType: getStateRendererType(),
          message: getMessage(),
          retryActionFunction: retryActionFunction,
        );

      case ErrorState:
        {
          dismissDialog(context);
          WidgetsBinding.instance.addPostFrameCallback(
            (_) {
              dismissDialog(context);
            },
          );

          if (getStateRendererType() == StateRendererType.popupErrorState) {
            // show popup error
            showPopup(
              context,
              getStateRendererType(),
              getMessage(),
            );
            // show content screen
            return contentScreenWidget;
          } else {
            // show toast retry screen error
            showSnackBar(
              context,
              getStateRendererType(),
              getMessage(),
              retryActionFunction,
            );
            // show content screen
            return contentScreenWidget;
          }
        }

      case ContentState:
        {
          // show full screen content
          // dismissDialog(context);
          return contentScreenWidget;
        }
      default:
        {
          // show full screen content
          dismissDialog(context);
          return contentScreenWidget;
        }
    }
  }

  _isCurrentDialogShowing(BuildContext context) =>
      ModalRoute.of(context)?.isCurrent != true;

  dismissDialog(BuildContext context) {
    if (_isCurrentDialogShowing(context)) {
      Nav.popRoute(context);
    }
  }

  showPopup(
    BuildContext context,
    StateRendererType stateRendererType,
    String message, {
    String title = Constants.emptyStr,
    Function? retryActionFunction,
  }) {
    WidgetsBinding.instance.addPostFrameCallback(
      (_) {
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return StateRenderer(
              stateRendererType: stateRendererType,
              message: message,
              title: title,
              retryActionFunction: retryActionFunction ?? () {},
            );
          },
        );
      },
    );
  }

  showSnackBar(BuildContext context, StateRendererType stateRendererType,
      String message, retryActionFunction,
      {String title = Constants.emptyStr}) {
    WidgetsBinding.instance.addPostFrameCallback(
      (_) {
        if (message.contains("unauthorised")) {
          _appPrefs.removeIsUserLoggedInStatus();
          _appPrefs.removeToken();
          initChooseServerModule();
          initLoginModule();
          WidgetsBinding.instance.addPostFrameCallback(
            (_) {
              Navigator.pushNamedAndRemoveUntil(
                context,
                Routes.loginRoute,
                (Route<dynamic> route) => true,
              );
            },
          );
          return;
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              shape: RoundedRectangleBorder(
                borderRadius: AppSize.radius10,
              ),
              elevation: AppSize.s1_5,
              backgroundColor: ColorManager.whiteNeutral,
              dismissDirection: DismissDirection.vertical,
              duration: const Duration(seconds: Constants.snackBarDelay),
              padding: const EdgeInsets.symmetric(
                horizontal: AppPadding.p8,
                vertical: AppPadding.p4,
              ),
              behavior: SnackBarBehavior.floating,
              content: StateRenderer(
                stateRendererType: stateRendererType,
                message: message,
                title: title,
                retryActionFunction: retryActionFunction,
              ),
            ),
          );
        }
      },
    );
  }
}
