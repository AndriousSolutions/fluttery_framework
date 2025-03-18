//
import '_tests_xport.dart';

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
    {String? key, bool? skipOffstage, int? repeat, String? keyUntil}) async {
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
    repeat ??= 0;

    if (repeat > 20) {
      repeat = 20;
    }

    for (var cnt = 0; cnt <= repeat; cnt++) {
      await tester.tap(finder);
      await tester.pumpAndSettle();
    }
  }
  return tap;
}

/// Push appropriate Back Button
Future<bool> tapBackButtonTester(WidgetTester tester) => tapButtonTester(tester,
    icon:
        App.useMaterial ? Icons.arrow_back : Icons.arrow_back_ios_new_rounded);

/// Tap a button found by a Key, by icon, or by specified Type.
Future<bool> tapButtonTester(
  WidgetTester tester, {
  String? key,
  IconData? icon,
  Type? type,
  bool? skipOffstage, // skip those widgets hidden from view
  int? repeat,
}) async {
  Finder? finder;

  skipOffstage ??= true;

  var push = key != null;

  if (push) {
    key = key.trim();
    push = key.isNotEmpty;
    if (push) {
      finder = find.byKey(Key(key), skipOffstage: skipOffstage);
    }
  }

  if (!push) {
    push = icon != null;
    if (push) {
      finder = find.byIcon(icon, skipOffstage: skipOffstage);
    }
  }

  if (!push) {
    push = type != null;
    if (push) {
      finder = find.byType(type, skipOffstage: skipOffstage);
    }
  }

  if (push) {
    push = finder!.evaluate().isNotEmpty;
  }

  // Tap that button.
  if (push) {
    repeat ??= 1;
    repeat = repeat.abs();
    try {
      for (var cnt = 1; cnt <= repeat; cnt++) {
        await tester.tap(finder!);
        await tester.pumpAndSettle();
      }
    } catch (e) {
      push = false;
    }
  }
  return push;
}
