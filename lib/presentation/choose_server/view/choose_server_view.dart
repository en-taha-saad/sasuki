import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:sasuki/app/app_inits_funs/constants.dart';
import 'package:sasuki/app/init_screens_dependencies/init_app_module.dart';
import 'package:sasuki/app/resources/other_managers/assets_manager.dart';
import 'package:sasuki/app/resources/other_managers/color_manager.dart';
import 'package:sasuki/app/resources/other_managers/strings_manager.dart';
import 'package:sasuki/app/resources/routes_manager/nav_funcs.dart';
import 'package:sasuki/app/resources/routes_manager/routes.dart';
import 'package:sasuki/app/resources/values_manager/app_size.dart';
import 'package:sasuki/app/shared_funs/change_status_bar_color.dart';
import 'package:sasuki/app/shared_widgets/elevated_button_widget.dart';
import 'package:sasuki/app/shared_widgets/footer.dart';
import 'package:sasuki/app/shared_widgets/shared_dropdown.dart';
import 'package:sasuki/app/shared_widgets/small_logo.dart';
import 'package:sasuki/app/shared_widgets/text_button_widget.dart';
import 'package:sasuki/domain/models/choosing_server/server.dart';
import 'package:sasuki/domain/models/choosing_server/servers.dart';
import 'package:sasuki/presentation/choose_server/viewmodel/choose_server_viewmodel.dart';
import 'package:sasuki/presentation/common/state_render/states/flow_state.dart';
import 'package:sasuki/presentation/common/state_render/states/flow_state_extension.dart';

class ChooseServerView extends StatefulWidget {
  const ChooseServerView({Key? key}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _ChooseServerViewState createState() => _ChooseServerViewState();
}

class _ChooseServerViewState extends State<ChooseServerView> {
  @override
  void initState() {
    changeStatusBarColor();

    _bind();
    super.initState();
  }

  final ChooseServerViewModel _viewModel = instance<ChooseServerViewModel>();
  _bind() {
    _viewModel.inputIsNotSelectedServer.add(Constants.trueBool);
    _viewModel.start();
  }

  @override
  void dispose() {
    changeStatusBarColor();
    _viewModel.dispose();
    super.dispose();
  }

  ///
  ServersList? serversList;
  Server? selectedServer;

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => Constants.falseBool,
      child: Stack(
        children: [
          Align(
            alignment: Alignment.bottomCenter,
            child: getScreenFooter(),
          ),
          SingleChildScrollView(
            child: Column(
              children: [
                const SizedBox(height: AppSize.s100),
                getScreenSmallLogo(),
                const SizedBox(height: AppSize.s50),
                getScreenContent(context),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget getScreenContent(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: AppSize.s25),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SvgPicture.asset(
                IconsAssets.chooseServer,
                theme: const SvgTheme(
                  currentColor: ColorManager.greyNeutral,
                ),
                // ignore: deprecated_member_use
                color: ColorManager.greyNeutral,
              ),
              const SizedBox(width: AppSize.s10),
              Text(
                AppStrings.servChooseServer,
                style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                      color: ColorManager.greyNeutral,
                    ),
              ),
            ],
          ),
          const SizedBox(height: AppSize.s25),
          _getDataContentWidget(),
          const SizedBox(height: AppSize.s50),
          StreamBuilder<bool?>(
            stream: _viewModel.outputIsNotSelectedServer,
            builder: (context, snapshot) {
              // ignore: prefer_is_empty
              return ElevatedButtonWidget(
                name: AppStrings.servContinueToLogin,
                onPressed: (snapshot.data ?? Constants.trueBool)
                    ? Constants.nullValue
                    : _continueToLogin,
              );
            },
          ),
          StreamBuilder<bool?>(
            stream: _viewModel.outputIsNotSelectedServer,
            builder: (context, snapshot) {
              // ignore: prefer_is_empty
              return Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const SizedBox(height: AppSize.s10),
                  Row(
                    children: [
                      SizedBox(
                        width: MediaQuery.of(context).size.width * 0.39,
                        child: Divider(
                          color: ColorManager.greyNeutral.withOpacity(
                            AppSize.s0point25,
                          ),
                          thickness: AppSize.s1,
                        ),
                      ),
                      Container(
                        margin: const EdgeInsets.symmetric(
                          horizontal: AppSize.s10,
                        ),
                        child: Text(
                          AppStrings.or,
                          style: Theme.of(context).textTheme.labelSmall,
                        ),
                      ),
                      SizedBox(
                        width: MediaQuery.of(context).size.width * 0.39,
                        child: Divider(
                          color: ColorManager.greyNeutral.withOpacity(
                            AppSize.s0point25,
                          ),
                          thickness: AppSize.s1,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: AppSize.s10),
                ],
              );
            },
          ),
          TextButtonWidget(
            name: AppStrings.servAddServer,
            assetName: IconsAssets.add,
            onPressed: _addServer,
          ),
        ],
      ),
    );
  }

  _continueToLogin() => Nav.replaceTo(context, Routes.loginRoute);

  void _addServer() => Nav.replaceTo(context, Routes.addServerRoute);

  Widget _getDataContentWidget() {
    return StreamBuilder<FlowState>(
      stream: _viewModel.outputState,
      builder: (context, snapshot) {
        return snapshot.data?.getScreenWidget(
              context,
              _getDropDown(context),
              () {},
            ) ??
            _getDropDown(context);
      },
    );
  }

  Widget _getDropDown(BuildContext context) {
    return StreamBuilder<ServersList>(
      stream: _viewModel.outputGotListOfServers,
      builder: (_, snapshot0) {
        serversList = snapshot0.data;
        // ignore: prefer_is_empty
        return (serversList?.servers?.length != Constants.zeroNum &&
                serversList?.servers?.length != Constants.nullValue)
            ? StreamBuilder<Server?>(
                stream: _viewModel.outputSelectedServer,
                builder: (context, snapshot) {
                  return ConstrainedBox(
                    constraints: BoxConstraints(
                      maxWidth: MediaQuery.of(context).size.width,
                    ),
                    child: DropDownComponent<Server?>(
                      isThisServersDropdown: Constants.trueBool,
                      items: serversList?.servers ?? [],
                      viewModel: _viewModel,
                      doOtherThings: (val) {
                        selectedServer = val;
                        _viewModel.inputIsNotSelectedServer
                            .add(Constants.falseBool);
                        _viewModel.inputIsSelectedServer
                            .add(Constants.trueBool);
                        _viewModel.inputSelectedServer.add(selectedServer);
                        _viewModel.saveSelectedServer(selectedServer);
                      },
                      displayFn: (item) => (item as Server).name,
                      textAndHintColor: ColorManager.whiteNeutral,
                    ),
                  );
                },
              )
            : Text(
                AppStrings.servNoServersFound,
                style: Theme.of(context).textTheme.bodyLarge,
              );
      },
    );
  }
}
