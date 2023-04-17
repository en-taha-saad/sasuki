import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:sasuki/app/app_inits_funs/constants.dart';
import 'package:sasuki/app/init_screens_dependencies/init_app_module.dart';
import 'package:sasuki/app/resources/other_managers/assets_manager.dart';
import 'package:sasuki/app/resources/other_managers/color_manager.dart';
import 'package:sasuki/app/resources/other_managers/strings_manager.dart';
import 'package:sasuki/app/resources/routes_manager/nav_funcs.dart';
import 'package:sasuki/app/resources/values_manager/app_margin.dart';
import 'package:sasuki/app/resources/values_manager/app_size.dart';
import 'package:sasuki/app/shared_widgets/elevated_button_widget.dart';
import 'package:sasuki/app/shared_widgets/get_addedit_text_field.dart';
import 'package:sasuki/app/shared_widgets/password_input.dart';
import 'package:sasuki/app/shared_widgets/shared_dropdown.dart';
import 'package:sasuki/domain/models/dashboard/auth.dart';
import 'package:sasuki/domain/models/dashboard/dashboard.dart';
import 'package:sasuki/domain/models/filter_lists/parent_list.dart';
import 'package:sasuki/domain/models/filter_lists/profile_list.dart';
import 'package:sasuki/domain/models/user_details/user_overview_api.dart';
import 'package:sasuki/presentation/common/state_render/states/flow_state.dart';
import 'package:sasuki/presentation/dashboard/viewmodel/dashboard_viewmodel.dart';
import 'package:sasuki/presentation/edit_user/viewmodel/edit_user_viewmodel.dart';
import 'package:sasuki/presentation/common/state_render/states/flow_state_extension.dart';
import 'package:sasuki/presentation/user_details/viewmodel/user_details_viewmodel.dart';
import 'package:sasuki/presentation/users_list/viewmodel/users_list_viewmodel.dart';

class EditUser extends StatefulWidget {
  const EditUser({Key? key}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _EditUserState createState() => _EditUserState();
}

class _EditUserState extends State<EditUser> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _firstNameController = TextEditingController();
  final TextEditingController _lastNameController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _notesController = TextEditingController();
  final UserDetailsViewModel _userDetailsViewModel =
      instance<UserDetailsViewModel>();
  final UsersListViewModel _usersListViewModel = instance<UsersListViewModel>();

  final EditUserViewModel _editUserViewModel = instance<EditUserViewModel>();
  final DashboardViewModel _dashboardViewModel = instance<DashboardViewModel>();
  UserOverviewApi? userOverviewApiVar;
  Dashboard? dashboardVar;
  List<ProfileData>? profileList;
  List<SingleParentData>? parentList;
  Auth? userAuth;

  ProfileData? selectedprofile;
  SingleParentData? selectedparent;

  _bind() {
    _editUserViewModel.start();
    _dashboardViewModel.getDataStreamingly();
    _userDetailsViewModel.getUserDataStreamingly();
    _usersListViewModel.getUsersListForPull();
    _dashboardViewModel.outputDashboardData.listen(
      (event) {
        if (mounted) {
          // check whether the state object is in tree
          setState(() => dashboardVar = event);
        }
      },
    );
    _dashboardViewModel.outputAuthData.listen(
      (event) {
        if (mounted) {
          // check whether the state object is in tree
          setState(() => userAuth = event);
        }
      },
    );

    _usernameController.addListener(
      () {
        _editUserViewModel.setUsername(_usernameController.text);
      },
    );
    _passwordController.addListener(
      () {
        _editUserViewModel.setPassword(_passwordController.text);
      },
    );
    _firstNameController.addListener(
      () {
        _editUserViewModel.setFirstName(_firstNameController.text);
      },
    );
    _lastNameController.addListener(
      () {
        _editUserViewModel.setLastName(_lastNameController.text);
      },
    );
    _phoneController.addListener(
      () {
        _editUserViewModel.setPhone(_phoneController.text);
      },
    );
    _notesController.addListener(
      () {
        _editUserViewModel.setNotes(_notesController.text);
      },
    );
    _userDetailsViewModel.outputUserOverviewApi.listen(
      (event) {
        if (mounted) {
          // check whether the state object is in tree
          setState(() => userOverviewApiVar = event);
          _usernameController.text =
              userOverviewApiVar?.data?.username ?? Constants.emptyStr;
          _passwordController.text =
              userOverviewApiVar?.data?.password ?? Constants.emptyStr;
          _firstNameController.text =
              userOverviewApiVar?.data?.firstname ?? Constants.emptyStr;
          _lastNameController.text =
              userOverviewApiVar?.data?.lastname ?? Constants.emptyStr;
          _phoneController.text =
              userOverviewApiVar?.data?.phone ?? Constants.emptyStr;
        }
      },
    );
    _usersListViewModel.outputUsersList.listen(
      (event) {
        if (mounted) {
          // check whether the state object is in tree
          event?.forEach((element) {
            if (element.username == userOverviewApiVar?.data?.username) {
              setState(() {
                _notesController.text = element.notes;
              });
            }
          });
        }
      },
    );
  }

