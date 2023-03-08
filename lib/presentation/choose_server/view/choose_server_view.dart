import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:sasuki/app/app_inits_funs/constants.dart';
import 'package:sasuki/app/init_screens_dependencies/init_app_module.dart';
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
      child: Container(),
    );
  }
}
