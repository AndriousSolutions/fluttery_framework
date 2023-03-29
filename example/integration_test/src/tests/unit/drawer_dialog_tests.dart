import '_unit_imports.dart';

const _location = '========================== drawer_dialog_tests.dart';

//
Future<void> dialogTests(WidgetTester tester) async {
  // // Drag open the left-sided Drawer
  // await tester.dragFrom(
  //     tester.getTopLeft(find.byType(MaterialApp)), const Offset(300, 0));
  // await tester.pumpAndSettle();

  // Programmatically open the Drawer
  final ScaffoldState state = tester.firstState(find.byType(Scaffold));
  state.openDrawer();
  await tester.pumpAndSettle();

  await _openDialogWindow('Show Box', tester);

  await _openDialogWindow('Dialog Box', tester);

  await _openDialogWindow('Message Box', tester);

  if (state.isDrawerOpen) {
    Navigator.pop(state.context);
  }
  await tester.pumpAndSettle();
}

/// Open a particular type of dialog window.
Future<void> _openDialogWindow(String key, WidgetTester tester) async {
  //
  var finder = find.byKey(Key(key));
  await tester.tap(finder);
  await tester.pumpAndSettle(const Duration(milliseconds: 200));

  finder = find.byKey(const Key('button01'));

  if (finder.evaluate().isNotEmpty) {
    await tester.tap(finder);
    await tester.pumpAndSettle(const Duration(milliseconds: 200));
  }
}
