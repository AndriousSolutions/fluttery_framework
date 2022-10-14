///
/// Copyright (C) 2018 Andrious Solutions
///
/// Licensed under the Apache License, Version 2.0 (the "License");
/// you may not use this file except in compliance with the License.
/// You may obtain a copy of the License at
///
///    http://www.apache.org/licenses/LICENSE-2.0
///
/// Unless required by applicable law or agreed to in writing, software
/// distributed under the License is distributed on an "AS IS" BASIS,
/// WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
/// See the License for the specific language governing permissions and
/// limitations under the License.
///
///          Created  25 Dec 2018
///
///

/// Material
export 'package:flutter/material.dart' hide runApp;

/// Cupertino
export 'package:flutter/cupertino.dart' hide RefreshCallback, runApp;

/// Supply the custom runApp function
export 'package:fluttery_framework/src/conditional_export.dart'
    if (dart.library.html) 'package:fluttery_framework/src/view/platforms/run_webapp.dart'
    if (dart.library.io) 'package:fluttery_framework/src/view/platforms/run_app.dart'
    show runApp;

/// Replace 'dart:io' for Web applications
export 'package:universal_platform/universal_platform.dart';

/// Flutter Framework's Foundation
export 'package:flutter/foundation.dart' show kIsWeb, mustCallSuper, protected;

/// StateX
export 'package:state_extended/state_extended.dart'
    show AppStateX, InheritedStateX, SetState, StateX;

/// App
export 'package:fluttery_framework/src/view/app.dart';

/// App StatefulWidget
export 'package:fluttery_framework/src/view/app_statefulwidget.dart'
    hide ErrorWidgetBuilder;

/// App State Object
export 'package:fluttery_framework/src/view/app_state.dart';

/// Settings
export 'package:fluttery_framework/src/view/utils/app_settings.dart';

/// Error Handling
export 'package:fluttery_framework/src/view/utils/error_handler.dart';
//    show AppErrorHandler, displayErrorWidgetChild, ReportErrorHandler;

/// Screens
export 'package:fluttery_framework/src/view/utils/loading_screen.dart';

/// Fields
export 'package:fluttery_framework/src/view/utils/field_widgets.dart';

/// Localizations
export 'package:flutter_localizations/flutter_localizations.dart'
    show
        GlobalCupertinoLocalizations,
        GlobalMaterialLocalizations,
        GlobalWidgetsLocalizations;

/// TimeZone
export 'package:fluttery_framework/src/view/utils/timezone.dart';

/// InheritedWidget Widget
export 'package:fluttery_framework/src/view/utils/inherited_state.dart'
    show InheritedStates, InheritedStateWidget;

/// Menus
export 'package:fluttery_framework/src/view/app_menu.dart'
    show AppMenu, AppPopupMenu, Menu;

/// Extensions
export 'package:fluttery_framework/src/view/extensions/_extensions_view.dart';

/// Router Navigation
export 'package:fluttery_framework/src/view/app_navigator.dart';

/// UX Utils
export 'package:fluttery_framework/src/view/uxutils/view.dart';

/// Preferences
export 'package:prefs/prefs.dart' show Prefs;

/// Translations
export 'package:l10n_translator/l10n.dart';
