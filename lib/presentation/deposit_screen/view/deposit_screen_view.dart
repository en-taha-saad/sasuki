import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:sasuki/app/app_inits_funs/constants.dart';
import 'package:sasuki/app/init_screens_dependencies/init_app_module.dart';
import 'package:sasuki/app/resources/other_managers/assets_manager.dart';
import 'package:sasuki/app/resources/other_managers/strings_manager.dart';
import 'package:sasuki/app/resources/routes_manager/nav_funcs.dart';
import 'package:sasuki/app/shared_widgets/get_addedit_text_field.dart';
import 'package:sasuki/app/shared_widgets/shared_dropdown.dart';
import 'package:sasuki/domain/models/filter_lists/profile_list.dart';
import 'package:sasuki/domain/models/payment_methods/payment_methods.dart';
import 'package:sasuki/presentation/common/state_render/states/flow_state.dart';
import 'package:sasuki/app/resources/other_managers/color_manager.dart';
import 'package:sasuki/presentation/common/state_render/states/flow_state_extension.dart';
import 'package:sasuki/app/resources/values_manager/app_margin.dart';
import 'package:sasuki/app/resources/values_manager/app_size.dart';
import 'package:sasuki/presentation/deposit_screen/viewmodel/deposit_screen_viewmodel.dart';

class DepositScreen extends StatefulWidget {
  const DepositScreen({Key? key}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _DepositScreenState createState() => _DepositScreenState();
}

class _DepositScreenState extends State<DepositScreen> {
  final TextEditingController _amountController = TextEditingController();
  final TextEditingController _pinController = TextEditingController();

  final DepositScreenViewModel _depositScreenViewModel =
      instance<DepositScreenViewModel>();

  PaymentMethods? paymentMethods;
  SinglePaymentMethod? selectedPaymentMethod;

  _bind() {
    _depositScreenViewModel.start();
    _amountController.addListener(
      () {
        _depositScreenViewModel.setAmount(_amountController.text);
      },
    );
    _pinController.addListener(
      () {
        _depositScreenViewModel.setPin(_pinController.text);
      },
    );
  }

  @override
  void dispose() {
    _depositScreenViewModel.dispose();
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
      stream: _depositScreenViewModel.outputState,
      builder: (context, AsyncSnapshot<FlowState> snapshot) {
        return snapshot.data?.getScreenWidget(
              context,
              _getScreenView(context),
              () async {
                ScaffoldMessenger.of(context).hideCurrentSnackBar();
                _depositScreenViewModel.depositPayment();
              },
            ) ??
            _getScreenView(context);
      },
    );
  }

  Widget _getScreenView(context) {
    return Column(
      children: [
        AppSize.statusBarHeight(context),
        Container(
          margin: const EdgeInsets.only(
            right: AppMargin.m25,
            left: AppMargin.m25,
            bottom: AppMargin.m5,
          ),
          child: AppBar(
            elevation: AppSize.s0,
            backgroundColor: Colors.transparent,
            centerTitle: Constants.trueBool,
            titleTextStyle: Theme.of(context).textTheme.headlineMedium,
            leading: Container(
              margin: const EdgeInsets.only(
                right: AppMargin.m20,
              ),
              child: IconButton(
                icon: SvgPicture.asset(IconsAssets.back),
                onPressed: () => Nav.popRoute(context),
              ),
            ),
            title: Text(
              AppStrings.depositTile,
              style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                    fontSize: 18,
                  ),
            ),
          ),
        ),
        Expanded(
          child: Container(
            width: MediaQuery.of(context).size.width,
            color: ColorManager.secondary,
            child: _getDepositScreenContent(),
          ),
        ),
      ],
    );
  }

  _getDepositScreenContent() {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Container(
            margin: const EdgeInsets.all(AppSize.s25),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  margin: const EdgeInsets.only(right: AppSize.s10),
                  child: SvgPicture.asset(
                    IconsAssets.deposit,
                    theme: const SvgTheme(
                      currentColor: ColorManager.greyNeutral2,
                    ),
                    // ignore: deprecated_member_use
                    color: ColorManager.greyNeutral2,
                  ),
                ),
                Text(
                  AppStrings.selfDeposit,
                  style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                        color: ColorManager.greyNeutral2,
                      ),
                ),
              ],
            ),
          ),
          Container(
            margin: const EdgeInsets.only(
              right: AppMargin.m25,
              left: AppMargin.m25,
            ),
            child: Column(
              children: [
                _getPaymentMethodDropdown(AppStrings.usersProfile, context),
                Container(
                  margin: const EdgeInsets.only(
                    bottom: AppMargin.m25,
                  ),
                  child: StreamBuilder<bool>(
                    stream: _depositScreenViewModel.outputIsAmountEntered,
                    builder: (context, snapshot) {
                      return getAddEditTextFieldInput(
                        context,
                        _amountController,
                        (val) {
                          FocusScope.of(context).unfocus();
                        },
                        AppStrings.servAmount,
                        Constants.falseBool,
                        TextInputType.text,
                        snapshot.data,
                        Constants.trueBool,
                      );
                    },
                  ),
                ),
                Container(
                  margin: const EdgeInsets.only(
                    bottom: AppMargin.m25,
                  ),
                  child: StreamBuilder<bool>(
                    stream: _depositScreenViewModel.outputIsPinEntered,
                    builder: (context, snapshot) {
                      return getAddEditTextFieldInput(
                        context,
                        _pinController,
                        (val) {
                          FocusScope.of(context).unfocus();
                        },
                        AppStrings.servAmount,
                        Constants.falseBool,
                        TextInputType.text,
                        snapshot.data,
                        Constants.trueBool,
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  _getPaymentMethodDropdown(String inputTitle, context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Text(
          inputTitle,
          style: Theme.of(context).textTheme.labelLarge?.copyWith(
                height: AppSize.s0_7,
              ),
        ),
        Container(
          margin: const EdgeInsets.only(
            top: AppMargin.m10,
            bottom: AppMargin.m25,
          ),
          child: StreamBuilder<PaymentMethods>(
            stream: _depositScreenViewModel.outputPaymentMethodList,
            builder: (_, snapshot0) {
              if (paymentMethods == Constants.nullValue ||
                  paymentMethods?.data?.length == Constants.zeroNum) {
                paymentMethods = snapshot0.data;
              }
              debugPrint("paymentMethods: $paymentMethods");
              // ignore: prefer_is_empty
              return DropDownComponent<SinglePaymentMethod>(
                isThisServersDropdown: Constants.falseBool,
                hintStr: AppStrings.usersProfileHint,
                items: paymentMethods?.data ?? [],
                doOtherThings: (val) {
                  selectedPaymentMethod = val;
                },
                displayFn: (item) => (item as ProfileData).name,
                textAndHintColor: ColorManager.whiteNeutral,
              );
            },
          ),
        ),
      ],
    );
  }
}
