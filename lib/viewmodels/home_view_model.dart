import '../services/signout_service.dart';
import '../viewmodels/base_model.dart';
import '../shared/locator.dart';

class HomeViewModel extends BaseModel {
  final SignOutService _signOutService = locator<SignOutService>();

  signOut() async {
    showProgressBar(true);
    _signOutService.signOut();
    showProgressBar(false);
  }
}
