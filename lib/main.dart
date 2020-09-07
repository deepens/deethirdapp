import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import './shared/redirect.dart' as pagerouting;
import './shared/locator.dart';
import './services/navigation_service.dart';
import './services/dialog_service.dart';
import './views/startup_view.dart';
import './shared/dialog_manager.dart';
import './views/constants.dart';
//import 'package:path_provider/path_provider.dart';
//import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';

void main() async {
  setupLocator();
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  //var dir = await getApplicationDocumentsDirectory();
  //Hive.init(dir.path);
  await Hive.initFlutter();
  await Hive.openBox<List<Map<String, dynamic>>>('pushNotificationMessageBox');
  Hive.box<List<Map<String, dynamic>>>('pushNotificationMessageBox').clear();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // StreamProvider<ConnectivityStatus>(
    //   builder: (context) => ConnectivityService().connectionStatusController,
    //       child: ChangeNotifierProvider<Fauth>(
    //       builder: (context) => Fauth(),
    //child:

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      navigatorKey: locator<NavigationService>().navigationKey,
      builder: (context, child) => Navigator(
        key: locator<DialogService>().dialogNavigationKey,
        onGenerateRoute: (settings) => MaterialPageRoute(
            builder: (context) => DialogManager(child: child)),
      ),
      theme: ThemeData(
        primaryColor: kPrimaryColor,
        //scaffoldBackgroundColor: Colors.white,
        textTheme: Theme.of(context).textTheme.apply(
              fontFamily: 'Open Sans',
            ),
      ),
      home: StartUpView(),
      onGenerateRoute: pagerouting.redirectingtopage,
    );
    //  ),
//  );
  }
}
