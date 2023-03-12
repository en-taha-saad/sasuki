import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:sasuki/app/app_inits_funs/constants.dart';
import 'package:sasuki/app/init_screens_dependencies/init_app_module.dart';
import 'package:sasuki/app/resources/other_managers/assets_manager.dart';
import 'package:sasuki/app/resources/other_managers/strings_manager.dart';
import 'package:sasuki/app/resources/values_manager/app_size.dart';
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
    _viewModel.dispose();
    super.dispose();
  }

  ///
  ServersList? serversList;
  bool isThereServers = Constants.falseBool;
  Server? selectedServer;

  void _updateIfThereIsServers() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      setState(() {
        // ignore: prefer_is_empty
        isThereServers = (serversList?.servers?.length != 0 ||
            serversList?.servers?.length != Constants.nullValue);
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => Constants.falseBool,
      child: Column(
        children: [
          const Spacer(),
          getScreenSmallLogo(),
          const SizedBox(height: AppSize.s50),
          getScreenContent(context),
          Spacer(flex: AppSize.s2.toInt()),
          getScreenFooter(),
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
              SvgPicture.asset(IconsAssets.chooseServer),
              const SizedBox(width: AppSize.s10),
              Text(
                AppStrings.servChooseServer,
                style: Theme.of(context).textTheme.headlineMedium,
              ),
            ],
          ),
          const SizedBox(height: AppSize.s25),
          _getDataContentWidget(),
          const SizedBox(height: AppSize.s50),
          ElevatedButtonWidget(
            name: AppStrings.servContinueToLogin,
            onPressed: isThereServers ? () {} : Constants.nullValue,
          ),
          const SizedBox(height: AppSize.s25),
          TextButtonWidget(
            name: AppStrings.servAddServer,
            onPressed: () {},
          ),
        ],
      ),
    );
  }

  Widget _getDataContentWidget() {
    return
        // StreamBuilder<FlowState>(
        //   stream: _viewModel.outputState,
        //   builder: (context, snapshot) {
        //     return snapshot.data?.getScreenWidget(
        //           context,
        //           _getDropDown(context),
        //           () {},
        //         ) ??

        _getDropDown(context);
    //   },
    // );
  }

  Widget _getDropDown(BuildContext context) {
    return StreamBuilder<ServersList>(
      stream: _viewModel.outputGotListOfServers,
      builder: (_, snapshot0) {
        // serversList = snapshot0.data;
        serversList = ServersList([
          Server(
            "Server 1",
            "Server 1",
            "Server 1",
            "Server 1",
          ),
          Server(
            "Server 2",
            "Server 2",
            "Server 2",
            "Server 2",
          ),
          Server(
            "Server 3",
            "Server 3",
            "Server 3",
            "Server 3",
          ),
        ]);
        _updateIfThereIsServers();
        return isThereServers
            ? StreamBuilder<Server?>(
                stream: _viewModel.outputSelectedServer,
                builder: (context, snapshot) {
                  return DropDownComponent<Server?>(
                    isThisServersDropdown: Constants.trueBool,
                    items: serversList?.servers ?? [],
                    doOtherThings: (val) {
                      selectedServer = val;
                      _viewModel.inputIsNotSelectedServer
                          .add(Constants.falseBool);
                      _viewModel.inputIsSelectedServer.add(Constants.trueBool);
                      _viewModel.inputSelectedServer.add(selectedServer);
                      _viewModel.saveSelectedServer(selectedServer);
                    },
                    displayFn: (item) => (item as Server).name,
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
