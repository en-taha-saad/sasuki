import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:sasuki/app/app_inits_funs/constants.dart';
import 'package:sasuki/app/init_screens_dependencies/init_app_module.dart';
import 'package:sasuki/app/resources/other_managers/assets_manager.dart';
import 'package:sasuki/app/resources/other_managers/color_manager.dart';
import 'package:sasuki/app/resources/other_managers/strings_manager.dart';
import 'package:sasuki/app/resources/routes_manager/nav_funcs.dart';
import 'package:sasuki/app/resources/routes_manager/routes.dart';
import 'package:sasuki/app/resources/values_manager/app_margin.dart';
import 'package:sasuki/app/resources/values_manager/app_size.dart';
import 'package:sasuki/app/shared_widgets/get_custome_appbar.dart';
import 'package:sasuki/app/shared_widgets/single_journal_card.dart';
import 'package:sasuki/domain/models/captcha/captcha.dart';
import 'package:sasuki/domain/models/manager_journal/manager_journal.dart';
import 'package:sasuki/presentation/common/state_render/states/flow_state.dart';
import 'package:sasuki/presentation/common/state_render/states/flow_state_extension.dart';
import 'package:sasuki/presentation/managers_journal/viewmodel/managers_journal_viewmodel.dart';

class ManagersJournalView extends StatefulWidget {
  const ManagersJournalView({Key? key}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _ManagersJournalViewState createState() => _ManagersJournalViewState();
}

class _ManagersJournalViewState extends State<ManagersJournalView> {
  final ManagersJournalViewModel _viewModel =
      instance<ManagersJournalViewModel>();
  final ScrollController _scrollController = ScrollController();
  bool loadingMoreJournal = Constants.falseBool;
  bool hidLoadingMoreJournal = Constants.falseBool;

  _bind() {
    _viewModel.start();
    _handleNext();
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

  _handleNext() {
    _scrollController.addListener(() {
      if (_scrollController.position.pixels ==
          _scrollController.position.maxScrollExtent) {
        setState(() {
          loadingMoreJournal = Constants.trueBool;
        });
        _viewModel.getNextManagersJournal();
        if (_scrollController.position.pixels !=
            _scrollController.position.maxScrollExtent) {
          setState(() {
            loadingMoreJournal = Constants.falseBool;
          });
        }
      } else {
        setState(() {
          loadingMoreJournal = Constants.trueBool;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<FlowState>(
      stream: _viewModel.outputState,
      builder: (context, AsyncSnapshot<FlowState> snapshot) {
        return snapshot.data?.getScreenWidget(
              context,
              _getScreenView(),
              () async {
                ScaffoldMessenger.of(context).hideCurrentSnackBar();
                await _viewModel.getManagersJournalStreamingly();
              },
            ) ??
            _getScreenView();
      },
    );
  }

  Widget _getScreenView() {
    return RefreshIndicator(
      onRefresh: () async => _viewModel.getManagersJournalForPull(),
      triggerMode: RefreshIndicatorTriggerMode.anywhere,
      backgroundColor: ColorManager.whiteNeutral,
      color: ColorManager.backgroundCenter,
      child: GestureDetector(
        onTap: () {
          FocusScope.of(context).unfocus();
        },
        child: _getContentWidget(context),
      ),
    );
  }

  Widget _getContentWidget(context) {
    return Container(
      color: ColorManager.secondary,
      child: Column(
        children: [
          Container(
            color: ColorManager.primaryshade1,
            child: Column(
              children: [
                AppSize.statusBarHeight(context),
                getCustomAppBar(context, AppStrings.drawerReports, true),
              ],
            ),
          ),
          Container(
            color: ColorManager.whiteNeutral.withOpacity(0.2),
            padding: const EdgeInsets.symmetric(
              horizontal: AppSize.s25,
              vertical: AppSize.s10,
            ),
            margin: const EdgeInsets.only(
              bottom: AppSize.s20,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      margin: const EdgeInsets.only(right: AppSize.s10),
                      child: SvgPicture.asset(
                        IconsAssets.reciept1,
                        theme: const SvgTheme(
                          currentColor: ColorManager.whiteNeutral,
                        ),
                        // ignore: deprecated_member_use
                        color: ColorManager.whiteNeutral,
                      ),
                    ),
                    Text(
                      AppStrings.drawerReportsJournal,
                      style:
                          Theme.of(context).textTheme.headlineMedium?.copyWith(
                                color: ColorManager.whiteNeutral,
                              ),
                    ),
                  ],
                ),
                Container(),
              ],
            ),
          ),
          Expanded(
            child: _getJournalListContent(),
          ),
        ],
      ),
    );
  }

  _getJournalListContent() {
    return StreamBuilder<ManagerJournal>(
      stream: _viewModel.outputManagersJournal,
      builder: (context, snapshot) {
        return snapshot.data?.data?.length != Constants.zeroNum
            ? SingleChildScrollView(
                physics: const AlwaysScrollableScrollPhysics(),
                controller: _scrollController,
                child: loadingMoreJournal
                    ? Column(
                        children: [
                          _singleJournal(
                            snapshot.data,
                            context,
                            _viewModel.dataCaptcha,
                          ),
                          const SizedBox(height: AppSize.s20),
                          !hidLoadingMoreJournal &&
                                  (snapshot.data?.data?.length)! > 8
                              ? const Center(
                                  child: CircularProgressIndicator(
                                    valueColor: AlwaysStoppedAnimation<Color>(
                                      ColorManager.whiteNeutral,
                                    ),
                                  ),
                                )
                              : Container(),
                          const SizedBox(height: AppSize.s20),
                        ],
                      )
                    : _singleJournal(
                        snapshot.data,
                        context,
                        _viewModel.dataCaptcha,
                      ),
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
                          _viewModel.refreshManagersJournal();
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
              );
      },
    );
  }

  Widget _singleJournal(
    ManagerJournal? listOfJournal,
    BuildContext context,
    Captcha? dataCaptcha,
  ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      mainAxisSize: MainAxisSize.min,
      children: listOfJournal?.data?.map(
            (managerJournalData) {
              return InkWell(
                onTap: () {
                  Nav.navTo(
                    context,
                    Routes.singleReportsJournalRoute,
                    TransferredDataBetweenJournalScreen(
                      journal: managerJournalData,
                      dataCaptcha: dataCaptcha,
                    ),
                  );
                },
                child: SingleJournalCard(
                  journal: managerJournalData,
                  dataCaptcha: dataCaptcha,
                ),
              );
            },
          ).toList() ??
          [],
    );
  }
}
