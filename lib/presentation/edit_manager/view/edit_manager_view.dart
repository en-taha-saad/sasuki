import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:sasuki/app/app_inits_funs/constants.dart';
import 'package:sasuki/app/shared_widgets/custom_switch.dart';

import 'package:sasuki/app/init_screens_dependencies/init_app_module.dart';
import 'package:sasuki/app/resources/fonts_manager/fontsize.dart';
import 'package:sasuki/app/resources/other_managers/assets_manager.dart';
import 'package:sasuki/app/resources/other_managers/color_manager.dart';
import 'package:sasuki/app/resources/other_managers/strings_manager.dart';
import 'package:sasuki/app/resources/other_managers/styles_manager.dart';
import 'package:sasuki/app/resources/values_manager/app_margin.dart';
import 'package:sasuki/app/resources/values_manager/app_size.dart';
import 'package:sasuki/app/shared_widgets/elevated_button_widget.dart';
import 'package:sasuki/app/shared_widgets/get_addedit_text_field.dart';
import 'package:sasuki/app/shared_widgets/get_custome_appbar.dart';
import 'package:sasuki/app/shared_widgets/password_input.dart';
import 'package:sasuki/app/shared_widgets/shared_dropdown.dart';
import 'package:sasuki/domain/models/acl_permission_group_list/acl_permission_group_list.dart';
import 'package:sasuki/domain/models/dashboard/auth.dart';
import 'package:sasuki/domain/models/manager_details/manager_details.dart';
import 'package:sasuki/domain/models/manager_details/manager_overview_api.dart';
import 'package:sasuki/domain/models/managers_list/managers_list.dart';
import 'package:sasuki/presentation/common/state_render/states/flow_state.dart';
import 'package:sasuki/presentation/dashboard/viewmodel/dashboard_viewmodel.dart';
import 'package:sasuki/presentation/common/state_render/states/flow_state_extension.dart';
import 'package:sasuki/presentation/edit_manager/viewmodel/edit_manager_viewmodel.dart';
import 'package:sasuki/presentation/manager_details/viewmodel/manager_details_viewmodel.dart';
import 'package:sasuki/presentation/managers_list/viewmodel/managers_list_viewmodel.dart';
import 'package:sasuki/domain/models/managers_list/managers_list.dart'
    as managers_list;

class EditManager extends StatefulWidget {
  const EditManager({Key? key}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _EditManagerState createState() => _EditManagerState();
}

class _EditManagerState extends State<EditManager> {
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
  final ManagerDetailsViewModel _managerDetailsViewModel =
      instance<ManagerDetailsViewModel>();
  final ManagersListViewModel _managersListViewModel =
      instance<ManagersListViewModel>();
  final EditManagerViewModel _editManagerViewModel =
      instance<EditManagerViewModel>();
  final DashboardViewModel _dashboardViewModel = instance<DashboardViewModel>();
  ManagerOverviewApi? managerOverviewApiVar;
  ManagerDetails? managerDetails;
  List<SingleAclPermissionGroup>? aclPermissionGroupList;
  List<managers_list.SingleManagerData>? parentManagerList;
  Auth? managerAuth;

  SingleAclPermissionGroup? selectedAclGroupPermission;
  managers_list.SingleManagerData? selectedParentManager;
  bool isChecked = Constants.falseBool;
  bool isStepOne = Constants.trueBool;

