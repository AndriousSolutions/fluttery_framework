//
import '/src/controller.dart';

/// The App's theme controller
///
/// {@category Get started}
class ThemeController extends StateXController {
  ///
  factory ThemeController() => _this ??= ThemeController._();
  ThemeController._() {
    _isDarkmode = Prefs.getBool('darkmode', false);
  }
  static ThemeController? _this;
  late bool _isDarkmode;

  /// Indicate if in 'dark mode' or not
  bool get isDarkMode => _isDarkmode;

  /// Record if the App's in dark mode or not.
  set isDarkMode(bool? set) {
    if (set == null) {
      return;
    }
    _isDarkmode = set;
    Prefs.setBool('darkmode', _isDarkmode);
  }

  /// Explicitly return the 'dark theme.'
  ThemeData setDarkMode() {
    isDarkMode = true;
    return ThemeData.dark();
  }

  /// Returns 'dark theme' only if specified.
  /// Otherwise, it returns null.
  ThemeData? setIfDarkMode() => _isDarkmode ? setDarkMode() : null;
}
