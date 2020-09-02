import '../services/signout_service.dart';
import '../viewmodels/base_model.dart';
import '../shared/locator.dart';
import '../viewmodels/pushnotification_view_model.dart';

class HomeViewModel extends BaseModel {
  final SignOutService _signOutService = locator<SignOutService>();

  signOut() async {
    showProgressBar(true);
    _signOutService.signOut();
    showProgressBar(false);
  }

  initialise() {
    PushnotificationViewModel().initialise();
  }
}
