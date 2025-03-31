library;
// Copyright 2022 Andrious Solutions Ltd. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

/// An absolute path is preferred but this source code is copied by other app.
import '/src/controller.dart';

/// An absolute path is preferred but this source code is copied by other app.
import '/src/view.dart';

/// The second page displayed in this app.
class Page2 extends StatefulWidget {
  ///
  const Page2({super.key});

  @override
  State createState() => Page2State();
}

/// This works with a separate 'data source'
/// It a separate data source, and so the count is never reset to zero.
class Page2State extends StateX<Page2> {
  ///
  Page2State() : super(controller: Controller(), printEvents: true) {
    /// Cast to type, Controller
    con = controller as Controller;
  }

  /// The controller reference property
  late Controller con;

  /// This function is not really necessary for th app to work
  /// Merely demonstrating the package's many capabilities to you.
  @override
  void initState() {
    //
    super.initState();

    /// Even the app's 'first' State object has a reference to itself
    final firstState = controller?.rootState;

    assert(firstState is AppStateX, "Should be the 'root' state object.");

    /// The latest BuildContext in the app.
    /// This is so important, there's a number of ways to get it.
    // ignore: unused_local_variable
    BuildContext? lastContext = controller?.state?.lastState?.context;
    lastContext = controller?.rootState?.lastState?.context;
    lastContext = controller?.lastContext;

    /// The app's data object
    // ignore: unused_local_variable
    final Object? dataObject = controller?.dataObject;

    /// Is the app is running in IDE or in production
    // ignore: unused_local_variable
    final bool? debugMode = controller?.inDebugMode;

    // its current state object
    var state = con.state;

    // by its StatefulWidget
    state = con.stateOf<Page1>();

    // by its type
    state = con.ofState<Page1State>();

    // Look what you have access to 'outside' the build() function.
    // ignore: unused_local_variable
    final mounted = state?.mounted;

    // ignore: unused_local_variable
    final widget = state?.widget;

    // ignore: unused_local_variable
    final context = state?.context;

    // Retrieve the app's own controller.
    final appCon = firstState?.rootCon;

    if (appCon != null && appCon is AppStateXController) {
      //
      final rootState = appCon.appState;

      // All three share the same State object.
      assert(rootState is AppStateX, "Should be the 'root' state object.");
    }
  }

  /// Place a breakpoint in here and see how it works
  @override
  Widget builder(BuildContext context) {
    /// 'More than one way to Skin a Cat! --- or get a Controller'
    /// Singleton pattern
    var con = AppController();

    /// The 'root' controller
    con = rootCon as AppController;

    /// The 'root' State has the controller
    con = rootState?.controller as AppController;
    // Throw an error right here to test recovery code.
    if (App.inWidgetsFlutterBinding && con.errorInBuild) {
      throw Exception('Error in builder!');
    }
    return super.builder(context);
  }

  /// Define the 'child' Widget that will be passed to the InheritedWidget above.
  @override
  Widget buildAndroid(BuildContext context) => TwoTabScaffold(
        appBar: AppBar(
          title: Text('Three-page example'.tr),
          actions: [AppMenu()],
        ),
        navigationBar: CupertinoNavigationBar(
          middle: Text('Three-page example'.tr),
          trailing: AppMenu(),
        ),

        /// Ignore BuildPage(). It's used only to highlight the other features in this page
        tab01: (_) => BuildPage(
          label: '2',
          count: con.count,
          counter: () {
            //
            if (App.inWidgetsFlutterBinding && AppController().buttonError) {
              // Deliberately throw an error to demonstrate error handling.
              throw Exception('Fake error to demonstrate error handling!'.tr);
            }
            con.onPressed();
          },
          row: (_) => [
            Flexible(
              child: ElevatedButton(
                key: const Key('Page 1'),
                style: flatButtonStyle,
                onPressed: context.pop,
                child: L10n.t('Page 1'),
              ),
            ),
            Flexible(
              child: ElevatedButton(
                key: const Key('Page 3'),
                style: flatButtonStyle,
                onPressed: () async {
                  if (AppController().useRoutes) {
                    // await App.context?.pushNamed('/Page3');
                    await context.pushNamed('/Page3');
                  } else {
                    // await App.context?.push('/Page3');
                    await context.push('/Page3');
                  }

                  /// A good habit to get into. Refresh the screen again.
                  /// In this case, to show the count may have changed.
                  setState(() {});
                },
                child: L10n.t('Page 3'),
              ),
            ),
          ],
          column: (context) => [
            Flexible(child: Text("Has a 'data source' to save the count".tr)),
            if (usingCupertino)
              Padding(
                padding: EdgeInsets.only(top: 1.h),
                child: CupertinoButton.filled(
                  onPressed: con.onPressed,
                  child: Text('Add'.tr),
                ),
              ),
          ],
          persistentFooterButtons: <Widget>[
            ElevatedButton(
              key: const Key('Page 1 Counter'),
              style: flatButtonStyle,
              onPressed: onPressed,
              child: L10n.t('Page 1 Counter'),
            ),
          ],
        ),
        tab02: (_) => SettingsScreen(
          title: 'Settings'.tr,
          child: const SettingsPage(),
        ),
      );

  /// Supply a public method to be accessed in Page 3.
  /// Calling another State object's function for demonstration purposes
  void onPressed() {
    final con = controller!;
    // Retrieve specific State object (thus it can't be private)
    Page1State state = con.ofState<Page1State>()!;
    // Retrieve State object by its StatefulWidget (will have to cast)
    state = con.stateOf<Page1>() as Page1State;
    state.count++;
    state.setState(() {});
  }

  /// Offer an error handler
  @override
  void onError(FlutterErrorDetails details) {
    //
    debugPrint('============ Event: onError() in $this');

    if (details
        .exceptionAsString()
        .contains('Fake error to demonstrate error handling!')) {
      con.onPressed();
    }
  }
}
