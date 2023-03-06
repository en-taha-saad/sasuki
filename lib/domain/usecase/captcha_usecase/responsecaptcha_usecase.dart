import 'package:dartz/dartz.dart';
import 'package:sasuki/data/network/models/failure.dart';
import 'package:sasuki/domain/models/captcha/captcha.dart';
import 'package:sasuki/domain/repository/repository.dart';
import 'package:sasuki/domain/usecase/base_usecase.dart';

class ResponseCaptchaUseCase implements BaseUseCase<String, DataCaptcha> {
  final Repository _repository;
  ResponseCaptchaUseCase(this._repository);
  @override
  // ignore: non_constant_identifier_names, avoid_types_as_parameter_names
  Future<Either<Failure, DataCaptcha>> execute(String sessionId) async {
    return await _repository.getCaptcha(sessionId);
  }
}
