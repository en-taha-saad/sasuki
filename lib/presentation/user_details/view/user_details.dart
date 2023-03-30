import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:lottie/lottie.dart';
import 'package:sasuki/app/app_inits_funs/constants.dart';
import 'package:sasuki/app/init_screens_dependencies/init_app_module.dart';
import 'package:sasuki/app/resources/other_managers/assets_manager.dart';
import 'package:sasuki/app/resources/other_managers/color_manager.dart';
import 'package:sasuki/app/resources/other_managers/opacity_manager.dart';
import 'package:sasuki/app/resources/other_managers/strings_manager.dart';
import 'package:sasuki/app/resources/routes_manager/nav_funcs.dart';
import 'package:sasuki/app/resources/routes_manager/routes.dart';
import 'package:sasuki/app/resources/values_manager/app_margin.dart';
import 'package:sasuki/app/resources/values_manager/app_padding.dart';
import 'package:sasuki/app/resources/values_manager/app_size.dart';
import 'package:sasuki/app/shared_funs/get_status_vals.dart';
import 'package:sasuki/app/shared_widgets/card_title.dart';
import 'package:sasuki/app/shared_widgets/single_card_statistics.dart';
import 'package:sasuki/app/shared_widgets/userdetails_list_tile.dart';
import 'package:sasuki/domain/models/dashboard_card_element.dart';
import 'package:sasuki/domain/models/filter_lists/profile_list.dart';
import 'package:sasuki/domain/models/user_details/user_overview_api.dart';
import 'package:sasuki/presentation/common/state_render/states/flow_state.dart';
import 'package:sasuki/presentation/common/state_render/states/flow_state_extension.dart';
import 'package:sasuki/presentation/user_details/viewmodel/user_details_viewmodel.dart';

class UserDetailsView extends StatefulWidget {
  const UserDetailsView({Key? key}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _UserDetailsViewState createState() => _UserDetailsViewState();
}

class _UserDetailsViewState extends State<UserDetailsView> {
  final UserDetailsViewModel _viewModel = instance<UserDetailsViewModel>();
  UserOverviewApi? userOverviewApiVar;
  List<ProfileData>? profileList;
  ProfileData? selectedprofile;

  final TextEditingController _newUsernameController = TextEditingController();
  final TextEditingController _amountController = TextEditingController();
  final TextEditingController _commentController = TextEditingController();

  _bind() {
    _viewModel.start();
    _viewModel.outputUserOverviewApi.listen(
      (event) {
        if (mounted) {
          // check whether the state object is in tree
          setState(() => userOverviewApiVar = event);
        }
      },
    );
  }

