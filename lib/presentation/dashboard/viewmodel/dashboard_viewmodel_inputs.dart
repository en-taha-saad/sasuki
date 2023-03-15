// inputs mean that "Orders" that our view model will receive from view
abstract class DashboardViewModelInputs {
  getAuth();
  getDashboardData();
  getDataStreamingly();
  Sink get inputDashboardData;
  Sink get inputAuthData;
  Sink get inputDataCaptcha;
}
