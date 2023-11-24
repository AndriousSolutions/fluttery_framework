/// Copyright 2018 Andrious Solutions Ltd. All rights reserved.
/// Use of this source code is governed by a 2-clause BSD License.
/// The main directory contains that LICENSE file.
///
///          Created  25 Dec 2018
///
///

/// Material
export 'package:flutter/material.dart' hide runApp, StateSetter;

/// Cupertino
export 'package:flutter/cupertino.dart'
    hide RefreshCallback, runApp, StateSetter;

/// Supply the custom runApp function
export 'package:fluttery_framework/src/view/platforms/run_app.dart'
    if (dart.library.html) 'package:fluttery_framework/src/view/platforms/run_webapp.dart'
    show runApp;

/// Replace 'dart:io' for Web applications
export 'package:universal_platform/universal_platform.dart';

/// Flutter Framework's Foundation
export 'package:flutter/foundation.dart'; // show kDebugMode, kIsWeb, mustCallSuper, protected;

/// StateX
export 'package:state_extended/state_extended.dart'
    show AppStateX, SetState, StateXonErrorMixin;

/// App
export 'package:fluttery_framework/view/app.dart';

/// App StatefulWidget
export 'package:fluttery_framework/view/app_statefulwidget.dart'
    hide ErrorWidgetBuilder;

/// App State Object
export 'package:fluttery_framework/view/app_state.dart';

/// Settings
export 'package:fluttery_framework/src/view/utils/app_settings.dart';

/// Error Handling
export 'package:fluttery_framework/src/view/utils/error_handler.dart';
//    show AppErrorHandler, displayErrorWidgetChild, ReportErrorHandler;

/// Routing
export 'package:fluttery_framework/src/view/utils/state_route_observer.dart';

/// Navigation
/// Hide its BuildContext extension. It's been replaced.
export 'package:go_router/go_router.dart' hide GoRouterHelper;

/// Localizations
export 'package:flutter_localizations/flutter_localizations.dart'
    show
        GlobalCupertinoLocalizations,
        GlobalMaterialLocalizations,
        GlobalWidgetsLocalizations;

/// Menus
export 'package:fluttery_framework/view/app_menu.dart';

/// Extensions
export 'package:fluttery_framework/view/app/app_appstate.dart';
export 'package:fluttery_framework/view/app/app_navigation.dart';
export 'package:fluttery_framework/view/extensions/_extensions_view.dart';
export 'package:fluttery_framework/view/extensions/string_extensions.dart';

/// UX Utils
export 'package:fluttery_framework/src/view/uxutils/view.dart';

/// Web
export 'package:url_launcher/link.dart';
export 'package:url_launcher/url_launcher.dart';
export 'package:fluttery_framework/src/view/web/hyperlink.dart';
export 'package:fluttery_framework/src/view/web/webpage_wrapper.dart';

/// Preferences
export 'package:prefs/prefs.dart' show Prefs;

/// Translations
export 'package:l10n_translator/l10n.dart';

/// Responsive UI
export 'package:sizer/sizer.dart';
