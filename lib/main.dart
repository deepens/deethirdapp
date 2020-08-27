import 'package:flutter/material.dart';
import './shared/redirect.dart' as pagerouting;
import './shared/locator.dart';
import './services/navigation_service.dart';
import './services/dialog_service.dart';
import './views/startup_view.dart';
import './shared/dialog_manager.dart';
import './views/constants.dart';
void main() {
  setupLocator();
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
        primaryColor:kPrimaryColor,
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
