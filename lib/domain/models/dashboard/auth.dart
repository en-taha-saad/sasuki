import 'package:sasuki/domain/models/dashboard/client_res.dart';

class Auth {
  int status;
  ClientRes? client;
  List<String> permissions;
  // List<String> features;
  // String licenseStatus;
  // String licenseExpiration;

  Auth(
    this.status,
    this.client,
    this.permissions,
    // this.features,
    // this.licenseStatus,
    // this.licenseExpiration,
  );
}
