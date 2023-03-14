import 'package:get_it/get_it.dart';
import 'package:sasuki/app/init_screens_dependencies/init_app_module.dart';
import 'package:sasuki/domain/repository/repository.dart';
import 'package:sasuki/domain/usecase/captcha_usecase/captcha_usecase.dart';
import 'package:sasuki/domain/usecase/captcha_usecase/responsecaptcha_usecase.dart';
import 'package:sasuki/domain/usecase/login_usecase/login_usecase.dart';
import 'package:sasuki/domain/usecase/servers_usecase/selected_server_usecase.dart';
import 'package:sasuki/presentation/login/viewmodel/login_viewmodel.dart';

initLoginModule() async {
  // login module, only login dependencies are here

  // login use case instance
  if (!GetIt.I.isRegistered<CaptchaUseCase>()) {
    instance.registerFactory<CaptchaUseCase>(
      () => CaptchaUseCase(instance<Repository>()),
    );
  }
  if (!GetIt.I.isRegistered<LoginUseCase>()) {
    instance.registerFactory<LoginUseCase>(
      () => LoginUseCase(instance<Repository>()),
    );
  }

  if (!GetIt.I.isRegistered<ResponseCaptchaUseCase>()) {
    instance.registerFactory<ResponseCaptchaUseCase>(
      () => ResponseCaptchaUseCase(instance<Repository>()),
    );
  }
  if (!GetIt.I.isRegistered<LoginViewModel>()) {
    // login view model instance
    instance.registerFactory<LoginViewModel>(
      () => LoginViewModel(
        instance<LoginUseCase>(),
        instance<CaptchaUseCase>(),
        instance<ResponseCaptchaUseCase>(),
        instance<SelectedServerUsecase>(),
      ),
    );
  }
}
