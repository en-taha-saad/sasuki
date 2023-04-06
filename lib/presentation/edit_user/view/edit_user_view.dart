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
import 'package:sasuki/app/shared_widgets/card_title.dart';
import 'package:sasuki/app/shared_widgets/elevated_button_widget.dart';
import 'package:sasuki/app/shared_widgets/get_addedit_text_field.dart';
import 'package:sasuki/app/shared_widgets/password_input.dart';
import 'package:sasuki/app/shared_widgets/shared_dropdown.dart';
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
            leadingWidth: AppSize.s10,
            titleTextStyle: Theme.of(context).textTheme.headlineMedium,
            leading: InkWell(
              child: SvgPicture.asset(IconsAssets.back),
              onTap: () => Nav.popRoute(context),
            ),
            title: Text(
              AppStrings.addEditUserTitle,
              style: Theme.of(context).textTheme.headlineMedium,
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
          getCardTitle(
            IconsAssets.edit,
            AppStrings.editCurrentUserTitle,
            context,
          ),
          Container(
            margin: const EdgeInsets.only(
              right: AppMargin.m25,
              left: AppMargin.m25,
            ),
            child: Column(
              children: [
                Container(
                  margin: const EdgeInsets.only(
                    bottom: AppMargin.m25,
                    top: AppMargin.m25,
                  ),
                  child: StreamBuilder<bool>(
                    stream: _editUserViewModel.outputIsUsernameValid,
                    builder: (context, snapshot) {
                      return getAddEditTextFieldInput(
                        context,
                        _usernameController,
                        (val) {
                          FocusScope.of(context).unfocus();
                        },
                        AppStrings.servUsername,
                        Constants.trueBool,
                        TextInputType.text,
                        snapshot.data,
                      );
                    },
                  ),
                ),
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
                Container(
                  margin: const EdgeInsets.only(bottom: AppMargin.m25),
                  child: getAddEditTextFieldInput(
                    context,
                    _phoneController,
                    (val) {
                      FocusScope.of(context).unfocus();
                    },
                    AppStrings.userPhoneHint,
                    Constants.falseBool,
                  ),
                ),
                PasswordTextInput(
                  stream: _editUserViewModel.outputIsPasswordValid,
                  controller: _passwordController,
                  // controller: rememberMe == true ? null : _userPasswordController,
                  inputLabel: AppStrings.servPassword,
                  inputHint: Constants.emptyStr,
                  errorText: AppStrings.servInvalidPassword,
                  autofocus: Constants.falseBool,
                  showPassword: Constants.trueBool,
                ),
                Container(
                  margin: const EdgeInsets.only(
                    bottom: AppMargin.m25,
                    top: AppMargin.m25,
                  ),
                  child: const Divider(
                    height: AppSize.s0_2,
                    thickness: AppSize.s0_5,
                    color: ColorManager.primaryshade1,
                  ),
                ),
                _getProfileDropdown(
                  AppStrings.usersProfile,
                  context,
                ),
                _getParentDropdown(
                  AppStrings.usersParent,
                  context,
                ),
                Container(
                  margin: const EdgeInsets.only(
                    top: AppMargin.m40,
                    bottom: AppMargin.m50,
                  ),
                  child: StreamBuilder<bool>(
                    stream: _editUserViewModel.outputAreAllInputsValid,
                    builder: (context, snapshot) {
                      return ElevatedButtonWidget(
                        name: AppStrings.addUserTitle,
                        assetName: IconsAssets.forward,
                        onPressed: () {
                          FocusScope.of(context).unfocus();
                          bool isTextInputsValid =
                              snapshot.data ?? Constants.falseBool;
                          setState(() {});
                          _editUserViewModel.saveFloatingButton(
                            isTextInputsValid,
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

  _getParentDropdown(String inputTitle, context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Text(
          inputTitle,
          style: Theme.of(context).textTheme.labelLarge,
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
                hintStr: AppStrings.usersParentHint,
                items: parentList ?? [],
                doOtherThings: (val) {
                  selectedparent = val;
                },
                displayFn: (item) => (item as SingleParentData).username,
              );
            },
          ),
        ),
      ],
    );
  }

  _getProfileDropdown(String inputTitle, context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Text(
          inputTitle,
          style: Theme.of(context).textTheme.labelLarge,
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
                hintStr: AppStrings.usersParentHint,
                items: profileList ?? [],
                doOtherThings: (val) {
                  selectedprofile = val;
                },
                displayFn: (item) => (item as ProfileData).name,
              );
            },
          ),
        ),
      ],
    );
  }
}
