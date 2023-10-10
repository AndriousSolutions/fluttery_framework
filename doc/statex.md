## _The State Extended_
Extend the capabilities of Flutter’s own State class.
This class allows you to use a [State Object Controller](https://pub.dev/documentation/fluttery_framework/latest/topics/State%20Object%20Controller-topic.html)
(SOC) to reliably call the State object's **setState**() function from outside its class — a very powerful capability!
<!--
<table cellspacing="0" cellpadding="0" border="0" align="center">
-->
<table>
  	<caption>Contents</caption>
    <tbody>
    <tr>
       <td><a href="#code">Control</a></td>
       <td><a href="#page">_HomePageState</a></td>
       <td><a href="#sync">Sync</a></td>
       <td><a href="#control">Control The Sync</a></td>
       <td><a href="#interface">Interface?</a></td>
       <td><a href="#inherit">Inherit</a></td>
      </tr>
    </tbody>
</table>
Of course, this State subclass has the <b>build</b>() function to return your interface has expected as if using the traditional State class.
However, you now have 5 more 'build' functions available to you for even further capabilities.
Note, for most of my projects, I use the <b><a href="https://pub.dev/documentation/fluttery_framework/latest/view_app_state/StateX/builder.html">builder</a></b>() function 
as it allows for most of the desired capabilities.
All six are listed below in order of precedence: 
<ul>
    <li>Use the <b><a href="https://api.flutter.dev/flutter/widgets/State/build.html">build</a></b>() function, of course, as you would the original State class.</li>

   <li>Use the <b><a href="https://pub.dev/documentation/fluttery_framework/latest/view_app_state/StateX/buildF.html">buildF</a></b>() function instead if you want to have the <b><a href="https://pub.dev/documentation/state_extended/latest/state_extended/AsyncOps/initAsync.html">initAsync</a></b>() function perform any asynchronous operations before displaying the interface.
   You see, a <a href="https://api.flutter.dev/flutter/widgets/FutureBuilder-class.html"><b>FutureBuilder</b></a> is then utilised.
   It calls the <b><a href="https://pub.dev/documentation/state_extended/latest/state_extended/AsyncOps/initAsync.html">initAsync</a></b>() function, and when the asynchronous operations are completed,
   the <b><a href="https://pub.dev/documentation/fluttery_framework/latest/view_app_state/StateX/buildF.html">buildF</a></b>() function is then called to display the interface.</li>
   
   <li>Next, if you use the <b><a href="https://pub.dev/documentation/fluttery_framework/latest/view_app_state/StateX/buildIn.html">buildIn</a></b>() function instead to return your interface,
   note that this is a progressive list of capabilities, 
   You're still free to implement the <b><a href="https://pub.dev/documentation/state_extended/latest/state_extended/AsyncOps/initAsync.html">initAsync</a></b>() function with its FutureBuilder widget,
   but now an <b><a href="https://api.flutter.dev/flutter/widgets/InheritedWidget-class.html">InheritedWidget</a></b> is involved as well.
   As just, the <b><a href="https://pub.dev/documentation/fluttery_framework/latest/view_app_state/StateX/buildIn.html">buildIn</a></b>() function will only run once and is never called again.
   and so only the <b><a href="https://pub.dev/documentation/fluttery_framework/latest/view_app_state/StateX/state.html">state</a></b>() function and 
   <b><a href="https://pub.dev/documentation/fluttery_framework/latest/view_app_state/StateX/dependOnInheritedWidget.html">dependOnInheritedWidget</a></b>() function will then dictate which widgets are updated when something changes.
   Instead of building the interface again and again from scratch, only specified portions on the interface is rebuilt improving performance.
   Note, using InheritedWidgets in this fashion is an advanced feature, and so by default, is disabled in the StateX class.
   Pass true to the StateX class' <a href="https://pub.dev/documentation/fluttery_framework/latest/view_app_state/StateX/StateX.html">useInherited</a> parameter 
   when you're more comfortable in Flutter and ready to use the built-in InheritedWidget.
   Three more functions that works with the InheritedWidget are then available to you in the StateX class:
   <b><a href="https://pub.dev/documentation/fluttery_framework/latest/view_app_state/StateX/didChangeDependencies.html">didChangeDependencies</a></b>()
   , <b><a href="https://pub.dev/documentation/fluttery_framework/latest/view_app_state/StateX/updateShouldNotify.html">updateShouldNotify</a></b>()
   and <b><a href="https://pub.dev/documentation/fluttery_framework/latest/view_app_state/StateX/notifyClients.html">notifyClient</a></b>().
   Optionally, use the <b><a href="https://pub.dev/documentation/fluttery_framework/latest/view_app_state/StateIn-class.html">StateIn</a></b> class that has the InheritedWidget always enabled.</li>

   <li>Next, use the <b><a href="https://pub.dev/documentation/fluttery_framework/latest/view_app_state/StateX/builder.html">builder</a></b>() function 
   that encompasses the capabilities listed above as well as reliably accesses the widget tree's BuildContext variable, <i>context</i>,
   since it is wrapped by a <b><a href="https://api.flutter.dev/flutter/widgets/Builder-class.html">Builder</a></b> widget.</li>
   
   <li>Finally, there are the build functions:
   <b><a href="https://pub.dev/documentation/fluttery_framework/latest/view_app_state/StateX/buildAndroid.html">buildAndroid</a></b>()
   and <b><a href="https://pub.dev/documentation/fluttery_framework/latest/view_app_state/StateX/buildiOS.html">buildiOS</a></b>().</li>
   Again, you have the option to take advantage of a built-in <a href="https://api.flutter.dev/flutter/widgets/FutureBuilder-class.html"><b>FutureBuilder</b></a> 
   and a built-in <b><a href="https://api.flutter.dev/flutter/widgets/InheritedWidget-class.html">InheritedWidget</a></b> or not,
   but you also have the option to supply both the Material interface and the Cupertino interface to your app.
   The framework will run one or the other depending on whether your app is running on a Android phone or iOS phone.
   As always, you have options.
   If you don't want to the Cupertino interface, 
   simply implement the <b><a href="https://pub.dev/documentation/fluttery_framework/latest/view_app_state/StateX/buildAndroid.html">buildAndroid</a></b>() function,
   and it will run by default---even on an iOS phone.
</ul>

Like any good app framework, you've got options. 
From left to right, the number of options only grows:

<b>build</b>()  ->  <b>buildF</b>() -> <b>buildIn</b>() -> <b>builder</b>() -> <b>buildAndroid</b>() ->  <b>buildiOS</b>()

<h3 id="handle">Handle Your Errors</h3>
Error handling should always be top of mind when developing software,
and so every StateX object now has the <b><a href="https://pub.dev/documentation/fluttery_framework/latest/view_app_state/StateXonErrorMixin/onError.html">onError</a></b>() function
that's called if an error occurs in the State object.
This allows you to 'clean up' and fail gracefully. And remember, the <b><a href="https://pub.dev/documentation/fluttery_framework/latest/controller_app/StateXController-class.html">State Object Controller</a></b> separates that interface (i.e. the State object's <b>build</b>() function) from the business rules and event handling.
Such an arrangement has proven to be very powerful encouraging a clean architecture <b>within</b> the State class itself!

<h3 id="code">Control Your Code</h3>
All your ‘mutable’ code should go into your State Object Controller.
It would contain the ‘business logic’ involved in a given app as well as address any 
event handling. Controllers are not new to Flutter. For example, two popular widgets that use a controller is the
<a href="https://github.com/flutter/flutter/blob/66cda5917daacd5e600221be0259b62115078486/packages/flutter/lib/src/material/text_field.dart#L246C13-L246C13">TextField</a>
widget and the <a href="https://github.com/flutter/flutter/blob/66cda5917daacd5e600221be0259b62115078486/packages/flutter/lib/src/widgets/single_child_scroll_view.dart#L139">SingleChildScrollView</a>
widget.

However, unlike those two widgets, a StateX object can have any number of controllers.
This promotes more modular development where each controller is dedicated to a particular responsibility independent of 
other controllers. This further relieves any 'controller bloat' common when involving a controller
(see [State Object Controller](https://pub.dev/documentation/fluttery_framework/latest/topics/State%20Object%20Controller-topic.html)).

<h3 id="page">The State Pattern</h3>
A common pattern seen when implementing a controller for use by a StateX object will have the controller object
instantiated right in the State object and then referenced here and there in one of the StateX object’s many <b>'build'</b> functions.
Thus providing the data and the event handling. For example, the first screenshot below is of the 'counter example app'
that accompanies the Flutter Framework package. The second screenshot shows how a number of controllers can be added.

###### (A controller and its use are highlighted by red arrows.)

<div>
<a target="_blank" rel="noopener noreferrer" href="https://github.com/AndriousSolutions/fluttery_framework/assets/32497443/9e1771be-ca42-453a-815f-67b3c37b2ba9"><img src="https://github.com/AndriousSolutions/fluttery_framework/assets/32497443/9e1771be-ca42-453a-815f-67b3c37b2ba9" width="48%" height="60%"></a>
<a target="_blank" rel="noopener noreferrer" href="https://github.com/AndriousSolutions/fluttery_framework/assets/32497443/cc3f2c03-916a-4169-b141-969d6beeceea"><img align="right" src="https://github.com/AndriousSolutions/fluttery_framework/assets/32497443/cc3f2c03-916a-4169-b141-969d6beeceea" width="48%" height="60%"></a>
</div>

| [_MyHomePageState](https://gist.github.com/Andrious/c3896795659c82daf5c78e427ba030bf#file-statex_counter_app-dart-L35) |                                                                                [Page1State](https://github.com/AndriousSolutions/fluttery_framework/blob/master/example/lib/src/home/view/counter/view/page_01.dart#L19)                                                                                 |
|:-----------------------------------------------------------------------------------------------------------------------|:---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------:|

<h3 id="sync">Sync The State</h3>

<p>There's now a means to deal with asynchronous operations in the State object before rendering its interface.
In other packages, the approach has been to execute such operations even before the app
begins. It's a disjointed approach. The operation is not done by the actually State object (the screen) where
it's relevant or required. However, Flutter has always had the FutureBuilder widget to make this possible.
A FutureBuilder widget is built into the StateX class, and has its <b>initAsync</b>() function to then
perform such asynchronous operations. As a result, when such a State object is called,
it can wait for its asynchronous operations to complete before proceeding. As easy as that.</p>

Below are four gif files. The first one depicts what a user will see more often than not when
starting up an app written with the Fluttery Framework. There's always a remote database to open or web services
to connect to and this takes a little time. You don't want your user staring at a blank screen. They'll think
the app is frozen! Fluttery displays a spinner indicating the app is indeed running. The second gif file depicts twelve separate StateX objects waiting to continue.
Each has its own individual asynchronous operation loading a animal graphic from some REST api somewhere.
The third gif file shows the whole startup process for this particular app.
It carry's on and shows you they are indeed individual operations ending with a different picture.
Note, in the last gif file, you've the option to implement a splash screen instead.
<div>
<a target="_blank" rel="noopener noreferrer" href="https://github.com/AndriousSolutions/fluttery_framework/assets/32497443/6ccff53b-da0e-41b9-aace-81dc95111254"><img src="https://github.com/AndriousSolutions/fluttery_framework/assets/32497443/6ccff53b-da0e-41b9-aace-81dc95111254" width="171" height="357"></a>
<a target="_blank" rel="noopener noreferrer" href="https://github.com/AndriousSolutions/fluttery_framework/assets/32497443/25ab69de-b9eb-4c8c-a2d0-9598152bf360"><img src="https://github.com/AndriousSolutions/fluttery_framework/assets/32497443/25ab69de-b9eb-4c8c-a2d0-9598152bf360" width="171" height="357"></a>
<a target="_blank" rel="noopener noreferrer" href="https://github.com/AndriousSolutions/fluttery_framework/assets/32497443/009afbfb-40a3-4c69-8813-7d7e71e21888"><img src="https://github.com/AndriousSolutions/fluttery_framework/assets/32497443/009afbfb-40a3-4c69-8813-7d7e71e21888" width="171" height="357"></a>
<a id="loadingScreen" target="_blank" rel="noopener noreferrer" href="https://github.com/AndriousSolutions/fluttery_framework/assets/32497443/4172e252-9633-42fd-80ff-5adc3b1dab4f"><img src="https://github.com/AndriousSolutions/fluttery_framework/assets/32497443/4172e252-9633-42fd-80ff-5adc3b1dab4f" width="171" height="357"></a>
</div>
Since I'm using an Android emulator, those spinners are from the 
<a href="https://github.com/flutter/flutter/blob/e1702a96f679772847459650670bbe9f04480840/packages/flutter/lib/src/material/progress_indicator.dart#L554">CircularProgressIndicator</a> widget.
If they were running on an iOS phone, the 
<a href="https://github.com/flutter/flutter/blob/e1702a96f679772847459650670bbe9f04480840/packages/flutter/lib/src/cupertino/activity_indicator.dart#L32">CupertinoActivityIndicator</a>
widget would produce the iOS-style activity indicators instead. Flutter is a cross-platform SDK after all.
<div>
<a target="_blank" rel="noopener noreferrer" href="https://github.com/AndriousSolutions/fluttery_framework/assets/32497443/1e846262-a0a5-47e3-891f-1ed7d0308962"><img src="https://github.com/AndriousSolutions/fluttery_framework/assets/32497443/1e846262-a0a5-47e3-891f-1ed7d0308962" width="48%" height="60%"></a>
<a target="_blank" rel="noopener noreferrer" href="https://github.com/AndriousSolutions/fluttery_framework/assets/32497443/e4b9c1ee-803a-4b53-b393-027a510599df"><img align="right" src="https://github.com/AndriousSolutions/fluttery_framework/assets/32497443/e4b9c1ee-803a-4b53-b393-027a510599df" width="48%" height="60%"></a>
</div>

| [image_api_controller.dart](https://github.com/AndriousSolutions/fluttery_framework/blob/512093984b404e4f2216521a5f95bd6418ea6054/example/lib/src/home/grid_app_example/gridview/controller/image_api_controller.dart#L38) | [working_memory_app.dart](https://github.com/Andrious/workingmemory/blob/master/lib/src/app/controller/working_memory_app.dart#L77) |
|:-----|:----:|

<h3 id="control">Control The Sync</h3>

<p>Those three screens above are from yet another example app supplied with the Flutter Framework.
Yes, there are twelve separate StateX objects on that one screen each loading an animal image. 
Actually its their own individual State Object Controller that's performing the 
asynchronous download. Above, is a screenshot of that controller's own <b>initAsync</b>() function. 
While each controller is calling its <b>_loadImage</b>() function, its associated StateX object will 
quietly wait with its indicator spinning away on the screen. Very nice.</p>

The screenshot on the right is another **initAsync**() function from another app altogether.
It demonstrates there can be a number of asynchronous operations performed before an app can continue.
This particular app involves the authentication of the user for example.
If not already logged in a login screen will appear. This function is in another controller
and that controller calls yet another controller to run its own **initAsync**().
See how you're able to separate distinct asynchronous operations
each prefixed with an **await** operator and returning a boolean value to the variable, *init*.
It's all easy to read and all in the right location to be implemented.

It's suggested you implement such operations in a Controller, and not directly in a StateX object.
Besides, the StateX object's own <b>initAsync</b>() function is already implemented:
It's calling all the <b>initAsync</b>() functions from its associated State Object Controllers.
When they're all complete, the StateX object only then calls its <b>build</b>() function.
Since most asynchronous operations have no direct relation to an app’s interface, 
you’ll likely have your asynchronous stuff running in a State Object Controller anyway 
with the rest of the app’s business logic. See how that works?

There can be individual controllers running their own **initAsync**() function. Very clean. Very modular.

<h3 id="interface">Which Interface?</h3>

As you know, Google touts Flutter as a cross-platform SDK. It even offers two 
types of interfaces to be displayed to users when running a Flutter app:
the **Material** interface design and the **Cupertino** interface design.

This suggests then that you're able to create an app using either interface or both.
For example, you'd run the Cupertino version of the interface if the app is running on a iOS phone
, and run the Material version if the app is running on an Android, or on Windows or on the Web or on Linux.
However, right out of the box, Flutter doesn't give you any place to make such a distinction.
It only gives you one function: the **build**() function. 
However, the Fluttery Framework already uses that function.
It uses that funtion to give you a separate place for those two types of interfaces:

[![build](https://github.com/AndriousSolutions/fluttery_framework/assets/32497443/c181662e-2e56-4405-b2b8-a471451845bc)](https://github.com/AndriousSolutions/fluttery_framework/blob/4dc676193914808583f111006334a91a08475b7f/lib/view/app_state.dart#L1561)
Like the State class, the StateX class is an abstract class. However, when you extend the StateX class, 
you don't have to implement the one **build**() function. You have to implement two functions:
<div>
<a target="_blank" rel="noopener noreferrer" href="https://github.com/AndriousSolutions/fluttery_framework/assets/32497443/2f78d7e6-494a-4b06-8d2d-67bf64e786f5"><img src="https://github.com/AndriousSolutions/fluttery_framework/assets/32497443/2f78d7e6-494a-4b06-8d2d-67bf64e786f5" width="48%" height="60%"></a>
<img align="right" src="https://github.com/AndriousSolutions/fluttery_framework/assets/32497443/4543c405-8dad-4c33-bb54-a3b5850c8c67" width="171" height="357">
</div>

| [app_state.dart](https://github.com/AndriousSolutions/fluttery_framework/blob/4dc676193914808583f111006334a91a08475b7f/lib/view/app_state.dart#L1526) |
|:-----|

Flutter produces one codebase for multiple platforms. It's likely the very reason you've 
turned to Flutter to make your next app is because of this ability.
If you only want to use the Cupertino interface, for example, 
then direct the <b>buildAndroid</b>() function to call the <b>buildiOS</b>() function. 
Otherwise, build both.
As you see from the video, with the Fluttery Framework, you can even have to user choose their favorite interface at runtime.

<h3 id="inherit">Inherit The State</h3>

<p>You've may have been introduced to the InheritedWidget, 
and how it allows you to repel down the widget tree any piece of data you've designated. 
However, a more intriguing feature is whenever you call an already instantiated InheritedWidget, 
any widgets assigned as its dependents are rebuilt (their <b>build</b>() functions run again)---as if their <b>setState</b>()
functions were explicitly called.Now that allows for improved performance with the refresh of only specific areas of the interface.
</p>
Even the efficiency of the humble 'counter app' is greatly improved. Instead of refreshing 
the whole screen (including the StatelessWidget with its 'You have pushed the button this many times')
, when the 'Use the built-in InheritedWidget' switch is on, only the lone widget displaying the
current count is then ever rebuilt. The rest of the screen would now be left alone with every 
press of that button. Granted this is a very simple interface and possibly a bad example,
but look how easy this is implemented in the screenshot below.
<div>
  <a href="https://github.com/AndriousSolutions/fluttery_framework/assets/32497443/12dccbda-b8e6-46ca-b1d2-ddc8a134f0da"><img src="https://github.com/AndriousSolutions/fluttery_framework/assets/32497443/12dccbda-b8e6-46ca-b1d2-ddc8a134f0da" width="45%" height="50%"></a>
  <img align="right" src="https://github.com/AndriousSolutions/fluttery_framework/assets/32497443/bfb0c949-f15a-4a84-b4e9-d3e789a3e92b" width="171" height="357">
  <img align="right" src="https://github.com/AndriousSolutions/fluttery_framework/assets/32497443/9557a498-2a8b-40a4-8d49-189b5120bde4" width="171" height="357">
</div>

| [counter_app.dart](https://github.com/AndriousSolutions/fluttery_framework/blob/4dc676193914808583f111006334a91a08475b7f/example/lib/src/home/view/counter_app.dart#L41) | 
|:-------------------------------------------------------------------------------------------------------------------------------------------------------------------------|

<p>The <b>state</b>() function found only in the Fluttery Framework will allow for this immediate
improvement in efficiency. When it comes to interfaces, the less that's rebuilt, the better.
You're app is running on a mobile phone and not a Cray Supercomputer after all.
</p>
<p>Back to the app with its grid of animal pictures, you can see above when the 'new dogs' text button
is pressed, only the three 'dog pictures' are downloaded again. What your seeing are only
three portions of the screen being updated---only three widgets being rebuilt. If the whole screen was
rebuilt, all the pictures would change. Not very effective.</p>

<a target="_blank" rel="noopener noreferrer" href="https://github.com/AndriousSolutions/fluttery_framework/assets/32497443/fa7f226f-7624-49a0-9d5d-598bdb936ed8"><img src="https://github.com/AndriousSolutions/fluttery_framework/assets/32497443/fa7f226f-7624-49a0-9d5d-598bdb936ed8" width="50%" height="60%"></a>

| [counter_app.dart](https://github.com/AndriousSolutions/fluttery_framework/blob/4dc676193914808583f111006334a91a08475b7f/example/lib/src/home/grid_app_example/gridview/view/image_api.dart#L38) | 
|:-------------------------------------------------------------------------------------------------------------------------------------------------------------------------|

The screenshot above depicts one of the three widgets being assigned as a dependent to
a State object's InheritedWidget using the <b>dependOnInheritedWidget</b>() function.
In fact, the State object's controller with its own <b>dependOnInheritedWidget</b>() function
is actually used.