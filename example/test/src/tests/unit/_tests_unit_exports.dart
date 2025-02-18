// Supply the dependencies for the example app
export 'package:fluttery_framework_example/src/controller.dart';

export 'package:fluttery_framework_example/src/model.dart' hide StateSetter;

export 'package:fluttery_framework_example/src/view.dart'
    hide AppSettingsDrawer, AppSettings;

/// Supply all the dependencies necessary to complete the testing.
///

export 'package:flutter_test/flutter_test.dart';

export 'package:fluttery_framework/view.dart' hide AppDrawer, PopupMenuWidget;

export 'package:fluttery_framework/controller.dart';

export 'unit_tests.dart';

/// Tests
///

export 'controller_test.dart';

export 'drawer_dialog_tests.dart';

export '../menu/open_drawer.dart';

export '../unit/src/controller/_tests_unit_controller.dart';

export '../unit/src/view/_tests_unit_view.dart';
