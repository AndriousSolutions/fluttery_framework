//
import 'src/_test_imports.dart';

String _location = '========================== test_navigation.dart';

/// Testing the counter app
Future<void> appNavigationTest(WidgetTester tester) async {
  //
  final opened = await openDrawerOption('Navigation', tester);

  if (!opened) {
    return;
  }
  // Run tests
  await _AppNavigationTest(tester).tests();
}

// Helper class
class _AppNavigationTest extends StateXController {
  _AppNavigationTest(this.tester) {
    con = NavController();
    con.state?.add(this);
  }

  final WidgetTester tester;

  late NavController con;

  /// Current Page
  String get page => (con.state as NavState).title;

  @override
  void dispose() {
    con.rootState?.removeNavigationListener(_callback);
    super.dispose();
  }

  /// Series of tests
  Future<void> tests() async {
    //
    await tapButton(tester, key: 'Next Page', count: 2);

    await _canPopWidgetTest(this);

    await _maybePopWidgetTest(this);

    await _exitScreens(tester);
  }

  // toggled when push and pop
  bool pushed = false;
  bool popped = false;
  bool pushedNext = false;
  bool poppedNext = false;
}

//
Future<void> _canPopWidgetTest(_AppNavigationTest app) => _buttonTest(
      app,
      'canPopWidget',
      () => find.textContaining('has returned'),
    );

//
Future<void> _maybePopWidgetTest(_AppNavigationTest app) {
  //
  app.rootState?.addNavigationListener(_callback);

  return _tapButton(app, 'maybePopWidget');
}

// Tap a button and expect the passed Finder function
Future<void> _buttonTest(
  _AppNavigationTest con,
  String keyValue,
  Finder Function() finder,
) async {
  //
  await _tapButton(con, keyValue);

  expect(finder(), findsOneWidget, reason: _location);
}

// Tap a button
Future<void> _tapButton(
  _AppNavigationTest app,
  String keyValue,
) async {
  //
  final keyButton = '$keyValue${app.page}Button';

  await tapButton(app.tester, key: keyButton);
}

/// Exit screens
Future<void> _exitScreens(WidgetTester tester) async {
  /// Retreat back and exit the screen
  await tapButton(tester, key: 'Prev Page', keyUntil: 'Exit');

  await closeDrawer(tester);
}


NotificationListenerCallback<NavigationNotification> _callback =
    (NavigationNotification notification) {
  //
  final canHandlePop = notification.canHandlePop;
  expectSync(canHandlePop, isTrue, reason: _location);
  return canHandlePop;
};