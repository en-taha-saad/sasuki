import 'package:flutter/material.dart';
import 'package:sasuki/app/init_screens_dependencies/init_activity_log_module.dart';
import 'package:sasuki/app/init_screens_dependencies/init_add_manager_module.dart';
import 'package:sasuki/app/init_screens_dependencies/init_add_server_module.dart';
import 'package:sasuki/app/init_screens_dependencies/init_add_user_module.dart';
import 'package:sasuki/app/init_screens_dependencies/init_choose_server_module.dart';
import 'package:sasuki/app/init_screens_dependencies/init_dashboard_module.dart';
import 'package:sasuki/app/init_screens_dependencies/init_deposit_payment_module.dart';
import 'package:sasuki/app/init_screens_dependencies/init_edit_manager_module.dart';
import 'package:sasuki/app/init_screens_dependencies/init_edit_user_module.dart';
import 'package:sasuki/app/init_screens_dependencies/init_extend_user_module.dart';
import 'package:sasuki/app/init_screens_dependencies/init_login_module.dart';
import 'package:sasuki/app/init_screens_dependencies/init_manager_details_module.dart';
import 'package:sasuki/app/init_screens_dependencies/init_managers_invoices_module.dart';
import 'package:sasuki/app/init_screens_dependencies/init_managers_journal_module.dart';
import 'package:sasuki/app/init_screens_dependencies/init_managers_list_module.dart';
import 'package:sasuki/app/init_screens_dependencies/init_reports_activations_module.dart';
import 'package:sasuki/app/init_screens_dependencies/init_user_activation_module.dart';
import 'package:sasuki/app/init_screens_dependencies/init_user_details_module.dart';
import 'package:sasuki/app/init_screens_dependencies/init_users_list_module.dart';
import 'package:sasuki/app/resources/other_managers/strings_manager.dart';
import 'package:sasuki/app/resources/routes_manager/routes.dart';
import 'package:sasuki/app/shared_funs/create_route.dart';
import 'package:sasuki/app/shared_widgets/app_background.dart';
import 'package:sasuki/presentation/about/about_view.dart';
import 'package:sasuki/presentation/activity_log/view/activity_log_view.dart';
import 'package:sasuki/presentation/add_manager/view/add_manager_view.dart';
import 'package:sasuki/presentation/add_server/view/add_server_view.dart';
import 'package:sasuki/presentation/add_user/view/add_user_view.dart';
import 'package:sasuki/presentation/choose_server/view/choose_server_view.dart';
import 'package:sasuki/presentation/dashboard/view/dashboard_view.dart';
import 'package:sasuki/presentation/deposit_screen/view/deposit_screen_view.dart';
import 'package:sasuki/presentation/drawer/drawer_view.dart';
import 'package:sasuki/presentation/edit_manager/view/edit_manager_view.dart';
import 'package:sasuki/presentation/edit_user/view/edit_user_view.dart';
import 'package:sasuki/presentation/extend_user/view/extend_user_view.dart';
import 'package:sasuki/presentation/login/view/login_view.dart';
import 'package:sasuki/presentation/manager_details/view/manager_details.dart';
import 'package:sasuki/presentation/managers_invoices/view/managers_invoices.dart';
import 'package:sasuki/presentation/managers_journal/view/managers_journal.dart';
import 'package:sasuki/presentation/managers_list/view/managers_list_view.dart';
import 'package:sasuki/presentation/reports_activations/view/reports_activations.dart';
import 'package:sasuki/presentation/single_activation/single_activation.dart';
import 'package:sasuki/presentation/single_invoice/single_invoice.dart';
import 'package:sasuki/presentation/single_journal/single_journal.dart';
import 'package:sasuki/presentation/splash/splash_view.dart';
import 'package:sasuki/presentation/user_activation/view/user_activation_view.dart';
import 'package:sasuki/presentation/user_details/view/user_details.dart';
import 'package:sasuki/presentation/users_list/view/users_list_view.dart';

