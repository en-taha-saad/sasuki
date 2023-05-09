import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:sasuki/app/app_inits_funs/constants.dart';
import 'package:sasuki/app/init_screens_dependencies/init_app_module.dart';
import 'package:sasuki/app/resources/fonts_manager/fontsize.dart';
import 'package:sasuki/app/resources/other_managers/assets_manager.dart';
import 'package:sasuki/app/resources/other_managers/color_manager.dart';
import 'package:sasuki/app/resources/other_managers/strings_manager.dart';
import 'package:sasuki/app/resources/other_managers/styles_manager.dart';
import 'package:sasuki/app/resources/routes_manager/nav_funcs.dart';
import 'package:sasuki/app/resources/values_manager/app_margin.dart';
import 'package:sasuki/app/resources/values_manager/app_size.dart';
import 'package:sasuki/app/shared_widgets/elevated_button_widget.dart';
import 'package:sasuki/app/shared_widgets/get_addedit_text_field.dart';
import 'package:sasuki/app/shared_widgets/password_input.dart';
import 'package:sasuki/app/shared_widgets/shared_dropdown.dart';
import 'package:sasuki/domain/models/acl_permission_group_list/acl_permission_group_list.dart';
import 'package:sasuki/domain/models/dashboard/auth.dart';
import 'package:sasuki/domain/models/manager_details/manager_overview_api.dart';
import 'package:sasuki/domain/models/managers_list/managers_list.dart';
import 'package:sasuki/presentation/add_manager/viewmodel/add_manager_viewmodel.dart';
import 'package:sasuki/presentation/common/state_render/states/flow_state.dart';
import 'package:sasuki/presentation/dashboard/viewmodel/dashboard_viewmodel.dart';
import 'package:sasuki/presentation/common/state_render/states/flow_state_extension.dart';
import 'package:sasuki/domain/models/managers_list/managers_list.dart'
    as managers_list;

class AddManager extends StatefulWidget {
  const AddManager({Key? key}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _AddManagerState createState() => _AddManagerState();
}

class _AddManagerState extends State<AddManager> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _firstNameController = TextEditingController();
  final TextEditingController _lastNameController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _notesController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _companyController = TextEditingController();
  final TextEditingController _cityController = TextEditingController();
  final TextEditingController _addressController = TextEditingController();

  final AddManagerViewModel _addManagerViewModel =
      instance<AddManagerViewModel>();
  final DashboardViewModel _dashboardViewModel = instance<DashboardViewModel>();
  ManagerOverviewApi? managerOverviewApiVar;
  List<SingleAclPermissionGroup>? aclPermissionGroupList;
  List<managers_list.SingleManagerData>? parentManagerList;
  Auth? managerAuth;

  SingleAclPermissionGroup? selectedAclGroupPermission;
  managers_list.SingleManagerData? selectedParentManager;
  bool isChecked = Constants.trueBool;
  bool isStepOne = Constants.trueBool;

  _bind() {
    _addManagerViewModel.start();
    _dashboardViewModel.getDataStreamingly();
    _dashboardViewModel.outputAuthData.listen(
      (event) {
        if (mounted) {
          // check whether the state object is in tree
          setState(() => managerAuth = event);
        }
      },
    );
    _usernameController.addListener(
      () {
        _addManagerViewModel.setUsername(_usernameController.text);
      },
    );
    _passwordController.addListener(
      () {
        _addManagerViewModel.setPassword(_passwordController.text);
      },
    );
    _firstNameController.addListener(
      () {
        _addManagerViewModel.setFirstName(_firstNameController.text);
      },
    );
    _lastNameController.addListener(
      () {
        _addManagerViewModel.setLastName(_lastNameController.text);
      },
    );
    _phoneController.addListener(
      () {
        _addManagerViewModel.setPhone(_phoneController.text);
      },
    );
    _notesController.addListener(
      () {
        _addManagerViewModel.setNotes(_notesController.text);
      },
    );
    _emailController.addListener(
      () {
        _addManagerViewModel.setEmail(_emailController.text);
      },
    );
    _companyController.addListener(
      () {
        _addManagerViewModel.setCompany(_companyController.text);
      },
    );
    _cityController.addListener(
      () {
        _addManagerViewModel.setCity(_cityController.text);
      },
    );
    _addressController.addListener(
      () {
        _addManagerViewModel.setAddress(_addressController.text);
      },
    );
  }

