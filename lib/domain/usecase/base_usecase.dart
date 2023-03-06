import 'package:dartz/dartz.dart';
import 'package:sasuki/data/network/models/failure.dart';

abstract class BaseUseCase<In, Out> {
  Future<Either<Failure, Out>> execute(In input);
}
