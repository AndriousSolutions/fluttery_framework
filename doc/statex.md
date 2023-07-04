## _The State Extended_
Extending the capabilities of Flutter’s own State class with the StateX class.
This class allows you to use a [State Object Controller](https://pub.dev/documentation/fluttery_framework/latest/topics/State%20Object%20Controller-topic.html) (SOC) to reliably call 
its **setState**() function from outside the class — a very powerful capability!

The StateX class gives you four things:

<ul style="list-style-type: none">
   <li>The State Object Controller separates the app's interface from everything else:</li>
   <li><b><a href="https://pub.dev/documentation/fluttery_framework/latest/controller_app/StateXController-class.html" style="text-decoration:none;">StateXController</a></b></li>
   <li>Two functions to supply the Material interface and the Cupertino interface:</li>
   <li><b><a href="https://pub.dev/documentation/fluttery_framework/latest/view_app_state/StateX/buildAndroid.html" style="text-decoration:none">buildAndroid</a></b>() and <b><a href="https://pub.dev/documentation/fluttery_framework/latest/view_app_state/StateX/buildiOS.html">buildiOS</a></b>()</li>
   <li>A function to perform any necessary asynchronous operations before displaying the interface.</li>
   <li><b><a href="https://pub.dev/documentation/state_extended/latest/state_extended/AsyncOps/initAsync.html" style="text-decoration:none;color:none;">initAsync</a></b>()</li>
   <li>A means to update only <i>particular</i> widgets on the screen improving performance:</li>
   <li><b><a href="https://pub.dev/documentation/fluttery_framework/latest/view_app_state/StateX/notifyClients.html">notifyClient></a></b>(), <b><a href="https://pub.dev/documentation/fluttery_framework/latest/view_app_state/StateX/state.html">state</a></b>(), <b><a href="https://pub.dev/documentation/fluttery_framework/latest/view_app_state/StateX/updateShouldNotify.html">updateShouldNotify</a></b>()</li>
</ul>

```Dart
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
event handling. Controllers are not new to Flutter. For example, two popular widgets that also use a controller are 
[TextField](https://github.com/flutter/flutter/blob/66cda5917daacd5e600221be0259b62115078486/packages/flutter/lib/src/material/text_field.dart#L246C13-L246C13)
and [SingleChildScrollView](https://github.com/flutter/flutter/blob/66cda5917daacd5e600221be0259b62115078486/packages/flutter/lib/src/widgets/single_child_scroll_view.dart#L139).

A StateX object can have any number of controllers during the app’s lifecycle. This promotes more modular development 
where each controller could be dedicated to a particular responsibility independent of 
other controllers. This further relieves any 'Controller bloat' common in such arrangements.

By design, the Controller object is then referenced here and there in the State object’s **build**() function 
providing the data and the event handling where necessary for the app to function correctly. 
```Dart
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
![initFutureDelay](https://github.com/AndriousSolutions/fluttery_framework/assets/32497443/f7e790f9-2362-4cc2-8ac5-0f38c82c7c3c)

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

Below are three other gif files. The first one depicts one StateX object waiting to continue while
the second depicts twelve StateX objects waiting to continue.
Each StateX object has its own individual asynchronous operation going on, and each uses Flutter’s
own FutureBuilder widget to wait for completion. See what I did there? I’m keeping it Flutter

<img src="https://github.com/AndriousSolutions/fluttery_framework/assets/32497443/6ccff53b-da0e-41b9-aace-81dc95111254" width="171" height="357">
<img src="https://github.com/AndriousSolutions/fluttery_framework/assets/32497443/25ab69de-b9eb-4c8c-a2d0-9598152bf360" width="171" height="357">
<img src="https://github.com/AndriousSolutions/fluttery_framework/assets/32497443/009afbfb-40a3-4c69-8813-7d7e71e21888" width="171" height="357">

Since this app is running on an Android emulator, those spinners are from the CircularProgressIndicator widget.
However, if it were running on an iOS phone, the CupertinoActivityIndicator widget would be used to
produce the iOS-style activity indicators instead. Flutter is a cross-platform SDK after all.

It’s Built-in
So, how do you use the built-in FutureBuilder in the StateX class? Simple. 
Instead of overriding the build() function, override the buildWidget() function instead. 
The function name is not very imaginative, but it had to be a different function. 
You see, in the StateX class, it’s the build() function that introduces the FutureBuilder widget (see the second screenshot below). 
It eventually calls the buildWidget() function in the internal function, _futureBuilder.

there are twenty-one event handlers added to the StateX class in the state_extended package, 
and when a controller is linked to a StateX object, it too then has access to these event handlers and 
to events that may be triggered in the app. I suspect Android developers in particular will recognize this 
as an indispensable capability as well.

there can be individual controllers running their own initState() functions. Very clean. Very modular.