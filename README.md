# Fluttery Framework
[![codecov](https://codecov.io/gh/AndriousSolutions/fluttery_framework/branch/master/graph/badge.svg)](https://codecov.io/gh/AndriousSolutions/fluttery_framework)
[![CI](https://github.com/AndriousSolutions/fluttery_framework/actions/workflows/format_test_and_relase.yml/badge.svg)](https://github.com/AndriousSolutions/fluttery_framework/actions/workflows/format_test_and_relase.yml)
[![Pub.dev](https://img.shields.io/pub/v/fluttery_framework.svg)](https://pub.dev/packages/fluttery_framework)
[![GitHub stars](https://img.shields.io/github/stars/AndriousSolutions/fluttery_framework.svg?style=social&amp;logo=github)](https://github.com/AndriousSolutions/fluttery_framework/stargazers)
[![Last Commit](https://img.shields.io/github/last-commit/AndriousSolutions/fluttery_framework)](https://github.com/AndriousSolutions/fluttery_framework/commits/master)
[![Chat](https://img.shields.io/discord/419322779851030538.svg?logo=discord)](https://discord.gg/TyPmeMc)
### Flutter Framework's Better Framework
![Fluttery_Framework](https://user-images.githubusercontent.com/32497443/185770676-89af0669-9040-4dc6-ad5b-412ed9fed5e5.jpg)
Allows for faster and easier development with better maintainability. It looks like Flutter. It works like Flutter.
There's no 're-inventing of the wheel.' It takes full advantage of built-in capabilities and features offered by Flutter
to make your app that much better.

It does this by already supplying adaptive functions and features expected of any production-ready app:
* Necessarily error handling capabilities
* Allow for both a Material & Cupertino interface
* Easily accessible system preferences
* Built-in app notifications
* A better menu bar
* Built-in device event handling
* A date picker
* A color theme picker
* An array dialog windows
* A customizable bottom bar
* A loading screen option

### Installing
I don't like the version number suggested in the '[Installing](https://pub.dev/packages/fluttery_framework#-installing-tab-)' page.
Instead, always go up to the '**minor**' semantic version number when installing this library package. This means always trailing with one zero, '**.0**'. This allows you to take in any '**patch**' versions that involves bugfixes. Example, when installing version 7.9.2, use 7.9.0. Thus, the bug fix, 7.9.3, will be installed the next time you 'upgrade' the dependencies.

## Fluttery Framework Documentation

<img align="right" src="https://github.com/AndriousSolutions/fluttery_framework/assets/32497443/46cf193f-a3cc-452b-94b2-01207ba18ea2" alt="Fluttery Framework" style="width:162px;height:208px;">

[Getting Started](https://pub.dev/documentation/fluttery_framwork/getting_started.md)

[State Object Controller](https://pub.dev/documentation/fluttery_framwork/getting_started.md)

[App's Preferences](https://pub.dev/documentation/fluttery_framwork/preferences.md)

[Error Handling](https://pub.dev/documentation/fluttery_framwork/error-handling.md)

Turn to this free Medium article for a full overview of the package:

[Fluttery Framework](https://andrious.medium.com/the-fluttery-framework-35480fb834da)

___
## Example Code:
###### (Copy & paste and try it out.)
##### The Counter App
```Dart
import 'package:fluttery_framework/view.dart';

import 'package:fluttery_framework/controller.dart';

void main() => runApp(MyApp());

class MyApp extends AppStatefulWidget {
  MyApp({Key? key}) : super(key: key);

  @override
  AppState createAppState() => View();
}

class View extends AppState {
  View()
      : super(
    title: 'Flutter Demo',
    home: const MyHomePage(),
    debugShowCheckedModeBanner: false,
    theme: ThemeData(
      primarySwatch: Colors.blue,
    ),
  );
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, this.title = 'Flutter Demo Home Page'})
      : super(key: key);
  // Fields in a StatefulWidget should always be "final".
  final String title;
  @override
  State createState() => _MyHomePageState();
}

class _MyHomePageState extends StateX<MyHomePage> {
  _MyHomePageState() : super(controller: Controller()) {
    con = controller as Controller;
  }
  late Controller con;

  @override
  Widget buildAndroid(BuildContext context) => Scaffold(
    appBar: AppBar(
      title: Text(widget.title),
    ),
    body: Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          const Text('You have pushed the button this many times:'),
          Text(
            '${con.counter}',
            style: Theme.of(context).textTheme.headlineMedium,
          ),
        ],
      ),
    ),
    floatingActionButton: FloatingActionButton(
      /// Try this alternative approach.
      /// The Controller merely mimics the Flutter's API
      //         onPressed: con.onPressed,
      onPressed: () => setState(con.incrementCounter),
      tooltip: 'Increment',
      child: const Icon(Icons.add),
    ),
  );
}

class Controller extends StateXController {
  factory Controller() => _this ??= Controller._();
  Controller._()
      : _model = _Model(),
        super();

  static Controller? _this;
  final _Model _model;

  /// You're free to mimic Flutter's own API
  /// The Controller is able to talk to the View (the State object)
  void onPressed() => setState(() => _model._incrementCounter());

  int get counter => _model.integer;

  /// The Controller knows how to 'talk to' the Model.
  void incrementCounter() => _model._incrementCounter();
}

class _Model {
  int get integer => _integer;
  int _integer = 0;
  int _incrementCounter() => ++_integer;
}
```
##### Note, this package uses at its core the StateX package:

[![statex](https://user-images.githubusercontent.com/32497443/178387749-1e28f27f-f64c-41df-b5c0-a7591f194e22.jpg)](https://pub.dev/packages/state_extended)
[![Pub.dev](https://img.shields.io/pub/v/state_extended.svg?logo=data:image/png)](https://pub.dev/packages/state_extended) [![GitHub stars](https://img.shields.io/github/stars/AndriousSolutions/state_extended.svg?style=social&amp;logo=github)](https://github.com/AndriousSolutions/state_extended/stargazers)  [![Last Commit](https://img.shields.io/github/last-commit/AndriousSolutions/state_extended)](https://github.com/AndriousSolutions/state_extended/commits/master)
