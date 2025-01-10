//
// Flutter Test files
import '../../../_tests_exports.dart';

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
  String get page {
    //
    final state = NavController().state;
    String page;
    if (state == null) {
      page = '';
      assert(() {
        assert(state != null, "NavController().state can't be null?!");
        return true;
      }());
    } else {
      page = (state as NavState).title;
    }
    return page;
  }

  @override
  void dispose() {
    appState?.removeNavigationListener(navListener);
    super.dispose();
  }

  /// Series of tests
  Future<void> tests() async {
    //
    final opened = await openDrawerOption('Navigation', tester);

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

    //   await _finalizeRouteWidgetTest(this);

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

    await _popAndPushNamedWidgetTest(this);

    expect(popped, isTrue, reason: _location);

    expect(page == 'Page05', isTrue, reason: _location);

    // Attempt to pop the next route
    popped = false;
    //
    // await _popUntilWidget(this);
    //
    // expect(popped, isTrue, reason: _location);
    //
    // expect(page == 'Page02', isTrue, reason: _location);

    final tapPush = await scrollToTap(tester, 'push');

    if (!tapPush) {
      return;
    }

    await _pushWidgetTest(this);

    await _pushAndRemoveUntilWidgetTest(this);

    await _pushNamedWidgetTest(this);

    await _pushNamedAndRemoveUntilWidget(this);

    await _pushReplacementWidgetTest(this);

    /// Stop the testing here for now.
    await exitScreens(tester);
    return;
    await _pushReplacementNamedWidgetTest(this);

    await _removeRouteWidgetTest(this);

    await _removeRouteBelowWidgetTest(this);

    await _replaceWidgetTest(this);

    await _replaceRouteBelowWidgetTest(this);

    await _restorablePopAndPushNamedWidgetTest(this);

    await _restorablePushWidgetTest(this);

    await _restorablePushAndRemoveUntilWidgetTest(this);

    await _restorablePushNamedWidgetTest(this);

    await _restorablePushNamedAndRemoveUntilWidgetTest(this);

    await _restorablePushReplacementWidgetTest(this);

    await _restorablePushReplacementNamedWidgetTest(this);

    await _restorableReplaceWidgetTest(this);

    await _restorableReplaceRouteBelowWidgetTest(this);

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

  /// Called when this State is *first* added to as a Route observer?!
  @override
  void didPush() {
    assert(() {
      debugPrint('============ Event: didPush($state) in $this');
      return true;
    }());
  }

  /// New route has been pushed, and this State object's route is no longer current.
  @override
  void didPushNext() {
    assert(() {
      debugPrint('============ Event: didPush($state) in $this');
      return true;
    }());
  }

  /// Called when this State is popped off a route.
  @override
  void didPop() {
    assert(() {
      debugPrint('============ Event: didPop($state) in $this');
      return true;
    }());
  }

  /// The top route has been popped off, and this route shows up.
  @override
  void didPopNext() {
    assert(() {
      debugPrint('============ Event: didPopNext($state) in $this');
      return true;
    }());
  }
}

//
Future<void> _canPopWidgetTest(_AppNavigationTest app) =>
    app.buttonTest('canPopWidget', () => find.textContaining('has returned'));

//
Future<void> _finalizeRouteWidgetTest(_AppNavigationTest app) =>
    app.tap('finalizeRouteWidget');

//
Future<void> _maybePopWidgetTest(_AppNavigationTest app) =>
    app.tap('maybePopWidget');

//
Future<void> _popWidgetTest(_AppNavigationTest app) => app.tap('popWidget');

//
Future<void> _pushWidgetTest(_AppNavigationTest app) => app.tap('pushWidget');

//
Future<void> _popAndPushNamedWidgetTest(_AppNavigationTest app) =>
    app.tap('popAndPushNamedWidget');

//
Future<void> _pushAndRemoveUntilWidgetTest(_AppNavigationTest app) =>
    app.tap('pushAndRemoveUntilWidget');

//
Future<void> _pushNamedWidgetTest(_AppNavigationTest app) =>
    app.tap('pushNamedWidget');

//
Future<void> _pushNamedAndRemoveUntilWidget(_AppNavigationTest app) =>
    app.tap('pushNamedAndRemoveUntilWidget');

//
Future<void> _pushReplacementWidgetTest(_AppNavigationTest app) =>
    app.tap('pushReplacementWidget');

//
Future<void> _pushReplacementNamedWidgetTest(_AppNavigationTest app) =>
    app.tap('pushReplacementNamedWidget');

//
Future<void> _removeRouteWidgetTest(_AppNavigationTest app) =>
    app.tap('removeRouteWidget');

//
Future<void> _removeRouteBelowWidgetTest(_AppNavigationTest app) =>
    app.tap('removeRouteBelowWidget');

//
Future<void> _replaceWidgetTest(_AppNavigationTest app) =>
    app.tap('replaceWidget');

//
Future<void> _replaceRouteBelowWidgetTest(_AppNavigationTest app) =>
    app.tap('replaceRouteBelowWidget');

//
Future<void> _restorablePopAndPushNamedWidgetTest(_AppNavigationTest app) =>
    app.tap('restorablePopAndPushNamedWidget');

//
Future<void> _restorablePushWidgetTest(_AppNavigationTest app) =>
    app.tap('restorablePushWidget');

//
Future<void> _restorablePushAndRemoveUntilWidgetTest(_AppNavigationTest app) =>
    app.tap('restorablePushAndRemoveUntilWidget');

//
Future<void> _restorablePushNamedWidgetTest(_AppNavigationTest app) =>
    app.tap('restorablePushNamedWidget');

//
Future<void> _restorablePushNamedAndRemoveUntilWidgetTest(
        _AppNavigationTest app) =>
    app.tap('restorablePushNamedAndRemoveUntilWidget');

//
Future<void> _restorablePushReplacementWidgetTest(_AppNavigationTest app) =>
    app.tap('restorablePushReplacementWidget');

//
Future<void> _restorablePushReplacementNamedWidgetTest(
        _AppNavigationTest app) =>
    app.tap('estorablePushReplacementNamedWidget');

//
Future<void> _restorableReplaceWidgetTest(_AppNavigationTest app) =>
    app.tap('restorableReplaceWidget');

//
Future<void> _restorableReplaceRouteBelowWidgetTest(_AppNavigationTest app) =>
    app.tap('restorableReplaceRouteBelowWidget');
