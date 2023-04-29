import 'package:sasuki/app/app_inits_funs/constants.dart';
import 'package:sasuki/app/extensions/non_null_int.dart';
import 'package:sasuki/app/extensions/non_null_string.dart';
import 'package:sasuki/domain/models/activations_reports/activations_reports.dart';
import 'package:sasuki/data/responses/activations_reports_responses/activations_reports_responses.dart';

extension ActivationsReportsResponsesMapper on ActivationsReportsResponse? {
  ActivationsReports toDomain() {
    return ActivationsReports(
      this?.data?.map((e) => e.toDomain()).toList(),
      this?.total.orZero(),
    );
  }
}

extension ActivationResponseMapper on ActivationResponse? {
  Activation toDomain() {
    return Activation(
      this?.id.orZero(),
      this?.price.orEmpty(),
      this?.createdAt.orEmpty(),
      this?.userDetails.toDomain(),
      this?.managerDetails.toDomain(),
      this?.profileDetails.toDomain(),
      this?.oldExpiration.orEmpty() ?? Constants.emptyStr,
      this?.newExpiration.orEmpty() ?? Constants.emptyStr,
      this?.activationMethod.orEmpty() ?? Constants.emptyStr,
      this?.userActivationsCount.orZero() ?? Constants.zeroNum.toInt(),
    );
  }
}

extension UserDetailsResponseMapper on UserDetailsResponse? {
  UserDetails toDomain() {
    return UserDetails(
      this?.id.orZero(),
      this?.username.orEmpty(),
      this?.firstname.orEmpty(),
      this?.lastname.orEmpty(),
    );
  }
}

extension ManagerDetailsResponseMapper on ManagerDetailsResponse? {
  ManagerDetails toDomain() {
    return ManagerDetails(
      this?.id.orZero(),
      this?.username.orEmpty(),
    );
  }
}

extension ProfileDetailsResponseMapper on ProfileDetailsResponse? {
  ProfileDetails toDomain() {
    return ProfileDetails(
      this?.id.orZero(),
      this?.name.orEmpty(),
    );
  }
}
