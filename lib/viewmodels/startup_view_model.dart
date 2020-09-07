import '../shared/shareddata_constants.dart';
import '../shared/locator.dart';
import '../services/navigation_service.dart';
import '../viewmodels/base_model.dart';
import '../shared/routing_constants.dart';
import '../services/shareddata_service.dart';

class StartUpViewModel extends BaseModel {
  final NavigationService _navigationService = locator<NavigationService>();
  final SharedDataService _sharedDataService = locator<SharedDataService>();

  Future handleStartUpLogic() async {
    await _sharedDataService.initialise();

    //await _auth.initalise();
    print("***>" + _sharedDataService.getSharedData(ISUSERLOGGEDIN).toString());
    if (_sharedDataService.getSharedData(ISUSERLOGGEDIN).toString() == YES) {
      _navigationService.navigateTo(HomePageRoute);
    } else {
      _navigationService.navigateTo(SignInViewPageRoute);
    }
  }
}
