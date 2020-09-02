import '../shared/shareddata_constants.dart';
import '../shared/locator.dart';
import '../services/navigation_service.dart';
import '../viewmodels/base_model.dart';
import '../shared/routing_constants.dart';
import '../services/pushnotification_service.dart';
import '../services/shareddata_service.dart';
//import '../viewmodels/pushnotification_view_model.dart';

class StartUpViewModel extends BaseModel {
  final NavigationService _navigationService = locator<NavigationService>();
  final PushNotificationService _pushNotificationService =
      locator<PushNotificationService>();
  final SharedDataService _sharedDataService = locator<SharedDataService>();
  Future handleStartUpLogic() async {
    //await _pushNotificationService.initialise();
    await _sharedDataService.initialise();

    print("***>" + _sharedDataService.getSharedData(ISUSERLOGGEDIN).toString());
    if (_sharedDataService.getSharedData(ISUSERLOGGEDIN).toString() == YES) {
      _navigationService.navigateTo(HomePageRoute);
    } else {
      _navigationService.navigateTo(SignInViewPageRoute);
    }
  }
}
