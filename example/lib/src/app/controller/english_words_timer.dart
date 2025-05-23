//
import 'dart:async' show Timer;

import '/src/model.dart';

import '/src/view.dart';

import 'package:fluttery_framework/controller.dart';

import 'package:english_words/english_words.dart';

///
class EnglishWordsTimer extends StateXController {
  /// Only one instance of the class is necessary and desired.
  factory EnglishWordsTimer({
    int? seconds,
    Duration? duration,
    void Function()? callback,
    int? count,
    StateX? state,
  }) =>
      _this ??= EnglishWordsTimer._(seconds, duration, callback, count, state);

  EnglishWordsTimer._(
      this.seconds, this.duration, this.callback, this.count, StateX? state)
      : model = WordPairsModel(),
        super(state);

  static EnglishWordsTimer? _this;

  ///
  final int? seconds;

  ///
  final Duration? duration;

  ///
  final void Function()? callback;

  ///
  final int? count;

  ///
  final WordPairsModel model;

  ///
  Timer? timer;

  ///
  final suggestions = <WordPair>[];

  ///
  int index = 0;

  @override
  void initState() {
    super.initState();

    /// Initialize the timer.
    _initTimer();

    model.addState(state);
  }

  /// In case the Widget is return to the Widget tree
  @override
  void activate() {
    // Create the Timer again.
    _initTimer();
  }

  /// In case this State object is unmounted from the widget tree.
  @override
  void deactivate() {
    // Cancel the timer
    _cancelTimer();
  }

  /// IMPORTANT dispose() runs late and will cancel the *new* timer
  /// Always use deactivate(). It is more reliable.
  // @override
  // void dispose() {
//  //   _appStateObject = null;
//  //   cancelTimer();
//  //   super.dispose();
  // }

  /// The application is in an inactive state and is not receiving user input.
  @override
  void inactiveAppLifecycleState() {
    // Cancel the timer
    _cancelTimer();
  }

  /// All views of an application are hidden, either because the application is
  /// about to be paused (on iOS and Android), or because it has been minimized
  /// or placed on a desktop that is no longer visible (on non-web desktop), or
  /// is running in a window or tab that is no longer visible (on the web).
  @override
  void hiddenAppLifecycleState() {
    // Cancel the timer
    _cancelTimer();
  }

  /// The application is running in the background.
  /// Only iOS and Android
  @override
  void pausedAppLifecycleState() {
    // Cancel the timer
    _cancelTimer();
  }

  /// Either be in the progress of attaching when the  engine is first initializing
  /// or after the view being destroyed due to a Navigator pop.
  /// Only iOS, Android and the Web
  @override
  void detachedAppLifecycleState() {}

  /// Called when app returns from the background
  @override
  void resumedAppLifecycleState() {
    // Create the Timer again.
    _initTimer();
  }

  /// The next route has been pushed
  @override
  void didPushNext() {
    // Cancel the timer
    _cancelTimer();
  }

  /// The next route has been popped off, and back to this route.
  @override
  void didPopNext() {
    /// Initialize the timer.
    _initTimer();
  }

  /// If the value of the object, obj, changes, this builder() is called again
  /// This allows spontaneous rebuilds here and there and not the whole screen.
  Widget get word => SetState(builder: (context, obj) {
        Widget widget;
        if (obj is String) {
          widget = Text(
            obj,
            style: TextStyle(
              color: Colors.red,
              fontSize: Theme.of(context).textTheme.headlineMedium!.fontSize,
            ),
          );
        } else {
          widget = SizedBox(height: 6.h);
        }
        return widget;
      });

  /// If the value of the object, obj, changes, this builder() is called again
  /// This allows spontaneous rebuilds here and there and not the whole screen.
  Widget get wordPair => SetState(builder: (context, obj) {
        Widget widget;
        if (obj is String) {
          widget = Text(
            obj,
            style: TextStyle(
              color: Colors.red,
              fontSize: Theme.of(context).textTheme.headlineMedium!.fontSize,
            ),
          );
        } else {
          widget = SizedBox(height: 6.h);
        }
        return widget;
      });

  // /// Alternate approach. See class _WordPair
  // Widget get wordPair => _WordPair(this);

  String _wordPair = '';

  void _getWordPair() {
    //
    try {
      final WordPair twoWords;

      if (model.saved.isNotEmpty) {
        twoWords = model.getWordPair();
      } else {
        twoWords = getWordPair();
      }

      /// Alternate approach uses inheritWidget() and setStatesInherited() functions.
      _wordPair = twoWords.asString;

      /// Change dataObject will rebuild the InheritedWidget
      /// Changing the 'dataObject' will call the SetState class implemented above
      /// and only that widget.
      appState?.dataObject = _wordPair;
    } catch (ex) {
      /// Stop the timer.
      /// Something is not working. Don't have the timer repeat it over and over.
      _cancelTimer();

      // Rethrow the error so to get processed by the App's error handler.
      rethrow;
    }
  }

  /// Supply a set of word pairs
  /// Generate a certain number of word pairs
  /// and when those are used, generate another set.
  WordPair getWordPair() {
    index++;
    if (index >= suggestions.length) {
      index = 0;
      suggestions.clear();
      suggestions.addAll(generateWordPairs().take(count ?? 10));
    }
    return suggestions[index];
  }

  bool _timerInit = false;

  /// Cancel the timer
  void _cancelTimer() {
    timer?.cancel();
    _timerInit = false;
  }

  /// Create a Timer to run periodically.
  void _initTimer() {
    // Initialize once.
    if (_timerInit) {
      return;
    }

    _timerInit = true;

    Duration duration;
    void Function()? callback;

    /// Supply a 'default' duration if one is not provided.
    if (this.duration == null) {
      int seconds;
      if (this.seconds == null) {
        seconds = 5;
      } else {
        seconds = this.seconds!;
      }
      duration = Duration(seconds: seconds);
    } else {
      duration = this.duration!;
    }

    /// Supply a 'default' callback function
    if (this.callback == null) {
      callback = _getWordPair;
    } else {
      callback = callback;
    }

    timer = Timer.periodic(duration, (timer) => callback!());
  }
}

/// Alternate approach to spontaneous rebuilds using the framework's InheritedWidget.
/// This class is assigned to the getter, wordPair.
// ignore: unused_element
class _WordPair extends StatelessWidget {
  const _WordPair(this.con);
  final EnglishWordsTimer con;
  @override
  Widget build(BuildContext context) {
    /// This is where the magic happens.
    /// This Widget becomes a dependent of an InheritedWidget deep in the framework.
    con.rootState?.dependOnInheritedWidget(context);
    return Text(
      con._wordPair, //data,
      style: TextStyle(
        color: Colors.red,
        fontSize: Theme.of(context).textTheme.headlineMedium!.fontSize,
      ),
    );
  }
}
