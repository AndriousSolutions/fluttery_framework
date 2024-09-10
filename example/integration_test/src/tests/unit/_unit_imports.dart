// Supply the dependencies for the example app
export 'package:fluttery_framework_example/src/controller.dart';

export 'package:fluttery_framework_example/src/model.dart' hide StateSetter;

export 'package:fluttery_framework_example/src/view.dart';

/// Supply all the dependencies necessary to complete the testing.
export 'package:flutter_test/flutter_test.dart';

export 'package:fluttery_framework/view.dart' hide AppDrawer, PopupMenuWidget;

export 'package:fluttery_framework/controller.dart' hide AppDrawer;

export 'unit_tests.dart';

/// Tests
///

export 'controller_test.dart';

export 'wordpairs_model.dart';

export 'drawer_dialog_tests.dart';

export 'simple_buttom_bar_test.dart';

export '../unit/src/controller/_unit_test_controller.dart';

export '../unit/src/model/_unit_test_model.dart';

export '../unit/src/view/extensions/test_extensions.dart';
export '../unit/src/view/extensions/test_context_extensions.dart';
export '../unit/src/view/extensions/test_double_extensions.dart';
export '../unit/src/view/extensions/test_duration_extensions.dart';
export '../unit/src/view/extensions/test_dynamic_extensions.dart';
export '../unit/src/view/extensions/test_num_extensions.dart';
export '../unit/src/view/extensions/test_string_extensions.dart';
export '../unit/src/view/extensions/test_widget_extensions.dart';

export '../unit/src/view/utils/test_app_settings.dart';
export '../unit/src/view/utils/test_error_handler.dart';
export '../unit/src/view/utils/test_field_widgets.dart';
export '../unit/src/view/utils/test_inherited_state.dart';
export '../unit/src/view/utils/test_loading_screen.dart';

export '../unit/src/view/uxutils/test_custom_raised_button.dart';
export '../unit/src/view/uxutils/test_custom_scroll_physics.dart';
export '../unit/src/view/uxutils/test_dialog_box.dart';
export '../unit/src/view/uxutils/test_iso_spinner.dart';
export '../unit/src/view/uxutils/test_nav_bottom_bar.dart';
export '../unit/src/view/uxutils/test_preferred_orientation_mixin.dart';
export '../unit/src/view/uxutils/test_show_cupertino_date_picker.dart';
export '../unit/src/view/uxutils/test_simple_bottom_appbar.dart';
export '../unit/src/view/uxutils/test_tab_buttons.dart';
export '../unit/src/view/uxutils/test_variable_string.dart';
export '../unit/src/view/uxutils/test_white_black_foreground.dart';

export '../unit/src/view/web/test_hyperlink.dart';
export '../unit/src/view/web/test_webpage_wrapper.dart';

export '../unit/src/view/test_app.dart';
export '../unit/src/view/test_app_menu.dart';
export '../unit/src/view/test_app_navigator.dart';
export '../unit/src/view/test_app_state.dart';
export '../unit/src/view/test_app_statefulwidget.dart';
