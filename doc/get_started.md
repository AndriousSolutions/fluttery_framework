There is a number of example apps that use the Fluttery Framework:

- [Shrine Example App](https://github.com/Andrious/shrine_example_app)
- [Bazaar Example App](https://github.com/Andrious/bazaar)
- [Stocks Example App](https://github.com/Andrious/fluttery_stocks)
- [Wonderous Example App](https://github.com/Andrious/wonderous)
###### (Download and try them out.)

<img style="float:right" src="https://github.com/AndriousSolutions/fluttery_framework/assets/32497443/f3ee5ec8-6ffe-4587-a06e-a1676413a4bc" alt="pubdev" width="445" height="228">

## _Fluttery Framework's Example App_
An extensive example app accompanies the Fluttery Framework package itself. You'll find it under the 'pub.dev' 
folder when you take in the Fluttery Framework through your `pubspec.yaml` file. 
The code will demonstrate the functions and features that quickly makes you a multi-platform app.

<a target="_blank" rel="noopener noreferrer" href="https://github.com/AndriousSolutions/fluttery_framework/assets/32497443/573eb817-88eb-438c-9360-f7c4449c9449"><img src="https://github.com/AndriousSolutions/fluttery_framework/assets/32497443/573eb817-88eb-438c-9360-f7c4449c9449" width="171" height="357"></a>
<a target="_blank" rel="noopener noreferrer" href="https://github.com/AndriousSolutions/fluttery_framework/assets/32497443/124d415d-2fd5-4629-a19f-c01bbbae8000"><img src="https://github.com/AndriousSolutions/fluttery_framework/assets/32497443/124d415d-2fd5-4629-a19f-c01bbbae8000" width="171" height="357"></a>
<a target="_blank" rel="noopener noreferrer" href="https://github.com/AndriousSolutions/fluttery_framework/assets/32497443/cea16091-79c8-45fd-8fa9-eb571cc521f9"><img src="https://github.com/AndriousSolutions/fluttery_framework/assets/32497443/cea16091-79c8-45fd-8fa9-eb571cc521f9" width="171" height="357"></a>

## _The Basic Steps Necessary_

1. Extend the State class with **StateX** instead of **State**.
2. Extend your State Object's Controller with the class, **StateXConroller**.
3. Pass your Controller to the State object's named parameter, **controller**.
4. Cast your Controller with the State object's property, **controller**.
5. Supply the 'Material' interface to the **buildAndroid**() function.
6. Supply the 'Cupertino' interface to the **buildiOS**() function.
7. If you don't have a preference, supply the interface to the **build**() function.
###### (See the little red arrows in the picture below)
___
[![counter_app](https://github.com/AndriousSolutions/fluttery_framework/assets/32497443/67c2ff90-9589-4b70-95e0-ad932aba82da)](https://github.com/AndriousSolutions/fluttery_framework/blob/0168b3c8a626dfebeb99b28fc3e60cefbba71966/example/lib/src/home/view/counter_app.dart)
___
![scalability](https://github.com/AndriousSolutions/fluttery_framework/assets/32497443/b5af9fb1-9aef-4f05-baa4-98ff3014caef)

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
  AppStateX createAppState() => _CounterAppState();
}

class _CounterAppState extends AppStateX {
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
  const MyHomePage({super.key, this.title = 'Flutter Demo Home Page'});
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
## _Define the 'Look and Feel' of your App_
Right at the beginning using the App's own State class, _AppState_, you're able to 
define in detail how your app is to 'look and behave'. This State class is the 
amalgamation of both the MaterialApp widget and the CupertinoApp widget and an 
assortment of other Flutter properties. See the class, __ThisAppState_, below.

(See Topic: <a href="https://pub.dev/documentation/fluttery_framework/latest/topics/AppState%20class-topic.html">AppState class</a>)
```Dart
import 'package:fluttery_framework/view.dart';

/// This is the widget passed to the runApp() function.
class MyApp extends AppStatefulWidget {
  ///
  MyApp({Key? key}) : super(key: key);
  @override
  AppState createAppState() => _ThisAppState();
}


/// Defines the 'look and behavior' of the app.
class _ThisAppState extends AppStateX {
  _ThisAppState()
      : super(
    controller: MainAppController(),
    controllers: [CounterController()],
    inTitle: () => 'Demo App'.tr,
    debugShowCheckedModeBanner: false,
    switchUI: Prefs.getBool('switchUI'),
    useRouterConfig: false,
    inSupportedLocales: () {
      /// The app's translations
      L10n.translations = {
        const Locale('zh', 'CN'): zhCN,
        const Locale('fr', 'FR'): frFR,
        const Locale('de', 'DE'): deDE,
        const Locale('he', 'IL'): heIL,
        const Locale('ru', 'RU'): ruRU,
        const Locale('es', 'AR'): esAR,
      };
      return L10n.supportedLocales;
    },
    localizationsDelegates: [
      L10n.delegate,
      GlobalWidgetsLocalizations.delegate,
      GlobalCupertinoLocalizations.delegate,
      GlobalMaterialLocalizations.delegate,
    ],
  );

}
```
There is a long [list of parameters](https://github.com/AndriousSolutions/fluttery_framework/blob/5bf647ed5639739995f8d5b1cd150b03f8f87d23/lib/view/app_state.dart#L33) available to you using the AppState class.
<br />
(If you know the widgets, MaterialApp or CupertinoApp, you'll know these parameters.)

## _A Responsive Interface_
This package utilises the [Sizer](https://pub.dev/packages/sizer) package right at the start.
The screenshot below is of the Fluttery Framework's <b>build</b>() function wrapping your app in the Sizer widget.
It's a very popular means to implement a responsive interface for Flutter apps. 
You're able to specify a percentage and not a set number when defining the size and position of widgets on the screen.
<br />
For example, `Container(width: 20.w, height: 30.h)` means 20% of the screen's width and 30% of the screen's height.
<br />
Doing so allows your app's interface to readily adapt to different screen sizes.

<a id="Sizer" target="_blank" rel="noopener noreferrer" href="https://github.com/AndriousSolutions/fluttery_framework/assets/32497443/6f302e30-9512-4ba3-9cbb-83092478c016"><img src="https://github.com/AndriousSolutions/fluttery_framework/assets/32497443/6f302e30-9512-4ba3-9cbb-83092478c016" width="48%" height="60%"></a>

| [app_state.dart](https://github.com/AndriousSolutions/fluttery_framework/blob/master/lib/view/app_state.dart#L289) |
|:---------------------------------------------------------------------------------------------------------------------|
<br />
<br />
<br />
Note, this package uses at its core the StateX package:

[![statex](https://user-images.githubusercontent.com/32497443/178387749-1e28f27f-f64c-41df-b5c0-a7591f194e22.jpg)](https://pub.dev/packages/state_extended)
[![Pub.dev](https://img.shields.io/pub/v/state_extended.svg?logo=data:image/png)](https://pub.dev/packages/state_extended) [![GitHub stars](https://img.shields.io/github/stars/AndriousSolutions/state_extended.svg?style=social&amp;logo=github)](https://github.com/AndriousSolutions/state_extended/stargazers)  [![Last Commit](https://img.shields.io/github/last-commit/AndriousSolutions/state_extended)](https://github.com/AndriousSolutions/state_extended/commits/master)