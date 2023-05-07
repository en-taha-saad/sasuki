import 'package:dartz/dartz.dart';
import 'package:sasuki/data/network/models/failure.dart';
import 'package:sasuki/domain/models/activity_log_list/activity_log_list.dart';
import 'package:sasuki/domain/repository/repository.dart';
import 'package:sasuki/domain/usecase/base_usecase.dart';
import 'package:sasuki/presentation/common/freezed_data_classes.dart';

class ActivityLogListUseCase
    implements BaseUseCase<ActivityLogRequestObject, ActivityLogList> {
  final Repository _repository;
  ActivityLogListUseCase(this._repository);
  @override
  // ignore: non_constant_identifier_names, avoid_types_as_parameter_names
  Future<Either<Failure, ActivityLogList>> execute(
    ActivityLogRequestObject activityLogRequestObject,
  ) async {
    return await _repository.getActivityLogList(activityLogRequestObject);
  }
}
