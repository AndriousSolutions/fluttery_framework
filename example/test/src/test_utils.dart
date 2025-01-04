//
import '_test_imports.dart';

String _errorMessage = '';

void collectError(Object error) {
  //
  _errorMessage = '$_errorMessage${error.toString()}';
}

/// Throw an Exception if there are a collection of errors.
void reportTestErrors() {
  //
  if (_errorMessage.isNotEmpty) {
    //
    throw Exception(_errorMessage);
  }
}

/// Tap the specified widget referenced by a Kay value
Future<bool> tapButton(WidgetTester tester,
    {String? key, bool? skipOffstage, int? count, String? keyUntil}) async {
  //
  bool tap = key != null && key.isNotEmpty;

  if (!tap) {
    return false;
  }

  var finder = find.byKey(Key(key), skipOffstage: skipOffstage ?? true);

  tap = finder.evaluate().isNotEmpty;

  if (!tap) {
    return false;
  }

  var until = keyUntil != null && keyUntil.isNotEmpty;

  if (until) {
    //
    while (until) {
      //
      await tester.tap(finder);

      await tester.pumpAndSettle();

      finder = find.byKey(Key(keyUntil));

      tap = finder.evaluate().isNotEmpty;

      if (tap) {
        break;
      }

      finder = find.byKey(Key(key));

      until = finder.evaluate().isNotEmpty;
    }

    ///
    if (tap) {
      //
      await tester.tap(finder);
      await tester.pumpAndSettle();
    }
  } else {
    //
    count ??= 0;

    if (count > 20) {
      count = 20;
    }

    for (var cnt = 0; cnt <= count; cnt++) {
      await tester.tap(finder);
      await tester.pumpAndSettle();
    }
  }
  return tap;
}
