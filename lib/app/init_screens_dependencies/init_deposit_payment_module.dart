import 'package:get_it/get_it.dart';
import 'package:sasuki/app/init_screens_dependencies/init_app_module.dart';
import 'package:sasuki/domain/repository/repository.dart';
import 'package:sasuki/domain/usecase/deposit_payment_usecase/deposit_payment_usecase.dart';
import 'package:sasuki/domain/usecase/payment_method_list_usecase/payment_method_list_usecase.dart';
import 'package:sasuki/presentation/deposit_screen/viewmodel/deposit_screen_viewmodel.dart';

initAdDepositPaymentdManagerModule() async {
  if (!GetIt.I.isRegistered<DepositPaymentUsecase>()) {
    instance.registerFactory<DepositPaymentUsecase>(
      () => DepositPaymentUsecase(instance<Repository>()),
    );
  }

  if (!GetIt.I.isRegistered<PaymentMethodListUsecase>()) {
    instance.registerFactory<PaymentMethodListUsecase>(
      () => PaymentMethodListUsecase(instance<Repository>()),
    );
  }

  if (!GetIt.I.isRegistered<DepositScreenViewModel>()) {
    // Edit UserViewModel instance
    instance.registerLazySingleton<DepositScreenViewModel>(
      () => DepositScreenViewModel(
        instance<DepositPaymentUsecase>(),
        instance<PaymentMethodListUsecase>(),
      ),
    );
  }
}
