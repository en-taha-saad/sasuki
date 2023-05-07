import 'package:dartz/dartz.dart';
import 'package:sasuki/data/network/models/failure.dart';
import 'package:sasuki/domain/models/activity_log_events/activity_log_events.dart';
import 'package:sasuki/domain/repository/repository.dart';
import 'package:sasuki/domain/usecase/base_usecase.dart';

class ActivityLogEventsUseCase implements BaseUseCase<void, ActivityLogEvents> {
  final Repository _repository;
  ActivityLogEventsUseCase(this._repository);
  @override
  // ignore: non_constant_identifier_names, avoid_types_as_parameter_names
  Future<Either<Failure, ActivityLogEvents>> execute(void input) async {
    return await _repository.getActivityLogEvent();
  }
}
