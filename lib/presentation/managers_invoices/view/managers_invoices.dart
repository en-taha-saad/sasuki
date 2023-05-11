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
import 'package:sasuki/app/shared_widgets/single_invoice_card.dart';
import 'package:sasuki/domain/models/captcha/captcha.dart';
import 'package:sasuki/domain/models/managers_invoices/managers_invoices.dart';
import 'package:sasuki/presentation/common/state_render/states/flow_state.dart';
import 'package:sasuki/presentation/common/state_render/states/flow_state_extension.dart';
import 'package:sasuki/presentation/managers_invoices/viewmodel/managers_invoices_viewmodel.dart';

class ManagersInvoicesView extends StatefulWidget {
  const ManagersInvoicesView({Key? key}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _ManagersInvoicesViewState createState() => _ManagersInvoicesViewState();
}

class _ManagersInvoicesViewState extends State<ManagersInvoicesView> {
  final ManagersInvoicesViewModel _viewModel =
      instance<ManagersInvoicesViewModel>();
  final ScrollController _scrollController = ScrollController();
  bool loadingMoreInvoices = Constants.falseBool;
  bool hidLoadingMoreInvoices = Constants.falseBool;

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
          loadingMoreInvoices = Constants.trueBool;
        });
        _viewModel.getNextManagersInvoices();
        if (_scrollController.position.pixels !=
            _scrollController.position.maxScrollExtent) {
          setState(() {
            loadingMoreInvoices = Constants.falseBool;
          });
        }
      } else {
        setState(() {
          loadingMoreInvoices = Constants.trueBool;
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
                await _viewModel.getManagersInvoicesStreamingly();
              },
            ) ??
            _getScreenView();
      },
    );
  }

  Widget _getScreenView() {
    return RefreshIndicator(
      onRefresh: () async => _viewModel.getManagersInvoicesForPull(),
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
                Container(
                  margin: const EdgeInsets.only(
                    right: AppMargin.m25,
                    left: AppMargin.m25,
                    bottom: AppMargin.m25,
                  ),
                  child: _getInvoiceAppBar(context),
                ),
              ],
            ),
          ),

          Container(
            color: ColorManager.whiteNeutral.withOpacity(0.2),
            padding: const EdgeInsets.symmetric(
              horizontal: AppSize.s20,
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
                      AppStrings.drawerReportsInvoices,
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
            child: _getInvoiceListContent(),
          ),
        ],
      ),
    );
  }

  AppBar _getInvoiceAppBar(context) {
    return AppBar(
      toolbarHeight: 40,
      titleSpacing: 0,
      leading: Container(
        margin: const EdgeInsets.only(
          right: AppMargin.m30,
        ),
        child: IconButton(
          icon: SvgPicture.asset(IconsAssets.back),
          onPressed: () => Nav.popRoute(context),
        ),
      ),
      title: Text(
        AppStrings.drawerReports,
        style: Theme.of(context).textTheme.headlineMedium?.copyWith(
              fontSize: 18,
            ),
      ),
    );
  }

  _getInvoiceListContent() {
    return StreamBuilder<ManagersInvoices>(
      stream: _viewModel.outputManagersInvoices,
      builder: (context, snapshot) {
        // ignore: prefer_is_empty
        if (snapshot.data?.data?.length == Constants.oneNum ||
            snapshot.data?.data?.length == Constants.zeroNum) {
          WidgetsBinding.instance.addPostFrameCallback((_) {
            Future.delayed(
              Duration(seconds: Constants.oneNum.toInt()),
              () => setState(() {}),
            );
          });
        }
        WidgetsBinding.instance.addPostFrameCallback((_) {
          Future.delayed(
            Duration(seconds: Constants.oneNum.toInt()),
                () => setState(() {
              hidLoadingMoreInvoices =
                  _viewModel.totalInvoices == snapshot.data?.data?.length;
            }),
          );
        });
        return snapshot.data?.data?.length != Constants.zeroNum
            ? SingleChildScrollView(
                physics: const AlwaysScrollableScrollPhysics(),
                controller: _scrollController,
                child: loadingMoreInvoices
                    ? Column(
                        children: [
                          _singleInvoice(
                            snapshot.data,
                            context,
                            _viewModel.dataCaptcha,
                          ),
                          const SizedBox(height: AppSize.s20),
                          !hidLoadingMoreInvoices && (snapshot.data?.data?.length)! >8
                              ? const Center(
                            child: CircularProgressIndicator(
                              valueColor:
                              AlwaysStoppedAnimation<Color>(
                                ColorManager.whiteNeutral,
                              ),
                            ),
                          )
                              : Container(),
                        ],
                      )
                    : _singleInvoice(
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
                          _viewModel.refreshManagersInvoices();
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

  Widget _singleInvoice(
    ManagersInvoices? listOfInvoices,
    BuildContext context,
    Captcha? dataCaptcha,
  ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      mainAxisSize: MainAxisSize.min,
      children: listOfInvoices?.data?.map(
            (managersInvoiceData) {
              return InkWell(
                onTap: () {
                  Nav.navTo(
                    context,
                    Routes.singleReportsInvoicesRoute,
                    TransferredDataBetweenInvoiceScreen(
                      invoice: managersInvoiceData,
                      dataCaptcha: dataCaptcha,
                    ),
                  );
                },
                child: SingleInvoiceCard(
                  invoice: managersInvoiceData,
                  dataCaptcha: dataCaptcha,
                ),
              );
            },
          ).toList() ??
          [],
    );
  }
}
