import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:sasuki/app/app_inits_funs/constants.dart';
import 'package:sasuki/app/init_screens_dependencies/init_app_module.dart';
import 'package:sasuki/app/resources/fonts_manager/fontsize.dart';
import 'package:sasuki/app/resources/other_managers/assets_manager.dart';
import 'package:sasuki/app/resources/other_managers/color_manager.dart';
import 'package:sasuki/app/resources/other_managers/strings_manager.dart';
import 'package:sasuki/app/resources/other_managers/styles_manager.dart';
import 'package:sasuki/app/resources/routes_manager/nav_funcs.dart';
import 'package:sasuki/app/resources/routes_manager/routes.dart';
import 'package:sasuki/app/resources/values_manager/app_size.dart';
import 'package:sasuki/app/shared_widgets/elevated_button_widget.dart';
import 'package:sasuki/app/shared_widgets/footer.dart';
import 'package:sasuki/app/shared_widgets/small_logo.dart';
import 'package:sasuki/presentation/add_server/viewmodel/add_server_viewmodel.dart';

class AddServerView extends StatefulWidget {
  const AddServerView({Key? key}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _AddServerViewState createState() => _AddServerViewState();
}

class _AddServerViewState extends State<AddServerView> {
  final AddServerViewModel _viewModel = instance<AddServerViewModel>();
  final _ispNameController = TextEditingController();
  final _serverAddressController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  _bind() {
    _viewModel.start();
    _ispNameController.addListener(
      () {
        _viewModel.setIspName(_ispNameController.text);
      },
    );
    _serverAddressController.addListener(
      () {
        _viewModel.setHostName(_serverAddressController.text);
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
    return WillPopScope(
      onWillPop: () async => Constants.falseBool,
      child: _getContentWidget(),
    );
  }

  Widget _getContentWidget() {
    return Stack(
      alignment: Alignment.bottomCenter,
      children: [
        getScreenFooter(),
        SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(height: AppSize.s100),
              getScreenSmallLogo(),
              const SizedBox(height: AppSize.s25),
              getScreenContent(context),
              const SizedBox(height: AppSize.s100),
            ],
          ),
        ),
      ],
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
                IconsAssets.add,
                theme: const SvgTheme(
                  currentColor: ColorManager.greyNeutral,
                ),
                // ignore: deprecated_member_use
                color: ColorManager.greyNeutral,
              ),
              const SizedBox(width: AppSize.s10),
              Text(
                AppStrings.servAddServer,
                style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                      color: ColorManager.greyNeutral,
                    ),
              ),
            ],
          ),
          const SizedBox(height: AppSize.s25),
          _getDataContentWidget(),
          const SizedBox(height: AppSize.s50),
          StreamBuilder<bool>(
            stream: _viewModel.outputAreAllInputsValid,
            builder: (context, snapshot) {
              return ElevatedButtonWidget(
                name: AppStrings.servAddServer,
                onPressed: (snapshot.data ?? Constants.falseBool)
                    ? _addServer
                    : Constants.nullValue,
              );
            },
          ),
          const SizedBox(height: AppSize.s10),
          InkWell(
            onTap: () => Nav.replaceTo(context, Routes.chooseServerRoute),
            child: Text(
              AppStrings.cancelButton,
              style: Theme.of(context).textTheme.headlineSmall,
            ),
          )
        ],
      ),
    );
  }

  Widget _getDataContentWidget() {
    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          _getSingleTextField(
            stream: _viewModel.outputIsIspNameValid,
            controller: _ispNameController,
            inputLabel: AppStrings.servISPName,
            inputHint: AppStrings.servISPNameHint,
            errorText: AppStrings.ispError,
            autofocus: Constants.trueBool,
          ),
          const SizedBox(height: AppSize.s25),
          _getSingleTextField(
            stream: _viewModel.outputIsServerAddressValid,
            controller: _serverAddressController,
            inputLabel: AppStrings.servServerAddress,
            inputHint: AppStrings.servServerAddressHint,
            errorText: AppStrings.serverAddressError,
            autofocus: Constants.falseBool,
          ),
          const SizedBox(height: AppSize.s25),
        ],
      ),
    );
  }

  Widget _getSingleTextField({
    Stream<bool>? stream,
    TextEditingController? controller,
    String? inputLabel,
    String? inputHint,
    String? errorText,
    bool? autofocus,
  }) {
    return StreamBuilder<bool>(
      stream: stream,
      builder: (context, snapshot) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              inputLabel!,
              style: Theme.of(context).textTheme.labelLarge,
            ),
            const SizedBox(height: AppSize.s10),
            TextFormField(
              controller: controller,
              decoration: InputDecoration(
                hintText: inputHint,
                errorText: (snapshot.data ?? Constants.trueBool)
                    ? Constants.nullValue
                    : errorText,
              ),
              autofocus: autofocus!,
            ),
          ],
        );
      },
    );
  }

  _addServer() {
    _viewModel.addServer();
    Nav.replaceTo(context, Routes.chooseServerRoute);
  }
}
