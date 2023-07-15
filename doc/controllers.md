In the Fluttery Framework, the typical controller object extends the **SateXController** class
and contains the business rules for the app. A controller is also used by a particular 
State object to deal with any event handling while the State object itself deals with just the interface.
The State object would typically extend the [StateX](https://pub.dev/documentation/fluttery_framework/latest/topics/StateX%20class-topic.html) class, 
so to utilize the Controller object in its **build**() function or in any other of its functions.
Again, so to deal with the app's business rules and or address any events like the pushing of a button.

<table>
  	<caption>Contents</caption>
    <tbody>
    <tr>
       <td><a href="#external">External State Control</a></td>
       <td><a href="#bloat">No Controller Bloat</a></td>
       <td><a href="#control">Control The State</a></td>
       <td><a href="#single">The Singleton Pattern</a></td>
       <td><a href="#list">The List of Device and System Events</a></td>
      </tr>
    </tbody>
</table>

<h3 id="external">External State Control</h3>
<div>
  <a target="_blank" href="https://github.com/AndriousSolutions/fluttery_framework/assets/32497443/cc3f2c03-916a-4169-b141-969d6beeceea"><img align="right" src="https://github.com/AndriousSolutions/fluttery_framework/assets/32497443/cc3f2c03-916a-4169-b141-969d6beeceea" width="48%" height="60%"></a>
</div>

When a **StateX** object takes in a **StateXController** object through its constructor or though one of its **add**() functions
(see screenshot), that controller now has access to that State object and all its properties and functions.
That very fact allows for some powerful capabilities. Essentially, you now have the ability to call the State object's 
**setState**() function from outside its class---through that controller object!
The basic requirement of any State Management in Flutter is to reliably call the **setState**() function 
from a particular State object. 

| [page_01.dart](https://github.com/AndriousSolutions/fluttery_framework/blob/23f566a79506e799f7d5af602ccaccb5d3bc533f/example/lib/src/home/view/counter/view/page_01.dart#L19) |
|:-----------------|

The two screenshots below demonstrate how easily you can now reference a particular State object from 
yet another State object if need be. The code below is from the example app that accompanies the 
Fluttery Framework package. The first screenshot is of the State class, **Page2State**, which displays 'Page 2'
of the [Three-Page Counter](https://github.com/AndriousSolutions/fluttery_framework/tree/23f566a79506e799f7d5af602ccaccb5d3bc533f/example/lib/src/home/view/counter/view) Example app.
In this app, you're able to increment the counter of even a neighboring page with a tap of a button.

The first screenshot shows how to increment the counter on 'Page 1' from the 'Page 2' screen.
The second screenshot shows how to increment the counter on 'Page 2' from the 'Page 3' screen.
A simple demonstration, but a spectacular one if you think about it! 
Notice it's the same controller class object (unimaginatively named Controller) being used, 
and it can reference all three State objects at the same time!
<div>
<a target="_blank" href="https://github.com/AndriousSolutions/fluttery_framework/assets/32497443/9a4a708a-b1cb-4c62-918a-91980b83e767"><img src="https://github.com/AndriousSolutions/fluttery_framework/assets/32497443/9a4a708a-b1cb-4c62-918a-91980b83e767" width="48%" height="60%"></a>
<a target="_blank" href="https://github.com/AndriousSolutions/fluttery_framework/assets/32497443/988694d4-326f-474d-9e8e-77ac143e3e55"><img align="right" src="https://github.com/AndriousSolutions/fluttery_framework/assets/32497443/988694d4-326f-474d-9e8e-77ac143e3e55" width="48%" height="60%"></a>
</div>

| [page_02.dart](https://github.com/AndriousSolutions/fluttery_framework/blob/23f566a79506e799f7d5af602ccaccb5d3bc533f/example/lib/src/home/view/counter/view/page_02.dart#L141) | [page_03.dart](https://github.com/AndriousSolutions/fluttery_framework/blob/23f566a79506e799f7d5af602ccaccb5d3bc533f/example/lib/src/home/view/counter/view/page_03.dart#L18) |
|:-----------------|-----------------:|
<div>
  <img id="fifo" align="right" src="https://github.com/Andrious/bazaar/assets/32497443/9c6ab55d-faf6-4b40-8f3c-6295ebe592b9">
</div>

During the course of a typical app, as the user progressively moves deeper, for example, into the app 
going from screen to screen, the **StateXController** object retains the sequence of State objects 
its been assigned to in turn. It's 'current' state object (its `.state` property) is always the one residing in the current screen.
However, as you see in the screenshots above, the controller has the means to reference 'past' State objects
from previous screens (<a href="https://pub.dev/documentation/state_extended/latest/state_extended/SetStateMixin/ofState.html">ofState</a>() and <a href="https://pub.dev/documentation/state_extended/latest/state_extended/SetStateMixin/stateOf.html">stateOf</a>()). Of course, when the user retreats back to the original screen, the controller's
'current' state object property reflects that change accordingly.

Further, the **StateX** class has access to some 27 events functions. Thus, if a controller is registered with that State object, 
those events are delegated to that controller. The controller is to directly handle any such events
while the State object is to be remain concerned with just the interface. This all follows the clean architecture paradigm.

<h3 id="bloat">No Controller Bloat</h3>
You're able to add as many controllers as you want to an individual StateX object. This prevents making your
controller class too big to manage---bloating it with all the business rules required. Instead, you can
break down the logic into manageable segments each representing a particular aspect of the app's business rules
, in turn, each aspect could be represented by an individual controller class if applicable.
Note, when a StateX object has a number of registered Controllers, and a system event occurs, for example, 
those controllers will run in the order they were assigned to possibly address that event---if
you've supplied the code to do so.

Of course, nothing is stopping you from having controllers call other controllers or other objects
representing databases, or other third-party packages so to address the varying complexity of your app and its business rules.
The 'controller side' of your app deals with the logic. 
You're free to organize the degree of abstraction and complexity necessary 
to do so leaving the interface to the StateX object.
<div>
  <img src="https://github.com/Andrious/bazaar/assets/32497443/f84c06e9-7622-495a-9a8d-91da133311d0">
  <a target="_blank" href="https://github.com/AndriousSolutions/fluttery_framework/assets/32497443/cc3f2c03-916a-4169-b141-969d6beeceea"><img align="right" src="https://github.com/AndriousSolutions/fluttery_framework/assets/32497443/cc3f2c03-916a-4169-b141-969d6beeceea" width="48%" height="60%"></a>
</div>

| [page_01.dart](https://github.com/AndriousSolutions/fluttery_framework/blob/23f566a79506e799f7d5af602ccaccb5d3bc533f/example/lib/src/home/view/counter/view/page_01.dart#L19) |
|:-----------------|

<h3 id="control">Control The State</h3>

Thus, when you register a controller to a StateX object, take advantage of the fact that a controller has all
the functions like its corresponding StateX object.
For example, if there's anything your controller may need to be initialized before a widget is displayed,
remember a controller has its **initState**() function to initialize such requirements.

In the first screenshot below, the **WordPairsTimer** controller class has to set up its timer
and pass its State object reference to the 'data object' called, _model_, before its particular
State object can proceed to calling its **build**() function and display somthing on the screen.
Since these are not operations pertaining to the interface directly, they are well-suited to reside 
in one of the designated controller objects.

The second screenshot below, is of another example app where it appears it's necessary for a controller
to instantiate another controller called, _ExampleAppController_. It obviously a requirement and
part of the 'business process' and so it too resides in a controller.
<div>
  <a id="wordPairInit" target="_blank" href="https://github.com/AndriousSolutions/fluttery_framework/assets/32497443/6a66aa52-a66a-4d56-aa2e-62683cc0c681"><img  src="https://github.com/AndriousSolutions/fluttery_framework/assets/32497443/6a66aa52-a66a-4d56-aa2e-62683cc0c681" width="48%" height="60%"></a>
  <a id="contactListInit" target="_blank" href="https://github.com/AndriousSolutions/fluttery_framework/assets/32497443/c47cfe0c-0ee1-479f-aa37-59ef378143b7"><img align="right" src="https://github.com/AndriousSolutions/fluttery_framework/assets/32497443/c47cfe0c-0ee1-479f-aa37-59ef378143b7" width="48%" height="60%"></a>
</div>

| [word_pair_timer.dart](https://github.com/AndriousSolutions/fluttery_framework/blob/23f566a79506e799f7d5af602ccaccb5d3bc533f/example/lib/src/app/controller/word_pair_timer.dart#L37) | [contacts_app.dart](https://github.com/AndriousSolutions/fluttery_framework/blob/23f566a79506e799f7d5af602ccaccb5d3bc533f/example/lib/src/home/view/contacts_app.dart#L7) |
|:-------------------------|----------------------:|

Further note in the first screenshot above, the controller's corresponding **deactivate**() function turns off
the timer if and when, in this instance, that screen is closed. But that's not sufficient. 
Let's assume this example app is running on a mobile phone. If and when the user chooses to answer a phone call,
for example, and place this app in the background, again, it's good practice to turn off the timer.
The timer is re-initialized only if and when the user returns to that app. 
This behavior is easily achieved in that controller as well using its
**didChangeAppLifecycleState**() and **resumedLifecycleState**() functions to name a few. See below.
<div>
  <a id="cancelTimer" target="_blank" href="https://github.com/AndriousSolutions/fluttery_framework/assets/32497443/e29083ac-1f1d-4b59-8f77-28aaf8c7d47c"><img  src="https://github.com/AndriousSolutions/fluttery_framework/assets/32497443/e29083ac-1f1d-4b59-8f77-28aaf8c7d47c" width="48%" height="60%"></a>
</div>

| [word_pair_timer.dart](https://github.com/AndriousSolutions/fluttery_framework/blob/master/example/lib/src/app/controller/word_pair_timer.dart#L72) |
|:-------------------------|
<h3 id="single">The Singleton Pattern</h3>
I find the role of a Controller is best served by a single instance of that class throughout the 
life of the app. It's called upon to respond to various system and user events 
throughout an app's lifecycle and yet still retain an ongoing and reliable state. 
A factory constructor for the Controller class readily accomplishes this. See below.

```Dart
class CounterController extends StateXController {
  factory CounterController() => _this ??= CounterController._();
  CounterController._() : super();
  static CounterController? _this;
```
With the Singleton pattern, making only one single instance of a particular class creates lesser overhead.
Certainly not a steadfast rule, but it's suggested all controllers instantiate with a factory constructor. 
Again, doing so agrees with its general role as an ongoing custodian of the app's business rules and event handling.
A clean, consistent, and manageable approach, and as it happens, one that adheres to good programming practices.

<h3 id="events">The Controller and State Events</h3>

As mentioned above, with the controller, you not only supply the app's business rules, but can also respond
to the device and system events that commonly occur during an app's lifecycle. The sample code below lists all the
available 'event' functions. In most cases, you'll only use the functions, **initAsync**(), **initState**(), **deactivate**(), and **dispose**()
as well as its 'lifecycle' functions. However, they're all there for you as you may need them someday in a future app:

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

<h3 id="list">The List of Device and System Events</h3>

###### (Tap on each below to see the source code and a further explanation of these function.)

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
