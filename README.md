<!-- https://pub.dev/packages/dartdoc -->
# Fluttery Framework
[![codecov](https://codecov.io/gh/AndriousSolutions/fluttery_framework/branch/master/graph/badge.svg)](https://codecov.io/gh/AndriousSolutions/fluttery_framework)
[![CI](https://github.com/AndriousSolutions/fluttery_framework/actions/workflows/format_test_and_relase.yml/badge.svg)](https://github.com/AndriousSolutions/fluttery_framework/actions/workflows/format_test_and_relase.yml)
[![Pub.dev](https://img.shields.io/pub/v/fluttery_framework.svg)](https://pub.dev/packages/fluttery_framework)
[![GitHub stars](https://img.shields.io/github/stars/AndriousSolutions/fluttery_framework.svg?style=social&amp;logo=github)](https://github.com/AndriousSolutions/fluttery_framework/stargazers)
[![Last Commit](https://img.shields.io/github/last-commit/AndriousSolutions/fluttery_framework)](https://github.com/AndriousSolutions/fluttery_framework/commits/master)
[![Chat](https://img.shields.io/discord/419322779851030538.svg?logo=discord)](https://discord.gg/TyPmeMc)
### A Framework for Flutter's Framework
![Fluttery_Framework](https://user-images.githubusercontent.com/32497443/185770676-89af0669-9040-4dc6-ad5b-412ed9fed5e5.jpg)
Allows for faster and easier development with better maintainability. It looks like Flutter and works like Flutter.
There's no 're-inventing of the wheel' or an extra learning curve. If you know Flutter, you'll know Fluttery Framework.  

It supplies the adaptive functions and features expected of a production-ready app:
* Flutter's own intuitive State Management
* An extended version of Flutter's State class
* A State Object Controller for this new State class
* Additional error handling capabilities
* Easy implementation of both the Material & Cupertino interface
* App-wide accessibility to system preferences
* Built-in app notifications
* A better menu bar
* Event handling for the device the app runs on
* A date picker
* A color theme picker
* An array of dialog windows
* A customizable bottom bar
* A loading screen option

### Installing
Instead of using version number suggested in the '[Installing](https://pub.dev/packages/fluttery_framework#-installing-tab-)' page, 
always go up to the '**minor**' semantic version number when installing this library package. 
This means always have a trailing zero, '**.0**'.
This allows you to take in any '**patch**' versions that involves bugfixes. 
For example, when installing version 7.9.2, use 7.9.0. That means, the bug fix, 7.9.3, will be 
installed the next time you 'upgrade' your dependencies.

## Fluttery Framework Documentation

<img align="right" src="https://github.com/AndriousSolutions/fluttery_framework/assets/32497443/46cf193f-a3cc-452b-94b2-01207ba18ea2" alt="Fluttery Framework" style="width:162px;height:208px;">

<ul style="list-style-type: none">
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

Free overview article on medium.com:

[Fluttery Framework](https://andrious.medium.com/the-fluttery-framework-35480fb834da)

As great as Flutter is, you will not create a ‘production-worthy’ app using Flutter right out of the box. 
When building a Flutter app, it’s expected to be one codebase that runs on an Android phone, 
an iOS phone, on Windows, on Linux, and or on the Web---and to do so seamlessly. 
It is to display the appropriate design interface (Material or Cupertino) depending on the platform it’s running on, 
it is to have a responsive interface that displays its information correctly no matter the screen size of the device or platform, 
and it is to fail gracefully if and when it encounters an error. 
Flutter right out of the box does not have these capabilities fully implemented.

When I first started working with Flutter, 
I began keeping modular bits of code from past projects that generally accelerated the development process. 
I’d use those again in future apps---building up a toolkit as we developers often do. 
Libraries of tried and tested bits of software that I can later put together to reliably supply a particular function or feature.

Over time, I turned to the Flutter community for such libraries, and again, 
if I didn’t find one I liked, I wrote my own. The Fluttery Framework is the result of this practice.
The Fluttery Framework uses packages, functions, and features, you will likely need in your own apps. 
It's a collection of software that's proven to be effective solutions to those capabilities required time and time again by a typical real-world app. 
It’s an amalgamation of what's great about Flutter and what the Flutter community has contributed over the last few years.

For example, if you know GetX and its many extensions, you’ll know Fluttery’s extensions as well. 
Jonny Borges, the author of GetX, did a great job providing these extensions! 
They’ve proven to be indispensable when writing a production-ready app. 
As for GetX itself, it never became my chosen approach, but I did like his extensions, 
and so I took them to be used in the Fluttery Framework…accompanied by Jonny’s MIT license of course.

The [extensions]( https://github.com/AndriousSolutions/fluttery_framework/tree/3fa2b01917cd975350068b956013eaf2ccadda90/lib/view/extensions) alone are reason enough to use this package frankly:
- extensions_view.dart
- context_extensions.dart
- double_extensions.dart
- duration_extensions.dart
- dynamic_extensions.dart
- gorouter_extension.dart
- num_extensions.dart
- string_extensions.dart
- widget_extensions.dart

As the years went by, I found packages that made my life easier and so they too were incorporated into Fluttery Framework:

- [connectivity_plus]( https://pub.dartlang.org/packages/connectivity_plus)
- [device_info_plus]( https://pub.dev/packages/device_info_plus)
- [flutter_localizations]( https://pub.dev/packages/flutter_localization)
- [flutter_material_color_picker]( https://pub.dev/packages/flutter_material_color_picker)
- [go_router]( https://pub.dev/packages/go_router) (but not before [discovering]( https://github.com/flutter/flutter/issues/123570#issuecomment-1588610299) how to fix it)
- [http](https://pub.dev/packages/http)
- [l10n_translator](https://pub.dev/packages/i10n_translator)
- [package_info_plus](https://pub.dev/packages/package_info_plus)
- [path_provider](https://pub.dev/packages/path_provider)
- [prefs](https://pub.dartlang.org/packages/prefs)
- [sizer](https://pub.dev/packages/sizer)
- [state_extended](https://pub.dartlang.org/packages/state_extended)
- [timezone](https://pub.dev/packages/timezone)
- [universal_io](https://pub.dev/packages/universal_io)
- [universal_platform](https://pub.dev/packages/universal_platform)
- [url_launcher](https://pub.dartlang.org/packages/url_launcher)
- [url_strategy](https://pub.dev/packages/url_strategy)
- [uuid](https://pub.dartlang.org/packages/uuid)
- [intl](https://pub.dev/packages/intl)

I was careful to choose only packages that fulfill the general requirements of a typical app. 
I didn’t choose those too specific and only suitable for a particular problem domain. 
This is a framework after all. It’s to serve as a ‘general framework’ for all my apps no matter how diverse each is. 
Of course, for your specific app with its specific needs, 
you then will add additional packages or write your own. 
The purpose of all this is so you supply that specific code while the Fluttery Framework supplies the rest.

Again, as a framework, it also offers a structured approach to making a production-worthy app. 
It offers a way of doing things. For we Flutter developers, a ready means to access a State object’s **setState**() function is of particular interest.
With that, Fluttery Framework's own unique contribution to this package is the concept of a ‘State Object Controller.’ 
The use of controllers are nothing new to Flutter. It uses controllers in a number of its widgets.

However, I realized that having a controller object working with a State object would only enhance the development process.
It would encourage a separation of an app’s interface from its event handling and business rules promoting a clean architecture.

The Fluttery Framework is a culmination of five years of working with Flutter.
It looks like Flutter and works like Flutter because it works with Flutter 
as well as sound Dart and Flutter packages from the Flutter community.

Enjoy.