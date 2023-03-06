import 'package:dartz/dartz.dart';
import 'package:sasuki/data/network/models/failure.dart';
import 'package:sasuki/domain/models/captcha/captcha.dart';
import 'package:sasuki/domain/repository/repository.dart';
import 'package:sasuki/domain/usecase/base_usecase.dart';

class CaptchaUseCase implements BaseUseCase<void, Captcha> {
  final Repository _repository;
  CaptchaUseCase(this._repository);
  @override
  // ignore: non_constant_identifier_names, avoid_types_as_parameter_names
  Future<Either<Failure, Captcha>> execute(void input) async {
    return await _repository.isCaptchaRequired();
  }
}