  _bind() {
    _editManagerViewModel.start();
    _dashboardViewModel.getDataStreamingly();
    _managerDetailsViewModel.getManagerDataStreamingly();
    _managersListViewModel.getManagersListForPull();
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
        _editManagerViewModel.setUsername(_usernameController.text);
      },
    );
    _passwordController.addListener(
      () {
        _editManagerViewModel.setPassword(_passwordController.text);
      },
    );
    _firstNameController.addListener(
      () {
        _editManagerViewModel.setFirstName(_firstNameController.text);
      },
    );
    _lastNameController.addListener(
      () {
        _editManagerViewModel.setLastName(_lastNameController.text);
      },
    );
    _phoneController.addListener(
      () {
        _editManagerViewModel.setPhone(_phoneController.text);
      },
    );
    _notesController.addListener(
      () {
        _editManagerViewModel.setNotes(_notesController.text);
      },
    );
    _emailController.addListener(
      () {
        _editManagerViewModel.setEmail(_emailController.text);
      },
    );
    _companyController.addListener(
      () {
        _editManagerViewModel.setCompany(_companyController.text);
      },
    );
    _cityController.addListener(
      () {
        _editManagerViewModel.setCity(_cityController.text);
      },
    );
    _addressController.addListener(
      () {
        _editManagerViewModel.setAddress(_addressController.text);
      },
    );
    _managerDetailsViewModel.outputManagerOverviewApi.listen(
      (event) {
        if (mounted) {
          // check whether the state object is in tree
          setState(() => managerOverviewApiVar = event);
          _usernameController.text =
              managerOverviewApiVar?.data?.username ?? Constants.emptyStr;
          _firstNameController.text =
              managerOverviewApiVar?.data?.firstname ?? Constants.emptyStr;
          _lastNameController.text =
              managerOverviewApiVar?.data?.lastname ?? Constants.emptyStr;
          _phoneController.text =
              managerOverviewApiVar?.data?.phone ?? Constants.emptyStr;
          isChecked = managerOverviewApiVar?.data?.status == 1
              ? Constants.trueBool
              : Constants.falseBool;
        }
      },
    );

