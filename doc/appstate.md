## _The 'Look and Feel' of your App_

This is your app's first State object. It's the 'root' State object, and it's an important State object. 
You'll be accessing this State object to 'change the state' of your whole app.
It literally defines how your app will look and behave to the user.
You should take the time to understand this class, and if you know Flutter, that'll take seconds.
That's because all its properties and parameters come from the **MaterialApp** widget and the **CupertinoApp** widget.
However, it does have some additional functions for you.
<table cellspacing="0" cellpadding="0" border="0" align="center">
  	<caption>Contents</caption>
    <tbody>
    <tr>
       <td><a href="#shrine">ShrineAppState</a></td>
       <td><a href="#inline">Inline</a></td>
       <td><a href="#parameters">Parameters</a></td>
       <td><a href="#materialApp">MaterialApp</a></td>
       <td><a href="#cupertinoApp">CupertinoApp</a></td>
       <td><a href="#widgetsApp">WidgetsApp</a></td>
      </tr>
    </tbody>
</table>

<h3>The State of Your App Should Be An Adaptive One</h3>
Instead of explicitly passing parameters values to the App's State object,
you have the option of defining a function for each and every parameter. That means, instead of having
to supply a parameter value when your app's State object is first called, the more adaptive approach of
calling a function only when required by a particular parameter can instead be used.

You'll find this ability indispensable.

