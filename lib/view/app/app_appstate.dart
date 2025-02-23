// Copyright 2023 Andrious Solutions Ltd. All rights reserved.
// Use of this source code is governed by a 2-clause BSD License.
// The main directory contains that LICENSE file.
//
//          Created  01 Apr 2023
//

import '/view.dart';

///
extension AppStateExtension on AppObject {
  // Use Material UI when explicitly specified or even when running in iOS
  /// Indicates if the App is running the Material interface theme.
  bool get useMaterial => appState?.useMaterial ?? UniversalPlatform.isAndroid;

  // Use Cupertino UI when explicitly specified or even when running in Android
  /// Indicates if the App is running the Cupertino interface theme.
  bool get useCupertino => appState?.useCupertino ?? UniversalPlatform.isIOS;

  /// Explicitly change the app's locale.
  Future<bool> changeLocale(Locale? locale) async {
    bool change = locale != null;
    if (change) {
      change = await App.saveLocale(locale);
      if (change) {
        // Reflect the change by rebuilding the app.
        App.setState(() {});
      }
    }
    return change;
  }

  /// Determines if running in an IDE or in production.
  bool get inDebugMode => appState?.inDebugMode ?? false;

  /// Explicitly change to a particular interface.
  void changeUI(String ui) => appState?.changeUI(ui);

  /// Refresh the root State object with the passed function.
  void setState(VoidCallback fn) => appState?.setState(fn);

  /// Refresh the 'current/latest' State object and 'root/first' State object.
  /// todo: Is refresh() deprecated?
  void refresh() => appState?.refresh();

  /// Link a widget to a InheritedWidget in the root State object.
  void dependOnInheritedWidget(BuildContext? context) =>
      appState?.dependOnInheritedWidget(context);

  /// Rebuild dependencies to the root State object's InheritedWidget
  void notifyClients() => appState?.notifyClients();

  /// Catch and explicitly handle the error.
  void catchError(
    Object? ex, {
    StackTrace? stack,
    String? library,
    DiagnosticsNode? context,
    IterableFilter<String>? stackFilter,
    InformationCollector? informationCollector,
    bool? silent,
  }) {
    if (ex is! Exception) {
      ex = Exception(ex.toString());
    }

    appState?.catchError(
      ex,
      stack: stack,
      // Supply the app's name instead.
      library: library ?? App.packageInfo?.appName,
      context: context,
      stackFilter: stackFilter,
      informationCollector: informationCollector,
      silent: silent ?? false,
    );
  }

  /// Retrieve the 'latest' context
  BuildContext? get context => appState?.lastContext;
}
