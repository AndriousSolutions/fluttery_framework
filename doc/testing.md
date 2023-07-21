## _Testing Made Easy_
Flutter supplies the means to test your source code right away. This topic will introduce the
test files used to regularly test the Fluttery Framework package itself. 
It's hoped this overview will give you an appreciation of how easily testing your own code can be.

<table>
  	<caption>Contents</caption>
    <tbody>
      <tr>
        <td><a href="#widget_test">widget_test.dart</a></td>
        <td><a href="#tester">Test with Tester</a></td>
        <td><a href="#app">App Tests</a></td>
        <td><a href="#structure">Structured Testing</a></td>
        <td><a href="#setup">Setup Testing</a></td>
      </tr>
    </tbody>
</table>

<h3 id="widget_test">widget_test.dart</h3>

Below is a screenshot of the **widget_test.dart** file that runs every time the Fluttery Framework package
is about to be released with its latest changes. 
Much of the Fluttery Framework's functions and features are tested to assure no errors occur as a consequence any changes made.
The video below depicts that testing being performed when this Dart file is simply run in an IDE.
Both <a href="https://docs.flutter.dev/cookbook/testing/integration/introduction/">integration testing</a> as well as <a href="https://docs.flutter.dev/cookbook/testing/unit/introduction/">unit testing</a> is involved in the process.

As you see in the screenshot below, the example app's main widget, _FlutteryExampleApp_, is instantiated in the Lambda function, _testWidgets_. 
It's the very widget you'd see passed to the **runApp**() function: `void main() => runApp(FlutteryExampleApp());`.
Not only is the app started up, but its main controller, _ExampleAppController_, is assigned 
to the variable, _con_. This is done, in this case, to read its property, **.application**, so to proceed
with the integration testing of the three small example apps used to, in turn, test the Fluttery Framework package. 
<div>
  <a id="IntegrateTestVideo" target="_blank" rel="noopener noreferrer" href="https://github.com/AndriousSolutions/fluttery_framework/assets/32497443/1c97b613-3ec5-4280-bdfc-e4d97a9a636f"><img align="right" src="https://github.com/AndriousSolutions/fluttery_framework/assets/32497443/1c97b613-3ec5-4280-bdfc-e4d97a9a636f" width="277" height="579"></a>
</div>

<div>
  <a id="testWidgets" target="_blank" rel="noopener noreferrer" href="https://github.com/AndriousSolutions/fluttery_framework/assets/32497443/29f91418-6afb-4f1e-8e0d-8302fad668b1"><img src="https://github.com/AndriousSolutions/fluttery_framework/assets/32497443/29f91418-6afb-4f1e-8e0d-8302fad668b1" width="48%" height="60%"></a>
  <a id="testWidgets02" target="_blank" rel="noopener noreferrer" href="https://github.com/AndriousSolutions/fluttery_framework/assets/32497443/9ab8ee5d-831b-4cf4-a780-1f3ec8a87750"><img src="https://github.com/AndriousSolutions/fluttery_framework/assets/32497443/9ab8ee5d-831b-4cf4-a780-1f3ec8a87750" width="48%" height="60%"></a>
</div>