  @override
  void dispose() {
    _dashboardViewModel.dispose();
    _editUserViewModel.dispose();
    super.dispose();
  }

  @override
  void initState() {
    _bind();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<FlowState>(
      stream: _editUserViewModel.outputState,
      builder: (context, AsyncSnapshot<FlowState> snapshot) {
        return snapshot.data?.getScreenWidget(
              context,
              _getScreenView(context),
              () async {
                ScaffoldMessenger.of(context).hideCurrentSnackBar();
                _editUserViewModel.editUser();
              },
            ) ??
            _getScreenView(context);
      },
    );
  }

  Widget _getScreenView(context) {
    return Column(
      children: [
        AppSize.statusBarHeight(context),
        Container(
          margin: const EdgeInsets.only(
            right: AppMargin.m25,
            left: AppMargin.m25,
            bottom: AppMargin.m5,
          ),
          child: AppBar(
            elevation: AppSize.s0,
            backgroundColor: Colors.transparent,
            centerTitle: Constants.trueBool,
            titleTextStyle: Theme.of(context).textTheme.headlineMedium,
            leading: Container(
              margin: const EdgeInsets.only(
                right: AppMargin.m20,
              ),
              child: IconButton(
                icon: SvgPicture.asset(IconsAssets.back),
                onPressed: () => Nav.popRoute(context),
              ),
            ),
            title: Text(
              AppStrings.updateUserTitle,
              style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                    fontSize: 18,
                  ),
            ),
          ),
        ),
        Expanded(
          child: Container(
            width: MediaQuery.of(context).size.width,
            color: ColorManager.secondary,
            child: _getEditUserContent(),
          ),
        ),
      ],
    );
  }

  _getEditUserContent() {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Container(
            margin: const EdgeInsets.all(AppSize.s25),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  margin: const EdgeInsets.only(right: AppSize.s10),
                  child: SvgPicture.asset(
                    IconsAssets.edit,
                    theme: const SvgTheme(
                      currentColor: ColorManager.greyNeutral2,
                    ),
                    // ignore: deprecated_member_use
                    color: ColorManager.greyNeutral2,
                  ),
                ),
                Text(
                  AppStrings.editCurrentUserTitle,
                  style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                        color: ColorManager.greyNeutral2,
                      ),
                ),
              ],
            ),
          ),
          Container(
            margin: const EdgeInsets.only(
              right: AppMargin.m25,
              left: AppMargin.m25,
            ),
            child: Column(
              children: [
                Container(
                  margin: const EdgeInsets.only(bottom: AppMargin.m25),
                  child: getAddEditTextFieldInput(
                    context,
                    _usernameController,
                    (val) {
                      FocusScope.of(context).unfocus();
                    },
                    AppStrings.servUsername,
                    Constants.falseBool,
                    TextInputType.text,
                    Constants.trueBool,
                    Constants.trueBool,
                    Constants.falseBool,
                  ),
                ),
                Container(
                  margin: const EdgeInsets.only(
                    bottom: AppMargin.m25,
                  ),
                  child: PasswordTextInput(
                    stream: _editUserViewModel.outputIsPasswordValid,
                    controller: _passwordController,
                    // controller: rememberMe == true ? null : _userPasswordController,
                    inputLabel: AppStrings.servPassword,
                    inputHint: Constants.emptyStr,
                    errorText: AppStrings.servInvalidPassword,
                    autofocus: Constants.falseBool,
                    showPassword: Constants.trueBool,
                    isRequired: Constants.trueBool,
                  ),
                ),

                _getProfileDropdown(context),
                _getParentDropdown(context),
                Container(
                  margin: const EdgeInsets.only(
                    bottom: AppMargin.m25,
                  ),
                  child: Divider(
                    height: AppSize.s0_2,
                    thickness: AppSize.s0_5,
                    color: ColorManager.greyNeutral.withOpacity(0.25),
                  ),
                ),

                ///
                Container(
                  margin: const EdgeInsets.only(bottom: AppMargin.m25),
                  child: getAddEditTextFieldInput(
                    context,
                    _firstNameController,
                    (val) {
                      FocusScope.of(context).unfocus();
                    },
                    AppStrings.userFirstNameHint,
                    Constants.falseBool,
                  ),
                ),
                Container(
                  margin: const EdgeInsets.only(bottom: AppMargin.m25),
                  child: getAddEditTextFieldInput(
                    context,
                    _lastNameController,
                    (val) {
                      FocusScope.of(context).unfocus();
                    },
                    AppStrings.userLastNameHint,
                    Constants.falseBool,
                  ),
                ),
                getAddEditTextFieldInput(
                  context,
                  _phoneController,
                  (val) {
                    FocusScope.of(context).unfocus();
                  },
                  AppStrings.userPhoneHint,
                  Constants.falseBool,
                ),

                ///
                Container(
                  margin: const EdgeInsets.only(
                    top: AppMargin.m35,
                    bottom: AppMargin.m50,
                  ),
                  child: StreamBuilder<bool>(
                    stream: _editUserViewModel.outputAreAllInputsValid,
                    builder: (context, snapshot) {
                      return ElevatedButtonWidget(
                        name: AppStrings.userActionSubmitButton,
                        assetName: IconsAssets.forward,
                        onPressed: () {
                          debugPrint("snapshot.data = ${snapshot.data}");

                          FocusScope.of(context).unfocus();

                          debugPrint(
                              "selectedparent = ${selectedparent?.username}");
                          debugPrint(
                              "selectedprofile = ${selectedprofile?.name}");
                          setState(() {});
                          if (selectedparent == Constants.nullValue) {
                            selectedparent = _getParentUsername(
                              userAuth?.client?.username,
                            );
                          }
                          if (selectedprofile == Constants.nullValue) {
                            selectedprofile = _getProfileUsername(
                              userOverviewApiVar?.data?.profileName,
                            );
                          }
                          debugPrint(
                              "selectedparent = ${selectedparent?.username}");
                          debugPrint(
                              "selectedprofile = ${selectedprofile?.name}");

                          _editUserViewModel.saveFloatingButton(
                            selectedparent,
                            selectedprofile,
                          );
                        },
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  SingleParentData? _getParentUsername(parentUsername) {
    return parentList
        ?.firstWhere((element) => element.username == parentUsername);
  }

  ProfileData? _getProfileUsername(profileUsername) {
    return profileList
        ?.firstWhere((element) => element.name == profileUsername);
  }

  _getParentDropdown(context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Row(
          children: [
            Text(
              "*",
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                    color: ColorManager.orangeAnnotations2,
                  ),
            ),
            const SizedBox(width: AppSize.s5),
            Text(
              AppStrings.usersParent,
              style: Theme.of(context).textTheme.labelLarge?.copyWith(
                    height: AppSize.s0_7,
                  ),
            ),
          ],
        ),
        Container(
          margin: const EdgeInsets.only(
            top: AppMargin.m10,
            bottom: AppMargin.m25,
          ),
          child: StreamBuilder<List<SingleParentData>?>(
            stream: _editUserViewModel.outputParentList,
            builder: (_, snapshot0) {
              if (parentList == Constants.nullValue ||
                  parentList?.length == Constants.zeroNum) {
                parentList = snapshot0.data;
              }
              debugPrint("parentList: $parentList");
              // ignore: prefer_is_empty
              return DropDownComponent<SingleParentData?>(
                isThisServersDropdown: Constants.falseBool,
                hintStr: userOverviewApiVar?.data?.parentUsername ??
                    AppStrings.usersParentHint,
                items: parentList ?? [],
                doOtherThings: (val) {
                  selectedparent = val;
                },
                displayFn: (item) => (item as SingleParentData).username,
                textAndHintColor: ColorManager.whiteNeutral,
              );
            },
          ),
        ),
      ],
    );
  }

  _getProfileDropdown(context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Row(
          children: [
            Text(
              "*",
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                    color: ColorManager.orangeAnnotations2,
                  ),
            ),
            const SizedBox(width: AppSize.s5),
            Text(
              AppStrings.usersProfile,
              style: Theme.of(context).textTheme.labelLarge?.copyWith(
                    height: AppSize.s0_7,
                  ),
            ),
          ],
        ),
        Container(
          margin: const EdgeInsets.only(
            top: AppMargin.m10,
            bottom: AppMargin.m25,
          ),
          child: StreamBuilder<List<ProfileData>>(
            stream: _editUserViewModel.outputProfileList,
            builder: (_, snapshot0) {
              if (profileList == Constants.nullValue ||
                  profileList?.length == Constants.zeroNum) {
                profileList = snapshot0.data;
              }
              debugPrint("profileList: $profileList");
              // ignore: prefer_is_empty
              return DropDownComponent<ProfileData?>(
                isThisServersDropdown: Constants.falseBool,
                hintStr: userOverviewApiVar?.data?.profileName ??
                    AppStrings.usersProfileHint,
                items: profileList ?? [],
                doOtherThings: (val) {
                  selectedprofile = val;
                },
                displayFn: (item) => (item as ProfileData).name,
                textAndHintColor: ColorManager.whiteNeutral,
              );
            },
          ),
        ),
      ],
    );
  }
}
