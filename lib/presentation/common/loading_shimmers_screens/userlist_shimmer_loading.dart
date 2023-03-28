import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:sasuki/app/app_inits_funs/constants.dart';
import 'package:sasuki/app/resources/other_managers/assets_manager.dart';
import 'package:sasuki/app/resources/other_managers/color_manager.dart';
import 'package:sasuki/app/resources/other_managers/strings_manager.dart';
import 'package:sasuki/app/resources/values_manager/app_margin.dart';
import 'package:sasuki/app/resources/values_manager/app_padding.dart';
import 'package:sasuki/app/resources/values_manager/app_size.dart';
import 'package:sasuki/app/shared_widgets/item_card.dart';
import 'package:sasuki/app/shared_funs/screen_width.dart';
import 'package:sasuki/app/shared_widgets/app_background.dart';
import 'package:sasuki/app/shared_widgets/single_card_statistics.dart';
import 'package:sasuki/domain/models/dashboard/dashboard.dart';
import 'package:sasuki/domain/models/users_list/users_list.dart';

class UsersListView extends StatelessWidget {
  const UsersListView({super.key});

  @override
  Widget build(BuildContext context) {
    return AppBackground(
      isSecondAppBackground: Constants.falseBool,
      child: _getContentWidget(context),
    );
  }

  Widget _getContentWidget(context) {
    return Column(
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
                  SvgPicture.asset(IconsAssets.menu),
                  Text(
                    AppStrings.usersUsersList,
                    style: Theme.of(context).textTheme.headlineMedium,
                  ),
                  Container(),
                ],
              ),
              const SizedBox(height: AppSize.s20),
              SingleCardStatistics(
                          totalUsers:
                              "${outputUsersListData.data?.total ?? Constants.dash}",
                          activeUsers:
                              "${outputDashboardData.data?.data?.activeUsersCount ?? Constants.dash}",
                          expiredUsers:
                              "${outputDashboardData.data?.data?.expiredUsersCount ?? Constants.dash}",
                          onlineUsers:
                              "${outputDashboardData.data?.data?.usersOnlineCount ?? Constants.dash}",
                        ),
              const SizedBox(height: AppSize.s15),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SizedBox(
                    width: getScreenWidth(context) * 0.6,
                    child: _getSearchTextField(),
                  ),
                  InkWell(
                    onTap: _showFilterDialog,
                    child: SvgPicture.asset(
                      IconsAssets.filter,
                      width: AppSize.s18,
                      height: AppSize.s18,
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      // TODO : Add code for add user
                      // Nav.navTo(context, Routes.addUserRoute);
                    },
                    child: Container(
                      padding: const EdgeInsets.all(AppPadding.p7),
                      decoration: const BoxDecoration(
                        color: ColorManager.primaryshade1,
                        shape: BoxShape.circle,
                      ),
                      child: SvgPicture.asset(
                        IconsAssets.add,
                        width: AppSize.s24,
                        height: AppSize.s24,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: AppSize.s15),
            ],
          ),
        ),
        Expanded(
          child: _getUsersList(),
        ),
      ],
    );
  }
  

  _getSearchTextField() {
    return Stack(
      children: [
        TextFormField(
          controller: _searchInputController,
          onEditingComplete: _searchUsers,
          onFieldSubmitted: (value) => _searchUsers(),
          decoration: const InputDecoration(
            hintText: AppStrings.usersSearchusers,
            fillColor: ColorManager.greyshade1,
          ),
        ),
        Container(
          margin: const EdgeInsets.only(
            top: AppMargin.m10,
            right: AppMargin.m12,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              InkWell(
                onTap: () {
                  FocusScope.of(context).unfocus();
                  _searchInputController.clear();
                  _searchUsers();
                },
                child: SvgPicture.asset(
                  IconsAssets.clearInput,
                  theme: const SvgTheme(
                    currentColor: ColorManager.greyNeutral,
                  ),
                ),
              ),
              InkWell(
                onTap: _searchUsers,
                child: SvgPicture.asset(
                  height: AppSize.s18,
                  width: AppSize.s18,
                  IconsAssets.search,
                  theme: const SvgTheme(
                    currentColor: ColorManager.greyNeutral,
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  _searchUsers() {
    FocusScope.of(context).unfocus();
    setState(() => loadFilteredUsers = Constants.trueBool);
    _usersListViewModel.getUserFromSearch();
  }

  Widget _getUsersList() {
    return StreamBuilder<List<UsersListData>?>(
      stream: _usersListViewModel.outputUsersList,
      builder: (context, snapshot) {
        // ignore: prefer_is_empty
        if (snapshot.data?.length == Constants.oneNum ||
            snapshot.data?.length == Constants.zeroNum) {
          WidgetsBinding.instance.addPostFrameCallback((_) {
            Future.delayed(
              Duration(seconds: Constants.oneNum.toInt()),
              () => setState(() => loadFilteredUsers = Constants.falseBool),
            );
          });
        }
        return !loadFilteredUsers
            // ignore: prefer_is_empty
            ? snapshot.data?.length != Constants.zeroNum
                ? SingleChildScrollView(
                    physics: const AlwaysScrollableScrollPhysics(),
                    controller: _scrollController,
                    child: loadingMoreUsers
                        ? Column(
                            children: [
                              _singleUser(snapshot.data, context),
                              const SizedBox(height: AppSize.s20),
                              const Center(
                                child: CircularProgressIndicator(
                                  valueColor: AlwaysStoppedAnimation<Color>(
                                    ColorManager.whiteNeutral,
                                  ),
                                ),
                              ),
                            ],
                          )
                        : _singleUser(snapshot.data, context),
                  )
                : Container(
                    margin: const EdgeInsets.only(top: AppMargin.m38),
                    child: Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          SvgPicture.asset(ImageAssets.emptyState),
                          const SizedBox(height: AppSize.s20),
                          Text(
                            AppStrings.noUsersFound,
                            style: Theme.of(context).textTheme.titleMedium,
                          ),
                          const SizedBox(height: AppSize.s10),
                          IconButton(
                            onPressed: () {
                              FocusScope.of(context).unfocus();
                              setState(() => loadFilteredUsers = true);
                              _usersListViewModel.refreshUsersList();
                            },
                            icon: const Icon(
                              Icons.refresh,
                              size: AppSize.s32,
                              color: ColorManager.greyNeutral,
                            ),
                          ),
                        ],
                      ),
                    ),
                  )
            : const Center(
                child: CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation<Color>(
                    ColorManager.whiteNeutral,
                  ),
                ),
              );
      },
    );
  }

  Widget _singleUser(List<UsersListData>? listOfUsers, BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      mainAxisSize: MainAxisSize.min,
      children: listOfUsers?.map(
            (usersListData) {
              return InkWell(
                onTap: () {
                  // TODO: Add code for user details
                  // Nav.navTo(context, Routes.userDetailsRoute);
                  // instance<UserDetailsViewModel>()
                  //     .getUserApiOverview(usersListData.id);
                },
                child: ItemCard(
                  fullName: usersListData.firstname.isNotEmpty
                      ? "${usersListData.firstname} ${usersListData.lastname}"
                      : Constants.dash,
                  profileName:
                      usersListData.profileDetails?.name ?? Constants.dash,
                  balance: usersListData.balance.isNotEmpty
                      ? usersListData.balance
                      : Constants.dash,
                  expireOn: usersListData.expiration,
                  status: _getUserStatusString(usersListData),
                  statusColor: _getUserStatusColor(usersListData),
                  username: usersListData.username,
                ),
              );
            },
          ).toList() ??
          [],
    );
  }
}