  @override
  void dispose() {
    _dashboardViewModel.dispose();
    _addManagerViewModel.dispose();
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
      stream: _addManagerViewModel.outputState,
      builder: (context, AsyncSnapshot<FlowState> snapshot) {
        return snapshot.data?.getScreenWidget(
              context,
              _getScreenView(context),
              () async {
                ScaffoldMessenger.of(context).hideCurrentSnackBar();
                _addManagerViewModel.addManager();
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
            bottom: AppMargin.m5,
          ),
          child: AppBar(
            elevation: AppSize.s0,
            backgroundColor: const Color(0xff2D3B60),
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
              AppStrings.addManagerTitle,
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
            child: _getAddManagerContent(),
          ),
        ),
      ],
    );
  }

  managers_list.SingleManagerData? _getParentManagerUsername(
      parentManagerUsername) {
    return parentManagerList
        ?.firstWhere((element) => element.username == parentManagerUsername);
  }

  _getAddManagerContent() {
    return SingleChildScrollView(
      child: Container(
        margin: const EdgeInsets.only(
          right: AppMargin.m25,
          left: AppMargin.m25,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            ///
            Container(
              margin: const EdgeInsets.only(
                top: AppSize.s25,
                bottom: AppSize.s25,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    margin: const EdgeInsets.only(right: AppSize.s10),
                    child: SvgPicture.asset(
                      IconsAssets.add,
                      theme: const SvgTheme(
                        currentColor: ColorManager.whiteNeutral,
                      ),
                      // ignore: deprecated_member_use
                      color: ColorManager.whiteNeutral,
                    ),
                  ),
                  Text(
                    AppStrings.addManagerTitle,
                    style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                          color: ColorManager.whiteNeutral,
                        ),
                  ),
                ],
              ),
            ),

            ///
            Container(
              margin: const EdgeInsets.only(
                bottom: AppSize.s25,
              ),
              child: isStepOne
                  ? Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Container(
                          margin: const EdgeInsets.only(bottom: AppSize.s25),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Container(
                                height: AppSize.s5,
                                width: MediaQuery.of(context).size.width * 0.5 -
                                    25 -
                                    5,
                                decoration: BoxDecoration(
                                  color: ColorManager.primaryshade1,
                                  borderRadius:
                                      BorderRadius.circular(AppSize.s12),
                                ),
                              ),
                              const SizedBox(width: AppSize.s10),
                              Container(
                                height: AppSize.s5,
                                width: MediaQuery.of(context).size.width * 0.5 -
                                    25 -
                                    5,
                                decoration: BoxDecoration(
                                  color: ColorManager.whiteNeutral,
                                  borderRadius:
                                      BorderRadius.circular(AppSize.s12),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Text(
                          AppStrings.addEditManagerStepOneTitle,
                          style: StylesManager.getMediumStyle(
                            fontSize: FontSize.sInputText,
                            color: ColorManager.greyNeutral,
                          ),
                        ),
                      ],
                    )
                  : Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Container(
                          margin: const EdgeInsets.only(bottom: AppSize.s25),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Container(
                                height: AppSize.s5,
                                width: MediaQuery.of(context).size.width * 0.5 -
                                    25 -
                                    5,
                                decoration: BoxDecoration(
                                  color: ColorManager.primaryshade1,
                                  borderRadius:
                                      BorderRadius.circular(AppSize.s12),
                                ),
                              ),
                              const SizedBox(width: AppSize.s10),
                              Container(
                                height: AppSize.s5,
                                width: MediaQuery.of(context).size.width * 0.5 -
                                    25 -
                                    5,
                                decoration: BoxDecoration(
                                  color: ColorManager.primaryshade1,
                                  borderRadius:
                                      BorderRadius.circular(AppSize.s12),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Text(
                          AppStrings.addEditManagerStepTwoTitle,
                          style: StylesManager.getMediumStyle(
                            fontSize: FontSize.sInputText,
                            color: ColorManager.greyNeutral,
                          ),
                        ),
                      ],
                    ),
            ),

            ///
            Column(
              children: [
                isStepOne
                    ? Column(
                        children: [
                          Container(
                            margin:
                                const EdgeInsets.only(bottom: AppMargin.m25),
                            child: StreamBuilder<bool>(
                                stream:
                                    _addManagerViewModel.outputIsUsernameValid,
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
                                }),
                          ),
                          Container(
                            margin: const EdgeInsets.only(
                              bottom: AppMargin.m25,
                            ),
                            child: PasswordTextInput(
                              stream:
                                  _addManagerViewModel.outputIsPasswordValid,
                              controller: _passwordController,
                              // controller: rememberMe == true ? null : _managerPasswordController,
                              inputLabel: AppStrings.servPassword,
                              inputHint: Constants.emptyStr,
                              errorText: AppStrings.servInvalidPassword,
                              autofocus: Constants.falseBool,
                              showPassword: Constants.trueBool,
                              isRequired: Constants.trueBool,
                            ),
                          ),

                          ///
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
                          _getParentManagerDropdown(context),
                          _getAclGroupPermissionDropdown(context),
                          Container(
                            margin:
                                const EdgeInsets.only(bottom: AppMargin.m25),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  AppStrings.enableManagerSwitch,
                                  style: Theme.of(context).textTheme.labelLarge,
                                ),
                                StatefulBuilder(
                                  builder: (BuildContext context,
                                      StateSetter setState) {
                                    return Transform.scale(
                                      scale: 0.7,
                                      child: Switch(
                                        value: isChecked,
                                        activeColor: ColorManager.primaryshade1,
                                        activeTrackColor:
                                            const Color(0xffDCDFE3),
                                        inactiveThumbColor:
                                            ColorManager.primaryshade1,
                                        inactiveTrackColor:
                                            const Color(0xffDCDFE3),
                                        onChanged: (bool value) {
                                          setState(() => isChecked = value);
                                        },
                                      ),
                                    );
                                  },
                                ),
                              ],
                            ),
                          ),
                        ],
                      )
                    : Column(
                        children: [
                          ///
                          Container(
                            margin:
                                const EdgeInsets.only(bottom: AppMargin.m25),
                            child: StreamBuilder<bool>(
                                stream:
                                    _addManagerViewModel.outputIsFirstNameValid,
                                builder: (context, snapshot) {
                                  return getAddEditTextFieldInput(
                                    context,
                                    _firstNameController,
                                    (val) {
                                      FocusScope.of(context).unfocus();
                                    },
                                    AppStrings.userFirstNameHint,
                                    Constants.falseBool,
                                    TextInputType.text,
                                    snapshot.data,
                                    Constants.trueBool,
                                    Constants.trueBool,
                                  );
                                }),
                          ),
                          Container(
                            margin:
                                const EdgeInsets.only(bottom: AppMargin.m25),
                            child: StreamBuilder<bool>(
                                stream:
                                    _addManagerViewModel.outputIsLastNameValid,
                                builder: (context, snapshot) {
                                  return getAddEditTextFieldInput(
                                    context,
                                    _lastNameController,
                                    (val) {
                                      FocusScope.of(context).unfocus();
                                    },
                                    AppStrings.userLastNameHint,
                                    Constants.falseBool,
                                    TextInputType.text,
                                    snapshot.data,
                                    Constants.trueBool,
                                    Constants.trueBool,
                                  );
                                }),
                          ),
                          Container(
                            margin:
                                const EdgeInsets.only(bottom: AppMargin.m25),
                            child: getAddEditTextFieldInput(
                              context,
                              _emailController,
                              (val) {
                                FocusScope.of(context).unfocus();
                              },
                              AppStrings.userOverviewEmail,
                              Constants.falseBool,
                            ),
                          ),
                          Container(
                            margin:
                                const EdgeInsets.only(bottom: AppMargin.m25),
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

                          ///
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
                            margin:
                                const EdgeInsets.only(bottom: AppMargin.m25),
                            child: getAddEditTextFieldInput(
                              context,
                              _companyController,
                              (val) {
                                FocusScope.of(context).unfocus();
                              },
                              AppStrings.userCompanyHint,
                              Constants.falseBool,
                            ),
                          ),
                          Container(
                            margin:
                                const EdgeInsets.only(bottom: AppMargin.m25),
                            child: getAddEditTextFieldInput(
                              context,
                              _cityController,
                              (val) {
                                FocusScope.of(context).unfocus();
                              },
                              AppStrings.userCityHint,
                              Constants.falseBool,
                            ),
                          ),
                          Container(
                            margin:
                                const EdgeInsets.only(bottom: AppMargin.m25),
                            child: getAddEditTextFieldInput(
                              context,
                              _addressController,
                              (val) {
                                FocusScope.of(context).unfocus();
                              },
                              AppStrings.userAddressHint,
                              Constants.falseBool,
                            ),
                          ),
                          getAddEditTextFieldInput(
                            context,
                            _notesController,
                            (val) {
                              FocusScope.of(context).unfocus();
                            },
                            AppStrings.userNotesHint,
                            Constants.falseBool,
                          ),
                        ],
                      ),

                ///
                Container(
                  margin: const EdgeInsets.only(
                    top: AppMargin.m35,
                    bottom: AppMargin.m50,
                  ),
                  child: isStepOne
                      ? Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Container(),
                            StreamBuilder<bool>(
                              stream:
                                  _addManagerViewModel.outputIsUsernameValid,
                              builder: (context, outputIsUsernameValid) {
                                return StreamBuilder<bool>(
                                    stream: _addManagerViewModel
                                        .outputIsPasswordValid,
                                    builder: (context, outputIsPasswordValid) {
                                      return ElevatedButtonWidget(
                                        name: AppStrings.nextButton,
                                        onPressed: () {
                                          debugPrint(
                                              "selectedParentManager $selectedParentManager");
                                          debugPrint(
                                              "selectedAclGroupPermission = $selectedAclGroupPermission");
                                          debugPrint(
                                              "outputIsUsernameValid.data = ${outputIsUsernameValid.data}");
                                          debugPrint(
                                              "outputIsPasswordValid.data = ${outputIsPasswordValid.data}");
                                          if (selectedParentManager ==
                                              Constants.nullValue) {
                                            selectedParentManager =
                                                _getParentManagerUsername(
                                                    managerAuth
                                                        ?.client?.username);
                                          }
                                          if (selectedParentManager !=
                                                  Constants.nullValue &&
                                              selectedAclGroupPermission !=
                                                  Constants.nullValue &&
                                              (outputIsUsernameValid.data)! &&
                                              (outputIsPasswordValid.data)!) {
                                            FocusScope.of(context).unfocus();
                                            setState(() {
                                              isStepOne = Constants.falseBool;
                                            });
                                          }
                                        },
                                      );
                                    });
                              },
                            ),
                          ],
                        )
                      : Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            TextButton(
                              style: TextButton.styleFrom(
                                foregroundColor: ColorManager.whiteNeutral,
                                backgroundColor: Colors.transparent,
                                shadowColor: Colors.transparent,
                                elevation: 0,
                              ),
                              onPressed: () {
                                FocusScope.of(context).unfocus();
                                setState(() {
                                  isStepOne = Constants.trueBool;
                                });
                              },
                              child: const Text(AppStrings.previousButton),
                            ),
                            StreamBuilder<bool>(
                                stream:
                                    _addManagerViewModel.outputIsFirstNameValid,
                                builder: (context, outputIsFirstNameValid) {
                                  return StreamBuilder<bool>(
                                      stream: _addManagerViewModel
                                          .outputIsLastNameValid,
                                      builder:
                                          (context, outputIsLastNameValid) {
                                        return ElevatedButtonWidget(
                                          name:
                                              AppStrings.userActionSubmitButton,
                                          assetName: IconsAssets.forward,
                                          onPressed: () {
                                            FocusScope.of(context).unfocus();
                                            bool isTextInputsValid =
                                                (outputIsFirstNameValid
                                                        .data)! &&
                                                    (outputIsLastNameValid
                                                        .data)!;
                                            setState(() {});
                                            _addManagerViewModel
                                                .saveFloatingButton(
                                              isTextInputsValid,
                                              selectedParentManager,
                                              selectedAclGroupPermission,
                                            );
                                          },
                                        );
                                      });
                                }),
                          ],
                        ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  _getParentManagerDropdown(context) {
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
          child: StreamBuilder<List<SingleManagerData>?>(
            stream: _addManagerViewModel.outputParentManagerList,
            builder: (_, snapshot0) {
              if (parentManagerList == Constants.nullValue ||
                  parentManagerList?.length == Constants.zeroNum) {
                parentManagerList = snapshot0.data;
              }
              debugPrint("parentManagerList: $parentManagerList");
              // ignore: prefer_is_empty
              return DropDownComponent<SingleManagerData?>(
                isThisServersDropdown: Constants.falseBool,
                hintStr:
                    managerAuth?.client?.username ?? AppStrings.usersParentHint,
                items: parentManagerList ?? [],
                doOtherThings: (val) {
                  selectedParentManager = val;
                },
                displayFn: (item) => ((item as SingleManagerData).username)!,
                textAndHintColor: ColorManager.whiteNeutral,
              );
            },
          ),
        ),
      ],
    );
  }

  _getAclGroupPermissionDropdown(context) {
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
              AppStrings.managerSecurityGroup,
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
          child: StreamBuilder<List<SingleAclPermissionGroup>>(
            stream: _addManagerViewModel.outputAclPermissionGroupList,
            builder: (_, snapshot0) {
              if (aclPermissionGroupList == Constants.nullValue ||
                  aclPermissionGroupList?.length == Constants.zeroNum) {
                aclPermissionGroupList = snapshot0.data;
              }
              debugPrint("aclPermissionGroupList: $aclPermissionGroupList");
              // ignore: prefer_is_empty
              return DropDownComponent<SingleAclPermissionGroup?>(
                isThisServersDropdown: Constants.falseBool,
                hintStr: AppStrings.usersProfileHint,
                items: aclPermissionGroupList ?? [],
                doOtherThings: (val) {
                  selectedAclGroupPermission = val;
                },
                displayFn: (item) => ((item as SingleAclPermissionGroup).name)!,
                textAndHintColor: ColorManager.whiteNeutral,
              );
            },
          ),
        ),
      ],
    );
  }
}