| [widget_test.dart](https://github.com/AndriousSolutions/fluttery_framework/blob/23f566a79506e799f7d5af602ccaccb5d3bc533f/example/integration_test/widget_test.dart#L58) |
|:-------------------------------------------------------------------------------------------------------------------------------------------|

<h3 id="tester">Test with Tester</h3>

The screenshots below displays the **counterTest**() function and the **contactsTest**() function that are eventually called in the **widget_test.dart** file.
Both take in the <a href="https://api.flutter.dev/flutter/flutter_test/WidgetTester-class.html">WidgetTester</a> object, _tester_, which serves as the active agent in the test environment performing
the virtual 'pressing of buttons', the 'swiping of screens' and all the other necessary interactions with the very widgets being tested.
The test environment also supplies a conglomerate of <a href="https://api.flutter.dev/flutter/flutter_test/Finder-class.html">Finders</a> using the constant, **find**(), 
as well as the high-level function, <a href="https://api.flutter.dev/flutter/flutter_test/expect.html">expect</a>(), to isolate and test particular widgets for expected outcomes.
If, at any point, such a test fails the whole testing process stops and reports the issue.


<div>
  <a id="contactsTest" target="_blank" rel="noopener noreferrer" href="https://github.com/AndriousSolutions/fluttery_framework/assets/32497443/5d9be4c0-eb6d-46a2-85e9-34dc475ba0c5"><img align="right" src="https://github.com/AndriousSolutions/fluttery_framework/assets/32497443/5d9be4c0-eb6d-46a2-85e9-34dc475ba0c5" width="48%" height="60%"></a>
  <a id="counterTest" target="_blank" rel="noopener noreferrer" href="https://github.com/AndriousSolutions/fluttery_framework/assets/32497443/f63eb2c2-902e-4ac3-8a16-cc6758adc25a"><img src="https://github.com/AndriousSolutions/fluttery_framework/assets/32497443/f63eb2c2-902e-4ac3-8a16-cc6758adc25a" width="48%" height="60%"></a>
</div>

| [counter_test.dart](https://github.com/AndriousSolutions/fluttery_framework/blob/23f566a79506e799f7d5af602ccaccb5d3bc533f/example/integration_test/src/tests/counter_test.dart#L7) | [contacts_test.dart](https://github.com/AndriousSolutions/fluttery_framework/blob/23f566a79506e799f7d5af602ccaccb5d3bc533f/example/integration_test/src/tests/contacts_test.dart#L6) |
|:-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|:------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------:|

<h3 id="app">App Tests</h3>

The first screenshot below highlights the **data** property referenced in the first screenshot above.
Note, because the controllers in this app use factory constructors allowing only one single instance
of a particular controller class, they can be readily used in such test environments to, in this case,
confirm the counter app has had its button pressed nine times. The CounterController object has the 
public property, _data_, incremented and then tested for the expected count.

The second screenshot is that of the **_deleteContact**() function called in the second screenshot above.
It demonstrates how you're free to use a static property from the app itself to contribute to its very testing. 
In this case, the property, **App.useMaterial**, is utilized to determine which interface design the app is current running in (Material or Cupertino).
This property comes from the [App class](https://pub.dev/documentation/fluttery_framework/latest/topics/App%20object-topic.html)
and will be available to your next app if written with the Fluttery Framework.
<div>
  <a id="contacts_delete" target="_blank" rel="noopener noreferrer" href="https://github.com/AndriousSolutions/fluttery_framework/assets/32497443/d5994b18-e1a7-4f0b-9878-65f1e659a74f"><img align="right" src="https://github.com/AndriousSolutions/fluttery_framework/assets/32497443/d5994b18-e1a7-4f0b-9878-65f1e659a74f" width="48%" height="60%"></a>
  <a id="counter_controller" target="_blank" rel="noopener noreferrer" href="https://github.com/AndriousSolutions/fluttery_framework/assets/32497443/d6b5599f-c6f5-4c14-8ab6-5c5c5df25d4a"><img src="https://github.com/AndriousSolutions/fluttery_framework/assets/32497443/d6b5599f-c6f5-4c14-8ab6-5c5c5df25d4a" width="48%" height="60%"></a>
</div>

| [counter_controller.dart](https://github.com/AndriousSolutions/fluttery_framework/blob/23f566a79506e799f7d5af602ccaccb5d3bc533f/example/lib/src/home/controller/counter_controller.dart#L20) | [contacts_test.dart](https://github.com/AndriousSolutions/fluttery_framework/blob/23f566a79506e799f7d5af602ccaccb5d3bc533f/example/integration_test/src/tests/contacts_test.dart#L108) |
|:-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|:------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------:|

<h3 id="structure">Structured Testing</h3>

There are currently some 52 test files involved with the Fluttery Framework package. 
Admittedly, not all are fully implemented, but with that number of Dart files, there had to be some organizing involved.
The screenshot below conveys the directory structure used to contain these test files.
Among these test files, there are a number of 'export' files (named with leading underscores) that collect, in a way, all of them together.

The screenshot also reveals the reams of `export` statements that can be found in one of these export files listing out the test files contained in various folders.
That file and two others are listed below for your perusal:
<br />
<a id="_unit_test_view" href="https://github.com/AndriousSolutions/fluttery_framework/blob/23f566a79506e799f7d5af602ccaccb5d3bc533f/example/integration_test/src/tests/unit/src/view/_unit_test_view.dart">_unit_test_view.dart</a>
<br />
<a id="_unit_imports" href="https://github.com/AndriousSolutions/fluttery_framework/blob/23f566a79506e799f7d5af602ccaccb5d3bc533f/example/integration_test/src/tests/unit/_unit_imports.dart">_unit_imports.dart</a>
<br />
<a id="_test_imports" href="https://github.com/AndriousSolutions/fluttery_framework/blob/23f566a79506e799f7d5af602ccaccb5d3bc533f/example/integration_test/src/_test_imports.dart">_test_imports.dart</a>.

This all follows the Dart team’s own approach to <a href="https://dart.dev/guides/libraries/create-packages#organizing-a-package">organizing a library package</a>
<div>
  <a id="_test_imports" target="_blank" rel="noopener noreferrer" href="https://github.com/AndriousSolutions/fluttery_framework/assets/32497443/f6b3ba8b-c8b9-4574-9b3b-89e16b1ef0fb"><img src="https://github.com/AndriousSolutions/fluttery_framework/assets/32497443/f6b3ba8b-c8b9-4574-9b3b-89e16b1ef0fb" width="100%" height="100%"></a>
</div>

| [_test_imports.dart](https://github.com/AndriousSolutions/fluttery_framework/blob/23f566a79506e799f7d5af602ccaccb5d3bc533f/example/integration_test/src/_test_imports.dart) |
|:-------------------------------------------------------------------------------------------------------------------------------------------|

With 'export' files, instead of your Dart files listing dozens of `import` statements, you have just one or two 'import' statement taking in all that code.
The first screenshot below, for example, lists all the code taken in by the file, _unit_tests.dart_, in the second screenshot.
As a result, just one 'import' statement is necessary to complete the unit testing here. Very nice.
<div>
  <a id="unit_tests" target="_blank" rel="noopener noreferrer" href="https://github.com/AndriousSolutions/fluttery_framework/assets/32497443/17af9c7a-bbe9-4f8a-9d68-0828d588e9d2"><img align="right" src="https://github.com/AndriousSolutions/fluttery_framework/assets/32497443/17af9c7a-bbe9-4f8a-9d68-0828d588e9d2" width="48%" height="60%"></a>
  <a id="_unit_imports" target="_blank" rel="noopener noreferrer" href="https://github.com/AndriousSolutions/fluttery_framework/assets/32497443/52d3f4ae-3c22-4a30-a70f-44680928a405"><img src="https://github.com/AndriousSolutions/fluttery_framework/assets/32497443/52d3f4ae-3c22-4a30-a70f-44680928a405" width="48%" height="60%"></a>
</div>

| [_unit_imports.dart](https://github.com/AndriousSolutions/fluttery_framework/blob/23f566a79506e799f7d5af602ccaccb5d3bc533f/example/integration_test/src/tests/unit/_unit_imports.dart#L19) | [unit_tests.dart](https://github.com/AndriousSolutions/fluttery_framework/blob/23f566a79506e799f7d5af602ccaccb5d3bc533f/example/integration_test/src/tests/unit/unit_tests.dart) |
|:----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|:------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------:|

<h3 id="setup">Setup Testing</h3>

Below are screenshots of the Fluttery Framework's <a href="https://github.com/AndriousSolutions/fluttery_framework/blob/23f566a79506e799f7d5af602ccaccb5d3bc533f/pubspec.yaml">pubspec.yaml</a> file.
You'll see highlighted the settings necessary for testing.
For example, the libraries, <a href="https://api.flutter.dev/flutter/flutter_test/flutter_test-library.html">flutter_test</a>
 and <a href="https://github.com/flutter/flutter/tree/main/packages/integration_test#integration_test">integration_test</a>, 
have to be introduced into your **pubspec.yaml** file.
Unlike Fluttery Framework, for your app, place _flutter_test_ library under the heading, `dev_dependencies:`.

<div>
  <a id="pubspec.yaml" target="_blank" rel="noopener noreferrer" href="https://github.com/AndriousSolutions/fluttery_framework/assets/32497443/f1bf56e3-e778-4346-9d4c-96e9691d24aa"><img src="https://github.com/AndriousSolutions/fluttery_framework/assets/32497443/f1bf56e3-e778-4346-9d4c-96e9691d24aa" width="48%" height="60%"></a>
  <a id="pubspec02.yaml" target="_blank" rel="noopener noreferrer" href="https://github.com/AndriousSolutions/fluttery_framework/assets/32497443/f1ff888a-7cf4-4541-b494-78aae306dfd8"><img src="https://github.com/AndriousSolutions/fluttery_framework/assets/32497443/f1ff888a-7cf4-4541-b494-78aae306dfd8" width="48%" height="60%"></a>
</div>

| [pubspec.yaml](https://github.com/AndriousSolutions/fluttery_framework/blob/23f566a79506e799f7d5af602ccaccb5d3bc533f/pubspec.yaml#L16) |                                                                                [pubspec.yaml](https://github.com/AndriousSolutions/fluttery_framework/blob/23f566a79506e799f7d5af602ccaccb5d3bc533f/pubspec.yaml#L83)                                                                                 |
|:-------------------------------------------------------------------------------------------------------------------|:---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------:|

Further documentation on setting up and getting started is available to you at flutter.dev:
<br/>
<a href="https://docs.flutter.dev/cookbook/testing/widget/introduction">An introduction to widget testing</a>
<br/>
<a href="https://docs.flutter.dev/testing">Testing Flutter apps</a>