  @override
  void dispose() {
    _viewModel.dispose();
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
      stream: _viewModel.outputState,
      builder: (context, AsyncSnapshot<FlowState> snapshot) {
        return snapshot.data?.getScreenWidget(
              context,
              _getScreenView(context),
              () async {
                ScaffoldMessenger.of(context).hideCurrentSnackBar();
                await _viewModel.getUserDataStreamingly();
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
          const SizedBox(height: AppSize.s20),
          Container(
            margin: const EdgeInsets.symmetric(horizontal: AppPadding.p25),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    InkWell(
                      child: SvgPicture.asset(IconsAssets.back),
                      onTap: () => Nav.popRoute(context),
                    ),
                    Text(
                      AppStrings.userOverviewTitle,
                      style: Theme.of(context).textTheme.headlineMedium,
                    ),
                    InkWell(
                      child: SvgPicture.asset(IconsAssets.actions),
                      onTap: () {
                        // TODO : Add code for actions
                      },
                    ),
                  ],
                ),
                const SizedBox(height: AppSize.s20),
                Container(
                  padding: const EdgeInsets.symmetric(
                    vertical: AppSize.s15,
                    horizontal: AppSize.s20,
                  ),
                  height: AppSize.s72,
                  decoration: BoxDecoration(
                    color: ColorManager.primaryshade1,
                    borderRadius: BorderRadius.circular(AppSize.s12),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            AppStrings.userOverviewStatus,
                            style: Theme.of(context).textTheme.titleLarge,
                          ),
                          Row(
                            children: [
                              Container(
                                width: AppSize.s8,
                                height: AppSize.s8,
                                margin: const EdgeInsets.only(
                                  right: AppSize.s5,
                                ),
                                decoration: BoxDecoration(
                                  color: getStatusColor(
                                    getStatusString(
                                        userOverviewApiVar?.data?.status),
                                  ),
                                  shape: BoxShape.circle,
                                ),
                              ),
                              Text(
                                getStatusString(
                                    userOverviewApiVar?.data?.status),
                                style: Theme.of(context).textTheme.labelSmall,
                              ),
                            ],
                          ),
                        ],
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            AppStrings.userOverviewDailyTaffic,
                            style: Theme.of(context).textTheme.titleLarge,
                          ),
                          Text(
                            "${userOverviewApiVar?.data?.remainingRxtx ?? Constants.dash}",
                            style: Theme.of(context).textTheme.labelSmall,
                          ),
                        ],
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            AppStrings.userOverviewUptime,
                            style: Theme.of(context).textTheme.titleLarge,
                          ),
                          Text(
                            "${userOverviewApiVar?.data?.remainingUptime ?? Constants.dash}",
                            style: Theme.of(context).textTheme.labelSmall,
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: AppSize.s15),
              ],
            ),
          ),
          Container(
            width: MediaQuery.of(context).size.width,
            child: _getUserDetailsContent(),
            decoration: const BoxDecoration(
              color: ColorManager.secondary,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(AppSize.s35),
                topRight: Radius.circular(AppSize.s35),
              ),
            ),
          ),
        ],
      ),
    );
  }

  _getUserDetailsContent() {
    return Container(
      margin: const EdgeInsets.only(
        right: AppMargin.m25,
        left: AppMargin.m25,
        bottom: AppMargin.m50,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          getCardTitle(
            IconsAssets.information,
            AppStrings.userOverviewUserInformation,
            context,
          ),
          UserDetailsListTile(
                list: _viewModel.listOfUserInforms(userOverviewApiVar),
              ),
          getCardTitle(
            IconsAssets.userServiceInformation,
            AppStrings.userOverviewServiceInformation,
            context,
          ),
          UserDetailsListTile(
                list: _viewModel.listOfServiceInforms(userOverviewApiVar),
              ),
        ],
      ),
    );
  }

  // Widget _getScreenView0(context) {
  //   return Scaffold(
  //     appBar: CustomAppBar(
  //       actions: [
  //         PopupMenuButton<String>(
  //           onSelected: (String choice) => _openActions(choice, context),
  //           color: ColorManager.white,
  //           elevation: Constants.zeroDouble,
  //           enabled: Constants.trueVal,
  //           icon: SvgPicture.asset(
  //             ImageAssets.userDetailsActions,
  //             color: ColorManager.white,
  //           ),
  //           padding: const EdgeInsets.all(AppPadding.p12),
  //           position: PopupMenuPosition.under,
  //           shape: RoundedRectangleBorder(
  //             borderRadius: AppSize.radius10,
  //           ),
  //           itemBuilder: (BuildContext context) {
  //             return _viewModel.userActions.map(
  //               (String choice) {
  //                 return PopupMenuItem<String>(
  //                   value: choice,
  //                   child: Text(
  //                     choice,
  //                     style: getRegularStyle(
  //                       color: ColorManager.primary,
  //                       fontSize: FontSize.s16,
  //                     ),
  //                   ),
  //                 );
  //               },
  //             ).toList();
  //           },
  //         ),
  //       ],
  //     ),
  //   );
  // }

  // void _openActions(String selectedAction, context) async {
  //   if (selectedAction == AppStrings.userActionDelete) {
  //     _showDialog(
  //       context,
  //       _getDeleteDialogContent(context),
  //       Colors.white,
  //     );
  //   }
  //   if (selectedAction == AppStrings.userActionRename) {
  //     _showDialog(
  //       context,
  //       _getRenameUsernameDialogContent(context),
  //       ColorManager.backgroundCenter,
  //     );
  //   }
  //   if (selectedAction == AppStrings.userActionChangeProfile) {
  //     selectedprofile = Constants.nullValue;
  //     _showDialog(
  //       context,
  //       _getChangeProfileDialogContent(context),
  //       ColorManager.backgroundCenter,
  //     );
  //     if (profileList == Constants.nullValue ||
  //         profileList?.length == Constants.zeroNum) {
  //       await _viewModel.getProfileList();
  //     }
  //   }
  //   if (selectedAction == AppStrings.userActionActivate) {
  //     // TODO: implement activate user
  //     // Nav.navTo(context, Routes.userActivationInformsRoute);
  //   }
  //   if (selectedAction == AppStrings.userActionEdit) {
  //     // TODO: implement edit user
  //     // Nav.navTo(context, Routes.editUserRoute);
  //   }
  //   if (selectedAction == AppStrings.userActionExtend) {
  //     // TODO: implement extend user
  //     // Nav.navTo(context, Routes.extendUserRoute);
  //   }
  //   if (selectedAction == AppStrings.userActionDeposit) {
  //     _showDialog(
  //       context,
  //       _getDepositDialogContent(context),
  //       ColorManager.backgroundCenter,
  //     );
  //   }
  //   if (selectedAction == AppStrings.userActionWithdrawal) {
  //     _showDialog(
  //       context,
  //       _getWithdrawDialogContent(context),
  //       ColorManager.backgroundCenter,
  //     );
  //   }
  //   if (selectedAction == AppStrings.userActionPay) {
  //     _showDialog(
  //       context,
  //       _getPayDebtDialogContent(context),
  //       ColorManager.backgroundCenter,
  //     );
  //   }
  // }

  // Widget _getContentWidget() {
  //   return SingleChildScrollView(
  //     physics: const AlwaysScrollableScrollPhysics(),
  //     child: Container(
  //       color: ColorManager.black.withOpacity(AppOpacity.op30),
  //       child: Column(
  //         crossAxisAlignment: CrossAxisAlignment.start,
  //         mainAxisAlignment: MainAxisAlignment.start,
  //         mainAxisSize: MainAxisSize.min,
  //         children: [
  //           const SizedBox(height: AppSize.s16),
  //           _getSingleCard(
  //             AppStrings.userOverviewUserInformation,
  //             ImageAssets.userInformationIcon,
  //             _viewModel.listOfUserInforms(userOverviewApiVar),
  //           ),
  //           const SizedBox(height: AppSize.s16),
  //           _getSingleCard(
  //             AppStrings.userOverviewServiceInformation,
  //             ImageAssets.serviceInformationIcon,
  //             _viewModel.listOfServiceInforms(userOverviewApiVar),
  //           ),
  //           const SizedBox(height: AppSize.s46),
  //         ],
  //       ),
  //     ),
  //   );
  // }

  // Widget _getSingleCard(
  //   String cardTitle,
  //   String titleIcon,
  //   List<CardElement> listOfCardElements,
  // ) {
  //   return Column(
  //     mainAxisAlignment: MainAxisAlignment.start,
  //     crossAxisAlignment: CrossAxisAlignment.start,
  //     mainAxisSize: MainAxisSize.min,
  //     children: [
  //       Container(
  //         margin: const EdgeInsets.symmetric(horizontal: AppMargin.m16),
  //         child: Row(
  //           mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //           children: [
  //             Text(
  //               cardTitle,
  //               style: Theme.of(context).textTheme.titleMedium,
  //             ),
  //             SvgPicture.asset(
  //               titleIcon,
  //             ),
  //           ],
  //         ),
  //       ),
  //       Container(
  //         margin: const EdgeInsets.only(top: AppMargin.m16),
  //         child: Column(
  //           children: listOfCardElements
  //               .map(
  //                 (element) => ListTile(
  //                   leading: SvgPicture.asset(
  //                     element.icon,
  //                     color: ColorManager.white.withOpacity(AppOpacity.op70),
  //                     height: AppSize.s28,
  //                     width: AppSize.s28,
  //                   ),
  //                   title: Text(
  //                     element.title,
  //                     style: Theme.of(context).textTheme.titleMedium,
  //                   ),
  //                   subtitle: Text(
  //                     element.subtitle,
  //                     style: Theme.of(context).textTheme.headlineMedium,
  //                   ),
  //                 ),
  //               )
  //               .toList(),
  //         ),
  //       ),
  //     ],
  //   );
  // }

  // _showDialog(BuildContext context, Widget? child, Color color) {
  //   return showDialog(
  //     context: context,
  //     builder: (BuildContext context) {
  //       return Dialog(
  //         insetPadding: const EdgeInsets.all(AppPadding.p16),
  //         shape: RoundedRectangleBorder(borderRadius: AppSize.radius10),
  //         elevation: AppSize.s1_5,
  //         backgroundColor: Colors.transparent,
  //         child: Container(
  //           decoration: BoxDecoration(
  //             color: color,
  //             shape: BoxShape.rectangle,
  //             borderRadius: AppSize.radius10,
  //             boxShadow: const [BoxShadow(color: Colors.black26)],
  //           ),
  //           child: child,
  //         ),
  //       );
  //     },
  //   );
  // }

  // Widget _getDeleteDialogContent(BuildContext context) {
  //   return Padding(
  //     padding: const EdgeInsets.all(AppPadding.p16),
  //     child: Column(
  //       mainAxisSize: MainAxisSize.min,
  //       mainAxisAlignment: MainAxisAlignment.center,
  //       crossAxisAlignment: CrossAxisAlignment.center,
  //       children: [
  //         SizedBox(
  //           height: AppSize.s100,
  //           width: AppSize.s100,
  //           child: Lottie.asset(JsonAssets.error),
  //         ),
  //         Text(
  //           "${AppStrings.actionDeleteUserdialogTitle} ${userOverviewApiVar?.data?.username} ?",
  //           textAlign: TextAlign.center,
  //         ),
  //         const SizedBox(height: AppSize.s16),
  //         Row(
  //           mainAxisAlignment: MainAxisAlignment.spaceEvenly,
  //           crossAxisAlignment: CrossAxisAlignment.center,
  //           children: [
  //             ElevatedButton(
  //               style: ElevatedButton.styleFrom(
  //                 backgroundColor: ColorManager.primary,
  //                 foregroundColor: ColorManager.white,
  //                 textStyle: Theme.of(context).textTheme.titleMedium,
  //               ),
  //               onPressed: () => Nav.popRoute(context),
  //               child: const Text(AppStrings.cancelButton),
  //             ),
  //             TextButton(
  //               style: TextButton.styleFrom(
  //                 foregroundColor: ColorManager.primary,
  //               ),
  //               onPressed: () {
  //                 Nav.popRoute(context);
  //                 _viewModel.deleteUser(context);
  //               },
  //               child: const Text(AppStrings.deleteButton),
  //             ),
  //           ],
  //         ),
  //       ],
  //     ),
  //   );
  // }

  // Widget _getRenameUsernameDialogContent(BuildContext context) {
  //   return Padding(
  //     padding: const EdgeInsets.all(AppPadding.p16),
  //     child: Column(
  //       mainAxisSize: MainAxisSize.min,
  //       mainAxisAlignment: MainAxisAlignment.center,
  //       crossAxisAlignment: CrossAxisAlignment.center,
  //       children: [
  //         Text(
  //           AppStrings.usernameInputDialogtitle,
  //           style: Theme.of(context).textTheme.headlineMedium,
  //           textAlign: TextAlign.center,
  //         ),
  //         const SizedBox(height: AppSize.s20),
  //         _getTextFieldInput(
  //           AppStrings.usernameInputtitle,
  //           _newUsernameController,
  //           TextInputType.text,
  //           Constants.trueVal,
  //         ),
  //         const SizedBox(height: AppSize.s16),
  //         Row(
  //           mainAxisAlignment: MainAxisAlignment.spaceEvenly,
  //           crossAxisAlignment: CrossAxisAlignment.center,
  //           children: [
  //             TextButton(
  //               style: TextButton.styleFrom(side: BorderSide.none),
  //               onPressed: () => Nav.popRoute(context),
  //               child: Text(
  //                 AppStrings.cancelButton,
  //                 style: Theme.of(context).textTheme.headlineSmall,
  //               ),
  //             ),
  //             TextButton(
  //               style: TextButton.styleFrom(side: BorderSide.none),
  //               onPressed: () {
  //                 if (_newUsernameController.text.isNotEmpty) {
  //                   FocusScope.of(context).unfocus();
  //                   Nav.popRoute(context);
  //                   _viewModel.renameUsername(_newUsernameController.text);
  //                 }
  //               },
  //               child: Text(
  //                 AppStrings.userActionSubmitButton,
  //                 style: Theme.of(context).textTheme.headlineMedium,
  //               ),
  //             ),
  //           ],
  //         ),
  //       ],
  //     ),
  //   );
  // }

  // Widget _getChangeProfileDialogContent(BuildContext context) {
  //   return Padding(
  //     padding: const EdgeInsets.all(AppPadding.p16),
  //     child: Column(
  //       mainAxisSize: MainAxisSize.min,
  //       mainAxisAlignment: MainAxisAlignment.center,
  //       crossAxisAlignment: CrossAxisAlignment.center,
  //       children: [
  //         Text(
  //           AppStrings.profileInputDialogtitle,
  //           style: Theme.of(context).textTheme.headlineMedium,
  //           textAlign: TextAlign.center,
  //         ),
  //         const SizedBox(height: AppSize.s16),
  //         SizedBox(
  //           width: MediaQuery.of(context).size.width - AppSize.s20,
  //           child: StreamBuilder<List<ProfileData>>(
  //             stream: _viewModel.outputProfileList,
  //             builder: (_, snapshot0) {
  //               debugPrint("1@snapshot0.data: ${snapshot0.data}");
  //               if (profileList == Constants.nullValue ||
  //                   profileList?.length == Constants.zero) {
  //                 debugPrint("1@profileList: $profileList");
  //                 profileList = snapshot0.data;
  //               }
  //               debugPrint("2@profileList: $profileList");
  //               // ignore: prefer_is_empty
  //               return Container(
  //                 margin: const EdgeInsets.only(top: AppMargin.m12),
  //                 child: DropdownButtonFormField<ProfileData>(
  //                   hint: Text(
  //                     AppStrings.usersParentHint,
  //                     style: getRegularStyle(
  //                       color: ColorManager.white.withOpacity(
  //                         AppOpacity.op60,
  //                       ),
  //                       fontSize: FontSize.s16,
  //                     ),
  //                   ),
  //                   iconSize: AppSize.s36,
  //                   menuMaxHeight: AppSize.s300,
  //                   borderRadius: AppSize.radius10,
  //                   value: selectedprofile,
  //                   iconDisabledColor: ColorManager.white,
  //                   decoration: InputDecoration(
  //                     border: _filterTextFieldBorderProperties(),
  //                     enabledBorder: _filterTextFieldBorderProperties(),
  //                     focusedBorder: _filterTextFieldBorderProperties(),
  //                     hintStyle: Theme.of(context).textTheme.titleMedium,
  //                     hintText: AppStrings.usersParentHint,
  //                     contentPadding: const EdgeInsets.symmetric(
  //                       horizontal: AppPadding.p20,
  //                     ),
  //                     iconColor: ColorManager.white,
  //                   ),
  //                   iconEnabledColor: ColorManager.white,
  //                   dropdownColor: ColorManager.white,
  //                   elevation: AppSize.s0.toInt(),
  //                   style: Theme.of(context).textTheme.titleMedium,
  //                   selectedItemBuilder: (context) {
  //                     return profileList
  //                             ?.map(
  //                               (e) => SizedBox(
  //                                 width: AppSize.s250,
  //                                 child: Text(
  //                                   e.name,
  //                                   style:
  //                                       Theme.of(context).textTheme.titleMedium,
  //                                   overflow: TextOverflow.fade,
  //                                   textAlign: TextAlign.left,
  //                                 ),
  //                               ),
  //                             )
  //                             .toList() ??
  //                         [];
  //                   },
  //                   onChanged: (singleProfileData) {
  //                     selectedprofile = singleProfileData;
  //                   },
  //                   items: profileList?.map(
  //                     (ProfileData value) {
  //                       return DropdownMenuItem<ProfileData>(
  //                         value: value,
  //                         child: Center(
  //                           child: Column(
  //                             children: [
  //                               Card(
  //                                 color: ColorManager.transparent,
  //                                 elevation: AppSize.s0,
  //                                 child: Text(
  //                                   value.name,
  //                                   style:
  //                                       Theme.of(context).textTheme.bodyMedium,
  //                                   textAlign: TextAlign.center,
  //                                 ),
  //                               ),
  //                               if (profileList?.last != value)
  //                                 Divider(
  //                                   color: ColorManager.primary.withOpacity(
  //                                     AppOpacity.op70,
  //                                   ),
  //                                   height: AppSize.s1,
  //                                 ),
  //                             ],
  //                           ),
  //                         ),
  //                       );
  //                     },
  //                   ).toList(),
  //                 ),
  //               );
  //             },
  //           ),
  //         ),
  //         const SizedBox(height: AppSize.s16),
  //         Row(
  //           mainAxisAlignment: MainAxisAlignment.spaceEvenly,
  //           crossAxisAlignment: CrossAxisAlignment.center,
  //           children: [
  //             TextButton(
  //               style: TextButton.styleFrom(side: BorderSide.none),
  //               onPressed: () => Nav.popRoute(context),
  //               child: Text(
  //                 AppStrings.cancelButton,
  //                 style: Theme.of(context).textTheme.headlineSmall,
  //               ),
  //             ),
  //             TextButton(
  //               style: TextButton.styleFrom(side: BorderSide.none),
  //               onPressed: () {
  //                 if (selectedprofile != Constants.nullValue) {
  //                   Nav.popRoute(context);
  //                   _viewModel.changeProfile(selectedprofile?.id);
  //                 }
  //               },
  //               child: Text(
  //                 AppStrings.userActionSubmitButton,
  //                 style: Theme.of(context).textTheme.headlineMedium,
  //               ),
  //             ),
  //           ],
  //         ),
  //       ],
  //     ),
  //   );
  // }

  // Widget _getDepositDialogContent(BuildContext context) {
  //   return Padding(
  //     padding: const EdgeInsets.all(AppPadding.p16),
  //     child: Column(
  //       mainAxisSize: MainAxisSize.min,
  //       mainAxisAlignment: MainAxisAlignment.center,
  //       crossAxisAlignment: CrossAxisAlignment.center,
  //       children: [
  //         Text(
  //           AppStrings.depositAmountInputDialogtitle,
  //           style: Theme.of(context).textTheme.headlineMedium,
  //           textAlign: TextAlign.center,
  //         ),
  //         const SizedBox(height: AppSize.s20),
  //         _getTextFieldInput(
  //           AppStrings.amount,
  //           _amountController,
  //           TextInputType.number,
  //           Constants.trueVal,
  //         ),
  //         const SizedBox(height: AppSize.s16),
  //         _getTextFieldInput(AppStrings.comment, _commentController),
  //         const SizedBox(height: AppSize.s16),
  //         Row(
  //           mainAxisAlignment: MainAxisAlignment.spaceEvenly,
  //           crossAxisAlignment: CrossAxisAlignment.center,
  //           children: [
  //             TextButton(
  //               style: TextButton.styleFrom(side: BorderSide.none),
  //               onPressed: () => Nav.popRoute(context),
  //               child: Text(
  //                 AppStrings.cancelButton,
  //                 style: Theme.of(context).textTheme.headlineSmall,
  //               ),
  //             ),
  //             TextButton(
  //               style: TextButton.styleFrom(side: BorderSide.none),
  //               onPressed: () {
  //                 if (_amountController.text.isNotEmpty) {
  //                   FocusScope.of(context).unfocus();
  //                   Nav.popRoute(context);
  //                   _viewModel.depositAction(
  //                     _amountController.text,
  //                     _commentController.text,
  //                   );
  //                   _amountController.clear();
  //                   _commentController.clear();
  //                 }
  //               },
  //               child: Text(
  //                 AppStrings.userActionSubmitButton,
  //                 style: Theme.of(context).textTheme.headlineMedium,
  //               ),
  //             ),
  //           ],
  //         ),
  //       ],
  //     ),
  //   );
  // }

  // Widget _getWithdrawDialogContent(BuildContext context) {
  //   return Padding(
  //     padding: const EdgeInsets.all(AppPadding.p16),
  //     child: Column(
  //       mainAxisSize: MainAxisSize.min,
  //       mainAxisAlignment: MainAxisAlignment.center,
  //       crossAxisAlignment: CrossAxisAlignment.center,
  //       children: [
  //         Text(
  //           AppStrings.deductAmountInputDialogtitle,
  //           style: Theme.of(context).textTheme.headlineMedium,
  //           textAlign: TextAlign.center,
  //         ),
  //         const SizedBox(height: AppSize.s20),
  //         _getTextFieldInput(
  //           AppStrings.amount,
  //           _amountController,
  //           TextInputType.number,
  //           Constants.trueVal,
  //         ),
  //         const SizedBox(height: AppSize.s16),
  //         _getTextFieldInput(AppStrings.comment, _commentController),
  //         const SizedBox(height: AppSize.s16),
  //         Row(
  //           mainAxisAlignment: MainAxisAlignment.spaceEvenly,
  //           crossAxisAlignment: CrossAxisAlignment.center,
  //           children: [
  //             TextButton(
  //               style: TextButton.styleFrom(side: BorderSide.none),
  //               onPressed: () => Nav.popRoute(context),
  //               child: Text(
  //                 AppStrings.cancelButton,
  //                 style: Theme.of(context).textTheme.headlineSmall,
  //               ),
  //             ),
  //             TextButton(
  //               style: TextButton.styleFrom(side: BorderSide.none),
  //               onPressed: () {
  //                 if (_amountController.text.isNotEmpty) {
  //                   FocusScope.of(context).unfocus();
  //                   Nav.popRoute(context);
  //                   _viewModel.withdrawAction(
  //                     _amountController.text,
  //                     _commentController.text,
  //                   );
  //                   _amountController.clear();
  //                   _commentController.clear();
  //                 }
  //               },
  //               child: Text(
  //                 AppStrings.userActionSubmitButton,
  //                 style: Theme.of(context).textTheme.headlineMedium,
  //               ),
  //             ),
  //           ],
  //         ),
  //       ],
  //     ),
  //   );
  // }

  // _filterTextFieldBorderProperties() {
  //   return OutlineInputBorder(
  //     borderRadius: AppSize.radius10,
  //     borderSide: BorderSide(
  //       color: ColorManager.white,
  //       width: AppSize.s1_5,
  //     ),
  //   );
  // }

  // Widget _getTextFieldInput(hintText, controller, [type, bool? autoFocus]) {
  //   return SizedBox(
  //     width: AppSize.s265,
  //     height: AppSize.s50,
  //     child: Directionality(
  //       textDirection: TextDirection.ltr,
  //       child: TextFormField(
  //         controller: controller,
  //         autofocus: autoFocus ?? Constants.falseVal,
  //         textDirection: TextDirection.rtl,
  //         textAlign: TextAlign.left,
  //         keyboardType: type ?? TextInputType.text,
  //         onEditingComplete: () {
  //           FocusScope.of(context).unfocus();
  //         },
  //         onFieldSubmitted: (val) {
  //           FocusScope.of(context).unfocus();
  //           if (hintText == AppStrings.usernameInputtitle) {
  //             if (val.isNotEmpty) {
  //               Nav.popRoute(context);
  //               _viewModel.renameUsername(_newUsernameController.text);
  //               _newUsernameController.clear();
  //             }
  //           }
  //         },
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
  //           labelText: hintText,
  //           hintTextDirection: TextDirection.ltr,
  //         ),
  //       ),
  //     ),
  //   );
  // }

  // Widget? _getPayDebtDialogContent(context) {
  //   return Padding(
  //     padding: const EdgeInsets.all(AppPadding.p16),
  //     child: Column(
  //       mainAxisSize: MainAxisSize.min,
  //       mainAxisAlignment: MainAxisAlignment.center,
  //       crossAxisAlignment: CrossAxisAlignment.center,
  //       children: [
  //         Text(
  //           AppStrings.payDebtInputDialogtitle,
  //           style: Theme.of(context).textTheme.headlineMedium,
  //           textAlign: TextAlign.center,
  //         ),
  //         const SizedBox(height: AppSize.s20),
  //         _getTextFieldInput(
  //           AppStrings.amount,
  //           _amountController,
  //           TextInputType.number,
  //           Constants.trueVal,
  //         ),
  //         const SizedBox(height: AppSize.s16),
  //         _getTextFieldInput(AppStrings.comment, _commentController),
  //         const SizedBox(height: AppSize.s16),
  //         Row(
  //           mainAxisAlignment: MainAxisAlignment.spaceEvenly,
  //           children: [
  //             Text(
  //               AppStrings.totaldebtDialogText,
  //               style: Theme.of(context).textTheme.headlineMedium,
  //               textAlign: TextAlign.center,
  //             ),
  //             Text(
  //               "${_viewModel.paydebtInforms?.data?.total}",
  //               style: Theme.of(context).textTheme.headlineMedium,
  //               textAlign: TextAlign.center,
  //             ),
  //           ],
  //         ),
  //         const SizedBox(height: AppSize.s16),
  //         Row(
  //           mainAxisAlignment: MainAxisAlignment.spaceEvenly,
  //           crossAxisAlignment: CrossAxisAlignment.center,
  //           children: [
  //             TextButton(
  //               style: TextButton.styleFrom(side: BorderSide.none),
  //               onPressed: () => Nav.popRoute(context),
  //               child: Text(
  //                 AppStrings.cancelButton,
  //                 style: Theme.of(context).textTheme.headlineSmall,
  //               ),
  //             ),
  //             TextButton(
  //               style: TextButton.styleFrom(side: BorderSide.none),
  //               onPressed: () {
  //                 if (_amountController.text.isNotEmpty) {
  //                   if (_viewModel.paydebtInforms?.data?.total !=
  //                           Constants.nullValue &&
  //                       // ignore: unrelated_type_equality_checks
  //                       _viewModel.paydebtInforms?.data?.total !=
  //                           Constants.zero) {
  //                     FocusScope.of(context).unfocus();
  //                     Nav.popRoute(context);
  //                     _viewModel.payDebtAction(
  //                       _amountController.text,
  //                       _commentController.text,
  //                     );
  //                     _amountController.clear();
  //                     _commentController.clear();
  //                   }
  //                 }
  //               },
  //               child: Text(
  //                 AppStrings.userActionSubmitButton,
  //                 style: _viewModel.paydebtInforms?.data?.total !=
  //                             Constants.nullValue &&
  //                         // ignore: unrelated_type_equality_checks
  //                         _viewModel.paydebtInforms?.data?.total !=
  //                             Constants.zero
  //                     ? Theme.of(context).textTheme.headlineMedium
  //                     : Theme.of(context).textTheme.headlineSmall,
  //               ),
  //             ),
  //           ],
  //         ),
  //       ],
  //     ),
  //   );
  // }
}
