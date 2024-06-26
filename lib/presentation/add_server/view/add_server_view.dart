import 'package:double_back_to_close_app/double_back_to_close_app.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:sasuki/app/app_inits_funs/constants.dart';
import 'package:sasuki/app/init_screens_dependencies/init_app_module.dart';
import 'package:sasuki/app/resources/other_managers/assets_manager.dart';
import 'package:sasuki/app/resources/other_managers/color_manager.dart';
import 'package:sasuki/app/resources/other_managers/strings_manager.dart';
import 'package:sasuki/app/resources/routes_manager/nav_funcs.dart';
import 'package:sasuki/app/resources/routes_manager/routes.dart';
import 'package:sasuki/app/resources/values_manager/app_size.dart';
import 'package:sasuki/app/shared_funs/change_status_bar_color.dart';
import 'package:sasuki/app/shared_widgets/double_back_to_exit_snackbar.dart';
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
  bool isFieldTapped = false;
  bool isThereFooter = false;

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
    changeStatusBarColor();
    _viewModel.dispose();
    super.dispose();
  }

  @override
  void initState() {
    changeStatusBarColor();
    _bind();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return DoubleBackToCloseApp(
      snackBar: doubleBackToExitSnackBar(),
      child: _getContentWidget(),
    );
  }

  Widget _getContentWidget() {
    return GestureDetector(
      onTap: () {
        setState(() {
          isFieldTapped = false;
          isThereFooter = true;
        });
        FocusScope.of(context).unfocus();
      },
      child: Stack(
        alignment: Alignment.bottomCenter,
        children: [
          if (isThereFooter) getScreenFooter(),
          SingleChildScrollView(
            physics: isFieldTapped
                ? const AlwaysScrollableScrollPhysics()
                : const NeverScrollableScrollPhysics(),
            child: Column(
              children: [
                const SizedBox(height: AppSize.s100),
                getScreenSmallLogo(),
                const SizedBox(height: AppSize.s35),
                getScreenContent(context),
                const SizedBox(height: 205),
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
                IconsAssets.addServer,
                theme: const SvgTheme(
                  currentColor: ColorManager.greyNeutral2,
                ),
                // ignore: deprecated_member_use
                color: ColorManager.greyNeutral2,
              ),
              const SizedBox(width: AppSize.s10),
              Text(
                AppStrings.servAddServer,
                style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                      color: ColorManager.greyNeutral2,
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
          const SizedBox(height: AppSize.s15),
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
            onTap: () {
              setState(() {
                isFieldTapped = true;
                isThereFooter = false;
              });
            },
            onFieldSubmitted: (value) {
              setState(() {
                isFieldTapped = false;
                isThereFooter = true;
              });
            },
          ),
          const SizedBox(height: AppSize.s25),
          _getSingleTextField(
            stream: _viewModel.outputIsServerAddressValid,
            controller: _serverAddressController,
            inputLabel: AppStrings.servServerAddress,
            inputHint: AppStrings.servServerAddressHint,
            errorText: AppStrings.serverAddressError,
            autofocus: Constants.falseBool,
            onTap: () {
              setState(() {
                isFieldTapped = true;
                isThereFooter = false;
              });
            },
            onFieldSubmitted: (value) {
              setState(() {
                isFieldTapped = false;
                isThereFooter = true;
              });
            },
          ),
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
    Function()? onTap,
    Function(String)? onFieldSubmitted,
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
              onTap: onTap,
              onFieldSubmitted: onFieldSubmitted,
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
