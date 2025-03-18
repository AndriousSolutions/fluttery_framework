library;

/// Copyright 2023 Andrious Solutions Ltd. All rights reserved.
/// Use of this source code is governed by a 2-clause BSD License.
/// The main directory contains that LICENSE file.
///
///          Created 07 February, 2025
///

import 'package:fluttery_framework_example/test/src/_tests_xport.dart';

String _location = '========================== multi_counters_test.dart';

/// Testing the counter app
Future<void> multiCountersTest(WidgetTester tester) async {
  // tap button
  await tester.tap(find.byKey(const Key('Page 1')));
  await tester.pumpAndSettle(const Duration(seconds: 1));

  // Verify that our counter starts at 0.
  expect(find.text('0'), findsOneWidget, reason: _location);

  // Access thr 'Counter' Controller object
  final con = Controller();

  StateX state = con.state!;
  expect(state, isA<Page1State>(),
      reason: _location); // State public for Testing.

  // Tap the '+' icon and settle a frame.
  await tester.tap(find.byIcon(Icons.add));
  await tester.pumpAndSettle();

  // Tap the '+' icon again
  await tester.tap(find.byIcon(Icons.add));
  await tester.pumpAndSettle();

  // Verify that our counter has incremented.
  expect(find.text('2'), findsOneWidget, reason: _location);

  // Go to Page 2
  await tester.tap(find.byKey(const Key('Page 2')));
  await tester.pumpAndSettle();

  /// Looking up by the StatefulWidget (in case the State class is private),
  /// you can retrieve the 'current' State object the Controller has collected so far.
  state = con.stateOf<Page2>()!;

  // Polymorphism of course
  expect(state, isA<Page2State>(), reason: _location);
  expect(state, isA<StateX>(), reason: _location);
  expect(state, isA<State>(), reason: _location);

  /// Note still has access to the previous screen (the previous State object)
  /// THIS IS HUGE! You now have the State object from a previous screen!!
  state = con.stateOf<Page1>()!;

  expect(state, isA<Page1State>(), reason: _location);

  /// A StateX object notes its latest Controller as well.
  StateXController controller = state.controllerByType<Controller>()!;

  expect(controller, isA<Controller>(), reason: _location);
  expect(controller, isA<StateXController>(), reason: _location);

  /// As a StateX object, there's certain properties available
  controller = state.controller!;

  expect(controller, isA<Controller>(), reason: _location);
  expect(controller, isA<StateXController>(), reason: _location);

  /// The current State object is the current StatefulWidget displayed.
  state = con.state!;

  // Polymorphism
  expect(state, isA<Page2State>(), reason: _location);
  expect(state, isA<StateX>(), reason: _location);
  expect(state, isA<State>(), reason: _location);

  /// The controller's latest State is its current State
  expect(state == con.lastState!, isTrue, reason: _location);

  /// Page1State is not Page2State
  expect(state == con.firstState!, isFalse, reason: _location);

  /// As a State object, there's the standard properties
  expect(state.widget, isA<Page2>(), reason: _location);

  final id = controller.identifier;

  /// Each controller is assigned an unique identifier.
  final stateXController = state.controllerById(id);

  expect(stateXController, isA<StateXController?>(), reason: _location);
  expect(controller, isA<Controller>(), reason: _location);

  // Retrieve the current count.
  expect(find.text('0'), findsOneWidget, reason: _location);
  // Verify that the controller's count also starts at 0.
  expect(con.count == 0, isTrue, reason: _location);

  // Tap the '+' icon
  await tester.tap(find.byIcon(Icons.add));
  await tester.pumpAndSettle();

  // Verify the count has incremented
  expect(find.text('1'), findsOneWidget, reason: _location);

  /// Note the Controller is recording the count on Page 2
  expect(con.count == 1, isTrue, reason: _location);

  // Go to Page 3
  await tester.tap(find.byKey(const Key('Page 3')));
  await tester.pumpAndSettle();

  // Fall back to the last screen
  if (AppErrorHandler().errorMsg.contains('Error in _buildPage3')) {
    AppController().appState?.lastContext?.pop();
    await tester.pumpAndSettle();
  }

  // Increase the count on Page 1
  var finder = find.byKey(const Key('Page 1 Counter'));
  await tester.tap(finder);
  await tester.pumpAndSettle();
  await tester.tap(finder);
  await tester.pumpAndSettle();

  // Back to Page 1
  await tester.tap(find.byKey(const Key('Page 1')));
  await tester.pumpAndSettle();

  // Verify the count has incremented
  expect(find.text('4'), findsOneWidget, reason: _location);

  // Back to Page 2
  await tester.tap(find.byKey(const Key('Page 2')));
  await tester.pumpAndSettle();

  // Back to Page 3
  await tester.tap(find.byKey(const Key('Page 3')));
  await tester.pumpAndSettle();

  // Increase the count on Page 2
  finder = find.byKey(const Key('Page 2 Counter'));
  await tester.tap(finder);
  await tester.pumpAndSettle();
  await tester.tap(finder);
  await tester.pumpAndSettle();

  // Back to Page 2
  await tester.tap(find.byKey(const Key('Page 2')));
  await tester.pumpAndSettle();

  // Verify the count has incremented
  expect(find.text('3'), findsOneWidget, reason: _location);

  // Back to Page 1
  await tester.tap(find.byKey(const Key('Page 1')));
  await tester.pumpAndSettle();

  /// Press the 'back button'
  await tapBackButtonTester(tester);
}
