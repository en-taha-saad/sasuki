// ignore: depend_on_referenced_packages
import 'package:freezed_annotation/freezed_annotation.dart';
part 'freezed_data_classes.freezed.dart';

@freezed
class LoginObject with _$LoginObject {
  factory LoginObject(
    String username,
    String password,
    String language,
    String otp,
    String captchaText,
    String sessionId,
  ) = _LoginObject;
}

@freezed
class UserRequestObject with _$UserRequestObject {
  factory UserRequestObject(
    int page,
    int count,
    String sortBy,
    String direction,
    String search,
    List<String> columns,
    int status,
    int connection,
    int profileId,
    int parentId,
    int groupId,
    int siteId,
    int subUsers,
    String mac,
  ) = _UserRequestObject;
}

@freezed
class ActivationRequestObject with _$ActivationRequestObject {
  factory ActivationRequestObject(
    String? method,
    String? pin,
    String? userId,
    int? moneyCollected,
    String? comments,
    int? userPrice,
    bool? issueInvoice,
    String? transactionId,
    int? activationUnits,
  ) = _ActivationRequestObject;
}

@freezed
class AddUserRequestObject with _$AddUserRequestObject {
  factory AddUserRequestObject(
    String? username,
    int? enabled,
    String? password,
    String? confirmPassword,
    int? profileId,
    int? parentId,
    int? siteId,
    int? macAuth,
    int? allowedMacs,
    int? useSeparatePortalPassword,
    String? portalPassword,
    int? groupId,
    String? firstname,
    String? lastname,
    String? company,
    String? email,
    String? phone,
    String? city,
    String? address,
    String? apartment,
    String? street,
    int? contractId,
    int? nationalId,
    String? notes,
    int? autoRenew,
    String? expiration,
    int? simultaneousSessions,
    int? staticIp,
    String? userType,
    int? restricted,
  ) = _AddUserRequestObject;
}

@freezed
class ExtendUserRequestObject with _$ExtendUserRequestObject {
  factory ExtendUserRequestObject(
    String? userId,
    String? profileId,
    String? method,
    String? transactionId,
  ) = _ExtendUserRequestObject;
}

@freezed
class DepositWithdrawUserRequestObject with _$DepositWithdrawUserRequestObject {
  factory DepositWithdrawUserRequestObject(
    String? userId,
    String? userUsername,
    int? amount,
    String? comment,
    String? transactionId,
  ) = _DepositWithdrawUserRequestObject;
}

@freezed
class PayDebtRequestObject with _$PayDebtRequestObject {
  factory PayDebtRequestObject(
    int? userId,
    String? username,
    int? amount,
    String? comment,
    int? transactionId,
    bool? isLoan,
    int? debtForMe,
    int? debt,
  ) = _PayDebtRequestObject;
}

@freezed
class DepositWithdrawPayDebtManagerRequestObject
    with _$DepositWithdrawPayDebtManagerRequestObject {
  factory DepositWithdrawPayDebtManagerRequestObject(
    int? managerId,
    String? managerUsername,
    int? amount,
    String? comment,
    String? transactionId,
    bool? isLoan,
  ) = _DepositWithdrawPayDebtManagerRequestObject;
}

@freezed
class AddEditManagerRequestObject with _$AddEditManagerRequestObject {
  factory AddEditManagerRequestObject(
    String? username,
    int? enabled,
    String? password,
    String? confirmPassword,
    int? aclGroupId,
    int? parentId,
    String? firstname,
    String? lastname,
    String? company,
    String? email,
    String? phone,
    String? city,
    String? address,
    String? notes,
  ) = _AddEditManagerRequestObject;
}

@freezed
class ManagerRequestObject with _$ManagerRequestObject {
  factory ManagerRequestObject(
    int page,
    int count,
    String sortBy,
    String direction,
    String search,
    List<String> columns,
    int parentId,
    int subManagers,
    int siteId,
    int aclGroupId,
    int groupId,
  ) = _ManagerRequestObject;
}

@freezed
class ActivationReportsRequestObject with _$ActivationReportsRequestObject {
  factory ActivationReportsRequestObject(
    int page,
    int count,
    String sortBy,
    String direction,
    String search,
    List<String> columns,
    int managerId,
    int subManagers,
    int profileId,
    int groupId,
    String activationMethod,
    String dateStart,
    String dateEnd,
  ) = _ActivationReportsRequestObject;
}

@freezed
class ManagerInvoicesRequestObject with _$ManagerInvoicesRequestObject {
  factory ManagerInvoicesRequestObject(
    int page,
    int count,
    String sortBy,
    String direction,
    String search,
    List<String> columns,
  ) = _ManagerInvoicesRequestObject;
}

@freezed
class ManagerJournalRequestObject with _$ManagerJournalRequestObject {
  factory ManagerJournalRequestObject(
    int page,
    int count,
    String sortBy,
    String direction,
    String search,
    List<String> columns,
  ) = _ManagerJournalRequestObject;
}

@freezed
class DepositObject with _$DepositObject {
  factory DepositObject(
    int amount,
    String method,
    String methodName,
    String pin,
  ) = _DepositObject;
}
