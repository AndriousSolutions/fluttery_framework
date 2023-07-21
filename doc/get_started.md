There is a number of example apps that use the Fluttery Framework:

- [Shrine Example App](https://github.com/Andrious/shrine_example_app)
- [Bazaar Example App](https://github.com/Andrious/bazaar)
- [Stocks Example App](https://github.com/Andrious/fluttery_stocks)
- [Wonderous Example App](https://github.com/Andrious/wonderous)
###### (Download and try them out.)

<img align="right" src="https://github.com/AndriousSolutions/fluttery_framework/assets/32497443/f3ee5ec8-6ffe-4587-a06e-a1676413a4bc" alt="pubdev" width="445" height="228">

## _Fluttery Framework's Example App_
An extensive example app accompanies the Fluttery Framework package itself. You'll find it under the 'pub.dev' 
folder when you take in the Fluttery Framework through your `pubspec.yaml` file. 
The code will demonstrate the functions and features that quickly make a multi-platform app.

<img src="https://github.com/AndriousSolutions/fluttery_framework/assets/32497443/573eb817-88eb-438c-9360-f7c4449c9449" width="171" height="357">
<img src="https://github.com/AndriousSolutions/fluttery_framework/assets/32497443/124d415d-2fd5-4629-a19f-c01bbbae8000" width="171" height="357">
<img src="https://github.com/AndriousSolutions/fluttery_framework/assets/32497443/cea16091-79c8-45fd-8fa9-eb571cc521f9" width="171" height="357">

## _The Basic Steps Necessary_

1. Extend the State class with **StateX** instead of **State**.
2. Extend your State Object's Controller with the class, **StateXConroller**.
3. Pass your Controller to the State object's named parameter, **controller**.
4. Cast your Controller with the State object's property, **controller**.
5. Supply the 'Material' interface to the **buildAndroid**() function.
6. Supply the 'Cupertino' interface to the **buildiOS**() function.
###### (See the little red arrows in the picture below)
___
[![counter_app](https://github.com/AndriousSolutions/fluttery_framework/assets/32497443/67c2ff90-9589-4b70-95e0-ad932aba82da)](https://github.com/AndriousSolutions/fluttery_framework/blob/0168b3c8a626dfebeb99b28fc3e60cefbba71966/example/lib/src/home/view/counter_app.dart)
___
![scalability](https://github.com/AndriousSolutions/fluttery_framework/assets/32497443/b5af9fb1-9aef-4f05-baa4-98ff3014caef)


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
class _ThisAppState extends AppState {
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
##### There is a long [list of parameters](https://github.com/AndriousSolutions/fluttery_framework/blob/5bf647ed5639739995f8d5b1cd150b03f8f87d23/lib/view/app_state.dart#L33) available to you using the AppState class.
##### (If you know the widgets, MaterialApp or CupertinoApp, you'll know these parameters.)