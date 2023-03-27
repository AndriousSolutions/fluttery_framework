# Fluttery Framework
[![codecov](https://codecov.io/gh/AndriousSolutions/fluttery_framework/branch/master/graph/badge.svg)](https://codecov.io/gh/AndriousSolutions/fluttery_framework)
[![CI](https://github.com/AndriousSolutions/fluttery_framework/actions/workflows/format_test_and_relase.yml/badge.svg)](https://github.com/AndriousSolutions/fluttery_framework/actions/workflows/format_test_and_relase.yml)
[![Pub.dev](https://img.shields.io/pub/v/fluttery_framework.svg)](https://pub.dev/packages/fluttery_framework)
[![GitHub stars](https://img.shields.io/github/stars/AndriousSolutions/fluttery_framework.svg?style=social&amp;logo=github)](https://github.com/AndriousSolutions/fluttery_framework/stargazers)
[![Last Commit](https://img.shields.io/github/last-commit/AndriousSolutions/fluttery_framework)](https://github.com/AndriousSolutions/fluttery_framework/commits/master)
[![Chat](https://img.shields.io/discord/722900883784073290.svg?logo=discord)](https://discord.gg/TyPmeMc)
### A Flutter Framework's Framework
![Fluttery_Framework](https://user-images.githubusercontent.com/32497443/185770676-89af0669-9040-4dc6-ad5b-412ed9fed5e5.jpg)
Allows for easier and, dare I say, faster development and better maintainability. No 're-inventing of the wheel' using already built-in capabilities and features offered by Flutter itself.
Accommodating and Integrated features:
* Error Handling
* System Preferences
* App Notifications
* A Better Menu Bar
* Device Event Handling
* Date picker
* App Color picker
* Dialog Boxes
* Customizable Bottom Bar
* Loading Screen
* Time Zones

### Installing
I don't like the version number suggested in the '[Installing](https://pub.dev/packages/fluttery_framework#-installing-tab-)' page.
Instead, always go up to the '**major**' semantic version number when installing this library package. This means always trailing with two zero, '**.0.0**'. This allows you to take in any '**minor**' versions introducing new features as well as any '**patch**' versions that involves bugfixes. Example, to install version 7.9.2, use 7.0.0. Thus, the bug fix, 7.9.2, will be installed the next time you 'upgrade' the dependencies.
1. **patch** - bugfixes
2. **minor** - Introduced new features
3. **major** - Essentially made a new app. It's broken backwards-compatibility and has a completely new user experience. You won't get this version until you increment the **major** number in the pubspec.yaml file.

And so, in this case, add this to your package's pubspec.yaml file:
```dart
dependencies:
   fluttery_framework: ^1.0.0
```
For more information on version numbers: [The importance of semantic versioning](https://medium.com/@xabaras/the-importance-of-semantic-versioning-9b78e8e59bba).

##### Note, in fact, this package serves as a 'wrapper' for the core package:
## StateX [![Pub.dev](https://img.shields.io/pub/v/state_extended.svg?logo=data:image/png;base64,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)](https://pub.dev/packages/state_extended) [![GitHub stars](https://img.shields.io/github/stars/AndriousSolutions/state_extended.svg?style=social&amp;logo=github)](https://github.com/AndriousSolutions/state_extended/stargazers)  [![Last Commit](https://img.shields.io/github/last-commit/AndriousSolutions/state_extended)](https://github.com/AndriousSolutions/state_extended/commits/master)


## Example Code:

##### The Counter App
```dart
import 'package:fluttery_framework/exports_imports.dart';

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
      primarySwatch: Colors.green,
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
  _MyHomePageState() : super(Controller()) {
    con = controller as Controller;
  }
  late Controller con;

  @override
  Widget build(BuildContext context) => Scaffold(
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
            style: Theme.of(context).textTheme.headline4,
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
      : model = _Model(),
        super();

  static Controller? _this;
  final _Model model;

  /// You're free to mimic Flutter's own API
  /// The Controller is able to talk to the View (the State object)
  void onPressed() => setState(() => model._incrementCounter());

  int get counter => model.integer;

  /// The Controller knows how to 'talk to' the Model.
  void incrementCounter() => model._incrementCounter();
}

class _Model {
  int get integer => _integer;
  int _integer = 0;
  int _incrementCounter() => ++_integer;
}
```
#### Name Generator App
```dart
import 'package:english_words/english_words.dart' show generateWordPairs;

import 'package:flutter/material.dart' hide runApp;

import 'package:fluttery_framework/exports_imports.dart'
    show AppStatefulWidget, AppState, Colors, runApp, StateX;

import 'package:fluttery_framework/controller.dart' show StateXController;

void main() => runApp(NameApp());

class NameApp extends AppStatefulWidget {
  NameApp({Key? key}) : super(key: key);

  @override
  AppState createAppState() => MyApp();
}

class MyApp extends AppState {
  factory MyApp() => _this ??= MyApp._();
  MyApp._()
      : super(
    title: 'Startup Name Generator',
    home: const RandomWords(),
    theme: ThemeData(
      primaryColor: Colors.white,
    ),
    debugShowCheckedModeBanner: false,
  );
  static MyApp? _this;
}

class RandomWords extends StatefulWidget {
  const RandomWords({Key? key}) : super(key: key);

  @override
  State createState() => _RandomWordsState();
}

class _RandomWordsState extends StateX<RandomWords> {
  _RandomWordsState() : super(_Controller()) {
    con = controller as _Controller;
  }
  late _Controller con;

  final TextStyle _biggerFont = const TextStyle(fontSize: 18.0);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Startup Name Generator'),
        actions: <Widget>[
          IconButton(
              icon: const Icon(Icons.list),
              onPressed: () {
                pushSaved(context);
              }),
        ],
      ),
      body: _buildSuggestions(),
    );
  }

  Widget _buildSuggestions() {
    return ListView.builder(
      padding: const EdgeInsets.all(16.0),
      itemBuilder: (context, i) {
        // Add a one-pixel-high divider widget before each row in theListView.
        if (i.isOdd) return const Divider();
        final index = i ~/ 2;
        // If you've reached the end of the available word pairings...
        if (index >= con.length) {
          // ...then generate 10 more and add them to the suggestions list.
          con.addAll(10);
        }
        return buildRow(index);
      },
    );
  }

  void pushSaved(BuildContext context) {
    Navigator.of(context).push(
      MaterialPageRoute<void>(
        builder: (BuildContext context) {
          final Iterable<ListTile> tiles = this.tiles;

          List<Widget> divided;

          if (tiles.isEmpty) {
            divided = [];
          } else {
            divided = ListTile.divideTiles(
              context: context,
              tiles: tiles,
            ).toList();
          }

          return Scaffold(
            appBar: AppBar(
              title: const Text('Saved Suggestions'),
            ),
            body: ListView(children: divided),
          );
        },
      ),
    );
  }

  Widget buildRow(int? index) {
    if (index == null || index < 0) index = 0;

    String something = con.something(index);

    final alreadySaved = con.contains(something);

    return ListTile(
      title: Text(
        something,
        style: _biggerFont,
      ),
      trailing: Icon(
        alreadySaved ? Icons.favorite : Icons.favorite_border,
        color: alreadySaved ? Colors.red : null,
      ),
      onTap: () {
        setState(() {
          con.somethingHappens(something);
        });
      },
    );
  }

  Iterable<ListTile> get tiles => con.mapHappens(
        (String something) {
      return ListTile(
        title: Text(
          something,
          style: _biggerFont,
        ),
      );
    },
  );
}

class _Controller extends StateXController {
  // Supply only one instance of this Controller class.
  factory _Controller() => _this ??= _Controller._();

  static _Controller? _this;

  _Controller._() {
    model = _Model();
  }

  late _Model model;

  int get length => model.length;

  void addAll(int count) => model.addAll(count);

  String something(int index) => model.wordPair(index);

  bool contains(String something) => model.contains(something);

  void somethingHappens(String something) => model.save(something);

  Iterable<ListTile> mapHappens<ListTile>(ListTile Function(String v) f) =>
      model.saved(f);
}

class _Model {
  final List<String> _suggestions = [];

  int get length => _suggestions.length;

  String wordPair(int? index) {
    if (index == null || index < 0) index = 0;
    return _suggestions[index];
  }

  bool contains(String? pair) {
    if (pair == null || pair.isEmpty) return false;
    return _saved.contains(pair);
  }

  final Set<String> _saved = {};

  void save(String? pair) {
    if (pair == null || pair.isEmpty) return;
    final alreadySaved = contains(pair);
    if (alreadySaved) {
      _saved.remove(pair);
    } else {
      _saved.add(pair);
    }
  }

  Iterable<ListTile> saved<ListTile>(ListTile Function(String v) f) =>
      _saved.map(f);

  Iterable<String> wordPairs([int count = 10]) => _makeWordPairs(count);

  void addAll(int count) => _suggestions.addAll(wordPairs(count));
}

Iterable<String> _makeWordPairs(int count) =>
    generateWordPairs().take(count).map((pair) => pair.asPascalCase);
```

##### Other Dart Packages
[![packages](https://user-images.githubusercontent.com/32497443/64993716-5c818280-d89c-11e9-87b5-f35aee3e22f4.jpg)](https://pub.dev/publishers/andrioussolutions.com/packages)
Other Dart packages from the author can also be found at [Pub.dev](https://pub.dev/publishers/andrioussolutions.com/packages)
