import 'dart:async';
import 'dart:ffi';
import 'package:flutter/material.dart';
import 'package:sasuki/app/app_inits_funs/constants.dart';
import 'package:sasuki/app/resources/other_managers/strings_manager.dart';
import 'package:sasuki/app/resources/values_manager/app_size.dart';
import 'package:sasuki/domain/models/payment_methods/payment_methods.dart';
import 'package:sasuki/domain/usecase/deposit_payment_usecase/deposit_payment_usecase.dart';
import 'package:sasuki/domain/usecase/payment_method_list_usecase/payment_method_list_usecase.dart';
import 'package:sasuki/presentation/base/base_viewmodel.dart';
import 'package:sasuki/presentation/common/freezed_data_classes.dart';
import 'package:sasuki/presentation/common/state_render/states/content_state.dart';
import 'package:sasuki/presentation/common/state_render/states/error_state.dart';
import 'package:sasuki/presentation/common/state_render/states/loading_state.dart';
import 'package:sasuki/presentation/common/state_render/states/state_renderer_type.dart';
import 'package:sasuki/presentation/deposit_screen/viewmodel/deposit_screen_viewmodel_inputs.dart';
import 'package:sasuki/presentation/deposit_screen/viewmodel/deposit_screen_viewmodel_outputs.dart';

class DepositScreenViewModel extends BaseViewModel
    with DepositScreenModelInputs, DepositScreenModelOutputs {
  final DepositPaymentUsecase _depositPaymentUseCase;
  final PaymentMethodListUsecase _paymentMethodsListUseCase;

  DepositScreenViewModel(
    this._depositPaymentUseCase,
    this._paymentMethodsListUseCase,
  );

  DepositObject depositObject = DepositObject(
    Constants.zeroNum.toInt(),
    Constants.emptyStr,
    Constants.emptyStr,
    Constants.emptyStr,
  );

  @override
  void start() {
    getPaymentMethodList();
  }

  @override
  void dispose() {
    _isPinEnteredStreamController.close();
    _isAmountEnteredStreamController.close();
    _paymentMethodListStreamController.close();
    _amountStreamController.close();
    _pinStreamController.close();
    super.dispose();
  }

  @override
  depositPayment() async {
    depositObject = depositObject.copyWith(
      amount: depositObject.amount,
      pin: depositObject.pin,
      methodName: depositObject.methodName,
      method: depositObject.method,
    );
    inputState.add(LoadingState(
      stateRendererType: StateRendererType.popupLoadingState,
    ));
    return (await _depositPaymentUseCase.execute(depositObject)).fold(
      (failure) {
        // left -> failure
        debugPrint("depositPayment failure = ${failure.message}");
        inputState.add(
          ErrorState(
            StateRendererType.toastErrorState,
            failure.message,
          ),
        );
      },
      (userAction) async {
        // right -> success (data)
        debugPrint("userAction = $userAction");
        inputState.add(
          LoadingState(
            stateRendererType: StateRendererType.popupSuccessState,
            message: AppStrings.depositPaymentSuccessfully,
          ),
        );
        Future.delayed(Duration(milliseconds: AppSize.s500.toInt()), () {
          inputState.add(ContentState());
        });
      },
    );
  }

  @override
  Future getPaymentMethodList() async {
    // ignore: void_checks
    return (await _paymentMethodsListUseCase.execute(Void)).fold(
      (failure) {
        // left -> failure
        debugPrint("getPaymentMethodList failure = ${failure.message}");
        inputState.add(
          ErrorState(
            StateRendererType.toastErrorState,
            failure.message,
          ),
        );
      },
      (paymentMethodList0) async {
        // right -> success (data)
        List<SinglePaymentMethod> paymentMethodList = [];
        debugPrint("getPaymentMethodList =  ${paymentMethodList0.data?.length}");
        paymentMethodList.addAll((paymentMethodList0.data)!);
        inputPaymentMethodList.add(
          PaymentMethods(
            paymentMethodList0.status,
            paymentMethodList,
          ),
        );
      },
    );
  }

  ///
  final StreamController _isPinEnteredStreamController =
      StreamController<bool>.broadcast();
  @override
  Sink get inputIsPinEntered => _isPinEnteredStreamController.sink;
  @override
  Stream<bool> get outputIsPinEntered =>
      _isPinEnteredStreamController.stream.map(
        (event) => event,
      );

  ///
  final StreamController _isAmountEnteredStreamController =
      StreamController<bool>.broadcast();
  @override
  Stream<bool> get outputIsAmountEntered =>
      _isAmountEnteredStreamController.stream.map(
        (event) => event,
      );
  @override
  Sink get inputIsAmountEntered => _isAmountEnteredStreamController.sink;

  ///
  final StreamController _paymentMethodListStreamController =
      StreamController<PaymentMethods>.broadcast();
  @override
  Sink get inputPaymentMethodList => _paymentMethodListStreamController.sink;
  @override
  Stream<PaymentMethods> get outputPaymentMethodList =>
      _paymentMethodListStreamController.stream.map(
        (event) => event,
      );

  ///
  final StreamController _amountStreamController =
      StreamController<String>.broadcast();
  @override
  Sink get inputAmount => _amountStreamController.sink;
  @override
  Stream<String> get outputAmount =>
      _amountStreamController.stream.map((event) => event);

  ///
  final StreamController _pinStreamController =
      StreamController<String>.broadcast();
  @override
  Sink get inputPin => _pinStreamController.sink;
  @override
  Stream<String> get outputPin =>
      _pinStreamController.stream.map((event) => event);

  @override
  setAmount(String amount) {
    inputAmount.add(amount);
    depositObject = depositObject.copyWith(amount: int.parse(amount));
    inputIsAmountEntered.add(Constants.falseBool);
  }

  @override
  setPin(String pin) {
    inputPin.add(pin);
    depositObject = depositObject.copyWith(pin: pin);
    inputIsPinEntered.add(Constants.falseBool);
  }

  saveFloatingButton(
    bool? enteredInputs,
    SinglePaymentMethod? selectedPaymentMethod,
  ) {
    if (enteredInputs == Constants.trueBool &&
        selectedPaymentMethod != Constants.nullValue) {
      depositObject = depositObject.copyWith(
        method: "${selectedPaymentMethod!.id}",
        methodName: (selectedPaymentMethod.name)!,
      );
      depositPayment();
    } else {
      if (!enteredInputs!) {
        inputAmount.add(Constants.emptyStr);
        inputPin.add(Constants.emptyStr);
      }
    }
  }
}
