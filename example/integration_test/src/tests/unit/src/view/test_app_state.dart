/// Copyright 2023 Andrious Solutions Ltd. All rights reserved.
/// Use of this source code is governed by a 2-clause BSD License.
/// The main directory contains that LICENSE file.
///
///          Created 17 March, 2023
///

import 'package:fluttery_framework_example/src/controller.dart';

import '_unit_test_view.dart';

void testAppState(WidgetTester tester) {
  //
//  test('Test AppState', () async {
  // Find its StatefulWidget first then the 'type' of State object.
//  final appState = tester.firstState<AppState>(find.byType(FlutteryExampleApp));

  final appState = TemplateController().state as AppState;

  bool? use = appState.useCupertino;

  use = appState.isCupertino;

  use = appState.useMaterial;

  use = appState.isMaterial;

  AppState.homeKey;

  appState.app;

  appState.onError(FlutterErrorDetails(exception: AssertionError('Error')));
//  });
}
