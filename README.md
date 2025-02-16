# Fluttery Framework
[![codecov](https://codecov.io/gh/AndriousSolutions/fluttery_framework/branch/master/graph/badge.svg)](https://codecov.io/gh/AndriousSolutions/fluttery_framework)
[![CI](https://github.com/AndriousSolutions/fluttery_framework/actions/workflows/format_test_and_relase.yml/badge.svg)](https://github.com/AndriousSolutions/fluttery_framework/actions/workflows/format_test_and_relase.yml)
[![Pub.dev](https://img.shields.io/pub/v/fluttery_framework.svg)](https://pub.dev/packages/fluttery_framework)
[![GitHub stars](https://img.shields.io/github/stars/AndriousSolutions/fluttery_framework.svg?style=social&amp;logo=github)](https://github.com/AndriousSolutions/fluttery_framework/stargazers)
[![Last Commit](https://img.shields.io/github/last-commit/AndriousSolutions/fluttery_framework)](https://github.com/AndriousSolutions/fluttery_framework/commits/master)
[![Chat](https://img.shields.io/discord/419322779851030538.svg?logo=discord)](https://discord.gg/TyPmeMc)
### A Framework for Flutter's Framework
![Fluttery_Framework](https://user-images.githubusercontent.com/32497443/185770676-89af0669-9040-4dc6-ad5b-412ed9fed5e5.jpg)
Allows for faster and easier development with better maintainability. It looks like Flutter because it works like Flutter.
There's no 're-inventing of the wheel' here.
If you know Flutter, you'll know how to use this.

It supplies the adaptive functions and features expected of a production-ready app:
* An extended State class offering a built-in FutureBuilder or InheritedWidget.
* A State Object Controller class for this State class
* A responsive interface capability from the package, Sizer
* Extensive and essential error handling
* Easy implementation of both the Material & Cupertino interface for one app
  i.e. One app with both an Android and iOS interface.
* App-wide accessibility to your app's preferences
* A better menu bar
* 27 device event-handlers
* A loading screen option

## Fluttery Framework Documentation

<img align="right" src="https://github.com/AndriousSolutions/fluttery_framework/assets/32497443/46cf193f-a3cc-452b-94b2-01207ba18ea2" alt="Fluttery Framework" style="width:162px;height:208px;">

<ul>
   <li id="started"><a href="https://pub.dev/documentation/fluttery_framework/latest/topics/Get%20started-topic.html">Get&nbsp;started</a></li>
   <li id="statex"><a href="https://pub.dev/documentation/fluttery_framework/latest/topics/StateX%20class-topic.html">StateX class</a></li>
   <li id="controller"><a href="https://pub.dev/documentation/fluttery_framework/latest/topics/State%20Object%20Controller-topic.html">State&nbsp;Object&nbsp;Controller</a></li>
   <li id="appstate"><a href="https://pub.dev/documentation/fluttery_framework/latest/topics/AppState%20class-topic.html">AppState class</a></li>
   <li id="app-prefs"><a href="https://pub.dev/documentation/fluttery_framework/latest/topics/App's%20Preferences-topic.html">App's&nbsp;Preferences</a></li>
   <li id="app-object"><a href="https://pub.dev/documentation/fluttery_framework/latest/topics/App%20object-topic.html">App object</a></li>
   <li id="error"><a href="https://pub.dev/documentation/fluttery_framework/latest/topics/Error%20handling-topic.html">Error&nbsp;handling</a></li>
   <li id="testing"><a href="https://pub.dev/documentation/fluttery_framework/latest/topics/Testing-topic.html">Testing</a></li>
   <li id="extensions"><a href="https://pub.dev/documentation/fluttery_framework/latest/topics/Extensions-topic.html">Extensions</a></li>
   <li id="device"><a href="https://pub.dev/documentation/fluttery_framework/latest/topics/Device%20Information-topic.html">Device Information</a></li>
</ul>

Free articles on Fluttery Framework:

[A Fluttery Digest](https://dev.to/andrious/a-fluttery-digest-2kb8)

As great as Flutter is, you will not create a ‘production-worthy’ app using Flutter right out of the box.
When building a Flutter app, it’s expected to be one codebase that runs on an Android phone,
an iOS phone, on Windows, on Linux, and or on the Web---and to do so seamlessly.
It is to display the appropriate design interface (Material, Cupertino, etc.) depending on the platform it’s running on,
it is to have a responsive interface that displays its information correctly no matter the screen size of the device or platform,
and it is to fail gracefully if and when it encounters an error.
Flutter right out of the box does not have these capabilities.
Until now.

When I first started working with Flutter,
I began keeping modular bits of code from past projects that generally accelerated the development process.
I would use these again and again in future apps---building up a toolkit as we developers often do.
Libraries of tried and tested bits of software that I can later put together to reliably supply a particular function or feature.
Over time, I turned to the Flutter community for such libraries, and again,
if I didn’t find one I liked, I wrote my own:
<ul>
   <li id="prefs"><a href="https://pub.dev/packages/prefs">Prefs</a></li>
   <li id="state"><a href="https://pub.dev/packages/state_set">State Set</a></li>
   <li id="db"><a href="https://pub.dev/packages/dbutils">DBUtils</a></li>
   <li id="l10n"><a href="https://pub.dev/packages/l10n_translator">l10n Translator</a></li>
   <li id="remote"><a href="https://pub.dev/packages/remote_config">Remote Config</a></li>
   <li id="extend"><a href="https://pub.dartlang.org/packages/state_extended">StateX</a></li> 
</ul>

The Fluttery Framework uses packages you will likely need in your own apps.
It's a collection of software that's proven to be effective solutions to those capabilities required time and time again by a typical real-world app.
It’s an amalgamation of what's great about Flutter and what the Flutter community has contributed over the last years.
As the years went by, I found packages that made my life easier and so they too were incorporated into the Fluttery Framework:

- [connectivity_plus]( https://pub.dartlang.org/packages/connectivity_plus)
- [device_info_plus]( https://pub.dev/packages/device_info_plus)
- [flutter_localizations]( https://pub.dev/packages/flutter_localization)
- [go_router]( https://pub.dev/packages/go_router) (but not before [discovering]( https://github.com/flutter/flutter/issues/123570#issuecomment-1588610299) how to fix it)
- [http](https://pub.dev/packages/http)
- [package_info_plus](https://pub.dev/packages/package_info_plus)
- [path_provider](https://pub.dev/packages/path_provider)
- [sizer](https://pub.dev/packages/sizer)
- [state_extended](https://pub.dev/packages/state_extended)
- [timezone](https://pub.dev/packages/timezone)
- [universal_io](https://pub.dev/packages/universal_io)
- [universal_platform](https://pub.dev/packages/universal_platform)
- [url_launcher](https://pub.dartlang.org/packages/url_launcher)
- [url_strategy](https://pub.dev/packages/url_strategy)
- [uuid](https://pub.dartlang.org/packages/uuid)

I was careful to choose only packages that fulfill the general requirements of a typical app.
After all, this is to serve as a ‘general framework’ for all my apps no matter how diverse each is.
Of course, for your specific app with its specific needs,
you then will add additional packages or write your own.
You supply the specific code; the Fluttery Framework supplies the rest.

Such a framework is to offer a structured approach to making a production-worthy app.
For we Flutter developers in particular, a ready means to access a State object’s **setState**() function is of interest.
With that, Fluttery own unique contribution to this package is the concept of a ‘State Object Controller.’
The use of controllers are nothing new to Flutter. It uses controllers in a number of its widgets.
It would encourage a separation of an app’s interface from its event handling and business rules promoting a clean architecture.
Unlike other options out there, it works with Flutter; not on top of it as a separate approach.