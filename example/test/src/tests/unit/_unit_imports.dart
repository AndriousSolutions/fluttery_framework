// Supply the dependencies for the example app
export 'package:fluttery_framework_example/src/controller.dart';

export 'package:fluttery_framework_example/src/model.dart' hide StateSetter;

export 'package:fluttery_framework_example/src/view.dart';

/// Supply all the dependencies necessary to complete the testing.
///

export 'package:flutter_test/flutter_test.dart';

export 'package:fluttery_framework/view.dart' hide AppDrawer, PopupMenuWidget;

export 'package:fluttery_framework/controller.dart' hide AppDrawer;

export 'unit_tests.dart';

/// Tests
///

export 'controller_test.dart';

export 'drawer_dialog_tests.dart';

export 'simple_buttom_bar_test.dart';

export '../menu/open_drawer.dart';

export '../unit/src/controller/_unit_test_controller.dart';

export '../unit/src/view/utils/test_app_settings.dart';
export '../unit/src/view/utils/test_error_handler.dart';
export '../unit/src/view/utils/test_inherited_state.dart';
export '../unit/src/view/utils/test_loading_screen.dart';

export '../unit/src/view/test_app.dart';
export '../unit/src/view/test_app_menu.dart';
export '../unit/src/view/test_app_navigator.dart';
export '../unit/src/view/test_app_state.dart';
export '../unit/src/view/test_app_statefulwidget.dart';
