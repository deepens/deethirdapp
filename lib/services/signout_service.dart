import '../services/navigation_service.dart';
import '../services/shareddata_service.dart';
import '../shared/locator.dart';
import '../shared/routing_constants.dart';
import '../shared/shareddata_constants.dart';

class SignOutService {
  final NavigationService _navigationService = locator<NavigationService>();
  final SharedDataService _sharedDataService = locator<SharedDataService>();
  signOut() async {
    await _sharedDataService.setSharedData(ISUSERLOGGEDIN, NO);
    print("Signout->" +
        _sharedDataService.getSharedData(ISUSERLOGGEDIN).toString());
    _navigationService.navigateTo(SignInViewPageRoute);
  }
}
