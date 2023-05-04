import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:sasuki/app/app_inits_funs/constants.dart';
import 'package:sasuki/app/init_screens_dependencies/init_app_module.dart';
import 'package:sasuki/app/resources/other_managers/assets_manager.dart';
import 'package:sasuki/app/resources/other_managers/strings_manager.dart';
import 'package:sasuki/app/resources/routes_manager/nav_funcs.dart';
import 'package:sasuki/app/shared_widgets/elevated_button_widget.dart';
import 'package:sasuki/app/shared_widgets/shared_dropdown.dart';
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
  bool isZaincash = Constants.falseBool;
  bool isVoucher = Constants.falseBool;
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
                _getPaymentMethodDropdown(
                  AppStrings.usersPaymentMethod,
                  context,
                ),
                isZaincash == Constants.trueBool
                    ? Container(
                        margin: const EdgeInsets.only(
                          bottom: AppMargin.m25,
                        ),
                        child: StreamBuilder<bool>(
                          stream: _depositScreenViewModel.outputIsAmountEntered,
                          builder: (context, snapshot) {
                            return Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  margin: const EdgeInsets.only(
                                      bottom: AppMargin.m10),
                                  child: Text(
                                    AppStrings.servAmount,
                                    style:
                                        Theme.of(context).textTheme.titleLarge,
                                  ),
                                ),
                                TextFormField(
                                  controller: _amountController,
                                  keyboardType: TextInputType.text,
                                  decoration: InputDecoration(
                                    errorText: snapshot.data == true
                                        ? AppStrings.inputIsEmpty
                                        : null,
                                  ),
                                  onEditingComplete: () =>
                                      FocusScope.of(context).unfocus(),
                                  onFieldSubmitted: (st) =>
                                      FocusScope.of(context).unfocus(),
                                  style: Theme.of(context).textTheme.bodyLarge,
                                ),
                              ],
                            );
                          },
                        ),
                      )
                    : Container(),
                if (isVoucher)
                  isVoucher == Constants.trueBool
                      ? Container(
                          margin: const EdgeInsets.only(
                            bottom: AppMargin.m25,
                          ),
                          child: StreamBuilder<bool>(
                            stream: _depositScreenViewModel.outputIsPinEntered,
                            builder: (context, snapshot) {
                              return Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Container(
                                    margin: const EdgeInsets.only(
                                        bottom: AppMargin.m10),
                                    child: Text(
                                      AppStrings.servPin,
                                      style: Theme.of(context)
                                          .textTheme
                                          .titleLarge,
                                    ),
                                  ),
                                  TextFormField(
                                    controller: _pinController,
                                    keyboardType: TextInputType.number,
                                    decoration: InputDecoration(
                                      errorText: snapshot.data == true
                                          ? AppStrings.inputIsEmpty
                                          : null,
                                    ),
                                    onEditingComplete: () =>
                                        FocusScope.of(context).unfocus(),
                                    onFieldSubmitted: (st) =>
                                        FocusScope.of(context).unfocus(),
                                    style:
                                        Theme.of(context).textTheme.bodyLarge,
                                  ),
                                ],
                              );
                            },
                          ),
                        )
                      : Container(),
                Container(
                  margin: const EdgeInsets.only(
                    top: AppMargin.m35,
                    bottom: AppMargin.m50,
                  ),
                  child: ElevatedButtonWidget(
                    name: AppStrings.depositButton,
                    assetName: IconsAssets.forward,
                    onPressed: () {
                      if (_amountController.text.isNotEmpty ||
                          _pinController.text.isNotEmpty) {
                        FocusScope.of(context).unfocus();
                        _depositScreenViewModel.saveFloatingButton(
                          true,
                          selectedPaymentMethod,
                        );
                      }
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
              // ignore: prefer_is_empty
              return DropDownComponent<SinglePaymentMethod>(
                isThisServersDropdown: Constants.falseBool,
                hintStr: AppStrings.usersPaymentMethodHint,
                items: paymentMethods?.data ?? [],
                doOtherThings: (val) {
                  selectedPaymentMethod = val;
                  debugPrint(
                      "@selectedPaymentMethod: ${selectedPaymentMethod?.country} ${selectedPaymentMethod?.id} ${selectedPaymentMethod?.name}");
                  if (selectedPaymentMethod?.name == "ZainCash") {
                    setState(() {
                      isZaincash = Constants.trueBool;
                      isVoucher = Constants.falseBool;
                    });
                    _depositScreenViewModel.inputIsAmountEntered.add(
                      Constants.trueBool,
                    );
                    _depositScreenViewModel.inputIsPinEntered.add(
                      Constants.falseBool,
                    );
                    _depositScreenViewModel.inputPin.add(Constants.emptyStr);
                  }
                  if (selectedPaymentMethod?.name == "Voucher") {
                    setState(() {
                      isVoucher = Constants.trueBool;
                      isZaincash = Constants.falseBool;
                    });
                    _depositScreenViewModel.inputIsAmountEntered.add(
                      Constants.falseBool,
                    );
                    _depositScreenViewModel.inputIsPinEntered.add(
                      Constants.trueBool,
                    );
                    _depositScreenViewModel.inputAmount.add(Constants.emptyStr);
                  }
                },
                displayFn: (item) => ((item as SinglePaymentMethod).name)!,
                textAndHintColor: ColorManager.whiteNeutral,
              );
            },
          ),
        ),
      ],
    );
  }
}
