//
// Flutter Test files
import '../src/_test_imports.dart';

String _location = '========================== test_navigation.dart';

/// Testing the counter app
Future<void> appNavigationTest(WidgetTester tester) =>
    _AppNavigationTest(tester).tests();

// Helper class
class _AppNavigationTest extends StateXController {
  factory _AppNavigationTest(WidgetTester tester) =>
      _this ??= _AppNavigationTest._(tester);
  _AppNavigationTest._(this.tester);
  static _AppNavigationTest? _this;

  final WidgetTester tester;

  /// Current Page
  String get page => (NavController().state as NavState).title;

  @override
  void dispose() {
    appState?.removeNavigationListener(navListener);
    super.dispose();
  }

  /// Series of tests
  Future<void> tests() async {
    //
    var opened = await openDrawerOption('Navigation', tester);

    if (!opened) {
      return;
    }

    final con = NavController();

    con.state?.add(this);

    await tapButton(tester, key: 'Next Page', count: 2);

    //
    appState?.addNavigationListener(navListener);

    await _canPopWidgetTest(this);

    expect(page == 'Page04', isTrue, reason: _location);

    // Attempt to pop the route
    if (con.state!.canPop()) {
      popped = false;
    }

    await _maybePopWidgetTest(this);

    expect(popped, isTrue, reason: _location);

    expect(page == 'Page03', isTrue, reason: _location);

    // Attempt to pop the next route
    popped = false;

    await _popWidgetTest(this);

    expect(popped, isTrue, reason: _location);

    expect(page == 'Page02', isTrue, reason: _location);

    // Attempt to pop the next route
    popped = false;

    await _popAndPushNamedWidget(this);

    expect(popped, isTrue, reason: _location);

    expect(page == 'Page06', isTrue, reason: _location);

    // // Attempt to pop the next route
    // popped = false;
    //
    // await _popUntilWidget(this);
    //
    // expect(popped, isTrue, reason: _location);
    //
    // expect(page == 'Page02', isTrue, reason: _location);


    // await _pushWidget(this);


    await exitScreens(tester);
  }

  // toggled when push and pop
  bool pushed = false;
  bool popped = false;
  bool pushedNext = false;
  bool poppedNext = false;

  // Called with an Navigator change
  bool navListener(NavigationNotification notification) {
    final canHandlePop = notification.canHandlePop;
    expectSync(canHandlePop, isTrue, reason: _location);
    popped = true;
    return canHandlePop;
  }

  // Tap a button and expect the passed Finder function
  Future<void> buttonTest(
    String keyValue,
    Finder Function() finder,
  ) async {
    //
    await tap(keyValue);

    expect(finder(), findsOneWidget, reason: _location);
  }

  // Tap a button
  Future<void> tap(String keyValue) async {
    //
    final keyButton = '$keyValue${page}Button';

    await tapButton(tester, key: keyButton);
  }

  /// Exit screens
  Future<void> exitScreens(WidgetTester tester) async {
    /// Retreat back and exit the screen
    await tapButton(tester, key: 'Prev Page', keyUntil: 'Exit');

    await closeDrawer(tester);
  }
}

//
Future<void> _canPopWidgetTest(_AppNavigationTest app) =>
    app.buttonTest('canPopWidget', () => find.textContaining('has returned'));

//
Future<void> _maybePopWidgetTest(_AppNavigationTest app) =>
    app.tap('maybePopWidget');

//
Future<void> _popWidgetTest(_AppNavigationTest app) => app.tap('popWidget');

//
Future<void> _popAndPushNamedWidget(_AppNavigationTest app) =>
    app.tap('popAndPushNamedWidget');

//
Future<void> _popUntilWidget(_AppNavigationTest app) =>
    app.tap('popUntilWidget');

//
Future<void> _pushWidget(_AppNavigationTest app) =>
    app.tap('pushWidget');