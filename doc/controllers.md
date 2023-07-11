### Control The Pattern
It’s the Controller that contains the business logic and performs 
the event handling while the State object is just concerned with the interface. 
There are variations in how and when the Controller is assigned to a variable, 
but that’s the general pattern.

### Avoid Controller Bloat
You're able to add as many Controllers as you want to your StateX object.
And so, if there is a number of Controllers assigned to a StateX, and when ‘an event’ occurs in that View, 
the Controllers will fire, in turn, in the order they were assigned.
<div>
  <img src="https://github.com/Andrious/bazaar/assets/32497443/f84c06e9-7622-495a-9a8d-91da133311d0">
  <img align="right" src="https://github.com/AndriousSolutions/fluttery_framework/assets/32497443/f2f41422-5986-4cf9-8d56-88b12b1d71ab" width="48%" height="60%">
</div>

Thus, when your controller is ‘registered’ with a State object and its State object’s initState() function 
is called, its own initState() function will also be called. Anything your controller may need to be 
initialized, for example, before that widget is displayed can now be done so in its own initState() function.

Thus, when your controller is ‘registered’ with a State object and its State object’s initState() function
is called, its own initState() function will also be called. Anything your controller may need to be
initialized, for example, before that widget is displayed can now be done so in its own initState() function.
<div>
<img src="https://github.com/AndriousSolutions/fluttery_framework/assets/32497443/13e580ad-73bc-40e5-a95f-a1d5a7731574" width="48%" height="60%">
<img align="right" src="https://github.com/AndriousSolutions/fluttery_framework/assets/32497443/988694d4-326f-474d-9e8e-77ac143e3e55" width="48%" height="60%">
</div>
<div>
  <img src="https://github.com/Andrious/bazaar/assets/32497443/9c6ab55d-faf6-4b40-8f3c-6295ebe592b9">
</div>

## _The Controller and State Events_
With the controller, you not only supply the app's business rules, but can also respond
to the device and system events that commonly occur during an app's lifecycle. The sample code below lists all the
available 'event' functions. In most cases, you'll only use the 'lifecycle' functions. However, they're
all there just the same as you may need them someday in a future app:
###### (Below is the [Controller](https://github.com/AndriousSolutions/fluttery_framework/blob/0168b3c8a626dfebeb99b28fc3e60cefbba71966/example/lib/src/home/view/counter/controller/controller.dart#L12) from the 'Three Page' Counter Example App.)
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
