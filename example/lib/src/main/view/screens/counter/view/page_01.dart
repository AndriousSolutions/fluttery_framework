// Copyright 2022 Andrious Solutions Ltd. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

// An absolute path is preferred but this source code is copied by other app.
import '/src/controller.dart';

import '/src/view.dart';

/// The first page displayed in this app.
class Page1 extends StatefulWidget {
  /// Page 1
  const Page1({super.key});

  @override
  State createState() => Page1State();
}

///
class Page1State extends StateX<Page1> {
  /// Supply a controller to this State object
  /// so to call its setState() function below.
  Page1State() : super(controller: Controller(), printEvents: true) {
    // Add some additional controllers;
    addList([AnotherController(), YetAnotherController()]);
  }

  /// The counter
  int count = 0;

  /// This function is not really necessary for th app to work
  /// Merely demonstrating the package's many capabilities to you.
  @override
  void initState() {
    //
    super.initState();

    // Just used to emphasize null can to returned if the controller is not found.
    StateXController? nullableController;

    /// Each StateX object references its current controller by this property.
    nullableController = controller;

    /// Each controller is assigned a unique identifier.
    // identifier is a 35-alphanumeric character string
    var id = nullableController?.identifier;

    /// You're able to retrieve a controller by its identifier.
    // Note, returns null if not found or id == null or empty
    nullableController = controllerById(id);

    /// You're able to retrieve a controller by its Type.
    // Note, returns null if not found.
    nullableController = controllerByType<Controller>();

    /// You're able to retrieve a controller by its Type.
    // Note, returns null if not found.
    var anotherController = controllerByType<AnotherController>();

    /// Each controller is assigned a unique identifier.
    // identifier is a 35-alphanumeric character string
    id = anotherController?.identifier;

    /// You're able to retrieve a controller by its identifier.
    // Note, returns null if not found or id == null or empty
    nullableController = controllerById(id);

    // No need to test 'nullableController is AnotherController'
    // Searching by identifier ensures its of that Type.
    if (nullableController != null) {
      anotherController = nullableController as AnotherController;
    }

    // Since, I'm confident such a controller will be retrieved
    // I can shortened the process like this.
    anotherController = controllerById(id) as AnotherController;
  }

  @override
  // ignore: unnecessary_overrides
  void dispose() {
    super.dispose();
  }

  /// Offer an error handler
  @override
  void onError(FlutterErrorDetails details) {
    //
    debugPrint('============ Event: onError() in $this');

    final msg = details.exceptionAsString();

    if (msg.contains('Fake error to demonstrate error handling!')) {
      count++;
      controller?.setState(() {});
    }
  }

  /// initAsync() has failed and a 'error' widget instead will be displayed.
  /// This takes in the snapshot.error details.
  @override
  void onAsyncError(FlutterErrorDetails details) {
    //
    debugPrint('============ Event: onAsyncError() in $this');
  }

  /// Invoke an error or not
  bool get initAsyncError => AppSettingsController().initAsyncError;

  /// Ignore class, BuildPage
  /// BuildPage is just a 'generic' widget I made for each page to highlight
  /// the parameters it takes in for demonstration purposes.
  @override
  Widget buildAndroid(context) => TwoTabScaffold(
        appBar: AppBar(
          title: Text('Three-page example'.tr),
          actions: [AppMenu()],
        ),
        navigationBar: CupertinoNavigationBar(
          middle: Text('Three-page example'.tr),
          trailing: AppMenu(),
        ),
        tab01: (_) => BuildPage(
          label: '1',
          count: count,
          counter: () {
            //
            if (App.inWidgetsFlutterBinding && AppController().buttonError) {
              // Deliberately throw an error to demonstrate error handling.
              throw Exception('Fake error to demonstrate error handling!'.tr);
            }
            //
            count++;
            // Commented out since the controller has access to this State object.
//          setState(() {});
            // Look how this Controller has access to this State object!
            // The incremented counter will not update otherwise! Powerful!
            // Comment out and the counter will appear not to work.
            controller?.setState(() {});
          },
          row: (_) => [
            const SizedBox(),
            Flexible(
              child: ElevatedButton(
                key: const Key('Page 2'),
                onPressed: () async {
                  if (AppController().useRoutes) {
                    // await App.context?.pushNamed('/Page2');
                    await context.pushNamed('/Page2');
                  } else {
                    // await App.context?.push('/Page2');
                    await context.push('/Page2');
                  }
                },
                child: L10n.t('Page 2'),
              ),
            ),
          ],
          column: (_) => [
            if (usingCupertino)
              Padding(
                padding: EdgeInsets.only(top: 1.h),
                child: CupertinoButton.filled(
                  onPressed: () {
                    count++;
                    controller?.setState(() {});
                  },
                  child: Text('Add'.tr),
                ),
              ),
          ],
        ),
        tab02: (_) => SettingsScreen(
          title: 'Settings'.tr,
          child: const SettingsPage(),
        ),
      );

  /// Place breakpoints and step through the functions below
  /// to see how this all works.

  @override
  // ignore: unnecessary_overrides
  Widget build(BuildContext context) => super.build(context);

  @override
  // ignore: unnecessary_overrides
  Widget buildF(BuildContext context) => super.buildF(context);
}
