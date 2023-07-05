There is a number of example apps that use the Fluttery Framework:

- [Shrine Example App](https://github.com/Andrious/shrine_example_app)
- [Bazaar Example App](https://github.com/Andrious/bazaar)
- [Stocks Example App](https://github.com/Andrious/fluttery_stocks)
###### (Download and try them out.)

<img align="right" src="https://github.com/AndriousSolutions/fluttery_framework/assets/32497443/f3ee5ec8-6ffe-4587-a06e-a1676413a4bc" alt="pubdev" width="445" height="228">

## _Fluttery Framework's Example App_
An extensive example app accompanies the Fluttery Framework package itself. You'll find it under the 'pub.dev' 
folder when you take in the Fluttery Framework through your `pubspec.yaml` file. 
This example code demonstrates the functions and features that quickly make a multi-platform app.

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
[![CounterController](https://github.com/AndriousSolutions/fluttery_framework/assets/32497443/fd9872ec-ba79-4660-a99d-d5d04adb9f30)](https://github.com/AndriousSolutions/fluttery_framework/blob/0168b3c8a626dfebeb99b28fc3e60cefbba71966/example/lib/src/home/view/counter_app.dart)
___
![scalability](https://github.com/AndriousSolutions/fluttery_framework/assets/32497443/b5af9fb1-9aef-4f05-baa4-98ff3014caef)

## _The Controller and State Events_
With the controller, you not only supply the app's business rules, but can also respond
to the device and system events that commonly occur during an app's lifecycle. The sample code below lists all the 
available 'event' functions. In most cases, you'll only use the 'lifecycle' functions. However, they're
all there just the same as you may need them someday in a future app:
```Dart
class CounterController extends StateXController {
  factory CounterController() => _this ??= CounterController._();
  CounterController._() : super();
  static CounterController? _this;

  /// The framework will call this method exactly once.
  /// Only when the [StateX] object is first created.
  @override
  void initState() {
    super.initState();
  }

  /// Called to complete any asynchronous operations.
  @override
  Future<bool> initAsync() async {
    return true;
  }

  /// The framework calls this method when the [StateX] object removed from widget tree.
  /// i.e. The screen is closed.
  @override
  void deactivate() {}

  /// Called when this State object was removed from widget tree for some reason
  /// Undo what was done when [deactivate] was called.
  @override
  void activate() {}

  /// The framework calls this method when this [StateX] object will never
  /// build again.
  /// Note: YOU DON'T KNOW WHEN THIS WILL RUN in the Framework.
  /// PERFORM ANY TIME-CRITICAL OPERATION IN deactivate() INSTEAD!
  @override
  void dispose() {
    super.dispose();
  }

  /// The application is not currently visible to the user, not responding to
  /// user input, and running in the background.
  @override
  void pausedLifecycleState() {}

  /// Called when app returns from the background
  @override
  void resumedLifecycleState() {}

  /// The application is in an inactive state and is not receiving user input.
  @override
  void inactiveLifecycleState() {}

  /// Either be in the progress of attaching when the engine is first initializing
  /// or after the view being destroyed due to a Navigator pop.
  @override
  void detachedLifecycleState() {}

  /// Override this method to respond when the [StatefulWidget] is recreated.
  @override
  void didUpdateWidget(StatefulWidget oldWidget) {}

  /// Called when this [StateX] object is first created immediately after [initState].
  /// Otherwise called only if this [State] object's Widget
  /// is a dependency of [InheritedWidget].
  @override
  void didChangeDependencies() {}

  /// Called whenever the application is reassembled during debugging, for
  /// example during hot reload.
  @override
  void reassemble() {}

  /// Called when the system tells the app to pop the current route.
  /// For example, on Android, this is called when the user presses
  /// the back button.
  @override
  Future<bool> didPopRoute() async {
    return super.didPopRoute();
  }

  /// Called when the host tells the app to push a new route onto the
  /// navigator.
  @override
  Future<bool> didPushRoute(String route) async {
    return super.didPushRoute(route);
  }

  /// Called when the host tells the application to push a new
  /// [RouteInformation] and a restoration state onto the router.
  @override
  Future<bool> didPushRouteInformation(RouteInformation routeInformation) {
    return super.didPushRouteInformation(routeInformation);
  }

  /// The top route has been popped off, and this route shows up.
  @override
  void didPopNext() {}

  /// Called when this route has been pushed.
  @override
  void didPush() {}

  /// Called when this route has been popped off.
  @override
  void didPop() {}

  /// New route has been pushed, and this route is no longer visible.
  @override
  void didPushNext() {}

  /// Called when the application's dimensions change. For example,
  /// when a phone is rotated.
  @override
  void didChangeMetrics() {}

  /// Called when the platform's text scale factor changes.
  @override
  void didChangeTextScaleFactor() {}

  /// Brightness changed.
  @override
  void didChangePlatformBrightness() {}

  /// Called when the system tells the app that the user's locale has changed.
  @override
  void didChangeLocales(List<Locale>? locales) {}

  /// Called when the system is running low on memory.
  @override
  void didHaveMemoryPressure() {}

  /// Called when the system changes the set of active accessibility features.
  @override
  void didChangeAccessibilityFeatures() {}
}
```
## _List of Device and System Events_
##### (Tap on each below to see the source code and a further explanation of their function.)

[![deactivate](https://github.com/AndriousSolutions/state_extended/assets/32497443/5efcf55d-4b34-4875-a4f3-5532ab438f58)](https://github.com/AndriousSolutions/state_extended/blob/074e17ee298eec2a22c3b904caf20e75d5ce41c3/lib/state_extended.dart#L1530)
[![activate](https://github.com/AndriousSolutions/state_extended/assets/32497443/1c69c8a9-7f16-40e2-b3de-d58ff521df2e)](https://github.com/AndriousSolutions/state_extended/blob/074e17ee298eec2a22c3b904caf20e75d5ce41c3/lib/state_extended.dart#L1540)
[![didUpdateWidget](https://github.com/AndriousSolutions/state_extended/assets/32497443/6f6a83a8-0fb7-43d4-985b-9dc6bc3b1b5a)](https://github.com/AndriousSolutions/state_extended/blob/074e17ee298eec2a22c3b904caf20e75d5ce41c3/lib/state_extended.dart#L1576)
[![didChangeDependencies](https://github.com/AndriousSolutions/state_extended/assets/32497443/60d4464a-32bc-475f-99be-d7bdeb964627)](https://github.com/AndriousSolutions/state_extended/blob/074e17ee298eec2a22c3b904caf20e75d5ce41c3/lib/state_extended.dart#L1582)
[![reassemble](https://github.com/AndriousSolutions/state_extended/assets/32497443/c614950f-a024-41e7-b0dc-3f22916437fd)](https://github.com/AndriousSolutions/state_extended/blob/074e17ee298eec2a22c3b904caf20e75d5ce41c3/lib/state_extended.dart#L1594)
[![didPopRoute](https://github.com/AndriousSolutions/state_extended/assets/32497443/142612aa-6246-4b23-9785-10c9aba33c1d)](https://github.com/AndriousSolutions/state_extended/blob/074e17ee298eec2a22c3b904caf20e75d5ce41c3/lib/state_extended.dart#L1605)
[![didPushRoute](https://github.com/AndriousSolutions/state_extended/assets/32497443/73b34f4f-2c26-4a3f-930a-9b950eec8535)](https://github.com/AndriousSolutions/state_extended/blob/074e17ee298eec2a22c3b904caf20e75d5ce41c3/lib/state_extended.dart#L1623)
[![didPushRouteInformation](https://github.com/AndriousSolutions/state_extended/assets/32497443/beb8bb62-b392-490e-b38d-d905ae662584)](https://github.com/AndriousSolutions/state_extended/blob/074e17ee298eec2a22c3b904caf20e75d5ce41c3/lib/state_extended.dart#L1635)
[![didChangeMetrics](https://github.com/AndriousSolutions/state_extended/assets/32497443/044f08a0-b346-4f26-bdc0-91cff110c229)](https://github.com/AndriousSolutions/state_extended/blob/074e17ee298eec2a22c3b904caf20e75d5ce41c3/lib/state_extended.dart#L1667)
[![didChangeTextScaleFactor](https://github.com/AndriousSolutions/state_extended/assets/32497443/ba9498ce-39f4-401d-b9c8-365644f7941b)](https://github.com/AndriousSolutions/state_extended/blob/074e17ee298eec2a22c3b904caf20e75d5ce41c3/lib/state_extended.dart#L1685)
[![didChangePlatformBrightness](https://github.com/AndriousSolutions/state_extended/assets/32497443/30254e51-1ea1-41cd-a97f-643da57d6555)](https://github.com/AndriousSolutions/state_extended/blob/074e17ee298eec2a22c3b904caf20e75d5ce41c3/lib/state_extended.dart#L1701)
[![didChangeLocales](https://github.com/AndriousSolutions/state_extended/assets/32497443/a192c4f6-4eb3-4885-9202-afa0e8c1206d)](https://github.com/AndriousSolutions/state_extended/blob/074e17ee298eec2a22c3b904caf20e75d5ce41c3/lib/state_extended.dart#L1704)
[![didChangeAppLifeCycle](https://github.com/AndriousSolutions/state_extended/assets/32497443/8f126c6c-6b5d-4ac5-934c-a0f822595ff9)](https://github.com/AndriousSolutions/state_extended/blob/074e17ee298eec2a22c3b904caf20e75d5ce41c3/lib/state_extended.dart#L1713)
[![inactiveLifecycle](https://github.com/AndriousSolutions/fluttery_framework/assets/32497443/9ee7509a-c6ce-4df6-99c9-929d11af3eb3)](https://github.com/AndriousSolutions/state_extended/blob/074e17ee298eec2a22c3b904caf20e75d5ce41c3/lib/state_extended.dart#L1722)
[![pausedLifecycle](https://github.com/AndriousSolutions/fluttery_framework/assets/32497443/63ee3495-34ae-4fa0-a40d-6a27e435807c)](https://github.com/AndriousSolutions/state_extended/blob/074e17ee298eec2a22c3b904caf20e75d5ce41c3/lib/state_extended.dart#L1738)
[![detachedLifecycle](https://github.com/AndriousSolutions/fluttery_framework/assets/32497443/b50f5c35-64b9-45ca-8554-83e6ef12deb1)](https://github.com/AndriousSolutions/state_extended/blob/074e17ee298eec2a22c3b904caf20e75d5ce41c3/lib/state_extended.dart#L1742)
[![resumedLifecycle](https://github.com/AndriousSolutions/fluttery_framework/assets/32497443/e6fdcca7-1866-4030-80fa-ae813fd43a4e)](https://github.com/AndriousSolutions/state_extended/blob/074e17ee298eec2a22c3b904caf20e75d5ce41c3/lib/state_extended.dart#L1746)
[![didHaveMemoryPressure](https://github.com/AndriousSolutions/state_extended/assets/32497443/61927f1e-3af7-4ffd-9dc5-01a212f01e2a)](https://github.com/AndriousSolutions/state_extended/blob/074e17ee298eec2a22c3b904caf20e75d5ce41c3/lib/state_extended.dart#L1749)
[![didChangeAccessibilityFeatures](https://github.com/AndriousSolutions/state_extended/assets/32497443/0810f4c6-3ed5-4be7-9e5d-42fddcd980cc)](https://github.com/AndriousSolutions/state_extended/blob/074e17ee298eec2a22c3b904caf20e75d5ce41c3/lib/state_extended.dart#L1764)

## _Define the 'Look and Feel' of your App_
Right at the beginning using the App's own State class, _AppState_, you're able to 
define in detail how your app is to 'look and behave'. This State class is the 
amalgamation of both the MaterialApp widget and the CupertinoApp widget and an 
assortment of other Flutter properties. See the class, _ThisAppState, below.

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
##### List of parameters available to you using the AppState class: [AppState](https://github.com/AndriousSolutions/fluttery_framework/blob/5bf647ed5639739995f8d5b1cd150b03f8f87d23/lib/view/app_state.dart#L33)
##### (If you know the widgets, MaterialApp or CupertinoApp, you'll know these parameters.)