class RouteGenerator {
  static Route<dynamic> getRoute(RouteSettings settings) {
    switch (settings.name) {
      case Routes.drawerRoute:
        return createRoute(
          AppBackground(child: DrawerView(settings.arguments)),
        );

      case Routes.splashRoute:
        return MaterialPageRoute(
          builder: (_) => const AppBackground(
            child: SplashView(),
          ),
          settings: settings,
        );
      case Routes.chooseServerRoute:
        initChooseServerModule();
        return MaterialPageRoute(
          builder: (_) => const AppBackground(
            child: ChooseServerView(),
          ),
        );
      case Routes.addServerRoute:
        initAddServerModule();
        return MaterialPageRoute(
          builder: (_) => const AppBackground(
            resizeToAvoidBottomInset: false,
            child: AddServerView(),
          ),
        );
      case Routes.dashboardRoute:
        initDashboardModule();
        return MaterialPageRoute(
          builder: (_) => const AppBackground(
            child: DashboardView(),
          ),
          settings: settings,
        );

      case Routes.loginRoute:
        initLoginModule();
        return MaterialPageRoute(
          builder: (_) => const AppBackground(
            resizeToAvoidBottomInset: false,
            child: LoginView(),
          ),
        );
      case Routes.usersListRoute:
        initUsersListModule();
        return MaterialPageRoute(
          builder: (_) => const AppBackground(
            child: UsersListView(),
          ),
          settings: settings,
        );
      case Routes.userDetailsRoute:
        initUserDetailsModule();
        return MaterialPageRoute(
          builder: (_) => const AppBackground(
            child: UserDetailsView(),
          ),
          settings: settings,
        );
      case Routes.extendUserRoute:
        initExtendUserModule();
        return MaterialPageRoute(
          builder: (_) => const AppBackground(
            child: ExtendUserView(),
          ),
          settings: settings,
        );
      case Routes.userActivationInformsRoute:
        initUserActivationModule();

        return MaterialPageRoute(
          builder: (_) => const AppBackground(
            child: UserActivationView(),
          ),
          settings: settings,
        );
      case Routes.addUserRoute:
        initAddUserModule();
        return MaterialPageRoute(
          builder: (_) => const AppBackground(
            child: AddUser(),
          ),
          settings: settings,
        );
      case Routes.editUserRoute:
        initEditUserModule();
        return MaterialPageRoute(
          builder: (_) => const AppBackground(
            child: EditUser(),
          ),
          settings: settings,
        );
      case Routes.managersListRoute:
        initManagersListModule();
        return MaterialPageRoute(
          builder: (_) => const AppBackground(
            child: ManagersListView(),
          ),
          settings: settings,
        );
      case Routes.managerDetailsRoute:
        initManagerDetailsModule();
        return MaterialPageRoute(
          builder: (_) => const AppBackground(
            child: ManagerDetailsView(),
          ),
          settings: settings,
        );
      case Routes.editManagerRoute:
        initEditManagerModule();
        return MaterialPageRoute(
          builder: (_) => const AppBackground(
            child: EditManager(),
          ),
          settings: settings,
        );
      case Routes.addManagerRoute:
        initAddManagerModule();
        return MaterialPageRoute(
          builder: (_) => const AppBackground(
            child: AddManager(),
          ),
          settings: settings,
        );

      ///
      case Routes.reportsActivationsRoute:
        initReportsActivationsModule();
        return MaterialPageRoute(
          builder: (_) => const AppBackground(
            child: ReportsActivationsView(),
          ),
          settings: settings,
        );
      case Routes.singleReportsActivationsRoute:
        return MaterialPageRoute(
          builder: (_) => const AppBackground(
            child: SingleActivationView(),
          ),
          settings: settings,
        );

      ///
      case Routes.reportsInvoicesRoute:
        initManagersInvoicesModule();
        return MaterialPageRoute(
          builder: (_) => const AppBackground(
            child: ManagersInvoicesView(),
          ),
          settings: settings,
        );
      case Routes.singleReportsInvoicesRoute:
        return MaterialPageRoute(
          builder: (_) => const AppBackground(
            child: SingleInvoiceView(),
          ),
          settings: settings,
        );

      ///
      case Routes.reportsJournalRoute:
        initManagersJournalModule();
        return MaterialPageRoute(
          builder: (_) => const AppBackground(
            child: ManagersJournalView(),
          ),
          settings: settings,
        );
      case Routes.singleReportsJournalRoute:
        return MaterialPageRoute(
          builder: (_) => const AppBackground(
            child: SingleJournalView(),
          ),
          settings: settings,
        );
      case Routes.depositPaymentRoute:
        initAdDepositPaymentdManagerModule();
        return MaterialPageRoute(
          builder: (_) => const AppBackground(
            child: DepositScreen(),
          ),
          settings: settings,
        );

      case Routes.activityLogsRoute:
        initActivityLogModule();
        return MaterialPageRoute(
          builder: (_) => const AppBackground(
            child: ActivityLogView(),
          ),
          settings: settings,
        );
      case Routes.aboutRoute:
        return MaterialPageRoute(
          builder: (_) => const AppBackground(
            child: AboutView(),
          ),
          settings: settings,
        );

      default:
        return unDefinedRoute();
    }
  }

  static Route<dynamic> unDefinedRoute() {
    return MaterialPageRoute(
      builder: (_) => const AppBackground(
        child: Center(
          child: Text(AppStrings.noRouteFound),
        ),
      ),
    );
  }
}
