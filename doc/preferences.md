# System preferences accessed system-wide.
## _What's Your Preference?_

Preserving your app's preferences is such a common feature found in apps, the [Shared Preferences](https://pub.dev/packages/shared_preferences)
plugin and its capability is now ingrained in the Fluttery Framework. An array of static functions defined in the library, [Prefs](https://pub.dev/packages/prefs/),
now works with this plugin to retain, for example, your personal preferences the next time you start up your app.
Being static, they are available to you throughout your app.
You can call the appropriate static function anywhere and at anytime.

<table>
  	<caption>Contents</caption>
    <tbody>
      <tr>
        <td><a href="#locale">Your Preferred Locale</a></td>
        <td><a href="#settings">A Simple Single Settings Class</a></td>
        <td><a href="#initialize">Initialize Your Preferences</a></td>
        <td><a href="#test">Test Your Preferences</a></td>
      </tr>
    </tbody>
</table>

<h3 id="locale">Your Preferred Locale</h3>

As an example, the [Shrine Example App](https://github.com/Andrious/shrine_example_app) determines its current Locale at start up with
the use of the [AppState](https://pub.dev/documentation/fluttery_framework/latest/topics/AppState%20class-topic.html) class.
In the first screenshot below, the **onLocale**() function from the AppState class is utilized, 
and in turn, calls the static function, **Prefs.getString**().
In the second screenshot, you see where the Locale can actually be changed by the user.
And so, the next time the app is started up, a new Locale may instead be used.
All easily done by using the static functions found in the **Prefs** class.

<div>
  <a id="setLocale" target="_blank" rel="noopener noreferrer" href="https://github.com/Andrious/shrine_example_app/assets/32497443/99e5fe9f-6670-4d3d-bc52-fe648530e4fe"><img align="right" src="https://github.com/Andrious/shrine_example_app/assets/32497443/99e5fe9f-6670-4d3d-bc52-fe648530e4fe" width="48%" height="60%"></a>
  <a id="onLocale" target="_blank" rel="noopener noreferrer" href="https://github.com/Andrious/shrine_example_app/assets/32497443/080df2b9-cca1-4ba7-af59-6e38672b1293"><img src="https://github.com/Andrious/shrine_example_app/assets/32497443/080df2b9-cca1-4ba7-af59-6e38672b1293" width="48%" height="60%"></a>
</div>

| [app.dart](https://github.com/Andrious/shrine_example_app/blob/a508b98cf76b408012ab77316fc1a77c37b56192/lib/src/app/view/app.dart#L54) | [backdrop.dart](https://github.com/Andrious/shrine_example_app/blob/a35a3fc05a1433dc91c2ba417507ecccb7616eb5/lib/src/home/view/backdrop.dart#L346) |
|:---|:---:|

<h3 id="settings">A Simple Single Settings Class</h3>

In practice, however, it's not generally wise to look up the same preference setting in two separate regions of your app.
For example, the string key parameter, 'locale', in the sample code above will not be easily maintained being located in two separate Dart files. 

The screenshot below is of one specific class called, **Settings**. It's responsible for its apps overall settings and user preferences.
The **Pref** class, and its distinct set of string key parameters are all found and maintained in that class---in that one Dart file.
All those string key parameters can then be easily changed and maintained since they're all in one place.
The **Pref** class with its static function gives you indeed great capability and so must be used wisely.  
![flutteryPrefs](https://github.com/Andrious/shrine_example_app/assets/32497443/8ac09b7b-54d5-424a-abb3-e4e3ebd7bfc4)

| [settings.dart](https://github.com/Andrious/workingmemory/blob/b7fdd7912ef790c2a1f2bf24bc2bc3e6d1597976/lib/src/home/model/settings.dart#L37) |
|:---|

<h3 id="initialize">Initialize Your Preferences</h3>

Again, we're working with the [Shared Preferences](https://pub.dev/packages/shared_preferences) plugin here,
and it works with all the platforms currently supported by Flutter:

**Android**, **iOS**, **Linux**, **macOS**, **Web** and **Windows**

With that, it takes a little time to ready the platform-specific mechanism involved in persistent storage.
Therefore, your app must wait for the plugin to initialize and its class object instantiated:

`_prefsInstance ??= await SharedPreferences.getInstance();`

However, let the Fluttery Framework worry about that. When starting up, the Fluttery Framework will initialize a number
of things for your app to use: 

**system preferences**
<br />
**general theme** (look and behavior)
<br />
**connectivity status**
<br />
**[device information](https://pub.dev/documentation/fluttery_framework/latest/topics/Device%20Information-topic.html)**

The first screenshot below is that of the Fluttery Framework's **[_StateApp](https://pub.dev/documentation/fluttery_framework/latest/topics/AppState%20class-topic.html)** class and its **initAsync**() function.
This class extends the [StateX](https://pub.dev/documentation/fluttery_framework/latest/topics/StateX%20class-topic.html) class, 
and this function is like the **initState**() function in the **State** class, but returns a Future after any asynchronous operations completes.
The second screenshot displays the **Prefs** class and its **init**() function called in the first screenshot. 

<a target="_blank" rel="noopener noreferrer" href="https://github.com/AndriousSolutions/fluttery_framework/assets/32497443/3d89d4a8-558d-42b6-81d0-a0bb79227a76"><img align="right" src="https://github.com/AndriousSolutions/fluttery_framework/assets/32497443/3d89d4a8-558d-42b6-81d0-a0bb79227a76" width="48%" height="60%"></a>
<a target="_blank" rel="noopener noreferrer" href="https://github.com/AndriousSolutions/fluttery_framework/assets/32497443/628f8159-d4ff-42e7-9dd1-dc4e3f358d4a"><img src="https://github.com/AndriousSolutions/fluttery_framework/assets/32497443/628f8159-d4ff-42e7-9dd1-dc4e3f358d4a" width="48%" height="60%"></a>

| [app_statefulwidget.dart](https://github.com/AndriousSolutions/fluttery_framework/blob/master/lib/view/app_statefulwidget.dart#L101) | [prefs.dart](https://github.com/AndriousSolutions/prefs/blob/3e53e445e61a559b7064cab57bb1fcdfc607ad0e/lib/prefs.dart#L45) |
|:---|:-----------------------------------------------------------------------------------------------------------------------------------------------:|

<h3 id="test">Test Your Preferences</h3>

Below is a routine that uses Flutter's testing library, **flutter_test.dart**, to put the **Prefs** library through its paces. 
Review the code, and you'll get readily acquainted with all the functions and features available to you.

###### (Copy & paste and try it out.)
```Dart 
import 'package:flutter_test/flutter_test.dart';

import 'package:prefs/prefs.dart';

const _location = '========================== prefs_unit_tests.dart';

void main() => prefsUnitTests();

Future<void> prefsUnitTests() async {
  //
  testWidgets('Prefs class properties', (tester) async {
    //
    bool set = Prefs.setPrefix('felix');

    expect(set, isTrue, reason: _location);

    //
    bool ready = Prefs.ready();

    expect(ready, isFalse, reason: _location);

    SharedPreferences prefs = await Prefs.instance;

    expect(prefs, isA<SharedPreferences>(), reason: _location);

    set = Prefs.setPrefix('test');

    expect(set, isFalse, reason: _location);

    //
    set = Prefs.initCalled();

    expect(set, isFalse, reason: _location);

    //
    prefs = await Prefs.init();

    expect(prefs, isA<SharedPreferences>(), reason: _location);

    //
    set = Prefs.initCalled();

    expect(set, isTrue, reason: _location);
    
    //
    prefs = await Prefs.initAsync();

    expect(prefs, isTrue, reason: _location);

    //
    set = await Prefs.setString('stringKey', 'Hello World!');

    expect(set, isTrue, reason: _location);

    String string = await Prefs.getStringF('stringKey');

    expect(string, 'Hello World!', reason: _location);

    string = Prefs.getString('stringKey');

    expect(string, 'Hello World!', reason: _location);

    //
    set = await Prefs.setInt('integerKey', 12);

    expect(set, isTrue, reason: _location);

    int integer = await Prefs.getIntF('integerKey');

    expect(integer, 12, reason: _location);

    integer = Prefs.getInt('integerKey');

    expect(integer, 12, reason: _location);

    //
    set = await Prefs.setDouble('doubleKey', 15.3);

    expect(set, isTrue, reason: _location);

    double num = await Prefs.getDoubleF('doubleKey');

    expect(num, 15.3, reason: _location);

    num = Prefs.getDouble('doubleKey');

    expect(num, 15.3, reason: _location);

    set = await Prefs.setBool('booleanKey', true);

    bool boolean = await Prefs.getBoolF('booleanKey');

    expect(boolean, isTrue, reason: _location);

    boolean = Prefs.getBool('booleanKey');

    expect(boolean, isTrue, reason: _location);

    Object? object;

    object = await Prefs.getF('doubleKey');

    expect(object, 15.3, reason: _location);

    object = Prefs.get('integerKey');

    expect(object, 12, reason: _location);

    Set<String> keys = await Prefs.getKeysF();

    expect(keys.contains('integerKey'), isTrue, reason: _location);

    keys = Prefs.getKeys();

    expect(keys.contains('doubleKey'), isTrue, reason: _location);

    bool contains = Prefs.containsKey('integerKey');

    expect(contains, isTrue, reason: _location);

    contains = await Prefs.containsKeyF('doubleKey');

    expect(contains, isTrue, reason: _location);

    set = await Prefs.setStringList('listKey', ['One', 'Two', 'Three']);

    List<String> keyList = await Prefs.getStringListF('listKey');

    keyList = Prefs.getStringList('listKey');

    expect(keyList.contains('Two'), isTrue, reason: _location);

    /// Fetches the latest values from the host platform.
    await Prefs.reload();

    set = await Prefs.remove('integerKey');

    expect(set, isTrue, reason: _location);

    contains = Prefs.containsKey('integerKey');

    expect(contains, isFalse, reason: _location);

    set = await Prefs.clear();

    expect(set, isTrue, reason: _location);

    keyList = Prefs.getStringList('listKey');

    expect(keyList[0], '', reason: _location);

    Prefs.dispose();

    ready = Prefs.ready();

    expect(ready, isFalse, reason: _location);
  });
}
```