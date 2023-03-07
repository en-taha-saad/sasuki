class ImagePaths {
  /// paths
  static const String assetsPath = "assets/";
  static const String imagesPath = "${assetsPath}images/";
  static const String iconsPath = "${assetsPath}icons/";
  static const String drawerIconsPath = "${iconsPath}drawer/";
  static const String specificScreenIconsPath = "${iconsPath}specific_screen/";
  static const String sharedIconsPath = "${iconsPath}shared_icons/";
}

class ImageAssets {
  static const String emptyState = "${ImagePaths.imagesPath}empty_state.svg";
  static const String mainLogo = "${ImagePaths.imagesPath}main_logo.png";
  static const String secondaryLogo =
      "${ImagePaths.imagesPath}secondary_logo.svg";
  static const String teritaryLogo =
      "${ImagePaths.imagesPath}teritary_logo.svg";
}

class IconsAssets {
  /// Drawer Icons
  static const String dashboard = "${ImagePaths.drawerIconsPath}dashboard.svg";
  static const String usersList = "${ImagePaths.drawerIconsPath}users_list.svg";
  static const String managers = "${ImagePaths.drawerIconsPath}managers.svg";
  static const String reports = "${ImagePaths.drawerIconsPath}reports.svg";
  static const String deposit = "${ImagePaths.drawerIconsPath}deposit.svg";
  static const String logout = "${ImagePaths.drawerIconsPath}logout.svg";

  /// Shared Icons
  static const String actions = "${ImagePaths.sharedIconsPath}actions.svg";
  static const String back = "${ImagePaths.sharedIconsPath}back.svg";
  static const String edit = "${ImagePaths.sharedIconsPath}edit.svg";
  static const String filter = "${ImagePaths.sharedIconsPath}filter.svg";
  static const String information =
      "${ImagePaths.sharedIconsPath}information.svg";
  static const String person = "${ImagePaths.sharedIconsPath}person.svg";
  static const String add = "${ImagePaths.sharedIconsPath}add.svg";
  static const String dropdown = "${ImagePaths.sharedIconsPath}dropdown.svg";
  static const String exit = "${ImagePaths.sharedIconsPath}exit.svg";
  static const String forward = "${ImagePaths.sharedIconsPath}forward.svg";
  static const String menu = "${ImagePaths.sharedIconsPath}menu.svg";
  static const String search = "${ImagePaths.sharedIconsPath}search.svg";

  /// Specific Screen Icons
  static const String activateUserService =
      "${ImagePaths.specificScreenIconsPath}activate_user_service.svg";
  static const String extendUserService =
      "${ImagePaths.specificScreenIconsPath}extend_user_service.svg";
  static const String dashboardSalesAndFinance =
      "${ImagePaths.specificScreenIconsPath}dashboard_sales_and_finance.svg";
  static const String userServiceInformation =
      "${ImagePaths.specificScreenIconsPath}user_service_information.svg";
  static const String dashboardUserStatistics =
      "${ImagePaths.specificScreenIconsPath}dashboard_user_statistics.svg";
}

class JsonAssets {
  // TODO add your JsonAssets
}
