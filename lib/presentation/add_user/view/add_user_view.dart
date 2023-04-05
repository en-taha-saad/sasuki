import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:sasuki/app/app_inits_funs/constants.dart';
import 'package:sasuki/app/init_screens_dependencies/init_app_module.dart';
import 'package:sasuki/domain/models/dashboard/dashboard.dart';
import 'package:sasuki/domain/models/filter_lists/parent_list.dart';
import 'package:sasuki/domain/models/filter_lists/profile_list.dart';
import 'package:sasuki/domain/models/user_details/user_overview_api.dart';
import 'package:sasuki/presentation/add_user/viewmodel/add_user_viewmodel.dart';
import 'package:sasuki/presentation/common/state_render/states/flow_state.dart';
import 'package:sasuki/presentation/dashboard/viewmodel/dashboard_viewmodel.dart';
import 'package:sasuki/app/resources/fonts_manager/fontsize.dart';
import 'package:sasuki/app/resources/other_managers/assets_manager.dart';
import 'package:sasuki/app/resources/other_managers/color_manager.dart';
import 'package:sasuki/presentation/common/state_render/states/flow_state_extension.dart';
import 'package:sasuki/app/resources/other_managers/opacity_manager.dart';
import 'package:sasuki/app/resources/other_managers/strings_manager.dart';
import 'package:sasuki/app/resources/values_manager/app_margin.dart';
import 'package:sasuki/app/resources/values_manager/app_padding.dart';
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
  UserOverviewApi? userOverviewApiVar;
  Dashboard? dashboardVar;
  List<ProfileData>? profileList;
  ProfileData? selectedprofile;

  List<SingleParentData>? parentList;
  SingleParentData? selectedparent;

  _bind() {
    _addUserViewModel.start();
    _dashboardViewModel.getDataStreamingly();
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
    return SingleChildScrollView(
      child: Column(
        children: [
          AppSize.statusBarHeight(context),
          Container(
            margin: const EdgeInsets.only(
              right: AppMargin.m25,
              left: AppMargin.m25,
              bottom: AppMargin.m15,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                // _getUserActions(context),
                // const SizedBox(height: AppSize.s20),
                // _getStatisticsCard(context),
                // const SizedBox(height: AppSize.s15),
              ],
            ),
          ),
          Container(
            width: MediaQuery.of(context).size.width,
            // child: _getUserDetailsContent(),
            color: ColorManager.secondary,
          ),
        ],
      ),
    );
  }


  // Widget _getScreenView(context) {
  //   final appBarContent = Container(
  //     margin: const EdgeInsets.only(
  //       top: AppMargin.m8,
  //     ),
  //     padding: const EdgeInsets.only(
  //       left: AppPadding.p12,
  //       // bottom: AppPadding.p12,
  //     ),
  //     child: Column(
  //       mainAxisAlignment: MainAxisAlignment.end,
  //       crossAxisAlignment: CrossAxisAlignment.start,
  //       children: [
  //         Column(
  //           crossAxisAlignment: CrossAxisAlignment.start,
  //           children: [
  //             Text(
  //               AppStrings.usersTotalUsers,
  //               style: Theme.of(context).textTheme.titleMedium,
  //             ),
  //             StreamBuilder<Dashboard>(
  //               stream: _dashboardViewModel.outputDashboardData,
  //               builder: (context, snapshot) {
  //                 return Text(
  //                   "${snapshot.data?.data?.usersCount ?? Constants.dash}",
  //                   style: Theme.of(context).textTheme.headlineLarge,
  //                 );
  //               },
  //             ),
  //           ],
  //         ),
  //         const SizedBox(height: AppSize.s8),
  //         Row(
  //           crossAxisAlignment: CrossAxisAlignment.start,
  //           children: [
  //             Column(
  //               crossAxisAlignment: CrossAxisAlignment.start,
  //               children: [
  //                 Text(
  //                   AppStrings.usersActive,
  //                   style: Theme.of(context).textTheme.titleMedium,
  //                 ),
  //                 StreamBuilder<Dashboard>(
  //                   stream: _dashboardViewModel.outputDashboardData,
  //                   builder: (context, snapshot) {
  //                     return Text(
  //                       "${snapshot.data?.data?.activeUsersCount ?? Constants.dash}",
  //                       style: Theme.of(context).textTheme.headlineMedium,
  //                     );
  //                   },
  //                 ),
  //               ],
  //             ),
  //             Container(
  //               width: AppSize.s10,
  //               height: AppSize.s46,
  //               margin: const EdgeInsets.only(
  //                 left: AppMargin.m22,
  //                 top: AppMargin.m4,
  //               ),
  //               padding: const EdgeInsets.only(left: AppPadding.p12),
  //               decoration: BoxDecoration(
  //                 border: Border(
  //                   left: BorderSide(
  //                     color: ColorManager.white.withOpacity(AppOpacity.op70),
  //                     width: AppSize.s2.toDouble(),
  //                   ),
  //                 ),
  //               ),
  //             ),
  //             Column(
  //               crossAxisAlignment: CrossAxisAlignment.start,
  //               children: [
  //                 Text(
  //                   AppStrings.usersExpired,
  //                   style: Theme.of(context).textTheme.titleMedium,
  //                 ),
  //                 StreamBuilder<Dashboard>(
  //                     stream: _dashboardViewModel.outputDashboardData,
  //                     builder: (context, snapshot) {
  //                       return Text(
  //                         "${snapshot.data?.data?.expiredUsersCount ?? Constants.dash}",
  //                         style: Theme.of(context).textTheme.headlineMedium,
  //                       );
  //                     }),
  //               ],
  //             ),
  //             Container(
  //               width: AppSize.s10,
  //               height: AppSize.s46,
  //               margin: const EdgeInsets.only(
  //                 left: AppMargin.m22,
  //                 top: AppMargin.m4,
  //               ),
  //               padding: const EdgeInsets.only(left: AppPadding.p12),
  //               decoration: BoxDecoration(
  //                 border: Border(
  //                   left: BorderSide(
  //                     color: ColorManager.white.withOpacity(AppOpacity.op70),
  //                     width: AppSize.s2.toDouble(),
  //                   ),
  //                 ),
  //               ),
  //             ),
  //             Column(
  //               crossAxisAlignment: CrossAxisAlignment.start,
  //               children: [
  //                 Text(
  //                   AppStrings.usersOnline,
  //                   style: Theme.of(context).textTheme.titleMedium,
  //                 ),
  //                 StreamBuilder<Dashboard>(
  //                     stream: _dashboardViewModel.outputDashboardData,
  //                     builder: (context, snapshot) {
  //                       return Text(
  //                         "${snapshot.data?.data?.usersOnlineCount ?? Constants.dash}",
  //                         style: Theme.of(context).textTheme.headlineMedium,
  //                       );
  //                     }),
  //               ],
  //             ),
  //           ],
  //         ),
  //         const SizedBox(height: AppSize.s4),
  //       ],
  //     ),
  //   );
  //   final appBar = CustomAppBar(
  //     AppStrings.addUserTitle,
  //     AppSize.s230,
  //     appBarContent,
  //     ImageAssets.appbarBackground,
  //     backgroundColor: ColorManager.drawerBackground,
  //     onPressed: () => Nav.popRoute(context),
  //     isBackButton: Constants.trueVal,
  //   );
  //   return Scaffold(
  //     appBar: appBar,
  //     backgroundColor: ColorManager.drawerBackground,
  //     body: _getContentWidget(),
  //   );
  // }

  // Widget _getContentWidget() {
  //   return SingleChildScrollView(
  //     physics: const AlwaysScrollableScrollPhysics(),
  //     child: Column(
  //       children: [
  //         const SizedBox(height: AppSize.s16),
  //         Container(
  //           decoration: BoxDecoration(
  //             color: ColorManager.drawerBackground,
  //             border: Border(
  //               bottom: BorderSide(
  //                 color: ColorManager.white.withOpacity(AppOpacity.op70),
  //                 width: AppSize.s1.toDouble(),
  //               ),
  //             ),
  //           ),
  //           padding: const EdgeInsets.only(
  //             bottom: AppMargin.m6,
  //             left: AppMargin.m16,
  //             right: AppMargin.m16,
  //           ),
  //           child: Row(
  //             mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //             children: [
  //               Text(
  //                 AppStrings.createNewUserTitle,
  //                 style: Theme.of(context).textTheme.titleMedium,
  //               ),
  //               SvgPicture.asset(ImageAssets.addUserIcon),
  //             ],
  //           ),
  //         ),
  //         Container(
  //           color: ColorManager.black.withOpacity(AppOpacity.op30),
  //           child: Column(
  //             crossAxisAlignment: CrossAxisAlignment.start,
  //             mainAxisAlignment: MainAxisAlignment.start,
  //             mainAxisSize: MainAxisSize.min,
  //             children: [
  //               const SizedBox(height: AppSize.s16),
  //               StreamBuilder<bool>(
  //                 stream: _addUserViewModel.outputIsUsernameValid,
  //                 builder: (context, snapshot) {
  //                   return _getInputTextField(
  //                     AppStrings.servUsername,
  //                     _usernameController,
  //                     snapshot.data,
  //                   );
  //                 },
  //               ),
  //               const SizedBox(height: AppSize.s16),
  //               StreamBuilder<bool>(
  //                 stream: _addUserViewModel.outputIsPasswordValid,
  //                 builder: (context, snapshot) {
  //                   return _getInputTextField(
  //                     AppStrings.servPassword,
  //                     _passwordController,
  //                     snapshot.data,
  //                   );
  //                 },
  //               ),
  //               const SizedBox(height: AppSize.s16),
  //               Container(
  //                 margin: const EdgeInsets.symmetric(horizontal: AppMargin.m16),
  //                 child: StreamBuilder<List<ProfileData>>(
  //                   stream: _addUserViewModel.outputProfileList,
  //                   builder: (_, snapshot0) {
  //                     if (profileList == Constants.nullValue ||
  //                         profileList?.length == Constants.zero) {
  //                       profileList = snapshot0.data;
  //                     }
  //                     // ignore: prefer_is_empty
  //                     return Container(
  //                       margin: const EdgeInsets.only(top: AppMargin.m12),
  //                       child: DropdownButtonFormField<ProfileData>(
  //                         hint: Text(
  //                           AppStrings.usersParentHint,
  //                           style: getRegularStyle(
  //                             color: ColorManager.white.withOpacity(
  //                               AppOpacity.op60,
  //                             ),
  //                             fontSize: FontSize.s16,
  //                           ),
  //                         ),
  //                         iconSize: AppSize.s36,
  //                         style: Theme.of(context).textTheme.titleLarge,
  //                         menuMaxHeight: AppSize.s300,
  //                         borderRadius: AppSize.radius10,
  //                         autovalidateMode: AutovalidateMode.always,
  //                         validator: (value) {
  //                           if (value == Constants.nullValue) {
  //                             return AppStrings.dropdownIsRequired;
  //                           }
  //                           return Constants.nullValue;
  //                         },
  //                         value: selectedprofile,
  //                         iconDisabledColor: ColorManager.white,
  //                         decoration: InputDecoration(
  //                           border: _addUserTextFieldBorderProperties(),
  //                           enabledBorder: _addUserTextFieldBorderProperties(),
  //                           focusedBorder: _addUserTextFieldBorderProperties(),
  //                           hintStyle: Theme.of(context).textTheme.titleMedium,
  //                           hintText: AppStrings.usersParentHint,
  //                           contentPadding: const EdgeInsets.symmetric(
  //                             horizontal: AppPadding.p20,
  //                           ),
  //                           iconColor: ColorManager.white,
  //                         ),
  //                         iconEnabledColor: ColorManager.white,
  //                         dropdownColor: ColorManager.white,
  //                         elevation: AppSize.s0.toInt(),
  //                         selectedItemBuilder: (context) {
  //                           return profileList
  //                                   ?.map(
  //                                     (e) => SizedBox(
  //                                       width: AppSize.s250,
  //                                       child: Text(
  //                                         e.name,
  //                                         style: Theme.of(context)
  //                                             .textTheme
  //                                             .titleLarge,
  //                                         overflow: TextOverflow.fade,
  //                                         textAlign: TextAlign.left,
  //                                       ),
  //                                     ),
  //                                   )
  //                                   .toList() ??
  //                               [];
  //                         },
  //                         onChanged: (singleProfileData) {
  //                           selectedprofile = singleProfileData;
  //                         },
  //                         items: profileList?.map(
  //                           (ProfileData value) {
  //                             return DropdownMenuItem<ProfileData>(
  //                               value: value,
  //                               child: Center(
  //                                 child: Column(
  //                                   children: [
  //                                     Card(
  //                                       color: ColorManager.transparent,
  //                                       elevation: AppSize.s0,
  //                                       child: Text(
  //                                         value.name,
  //                                         style: Theme.of(context)
  //                                             .textTheme
  //                                             .bodyMedium,
  //                                         textAlign: TextAlign.center,
  //                                       ),
  //                                     ),
  //                                     if (profileList?.last != value)
  //                                       Divider(
  //                                         color:
  //                                             ColorManager.primary.withOpacity(
  //                                           AppOpacity.op70,
  //                                         ),
  //                                         height: AppSize.s1,
  //                                       ),
  //                                   ],
  //                                 ),
  //                               ),
  //                             );
  //                           },
  //                         ).toList(),
  //                       ),
  //                     );
  //                   },
  //                 ),
  //               ),
  //               const SizedBox(height: AppSize.s16),
  //               Container(
  //                 margin: const EdgeInsets.symmetric(horizontal: AppMargin.m16),
  //                 child: StreamBuilder<List<SingleParentData>>(
  //                   stream: _addUserViewModel.outputParentList,
  //                   builder: (_, snapshot0) {
  //                     if (parentList == Constants.nullValue ||
  //                         parentList?.length == Constants.zero) {
  //                       parentList = snapshot0.data;
  //                     }
  //                     // ignore: prefer_is_empty
  //                     return Container(
  //                       margin: const EdgeInsets.only(top: AppMargin.m12),
  //                       child: DropdownButtonFormField<SingleParentData>(
  //                         hint: Text(
  //                           AppStrings.usersParentHint,
  //                           style: getRegularStyle(
  //                             color: ColorManager.white.withOpacity(
  //                               AppOpacity.op60,
  //                             ),
  //                             fontSize: FontSize.s16,
  //                           ),
  //                         ),
  //                         iconSize: AppSize.s36,
  //                         menuMaxHeight: AppSize.s300,
  //                         borderRadius: AppSize.radius10,
  //                         autovalidateMode: AutovalidateMode.always,
  //                         validator: (value) {
  //                           if (value == Constants.nullValue) {
  //                             return AppStrings.dropdownIsRequired;
  //                           }
  //                           return Constants.nullValue;
  //                         },
  //                         value: selectedparent,
  //                         iconDisabledColor: ColorManager.white,
  //                         decoration: InputDecoration(
  //                           border: _addUserTextFieldBorderProperties(),
  //                           enabledBorder: _addUserTextFieldBorderProperties(),
  //                           focusedBorder: _addUserTextFieldBorderProperties(),
  //                           hintStyle: Theme.of(context).textTheme.titleMedium,
  //                           hintText: AppStrings.usersParentHint,
  //                           contentPadding: const EdgeInsets.symmetric(
  //                             horizontal: AppPadding.p20,
  //                           ),
  //                           iconColor: ColorManager.white,
  //                         ),
  //                         iconEnabledColor: ColorManager.white,
  //                         dropdownColor: ColorManager.white,
  //                         elevation: AppSize.s0.toInt(),
  //                         style: Theme.of(context).textTheme.titleLarge,
  //                         selectedItemBuilder: (context) {
  //                           return parentList
  //                                   ?.map(
  //                                     (e) => SizedBox(
  //                                       width: AppSize.s250,
  //                                       child: Text(
  //                                         e.username,
  //                                         style: Theme.of(context)
  //                                             .textTheme
  //                                             .titleLarge,
  //                                         overflow: TextOverflow.fade,
  //                                         textAlign: TextAlign.left,
  //                                       ),
  //                                     ),
  //                                   )
  //                                   .toList() ??
  //                               [];
  //                         },
  //                         onChanged: (singleParentData) {
  //                           selectedparent = singleParentData;
  //                         },
  //                         items: parentList?.map(
  //                           (SingleParentData value) {
  //                             return DropdownMenuItem<SingleParentData>(
  //                               value: value,
  //                               child: Center(
  //                                 child: Column(
  //                                   children: [
  //                                     Card(
  //                                       color: ColorManager.transparent,
  //                                       elevation: AppSize.s0,
  //                                       child: Text(
  //                                         value.username,
  //                                         style: Theme.of(context)
  //                                             .textTheme
  //                                             .bodyMedium,
  //                                         textAlign: TextAlign.center,
  //                                       ),
  //                                     ),
  //                                     if (parentList?.last != value)
  //                                       Divider(
  //                                         color:
  //                                             ColorManager.primary.withOpacity(
  //                                           AppOpacity.op70,
  //                                         ),
  //                                         height: AppSize.s1,
  //                                       ),
  //                                   ],
  //                                 ),
  //                               ),
  //                             );
  //                           },
  //                         ).toList(),
  //                       ),
  //                     );
  //                   },
  //                 ),
  //               ),
  //               const SizedBox(height: AppSize.s16),
  //               _getInputTextField(
  //                 AppStrings.userFirstNameHint,
  //                 _firstNameController,
  //               ),
  //               const SizedBox(height: AppSize.s16),
  //               _getInputTextField(
  //                 AppStrings.userLastNameHint,
  //                 _lastNameController,
  //               ),
  //               const SizedBox(height: AppSize.s16),
  //               _getInputTextField(
  //                 AppStrings.userPhoneHint,
  //                 _phoneController,
  //               ),
  //               const SizedBox(height: AppSize.s16),
  //               _getInputTextField(
  //                 AppStrings.userNotesHint,
  //                 _notesController,
  //               ),
  //               const SizedBox(height: AppSize.s16),
  //               Container(
  //                 width: Constants.width(context),
  //                 height: AppSize.s46,
  //                 margin: const EdgeInsets.symmetric(
  //                   horizontal: AppMargin.m16,
  //                   vertical: AppMargin.m16,
  //                 ),
  //                 child: StreamBuilder<bool>(
  //                   stream: _addUserViewModel.outputAreAllInputsValid,
  //                   builder: (context, snapshot) {
  //                     return ElevatedButton(
  //                       onPressed: () {
  //                         FocusScope.of(context).unfocus();
  //                         bool isTextInputsValid =
  //                             snapshot.data ?? Constants.falseVal;
  //                         setState(() {});
  //                         _addUserViewModel.saveFloatingButton(
  //                           isTextInputsValid,
  //                           selectedparent,
  //                           selectedprofile,
  //                         );
  //                       },
  //                       style: ElevatedButton.styleFrom(
  //                         backgroundColor: ColorManager.white,
  //                       ),
  //                       child: Text(
  //                         AppStrings.userSavefloatingButton,
  //                         style: getSemiBoldStyle(
  //                           color: ColorManager.primary,
  //                           fontSize: FontSize.s20,
  //                         ),
  //                       ),
  //                     );
  //                   },
  //                 ),
  //               ),
  //               const SizedBox(height: AppSize.s16),
  //             ],
  //           ),
  //         ),
  //       ],
  //     ),
  //   );
  // }

  // Widget _getInputTextField(
  //   String? hintText,
  //   controller, [
  //   bool? isRequiredValidation,
  // ]) {
  //   return Container(
  //     margin: const EdgeInsets.symmetric(horizontal: AppMargin.m16),
  //     height: isRequiredValidation != Constants.nullValue &&
  //             isRequiredValidation != Constants.trueVal
  //         ? AppSize.s60
  //         : AppSize.s50,
  //     child: Directionality(
  //       textDirection: TextDirection.ltr,
  //       child: TextFormField(
  //         controller: controller,
  //         onFieldSubmitted: (value) {
  //           FocusScope.of(context).unfocus();
  //         },
  //         textDirection: TextDirection.rtl,
  //         textAlign: TextAlign.left,
  //         keyboardType: TextInputType.text,
  //         onEditingComplete: () {
  //           FocusScope.of(context).unfocus();
  //         },
  //         autocorrect: Constants.falseVal,
  //         enableSuggestions: Constants.falseVal,
  //         style: Theme.of(context).textTheme.titleLarge,
  //         decoration: InputDecoration(
  //           labelStyle: getMediumStyle(
  //             color: ColorManager.white.withOpacity(AppOpacity.op40),
  //             fontSize: FontSize.s16,
  //           ),
  //           contentPadding: const EdgeInsets.symmetric(
  //             horizontal: AppPadding.p12,
  //             vertical: AppPadding.p12,
  //           ),
  //           isDense: Constants.trueVal,
  //           labelText: hintText,
  //           enabledBorder: _addUserTextFieldBorderProperties(),
  //           border: _addUserTextFieldBorderProperties(),
  //           focusedBorder: _addUserTextFieldBorderProperties(),
  //           errorBorder: _addUserTextFieldBorderProperties(),
  //           focusedErrorBorder: _addUserTextFieldBorderProperties(),
  //           hintTextDirection: TextDirection.ltr,
  //           errorText: isRequiredValidation != Constants.nullValue &&
  //                   isRequiredValidation != Constants.trueVal
  //               ? AppStrings.inputIsEmpty
  //               : Constants.nullValue,
  //         ),
  //       ),
  //     ),
  //   );
  // }

  // _addUserTextFieldBorderProperties() {
  //   return OutlineInputBorder(
  //     borderRadius: AppSize.radius10,
  //     borderSide: BorderSide(
  //       color: ColorManager.white.withOpacity(AppOpacity.op70),
  //       width: AppSize.s1_5,
  //     ),
  //   );
  // }
}
