// Copyright 2018 Andrious Solutions Ltd. All rights reserved.
// Use of this source code is governed by a 2-clause BSD License.
// The main directory contains that LICENSE file.
//
//          Created  25 Dec 2018
//
//

/// Material
export 'package:flutter/material.dart' hide runApp, StateSetter;

/// Cupertino
export 'package:flutter/cupertino.dart'
    hide RefreshCallback, runApp, StateSetter;

/// Supply the custom runApp function
export '/src/view/platforms/run_app.dart'
    if (dart.library.html) '/src/view/platforms/run_webapp.dart' show runApp;

/// Replace 'dart:io' for Web applications
export 'package:universal_platform/universal_platform.dart';

/// Flutter Framework's Foundation
export 'package:flutter/foundation.dart'; // show kDebugMode, kIsWeb, mustCallSuper, protected;

/// StateX
export 'package:state_extended/state_extended.dart'
    show AppStateX, SetState, StateXonErrorMixin;

/// App
export '/view/app.dart';

/// App StatefulWidget
export '/view/app_statefulwidget.dart' hide ErrorWidgetBuilder;

/// App State Object
export '/view/app_state.dart';

/// Settings
export '/src/view/utils/app_settings.dart';

/// Error Handling
export '/src/view/utils/error_handler.dart';
//    show AppErrorHandler, displayErrorWidgetChild, ReportErrorHandler;

/// Routing
export '/src/view/utils/app_route_observer.dart';

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
export '/view/app_menu.dart';

/// Extensions
export '/view/app/app_appstate.dart';
export '/view/app/app_navigation.dart';
export '/view/extensions/_extensions_view.dart';
export '/view/extensions/string_extensions.dart';

/// Reactive
export '/view/rx_core/_view_rx.dart';

/// UX Utils
export '/src/view/uxutils/view.dart';

/// Web
export 'package:url_launcher/link.dart';
export 'package:url_launcher/url_launcher.dart';
export '/src/view/web/hyperlink.dart';
export '/src/view/web/webpage_wrapper.dart';

/// Preferences
export 'package:prefs/prefs.dart' show Prefs;

/// Translations
export 'package:l10n_translator/l10n.dart';

/// Responsive UI
export 'package:sizer/sizer.dart';
