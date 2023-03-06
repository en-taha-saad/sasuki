import 'package:dartz/dartz.dart';
import 'package:sasuki/data/network/models/failure.dart';
import 'package:sasuki/data/network/models/loginrequest.dart';
import 'package:sasuki/domain/models/login/login.dart';
import 'package:sasuki/domain/repository/repository.dart';
import 'package:sasuki/domain/usecase/base_usecase.dart';
import 'package:sasuki/domain/usecase/login_usecase/login_usecase_input.dart';

class LoginUseCase implements BaseUseCase<LoginUseCaseInput, Login> {
  final Repository _repository;
  LoginUseCase(this._repository);
  @override
  Future<Either<Failure, Login>> execute(LoginUseCaseInput input) async {
    return await _repository.login(
      LoginRequest(
        input.username,
        input.password,
        input.language,
        input.otp,
        input.captchaText,
        input.sessionId,
      ),
    );
  }
}
