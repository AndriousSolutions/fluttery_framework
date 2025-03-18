// ignore_for_file: unused_local_variable, prefer_const_constructors
//
import 'package:flutter_test/flutter_test.dart';

import 'package:fluttery_framework_example/src/view.dart';

// Specify the name of this file
const _location = '========================== test_app_statex.dart';

/// Run the StateX class.
void codeCoverage() {
  ///
  testWidgets('StateX Class Code Coverage', (WidgetTester tester) async {
    await tester.pumpWidget(
      MaterialApp(
        title: 'Material App',
        home: Scaffold(
          body: _TestBed(tester: tester),
        ),
      ),
    );
  });
}

class _TestBed extends StatefulWidget {
  const _TestBed({super.key, required this.tester});
  final WidgetTester tester;
  @override
  State<StatefulWidget> createState() => _TestBedState();
}

/// Supply a 'Widget tree' for testing
class _TestBedState extends State<_TestBed> {
  @override
  void initState() {
    super.initState();
    tester = widget.tester;
  }

  //
  late WidgetTester tester;

  @override
  Widget build(BuildContext context) {
    //
    _coverCode(this);

    return Center(
      child: Text('Run AppStateX Code Coverage'),
    );
  }
}

//
void _coverCode(_TestBedState state) {
  //
  final WidgetTester tester = state.tester;

  final context = state.context;

  final appState = AppStateX();

  appState.onCatchAsyncError(Exception('Fake Exception!'));

  appState.onTitle();

  final details = FlutterErrorDetails(
    exception: Exception('Fake Exception!'),
    library: 'test_app_statex.dart',
    context: ErrorDescription('Test built-in AppStateX class'),
  );

  appState.onErrorHandler(details);

  final statex = StateX();

  statex.buildAndroid(context);

  statex.buildiOS(context);

  statex.appState;

  PopupMenuFunctionsMixin<String> pop = _PopupController();

  pop.setMenu();

  pop.showButtonMenu();

  pop.onItems();

  pop.onMenuEntries();

  pop.onItemBuilder();

  pop.onOpened();

  pop.onSelected('');

  pop.onCanceled();

  pop.onInitialValue();

  pop.onTooltip();

  pop.onElevation();

  pop.onPadding();

  pop.onSplashRadius();

  pop.onChild();

  pop.onIcon();

  pop.onIconSize();

  pop.onOffset();

  pop.onEnabled();

  pop.onShape();

  pop.onColor();

  pop.onEnableFeedback();

  pop.onConstraints();

  pop.onPosition();

  pop.onClipBehavior();

  pop = _PopupMenuFunctions();

  pop.setMenu();

  pop.showButtonMenu();

  pop.onItems();

  pop.onMenuEntries();

  pop.onItemBuilder();

  pop.onOpened();

  pop.onSelected('');

  pop.onCanceled();

  pop.onInitialValue();

  pop.onTooltip();

  pop.onElevation();

  pop.onPadding();

  pop.onSplashRadius();

  pop.onChild();

  pop.onIcon();

  pop.onIconSize();

  pop.onOffset();

  pop.onEnabled();

  pop.onShape();

  pop.onColor();

  pop.onEnableFeedback();

  pop.onConstraints();

  pop.onPosition();

  pop.onClipBehavior();
}

class _TestStateXWidget extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => AppStateX();
}

class _PopupController with PopupMenuControllerMixin<String> {}

class _PopupMenuFunctions with PopupMenuFunctionsMixin<String> {}
