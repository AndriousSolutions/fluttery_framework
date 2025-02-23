//
import '/src/controller.dart';

///
mixin AppOptionSettings on StateXController {
  /// Delay the app's initAsync
  late bool initAsyncDelay;

  /// Use the Router Configuration or not
  late bool useRouterConfig;

  /// Use Routes instead
  late bool useRoutes;

  /// Use InheritedWidget
  late bool useInheritedWidget;

  /// Use the home parameter
  late bool useHome;

  /// Use the 'onHome' function
  late bool useOnHome;

  /// Error in builder()
  late bool errorInBuilder;

  /// Error right at the start
  late bool initAsyncError;

  /// Display a Splash Screen
  late bool splashScreen;

  /// Throw error with button press
  late bool buttonError;
}
