import 'package:sasuki/domain/models/captcha/captcha.dart';
import 'package:sasuki/domain/models/dashboard/auth.dart';
import 'package:sasuki/domain/models/dashboard/dashboard.dart';

abstract class DashboardViewModelOutputs {
  Stream<Dashboard> get outputDashboardData;
  Stream<Auth> get outputAuthData;
  Stream<Captcha> get outputDataCaptcha;
}