    _editManagerViewModel.outputManagerDetails.listen(
      (event) {
        if (mounted) {
          // check whether the state object is in tree
          setState(() => managerDetails = event);
          _companyController.text =
              managerDetails?.data?.company ?? Constants.emptyStr;
          _notesController.text =
              managerDetails?.data?.notes ?? Constants.emptyStr;
          _addressController.text =
              managerDetails?.data?.address ?? Constants.emptyStr;
          _emailController.text =
              managerDetails?.data?.email ?? Constants.emptyStr;

          _cityController.text =
              managerDetails?.data?.city ?? Constants.emptyStr;
        }
      },
    );
  }

  @override
  void dispose() {
    _dashboardViewModel.dispose();
    _editManagerViewModel.dispose();
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
      stream: _editManagerViewModel.outputState,
      builder: (context, AsyncSnapshot<FlowState> snapshot) {
        return snapshot.data?.getScreenWidget(
              context,
              _getScreenView(context),
              () async {
                ScaffoldMessenger.of(context).hideCurrentSnackBar();
                _editManagerViewModel.editManager();
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
        getCustomAppBar(context, AppStrings.updateManagerTitle, true),
        Expanded(
          child: Container(
            width: MediaQuery.of(context).size.width,
            color: ColorManager.secondary,
            child: _getEditManagerContent(),
          ),
        ),
      ],
    );
  }

  _getEditManagerContent() {
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
                      IconsAssets.edit,
                      theme: const SvgTheme(
                        currentColor: ColorManager.greyNeutral,
                      ),
                      // ignore: deprecated_member_use
                      color: ColorManager.greyNeutral,
                    ),
                  ),
                  Text(
                    AppStrings.editManagerTitle,
                    style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                          color: ColorManager.greyNeutral,
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
                              const Color(0xff41527B),
                              ColorManager.greyNeutral,
                            ),
                          ),
                          Container(
                            margin: const EdgeInsets.only(
                              bottom: AppMargin.m25,
                            ),
                            child: PasswordTextInput(
                              stream:
                                  _editManagerViewModel.outputIsPasswordValid,
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
                                    return CustomSwitch(
                                      color: Colors.white,
                                      value: isChecked,
                                      onChanged: (value) {
                                        setState(() {
                                          isChecked = value;
                                        });
                                      },
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
                            child: getAddEditTextFieldInput(
                              context,
                              _firstNameController,
                              (val) {
                                FocusScope.of(context).unfocus();
                              },
                              AppStrings.userFirstNameHint,
                              Constants.falseBool,
                              TextInputType.text,
                              Constants.trueBool,
                              Constants.trueBool,
                              Constants.trueBool,
                            ),
                          ),
                          Container(
                            margin:
                                const EdgeInsets.only(bottom: AppMargin.m25),
                            child: getAddEditTextFieldInput(
                              context,
                              _lastNameController,
                              (val) {
                                FocusScope.of(context).unfocus();
                              },
                              AppStrings.userLastNameHint,
                              Constants.falseBool,
                              TextInputType.text,
                              Constants.trueBool,
                              Constants.trueBool,
                              Constants.trueBool,
                            ),
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
                  child: StreamBuilder<bool>(
                    stream: _editManagerViewModel.outputAreAllInputsValid,
                    builder: (context, snapshot) {
                      return isStepOne
                          ? Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Container(),
                                ElevatedButtonWidget(
                                  name: AppStrings.nextButton,
                                  onPressed: () {
                                    debugPrint(
                                        "snapshot.data = ${snapshot.data}");
                                    FocusScope.of(context).unfocus();
                                    setState(() {
                                      isStepOne = Constants.falseBool;
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
                                ElevatedButtonWidget(
                                  name: AppStrings.userActionSubmitButton,
                                  assetName: IconsAssets.forward,
                                  onPressed: () {
                                    debugPrint(
                                        "snapshot.data = ${snapshot.data}");

                                    FocusScope.of(context).unfocus();

                                    debugPrint(
                                        "selectedParentManager = ${selectedParentManager?.username}");
                                    debugPrint(
                                        "selectedAclGroupPermission = ${selectedAclGroupPermission?.name}");

                                    if (selectedParentManager ==
                                        Constants.nullValue) {
                                      selectedParentManager =
                                          _getParentManagerUsername(
                                        managerAuth?.client?.username,
                                      );
                                    }
                                    if (selectedAclGroupPermission ==
                                        Constants.nullValue) {
                                      selectedAclGroupPermission =
                                          _getAclGroupPermissionUsername(
                                        managerOverviewApiVar
                                            ?.data?.aclGroupName,
                                      );
                                    }
                                    debugPrint(
                                        "selectedParentManager = ${selectedParentManager?.username}");
                                    debugPrint(
                                        "selectedAclGroupPermission = ${selectedAclGroupPermission?.name}");

                                    _editManagerViewModel.saveFloatingButton(
                                      selectedParentManager,
                                      selectedAclGroupPermission,
                                      isChecked,
                                    );
                                  },
                                ),
                              ],
                            );
                    },
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  SingleManagerData? _getParentManagerUsername(parentManagerUsername) {
    return parentManagerList
        ?.firstWhere((element) => element.username == parentManagerUsername);
  }

  SingleAclPermissionGroup? _getAclGroupPermissionUsername(
      aclGroupPermissionUsername) {
    return aclPermissionGroupList
        ?.firstWhere((element) => element.name == aclGroupPermissionUsername);
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
            stream: _editManagerViewModel.outputParentManagerList,
            builder: (_, snapshot0) {
              if (parentManagerList == Constants.nullValue ||
                  parentManagerList?.length == Constants.zeroNum) {
                parentManagerList = snapshot0.data;
              }
              debugPrint("parentManagerList: $parentManagerList");
              // ignore: prefer_is_empty
              return DropDownComponent<SingleManagerData?>(
                isThisServersDropdown: Constants.falseBool,
                hintStr: managerOverviewApiVar?.data?.parentUsername ??
                    AppStrings.usersParentHint,
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
            stream: _editManagerViewModel.outputAclPermissionGroupList,
            builder: (_, snapshot0) {
              if (aclPermissionGroupList == Constants.nullValue ||
                  aclPermissionGroupList?.length == Constants.zeroNum) {
                aclPermissionGroupList = snapshot0.data;
              }
              debugPrint("aclPermissionGroupList: $aclPermissionGroupList");
              // ignore: prefer_is_empty
              return DropDownComponent<SingleAclPermissionGroup?>(
                isThisServersDropdown: Constants.falseBool,
                hintStr: managerOverviewApiVar?.data?.aclGroupName ??
                    AppStrings.usersProfileHint,
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