Below is two screenshots the AppState class, *_ShrineAppState*, from the [Shrine Example App](https://github.com/Andrious/shrine_example_app).
In the first one, you see the **supportedLocales** parameter, for example, is passed an explicity value---a value
that must be conceived **before** the AppState object is called. However note the functions **onLocale**() and
**onTheme**() further down the screenshot. Because there is some further functionality necessary, 
both the parameters, **locale**, and **theme**, are instead supplied values from the specified functions---but only when they're needed.
A powerful capability.

<h3 id="shrine">_ShrineAppState Example</h3>

###### (Note: If a parameter is still supplied, any function is ignored. An explicit parameter takes precedence.)
<div>
<a href="https://github.com/Andrious/shrine_example_app/blob/d9b0969c40a59c2556b6a86046d20a444155c36b/lib/src/app/view/app.dart#L18"><img src="https://github.com/AndriousSolutions/fluttery_framework/assets/32497443/73cc50be-d06b-4bbc-83f1-0d330786c0d0" width="50%" height="60%"></a>
<a href="https://github.com/Andrious/shrine_example_app/blob/d9b0969c40a59c2556b6a86046d20a444155c36b/lib/src/app/view/app.dart#L18"><img align="right" src="https://github.com/AndriousSolutions/fluttery_framework/assets/32497443/11e55201-349e-4979-bd82-65914aad57dd" width="50%" height="60%"></a>
</div>

<h3 id="inline">Support for inline functions</h3>

In the second screenshot above, you'll notice the **supportedLocales** parameter in now addressed,
but it's instead using the inline function, **inSupportedLocales**, to pass a value. Like the other function, it's called **after**
the AppState object allowing your code to be more conceive, adaptive and modular. Notice in the first
screenshot, an required aspect of the **supportedLocales** feature (assigning the *L10n.translation* property)
had to be called in the State class' **initState**() function.
In the second screenshot, the process is a little more concise and called just when it's needed by
using the inline function, **inSupportedLocales**.

###### (Note: Of the two functions, the 'on' version takes precedence over the inline function.)

<h3 id="parameters">It Takes Class</h3>

As it's been stated before, the AppState class is very much an amalgamation of both the **MaterialApp** widget and the
**CupertinoApp** widget. Both widgets have pretty much the same parameters, and so you now have this one location
to define the overall 'look and feel' of your app.

Note, the **MaterialApp** does includes a few more parameters pertaining to the
app's general theme: 
[darkTheme](https://api.flutter.dev/flutter/material/MaterialApp/darkTheme.html)
, [highContrastTheme](https://api.flutter.dev/flutter/material/MaterialApp/highContrastTheme.html)
, [themeMode](https://api.flutter.dev/flutter/material/MaterialApp/themeMode.html) 
and [themeAnimationDuration](https://api.flutter.dev/flutter/material/MaterialApp/themeAnimationDuration.html).
However, both also have a 'router' version that involves you explicitly listing out specific routes (screens) to be displayed.
In fact, you'll find both **MaterialApp** and **CupertinoApp** pass on all those attributes and properties to
yet another common 'Design App' widget called, **WidgetsApp**.

There's nothing new here if you know Flutter. And if you're learning, working with the Fluttery Framework
will be a good way to learn Flutter.

<h3 id="materialApp">MaterialApp</h3>

###### (Tap on any of the parameters below to view its description right in Flutter's own source code.)
[![01MaterialApp](https://github.com/AndriousSolutions/fluttery_framework/assets/32497443/9ff0825b-a3b5-4478-ba1c-1262c3beca66)](https://github.com/flutter/flutter/blob/e1702a96f679772847459650670bbe9f04480840/packages/flutter/lib/src/material/app.dart#L207)
[![02Material](https://github.com/AndriousSolutions/fluttery_framework/assets/32497443/b81eab0b-eb09-4288-9ac6-2a99c1b8db2e)](https://github.com/flutter/flutter/blob/e1702a96f679772847459650670bbe9f04480840/packages/flutter/lib/src/widgets/framework.dart#L335)
[![03navigatorKey](https://github.com/AndriousSolutions/fluttery_framework/assets/32497443/4362a898-a88f-460e-9435-27f3078c25aa)](https://github.com/flutter/flutter/blob/e1702a96f679772847459650670bbe9f04480840/packages/flutter/lib/src/widgets/app.dart#L488)
[![04scaffoldMessengerKey](https://github.com/AndriousSolutions/fluttery_framework/assets/32497443/d135a1d9-87d0-46d0-b6c9-600d75f2d2fc)](https://github.com/flutter/flutter/blob/e1702a96f679772847459650670bbe9f04480840/packages/flutter/lib/src/material/app.dart#L318)
[![05routes](https://github.com/AndriousSolutions/fluttery_framework/assets/32497443/8bd44c00-c52a-4ee9-a304-41c0a71f9f69)](https://github.com/flutter/flutter/blob/e1702a96f679772847459650670bbe9f04480840/packages/flutter/lib/src/material/app.dart#L332)
[![06initialRoute](https://github.com/AndriousSolutions/fluttery_framework/assets/32497443/55865cff-8649-412e-998f-56909eae3ce5)](https://github.com/flutter/flutter/blob/e1702a96f679772847459650670bbe9f04480840/packages/flutter/lib/src/widgets/app.dart#L735)
[![07onGenerateRoute](https://github.com/AndriousSolutions/fluttery_framework/assets/32497443/734aefef-5077-45f2-be42-1f0f7262d690)](https://github.com/flutter/flutter/blob/e1702a96f679772847459650670bbe9f04480840/packages/flutter/lib/src/widgets/app.dart#L512)
[![08unknownRoute](https://github.com/AndriousSolutions/fluttery_framework/assets/32497443/7b6d1c8f-3847-4161-a97b-b836c4a67295)](https://github.com/flutter/flutter/blob/e1702a96f679772847459650670bbe9f04480840/packages/flutter/lib/src/widgets/app.dart#L702)
[![09navigatorObservers](https://github.com/AndriousSolutions/fluttery_framework/assets/32497443/a287c694-a0da-4cb5-953f-13c7a7d6c7ca)](https://github.com/flutter/flutter/blob/e1702a96f679772847459650670bbe9f04480840/packages/flutter/lib/src/widgets/app.dart#L747)
[![10builder](https://github.com/AndriousSolutions/fluttery_framework/assets/32497443/fe140f39-e1fd-4b7a-bb20-68d35b6953fe)](https://github.com/flutter/flutter/blob/e1702a96f679772847459650670bbe9f04480840/packages/flutter/lib/src/widgets/app.dart#L796)
[![11title](https://github.com/AndriousSolutions/fluttery_framework/assets/32497443/bc3fab6b-9192-4a0d-b68b-0d797583dc92)](https://github.com/flutter/flutter/blob/e1702a96f679772847459650670bbe9f04480840/packages/flutter/lib/src/widgets/app.dart#L809)
[![12onGenerateTitle](https://github.com/AndriousSolutions/fluttery_framework/assets/32497443/9755e317-de33-4eae-b2f0-57dfe6878ab9)](https://github.com/flutter/flutter/blob/e1702a96f679772847459650670bbe9f04480840/packages/flutter/lib/src/widgets/app.dart#L824)
[![13color](https://github.com/AndriousSolutions/fluttery_framework/assets/32497443/c6a73ad3-261f-431a-ba10-bac4157dee84)](https://github.com/flutter/flutter/blob/e1702a96f679772847459650670bbe9f04480840/packages/flutter/lib/src/widgets/app.dart#L836)
[![14theme](https://github.com/AndriousSolutions/fluttery_framework/assets/32497443/0884f3fc-f516-4cad-8282-c4565e009bf4)](https://github.com/flutter/flutter/blob/e1702a96f679772847459650670bbe9f04480840/packages/flutter/lib/src/material/app.dart#L398)
[![15darkTheme](https://github.com/AndriousSolutions/fluttery_framework/assets/32497443/ea67ff07-5c78-4db3-bd2c-1638572e5456)](https://github.com/flutter/flutter/blob/e1702a96f679772847459650670bbe9f04480840/packages/flutter/lib/src/material/app.dart#L420)
[![15highContrastTheme](https://github.com/AndriousSolutions/fluttery_framework/assets/32497443/545edecc-08fc-43d5-bfc0-84b615715387)](https://github.com/flutter/flutter/blob/e1702a96f679772847459650670bbe9f04480840/packages/flutter/lib/src/material/app.dart#L433)
[![16highContrastDarkTheme](https://github.com/AndriousSolutions/fluttery_framework/assets/32497443/f2aabe2a-3f72-4b72-bf62-5c150f72275f)](https://github.com/flutter/flutter/blob/e1702a96f679772847459650670bbe9f04480840/packages/flutter/lib/src/material/app.dart#L449)
[![17themeMode](https://github.com/AndriousSolutions/fluttery_framework/assets/32497443/19860baf-d99d-46e7-8a11-3bdddbe61d48)](https://github.com/flutter/flutter/blob/e1702a96f679772847459650670bbe9f04480840/packages/flutter/lib/src/material/app.dart#L475)
[![18themeAnimationDuration](https://github.com/AndriousSolutions/fluttery_framework/assets/32497443/2b62762d-608d-4aa2-be2a-1531e401386d)](https://github.com/flutter/flutter/blob/e1702a96f679772847459650670bbe9f04480840/packages/flutter/lib/src/material/app.dart#L489)
[![19themeAnimationCurve](https://github.com/AndriousSolutions/fluttery_framework/assets/32497443/a109ae1a-4710-4d1f-b3af-1c44b5f63bad)](https://github.com/flutter/flutter/blob/e1702a96f679772847459650670bbe9f04480840/packages/flutter/lib/src/material/app.dart#L499)
[![20locale](https://github.com/AndriousSolutions/fluttery_framework/assets/32497443/916321a3-8df3-4e8e-a06a-95d9fff79d48)](https://github.com/flutter/flutter/blob/e1702a96f679772847459650670bbe9f04480840/packages/flutter/lib/src/widgets/app.dart#L855)
[![21localizationDelegates](https://github.com/AndriousSolutions/fluttery_framework/assets/32497443/f487859b-4b3f-4ced-9424-37c5809cc092)](https://github.com/flutter/flutter/blob/e1702a96f679772847459650670bbe9f04480840/packages/flutter/lib/src/material/app.dart#L608)
[![22localListResolutionCallback](https://github.com/AndriousSolutions/fluttery_framework/assets/32497443/df00d126-e378-435c-8904-fa15510ce114)](https://github.com/flutter/flutter/blob/e1702a96f679772847459650670bbe9f04480840/packages/flutter/lib/src/widgets/app.dart#L902)
[![23localeResolutionCallback](https://github.com/AndriousSolutions/fluttery_framework/assets/32497443/5c2ab012-fa71-48b9-ae9d-bdf367f3417b)](https://github.com/flutter/flutter/blob/e1702a96f679772847459650670bbe9f04480840/packages/flutter/lib/src/widgets/app.dart#L918)
[![24supportedLocales](https://github.com/AndriousSolutions/fluttery_framework/assets/32497443/16f39402-3112-42f6-8649-ae4e7de6d46a)](https://github.com/flutter/flutter/blob/e1702a96f679772847459650670bbe9f04480840/packages/flutter/lib/src/widgets/app.dart#L987)
[![25shortcuts](https://github.com/AndriousSolutions/fluttery_framework/assets/32497443/7bfc7e3e-57e8-4d55-aaf1-10762881a1a0)](https://github.com/flutter/flutter/blob/e1702a96f679772847459650670bbe9f04480840/packages/flutter/lib/src/widgets/app.dart#L1086)
[![26actions](https://github.com/AndriousSolutions/fluttery_framework/assets/32497443/cc40b378-b84d-4990-90de-c49dabd48ce6)](https://github.com/flutter/flutter/blob/e1702a96f679772847459650670bbe9f04480840/packages/flutter/lib/src/widgets/app.dart#L1140)
[![27restorationScopeId](https://github.com/AndriousSolutions/fluttery_framework/assets/32497443/22add2fd-2020-4c4c-a288-ead044066ede)](https://github.com/flutter/flutter/blob/e1702a96f679772847459650670bbe9f04480840/packages/flutter/lib/src/widgets/app.dart#L1158)
[![28scrollBehavior](https://github.com/AndriousSolutions/fluttery_framework/assets/32497443/ecbeacb2-b6e5-4ad1-961f-e2d53cb1ffd8)](https://github.com/flutter/flutter/blob/e1702a96f679772847459650670bbe9f04480840/packages/flutter/lib/src/material/app.dart#L733)
[![29home](https://github.com/AndriousSolutions/fluttery_framework/assets/32497443/dc00af57-5a93-459c-98d2-a537a0817040)](https://github.com/flutter/flutter/blob/e1702a96f679772847459650670bbe9f04480840/packages/flutter/lib/src/widgets/app.dart#L656)
![rightParenthesis](https://github.com/AndriousSolutions/fluttery_framework/assets/32497443/db4fcdd6-3ba2-495c-9f07-bf67dfa53748)

The CupertinoApp is the 'iOS style' counterpart when it comes to the interface. The graphic below 
is that of the router version. 

<h3 id="cupertinoApp">CupertinoApp</h3>

###### (Tap on any of the parameters below to view its description right in Flutter's own source code.)
[![01CupertinoApp](https://github.com/AndriousSolutions/fluttery_framework/assets/32497443/c38f08a2-a410-486b-ac66-e72cabae6030)](https://github.com/flutter/flutter/blob/e1702a96f679772847459650670bbe9f04480840/packages/flutter/lib/src/cupertino/app.dart#L194)
[![02cupertinoKey](https://github.com/AndriousSolutions/fluttery_framework/assets/32497443/ddbb3785-a72a-494c-8107-97f0da346977)](https://github.com/flutter/flutter/blob/e1702a96f679772847459650670bbe9f04480840/packages/flutter/lib/src/widgets/framework.dart#L335)
[![03routeInformationProvider](https://github.com/AndriousSolutions/fluttery_framework/assets/32497443/72664542-8bc6-4181-b1dc-505b41c85dd9)](https://github.com/flutter/flutter/blob/e1702a96f679772847459650670bbe9f04480840/packages/flutter/lib/src/widgets/app.dart#L609)
[![04routeInformationParser](https://github.com/AndriousSolutions/fluttery_framework/assets/32497443/7769572a-c02b-43d3-a5ca-74aacc78d5a5)](https://github.com/flutter/flutter/blob/e1702a96f679772847459650670bbe9f04480840/packages/flutter/lib/src/widgets/app.dart#L560)
[![05routerDelegate](https://github.com/AndriousSolutions/fluttery_framework/assets/32497443/6d10c335-ec9c-4ada-96a3-b71753fb98e6)](https://github.com/flutter/flutter/blob/e1702a96f679772847459650670bbe9f04480840/packages/flutter/lib/src/widgets/app.dart#L576)
[![06backButtonDispatcher](https://github.com/AndriousSolutions/fluttery_framework/assets/32497443/4a82fa24-ef2c-4862-9b01-7a96f19f5a81)](https://github.com/flutter/flutter/blob/e1702a96f679772847459650670bbe9f04480840/packages/flutter/lib/src/widgets/app.dart#L591)
[![07routerConfig](https://github.com/AndriousSolutions/fluttery_framework/assets/32497443/b2f7737e-80eb-4aec-bafa-dcd1351fa85e)](https://github.com/flutter/flutter/blob/e1702a96f679772847459650670bbe9f04480840/packages/flutter/lib/src/widgets/app.dart#L623)
[![08theme](https://github.com/AndriousSolutions/fluttery_framework/assets/32497443/7f63efe5-0a81-483d-a5a9-0485a67371f8)](https://github.com/flutter/flutter/blob/e1702a96f679772847459650670bbe9f04480840/packages/flutter/lib/src/cupertino/app.dart#L246)
[![10builder](https://github.com/AndriousSolutions/fluttery_framework/assets/32497443/fe140f39-e1fd-4b7a-bb20-68d35b6953fe)](https://github.com/flutter/flutter/blob/e1702a96f679772847459650670bbe9f04480840/packages/flutter/lib/src/widgets/app.dart#L796)
[![11title](https://github.com/AndriousSolutions/fluttery_framework/assets/32497443/bc3fab6b-9192-4a0d-b68b-0d797583dc92)](https://github.com/flutter/flutter/blob/e1702a96f679772847459650670bbe9f04480840/packages/flutter/lib/src/widgets/app.dart#L809)
[![12onGenerateTitle](https://github.com/AndriousSolutions/fluttery_framework/assets/32497443/9755e317-de33-4eae-b2f0-57dfe6878ab9)](https://github.com/flutter/flutter/blob/e1702a96f679772847459650670bbe9f04480840/packages/flutter/lib/src/widgets/app.dart#L824)
[![13color](https://github.com/AndriousSolutions/fluttery_framework/assets/32497443/a5337bf3-20ea-473a-9eb2-7ba7516a3d7e)](https://github.com/flutter/flutter/blob/e1702a96f679772847459650670bbe9f04480840/packages/flutter/lib/src/widgets/app.dart#L836)
[![20locale](https://github.com/AndriousSolutions/fluttery_framework/assets/32497443/916321a3-8df3-4e8e-a06a-95d9fff79d48)](https://github.com/flutter/flutter/blob/e1702a96f679772847459650670bbe9f04480840/packages/flutter/lib/src/widgets/app.dart#L855)
[![21localizationDelegates](https://github.com/AndriousSolutions/fluttery_framework/assets/32497443/f487859b-4b3f-4ced-9424-37c5809cc092)](https://github.com/flutter/flutter/blob/e1702a96f679772847459650670bbe9f04480840/packages/flutter/lib/src/material/app.dart#L608)
[![22localListResolutionCallback](https://github.com/AndriousSolutions/fluttery_framework/assets/32497443/df00d126-e378-435c-8904-fa15510ce114)](https://github.com/flutter/flutter/blob/e1702a96f679772847459650670bbe9f04480840/packages/flutter/lib/src/widgets/app.dart#L902)
[![23localeResolutionCallback](https://github.com/AndriousSolutions/fluttery_framework/assets/32497443/5c2ab012-fa71-48b9-ae9d-bdf367f3417b)](https://github.com/flutter/flutter/blob/e1702a96f679772847459650670bbe9f04480840/packages/flutter/lib/src/widgets/app.dart#L918)
[![24supportedLocales](https://github.com/AndriousSolutions/fluttery_framework/assets/32497443/16f39402-3112-42f6-8649-ae4e7de6d46a)](https://github.com/flutter/flutter/blob/e1702a96f679772847459650670bbe9f04480840/packages/flutter/lib/src/widgets/app.dart#L987)
[![25shortcuts](https://github.com/AndriousSolutions/fluttery_framework/assets/32497443/7bfc7e3e-57e8-4d55-aaf1-10762881a1a0)](https://github.com/flutter/flutter/blob/e1702a96f679772847459650670bbe9f04480840/packages/flutter/lib/src/widgets/app.dart#L1086)
[![26actions](https://github.com/AndriousSolutions/fluttery_framework/assets/32497443/cc40b378-b84d-4990-90de-c49dabd48ce6)](https://github.com/flutter/flutter/blob/e1702a96f679772847459650670bbe9f04480840/packages/flutter/lib/src/widgets/app.dart#L1140)
[![27restorationScopeId](https://github.com/AndriousSolutions/fluttery_framework/assets/32497443/22add2fd-2020-4c4c-a288-ead044066ede)](https://github.com/flutter/flutter/blob/e1702a96f679772847459650670bbe9f04480840/packages/flutter/lib/src/widgets/app.dart#L1158)
[![28scrollBehavior](https://github.com/AndriousSolutions/fluttery_framework/assets/32497443/ecbeacb2-b6e5-4ad1-961f-e2d53cb1ffd8)](https://github.com/flutter/flutter/blob/e1702a96f679772847459650670bbe9f04480840/packages/flutter/lib/src/material/app.dart#L733)
![rightParenthesis](https://github.com/AndriousSolutions/fluttery_framework/assets/32497443/db4fcdd6-3ba2-495c-9f07-bf67dfa53748)

Again, both the **MaterialApp** and **CupertinoApp** widget pass many of their parameters on
to the widget, **WidgetsApp** (see below). This implies that there's 
nothing stopping you from writing your own 'Design App' widget. The Flutter framework
can utilize a whole new style of interface if you're so inclined to write one.

<h3 id="widgetsApp">WidgetsApp</h3>

###### (Screenshot below of CupertinoApp's **_buildWidgetApp**() function)
<a href="https://github.com/flutter/flutter/blob/e1702a96f679772847459650670bbe9f04480840/packages/flutter/lib/src/cupertino/app.dart#L563"><img src="https://github.com/AndriousSolutions/fluttery_framework/assets/32497443/79447d0a-887f-4edd-b907-5182312840c3" width="50%" height="60%"></a>