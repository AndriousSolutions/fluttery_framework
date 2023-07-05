# Fluttery Framework
[![codecov](https://codecov.io/gh/AndriousSolutions/fluttery_framework/branch/master/graph/badge.svg)](https://codecov.io/gh/AndriousSolutions/fluttery_framework)
[![CI](https://github.com/AndriousSolutions/fluttery_framework/actions/workflows/format_test_and_relase.yml/badge.svg)](https://github.com/AndriousSolutions/fluttery_framework/actions/workflows/format_test_and_relase.yml)
[![Pub.dev](https://img.shields.io/pub/v/fluttery_framework.svg)](https://pub.dev/packages/fluttery_framework)
[![GitHub stars](https://img.shields.io/github/stars/AndriousSolutions/fluttery_framework.svg?style=social&amp;logo=github)](https://github.com/AndriousSolutions/fluttery_framework/stargazers)
[![Last Commit](https://img.shields.io/github/last-commit/AndriousSolutions/fluttery_framework)](https://github.com/AndriousSolutions/fluttery_framework/commits/master)
[![Chat](https://img.shields.io/discord/419322779851030538.svg?logo=discord)](https://discord.gg/TyPmeMc)
### A Framework for Flutter's Framework
![Fluttery_Framework](https://user-images.githubusercontent.com/32497443/185770676-89af0669-9040-4dc6-ad5b-412ed9fed5e5.jpg)
Allows for faster and easier development with better maintainability. It looks like Flutter and works like Flutter.
There's no 're-inventing of the wheel' or an extra learning curve. If you know Flutter, you'll know Fluttery Framework.  

It supplies the adaptive functions and features expected of a production-ready app:
* Flutter's own intuitive State Management
* Necessary error handling capabilities
* Easy implementation of both the Material & Cupertino interface
* App-wide accessibility to system preferences
* Built-in app notifications
* A better menu bar
* Event handling for the device the app runs on
* A date picker
* A color theme picker
* An array of dialog windows
* A customizable bottom bar
* A loading screen option

### Installing
Instead of using version number suggested in the '[Installing](https://pub.dev/packages/fluttery_framework#-installing-tab-)' page, 
always go up to the '**minor**' semantic version number when installing this library package. 
This means always have a trailing zero, '**.0**'.
This allows you to take in any '**patch**' versions that involves bugfixes. 
For example, when installing version 7.9.2, use 7.9.0. That means, the bug fix, 7.9.3, will be 
installed the next time you 'upgrade' your dependencies.

## Fluttery Framework Documentation

<img align="right" src="https://github.com/AndriousSolutions/fluttery_framework/assets/32497443/46cf193f-a3cc-452b-94b2-01207ba18ea2" alt="Fluttery Framework" style="width:162px;height:208px;">

<ul style="list-style-type: none">
   <li><a href="../topics/Get%20started-topic.html">Get&nbsp;started</a></li>
   <li><a href="../topics/StateX%20class-topic.html">StateX class</a></li>
   <li><a href="../topics/State%20Object%20Controller-topic.html">State&nbsp;Object&nbsp;Controller</a></li>
   <li><a href="../topics/Error%20handling-topic.html">Error&nbsp;handling</a></li>
   <li><a href="../topics/App's%20Preferences-topic.html">App's&nbsp;Preferences</a></li>
   <li><a href="../topics/App%20object-topic.html">App object</a></li>
   <li><a href="../topics/Extensions-topic.html">Extensions</a></li>
   <li><a href="../topics/Device%20Information-topic.html">Device Information</a></li>
</ul>

Free overview article on medium.com:

[Fluttery Framework](https://andrious.medium.com/the-fluttery-framework-35480fb834da)

___
## The Counter Example App
###### (Copy & paste and try it out.)
```Dart
import 'package:fluttery_framework/view.dart';

import 'package:fluttery_framework/controller.dart';

void main() => runApp(MyApp());

class MyApp extends AppStatefulWidget {
  MyApp({Key? key}) : super(key: key);

  @override
  AppState createAppState() => _CounterAppState();
}

class _CounterAppState extends AppState {
  _CounterAppState()
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
