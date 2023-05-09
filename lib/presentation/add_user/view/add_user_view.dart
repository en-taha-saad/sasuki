import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:sasuki/app/app_inits_funs/constants.dart';
import 'package:sasuki/app/init_screens_dependencies/init_app_module.dart';
import 'package:sasuki/app/resources/other_managers/assets_manager.dart';
import 'package:sasuki/app/resources/other_managers/strings_manager.dart';
import 'package:sasuki/app/resources/routes_manager/nav_funcs.dart';
import 'package:sasuki/app/shared_widgets/elevated_button_widget.dart';
import 'package:sasuki/app/shared_widgets/get_addedit_text_field.dart';
import 'package:sasuki/app/shared_widgets/password_input.dart';
import 'package:sasuki/app/shared_widgets/shared_dropdown.dart';
import 'package:sasuki/domain/models/dashboard/auth.dart';
import 'package:sasuki/domain/models/dashboard/dashboard.dart';
import 'package:sasuki/domain/models/filter_lists/parent_list.dart';
import 'package:sasuki/domain/models/filter_lists/profile_list.dart';
import 'package:sasuki/presentation/add_user/viewmodel/add_user_viewmodel.dart';
import 'package:sasuki/presentation/common/state_render/states/flow_state.dart';
import 'package:sasuki/presentation/dashboard/viewmodel/dashboard_viewmodel.dart';
import 'package:sasuki/app/resources/other_managers/color_manager.dart';
import 'package:sasuki/presentation/common/state_render/states/flow_state_extension.dart';
import 'package:sasuki/app/resources/values_manager/app_margin.dart';
import 'package:sasuki/app/resources/values_manager/app_size.dart';

class AddUser extends StatefulWidget {
  const AddUser({Key? key}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _AddUserState createState() => _AddUserState();
}

class _AddUserState extends State<AddUser> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _firstNameController = TextEditingController();
  final TextEditingController _lastNameController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _notesController = TextEditingController();

  final AddUserViewModel _addUserViewModel = instance<AddUserViewModel>();
  final DashboardViewModel _dashboardViewModel = instance<DashboardViewModel>();
  Auth? userAuth;
  Dashboard? dashboardVar;
  List<ProfileData>? profileList;
  ProfileData? selectedprofile;

  List<SingleParentData>? parentList;
  SingleParentData? selectedparent;

  _bind() {
    _addUserViewModel.start();
    _dashboardViewModel.getDataStreamingly();
    _dashboardViewModel.outputAuthData.listen(
      (event) {
        if (mounted) {
          // check whether the state object is in tree
          setState(() => userAuth = event);
        }
      },
    );

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
        _addUserViewModel.setUsername(_usernameController.text);
      },
    );
    _passwordController.addListener(
      () {
        _addUserViewModel.setPassword(_passwordController.text);
      },
    );
    _firstNameController.addListener(
      () {
        _addUserViewModel.setFirstName(_firstNameController.text);
      },
    );
    _lastNameController.addListener(
      () {
        _addUserViewModel.setLastName(_lastNameController.text);
      },
    );
    _phoneController.addListener(
      () {
        _addUserViewModel.setPhone(_phoneController.text);
      },
    );
    _notesController.addListener(
      () {
        _addUserViewModel.setNotes(_notesController.text);
      },
    );
  }

  @override
  void dispose() {
    _dashboardViewModel.dispose();
    _addUserViewModel.dispose();
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
      stream: _addUserViewModel.outputState,
      builder: (context, AsyncSnapshot<FlowState> snapshot) {
        return snapshot.data?.getScreenWidget(
              context,
              _getScreenView(context),
              () async {
                ScaffoldMessenger.of(context).hideCurrentSnackBar();
                _addUserViewModel.addUser();
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
            left: AppMargin.m5,
          ),
          child: AppBar(
            leading: IconButton(
              icon: SvgPicture.asset(IconsAssets.back),
              onPressed: () => Nav.popRoute(context),
            ),
            title: Text(
              AppStrings.addUserTitle,
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
            child: _getAddUserContent(),
          ),
        ),
      ],
    );
  }

  SingleParentData? _getParentUsername(parentUsername) {
    return parentList
        ?.firstWhere((element) => element.username == parentUsername);
  }

  _getAddUserContent() {
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
                    IconsAssets.add,
                    theme: const SvgTheme(
                      currentColor: ColorManager.greyNeutral2,
                    ),
                    // ignore: deprecated_member_use
                    color: ColorManager.greyNeutral2,
                  ),
                ),
                Text(
                  AppStrings.createNewUserTitle,
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
                  margin: const EdgeInsets.only(
                    bottom: AppMargin.m25,
                  ),
                  child: StreamBuilder<bool>(
                    stream: _addUserViewModel.outputIsUsernameValid,
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
                        Constants.trueBool,
                      );
                    },
                  ),
                ),
                Container(
                  margin: const EdgeInsets.only(
                    bottom: AppMargin.m25,
                  ),
                  child: PasswordTextInput(
                    stream: _addUserViewModel.outputIsPasswordValid,
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
                _getProfileDropdown(AppStrings.usersProfile, context),
                _getParentDropdown(AppStrings.usersParent, context),
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
                    stream: _addUserViewModel.outputAreAllInputsValid,
                    builder: (context, snapshot) {
                      return ElevatedButtonWidget(
                        name: AppStrings.userActionSubmitButton,
                        assetName: IconsAssets.forward,
                        onPressed: () {
                          FocusScope.of(context).unfocus();
                          bool isTextInputsValid =
                              snapshot.data ?? Constants.falseBool;
                          setState(() {});
                          _addUserViewModel.saveFloatingButton(
                            isTextInputsValid,
                            selectedparent ??
                                _getParentUsername(
                                  userAuth?.client?.username,
                                ),
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
              inputTitle,
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
            stream: _addUserViewModel.outputParentList,
            builder: (_, snapshot0) {
              if (parentList == Constants.nullValue ||
                  parentList?.length == Constants.zeroNum) {
                parentList = snapshot0.data;
              }
              debugPrint("parentList: $parentList");
              // ignore: prefer_is_empty
              return DropDownComponent<SingleParentData?>(
                isThisServersDropdown: Constants.falseBool,
                hintStr:
                    userAuth?.client?.username ?? AppStrings.usersParentHint,
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

  _getProfileDropdown(String inputTitle, context) {
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
              inputTitle,
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
            stream: _addUserViewModel.outputProfileList,
            builder: (_, snapshot0) {
              if (profileList == Constants.nullValue ||
                  profileList?.length == Constants.zeroNum) {
                profileList = snapshot0.data;
              }
              debugPrint("profileList: $profileList");
              // ignore: prefer_is_empty
              return DropDownComponent<ProfileData?>(
                isThisServersDropdown: Constants.falseBool,
                hintStr: AppStrings.usersProfileHint,
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
