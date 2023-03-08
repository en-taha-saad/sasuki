import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:sasuki/app/app_inits_funs/constants.dart';
import 'package:sasuki/app/init_screens_dependencies/init_app_module.dart';
import 'package:sasuki/app/resources/other_managers/assets_manager.dart';
import 'package:sasuki/app/resources/other_managers/strings_manager.dart';
import 'package:sasuki/app/resources/values_manager/app_size.dart';
import 'package:sasuki/app/shared_widgets/footer.dart';
import 'package:sasuki/app/shared_widgets/shared_dropdown.dart';
import 'package:sasuki/app/shared_widgets/small_logo.dart';
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
  Server? selectedServer;

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
          const SizedBox(width: AppSize.s25),
          _getDataContentWidget(),
        ],
      ),
    );
  }

  StreamBuilder<FlowState> _getDataContentWidget() {
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
        return serversList?.servers?.length != 0
            ? StreamBuilder<Server?>(
                stream: _viewModel.outputSelectedServer,
                builder: (context, snapshot) {
                  return DropDownComponent<Server?>(
                    items: [],
                    itemText: ,
                    onItemSelected: ,
                    selectedItem: ,
                  );
                  // return DropdownButtonFormField<Server?>(
                  //   decoration: InputDecoration(
                  //     hintStyle: Theme.of(context).textTheme.titleMedium,
                  //     hintText: AppStrings.servChooseServerHint,
                  //     contentPadding: const EdgeInsets.symmetric(
                  //       horizontal: AppPadding.p16,
                  //     ),
                  //     iconColor: ColorManager.white,
                  //   ),
                  //   iconEnabledColor: ColorManager.white,
                  //   dropdownColor: ColorManager.white,
                  //   elevation: AppSize.s0.toInt(),
                  //   style: Theme.of(context).textTheme.titleMedium,
                  //   borderRadius: AppSize.radius10,
                  //   selectedItemBuilder: (context) {
                  //     return serversList?.servers
                  //             ?.map((e) => Text(
                  //                   e.name,
                  //                   style:
                  //                       Theme.of(context).textTheme.titleLarge,
                  //                 ))
                  //             .toList() ??
                  //         [];
                  //   },
                  //   onChanged: (selectedServer0) {
                  //     setState(() {
                  //       selectedServer = selectedServer0;
                  //     });
                  //     _viewModel.inputIsNotSelectedServer
                  //         .add(Constants.falseVal);
                  //     _viewModel.inputIsSelectedServer.add(Constants.trueVal);
                  //     _viewModel.inputSelectedServer.add(selectedServer);
                  //     _viewModel.saveSelectedServer(selectedServer);
                  //   },
                  //   items: serversList?.servers?.map((Server value) {
                  //         return _getMenuItemWidget(value, context);
                  //       }).toList() ??
                  //       [],
                  // );
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
