## _An Ignored Necessity_

Developers are guilty of two shortcomings when writing software: 
<br />
Error handling
<br />
Documentation 

Happily, not only does the Flutter Framework have its own error handler, you can introduce your own custom error handler if you want.
You're encouraged to handle errors in your app because they are going to happen in your app.

<table>
  	<caption>Contents</caption>
    <tbody>
      <tr>
        <td><a href="#state">Error In State</a></td>
        <td><a href="#count">Count On Errors</a></td>
        <td><a href="#firebasecrashlytics">Use FirebaseCrashlytics</a></td>
        <td><a href="#seeing">Seeing Red</a></td>
      </tr>
    </tbody>
</table>

<h3 id="state">Error In State</h3>

As a further extension to Flutter's State class, each [StateX](https://pub.dev/documentation/fluttery_framework/latest/topics/StateX%20class-topic.html) class has an **onError**() function.
It comes from the mixin, **StateXonErrorMixin**, and if not overridden will do nothing when indeed an error occurs (see below).
However,  if the **onError**() function is implemented when the StateX object encounters an error,
the function makes it possible to handle that error so that the app can recover and or fail gracefully.
```Dart
mixin StateXonErrorMixin<T extends StatefulWidget> on StateX<T> {
  /// This is called within the framework.
  void onError(FlutterErrorDetails details) {}
}
```

<h3 id="count">Count On Errors</h3>
<div>
<img align="right" src="https://github.com/AndriousSolutions/fluttery_framework/assets/32497443/665db521-0636-462b-bd01-ee16fbb14955" width="171" height="357">
</div>
<p>The example app that accompanies the Fluttery Framework package includes the traditional 'counter app.'
Note, with every tap of that button, an error is purposely thrown to demonstrate the Fluttery Framework's innate error handling.
Despite the error, you see the counter is still being incremented.</p>

In the first screenshot below, the **throw** command explicitly causes an exception. 
This would otherwise cause the counter not to be incremented with no change reflected on the screen.
This error, of course, is recorded in device's log files and or on the IDE's console.

However, in the second screenshot, that State object's **onError**() is specifically looking out for such an error.
It assumes the counter failed to increment and therefore does so there in the error routine.
The third screenshot below is that of the console screen on my IDE when the error occurred. 

<p>Of course, this is a very simple example from a very simple example app.
However, it does reveal the basic concept involved when an error occurs in one of these State objects. 
Using the Fluttery Framework, each State object could be considered its own little app, 
and so it should have its own error handling.</p>

If an error occurs in the State object the error will propagate back the app's error handler,
but not before calling the State object's **onError**() function. 
Error handling is, therefore, more modular and implemented more efficiently.
Any possible errors are anticipated and handled in the very State object where they occur. 
By the way, you have means of implementing a custom error handler for your app.
<br />
<a id="onError" target="_blank" rel="noopener noreferrer" href="https://github.com/AndriousSolutions/fluttery_framework/assets/32497443/417d9673-5a64-487a-a8ed-87af335fb0d1"><img align="right" src="https://github.com/AndriousSolutions/fluttery_framework/assets/32497443/417d9673-5a64-487a-a8ed-87af335fb0d1" width="48%" height="60%"></a>
<a id="throwException" target="_blank" rel="noopener noreferrer" href="https://github.com/AndriousSolutions/fluttery_framework/assets/32497443/d031cba4-43a6-4f8b-9911-4859fa3c2fa7"><img src="https://github.com/AndriousSolutions/fluttery_framework/assets/32497443/d031cba4-43a6-4f8b-9911-4859fa3c2fa7" width="48%" height="60%"></a>

| [counter_app.dart](https://github.com/AndriousSolutions/fluttery_framework/blob/1d5dbb4cc1d3b46308292ab19a5cd7898f46e872/example/lib/src/home/view/counter_app.dart#L101) | [counter_app.dart](https://github.com/AndriousSolutions/fluttery_framework/blob/1d5dbb4cc1d3b46308292ab19a5cd7898f46e872/example/lib/src/home/view/counter_app.dart#L183) |
|:------------------------------------------------------------------------------------------------------------------------------|:---------------------------------------------------------------------------------------------------------------------------------------:|

<a id="errorConsole" target="_blank" rel="noopener noreferrer" href="https://github.com/AndriousSolutions/fluttery_framework/assets/32497443/3efa6f4b-90b7-4457-973e-0579e0be2538"><img src="https://github.com/AndriousSolutions/fluttery_framework/assets/32497443/3efa6f4b-90b7-4457-973e-0579e0be2538" width="100%" height="100%"></a>

<h3 id="firebasecrashlytics">Use FirebaseCrashlytics</h3>

FirebaseCrashlytics is a popular realtime crash reporter.
It discretely sends a report to your Firebase console when one of your apps encounters an error.
You then can be more responsive to your user if and when such issues arise.
Of course, the Fluttery Framework allows you to implement FirebaseCrashlytics as your app's error handler.
It's a simple matter of instantiating the FirebaseCrashlytics class and assigning the appropriate handlers.

As an example, the first screenshot below depicts how you could utilize the **onInitAsync**() function in the App State class,
and begin setting up the FirebaseCrashlytics as the app's error handler.
As you see there, if the app is running in production, any occurring errors are reported to your Firebase console.
In the second screenshot, that instance of the FirebaseCrashlytics object is assigned as the app's error handler as well as 
report any errors occurring in the very Dart isolate or run zone executing the app.
The **AppWidgetErrorDisplayed** is merely there to demonstrate the ability to define a custom error screen when a widget fails to display.
As it is, It's already the default in the Fluttery Framework. 
An example of it is displayed below (see <a href="#seeing">Seeing Red</a>).
<div>
  <a id="setLocale" target="_blank" rel="noopener noreferrer" href="https://github.com/AndriousSolutions/fluttery_framework/assets/32497443/550558c2-0430-43d2-8baf-de7cff218e8a"><img align="right" src="https://github.com/AndriousSolutions/fluttery_framework/assets/32497443/550558c2-0430-43d2-8baf-de7cff218e8a" width="48%" height="60%"></a>
  <a id="onLocale" target="_blank" rel="noopener noreferrer" href="https://github.com/AndriousSolutions/fluttery_framework/assets/32497443/77a4da97-3294-4664-be7b-e6d0b6522bd2"><img src="https://github.com/AndriousSolutions/fluttery_framework/assets/32497443/77a4da97-3294-4664-be7b-e6d0b6522bd2" width="48%" height="60%"></a>
</div>

| [app.dart](https://github.com/AndriousSolutions/fluttery_framework/blob/db4bb8bfb07fe1be94483321cd0cd216b69c4eec/example/lib/src/app/view/app.dart#L50) |
|:-------------|

<h3 id="seeing">Seeing Red</h3>
<img align="right" src="https://github.com/AndriousSolutions/fluttery_framework/assets/32497443/0d9135e5-8558-43dd-a35d-f032cf7fae90" width="171" height="357">
<img align="right" src="https://github.com/AndriousSolutions/fluttery_framework/assets/32497443/3c034b7e-74b0-45a5-91e9-887e184f8c35" width="171" height="357">

As you know, typically when an error occurs while developing in Flutter and a widget fails to display, the 'Read Screen of Despair' appears.
Using the Fluttery Framework, you're greeted with something a little more helpful that displays the stack trace to the developer.
Further, as you see, it's a little more aesthetically pleasing as well.
Of course, you're free to implement your own custom screen if you like, and assign it to the **onErrorScreen**() function introduced earlier..
