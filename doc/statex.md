# StateX class
## _The State Extended_
Extending the capabilities of Flutter’s own State class with the StateX class,
this class allows you to use a State Object Controller (SOC) to reliably call 
its **setState**() function from outside the class — a very powerful capability!
I'll show you what I mean shortly.

My motto while writing this framework has always been, ‘Keep It Flutter.’
It should look like Flutter, and it should act like Flutter. With that, I kept the State class 
as the main player in State Management---just like Flutter. While a StatefulWidget is created, destroyed, 
and recreated again and again in a typical Flutter app, its State object remains in memory. 
All that should really be in a StatefulWidget is its **createState**() function. 
Any additional code should be immutable otherwise performance is affected.

```dart
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
```

### Control Your Code
All your ‘mutable’ code should go into the Dart file containing your State Object Controller.
It would generally contain the ‘business logic’ involved in a given app as well as address any 
event handling. Controllers not new to Flutter. You’ve likely encountered a number of controllers 
while working with Flutter’s own widgets---many with named parameters called ‘controller.’ 
The State class would be concerned with the interface, and the State Object Controller class would 
be concerned with the event handling and logic.

A StateX controller can do anything its associated StateX object can do as it has access to that
State object and its properties: widget, mounted, and context. Further, a StateX object can have 
any number of controllers during the app’s lifecycle. This promotes more modular development 
where each controller could, for example, be dedicated to a particular responsibility independent of 
the other controllers.


the Controller object is referenced here and there in the State object’s **build**() function. By design, 
the controller is providing the data and the event handling necessary for the app to function correctly. 
```dart
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

  @override
  Widget buildiOS(BuildContext context) => buildAndroid(context);
}
```
[statex_counter_app.dart](https://gist.github.com/Andrious/c3896795659c82daf5c78e427ba030bf)

I felt was an essential feature missing in Flutter’s original State class: 
The means to deal with asynchronous operations in a State object before proceeding to render the interface.

It’s for demonstration purposes, so there’s no real asynchronous operation going on there. 
A duration of 10 seconds is counting down when that black screen appears. 
It’s a Future.delay() function called in a function named, initAsync(), 
in one of the State Object Controllers. See below. As a result, 
the app waits for that duration before proceeding.

However, in a real production app, this could just as easily be a database opening up, 
web services being called, servers being logged into, etc. Such operations can now easily be 
performed in a State Object Controller, and its associated State object will quietly wait 
until completion with something spinner away on the screen.

All State Object Controllers have the **initAsync**() function to run any asynchronous operations 
before their corresponding StateX objects can proceed and call their build() functions. 
I use this function all the time and can’t live without it.
Since most asynchronous operations have no direct relation to an app’s interface, 
you’ll likely have your asynchronous stuff running in a State Object Controller 
with the rest of the app’s business logic. See how that works?

Below are three other gif files. The first one depicts one StateX object waiting to continue 
while the second depicts twelve StateX objects waiting to continue. Each StateX object has its own 
individual asynchronous operation going on, and each uses Flutter’s own FutureBuilder widget 
to wait for completion. See what I did there? I’m keeping it Flutter.

The one above on the far right shows the whole process completed. 
It’s the startup process for the third example app that accompanies the state_extended package. 
Since this app is running on an Android emulator, those spinners are from the 
CircularProgressIndicator widget. However, if it were running on an iOS phone, 
the CupertinoActivityIndicator widget would be used to produce the iOS-style activity indicators instead. 
Flutter is a cross-platform SDK after all.

It’s Built-in
So, how do you use the built-in FutureBuilder in the StateX class? Simple. 
Instead of overriding the build() function, override the buildWidget() function instead. 
The function name is not very imaginative, but it had to be a different function. 
You see, in the StateX class, it’s the build() function that introduces the FutureBuilder widget (see the second screenshot below). 
It eventually calls the buildWidget() function in the internal function, _futureBuilder.

listing the additional functions and features you gain when you use the StateX class.
add(StateXController? controller)
Add a specific StateXController to this State object.

addList(List<StateXController>? list)
Add a list of ‘Controllers’ to be associated with this StatX object.

StateXController? get controller
Provide the ‘first’ controller added to this State object
(allowed multiple controllers).

U? controllerByType<U extends StateXController>()

Retrieve a StateXController by type (allowed multiple controllers).

onError(FlutterErrorDetails details)
Its own Error Handler. The default routine is to dump the error to the console.

there are twenty-one event handlers added to the StateX class in the state_extended package, 
and when a controller is linked to a StateX object, it too then has access to these event handlers and 
to events that may be triggered in the app. I suspect Android developers in particular will recognize this 
as an indispensable capability as well.

StateX class and its initState() function below, presents how a StateX object, after running its own initState() function, 
then runs the initState() function of each and every controller currently associated with it at the time. 
You see, each controller may have its own operations or services that need to run before the StateX object can continue. 
Instead of a large and messy initState() function in the one State object — 
there can be individual controllers running their own initState() functions. Very clean. Very modular.

initState()
Called exactly once when the State object is first created.

initAsync()
Called exactly once at the app’s startup to initialize any ‘time-consuming’ operations that need to complete 
for the app can continue.

dispose()
When the State object will never build again. Its terminated.

didUpdateWidget(StatefulWidget oldWidget)
Override this method to respond when the State object’s accompanying StatefulWidget is destroyed 
and a new one recreated — a very common occurrence in the life of a typical Flutter app.

didChangeDependencies()
When a dependency of this State object changes.

didChangePlatformBrightness()
Brightness changed.

didChangeLocale(Locale locale)
When the user’s locale has changed.

didChangeMetrics()
When the application’s dimensions change. (i.e. when a phone is rotated.)

reassemble()
Called during hot reload. (e.g. reassembled during debugging.)

didPopRoute()
Called when the system tells the app to pop the current route.

didPushRoute(String route)
Called when the app pushes a new route onto the navigator.

didPushRouteInformation(RouteInformation routeInformation)
Called when pushing a new RouteInformation and a restoration state
onto the router.

deactivate()
When the State object is removed from the Widget tree.

didChangeTextScaleFactor()
When the platform’s text scale factor changes.

didHaveMemoryPressure()
When the phone is running low on memory.

didChangeAccessibilityFeatures()
When the system changes the set of active accessibility features.

didChangeAppLifecycleState(AppLifecycleState state)
Called when the app’s in the background or returns to the foreground.
The four following functions use this one to address specific events.

inactiveLifecycleState()
The application is in an inactive state and is not receiving user input.

pausedLifecycleState()
The application is not currently visible to the user, not responding to
user input, and running in the background.

detachedLifecycleState()
Either be in the progress of attaching when the engine is first initializing
or after the view being destroyed due to a Navigator pop.

resumedLifecycleState()
The application is visible and responding to user input.