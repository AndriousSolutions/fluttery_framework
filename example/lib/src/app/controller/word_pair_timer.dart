//
import 'dart:async';

import '/src/model.dart';

import '/src/view.dart';

import 'package:fluttery_framework/controller.dart';

import 'package:english_words/english_words.dart';

class WordPairsTimer extends StateXController {
  /// Only one instance of the class is necessary and desired.
  factory WordPairsTimer({
    int? seconds,
    Duration? duration,
    void Function()? callback,
    int? count,
    StateX? state,
  }) =>
      _this ??= WordPairsTimer._(seconds, duration, callback, count, state);

  WordPairsTimer._(
      this.seconds, this.duration, this.callback, this.count, StateX? state)
      : model = WordPairsModel(),
        super(state);

  static WordPairsTimer? _this;
  final int? seconds;
  final Duration? duration;
  final void Function()? callback;
  final int? count;
  final WordPairsModel model;

  Timer? timer;

  final suggestions = <WordPair>[];
  int index = 0;

  @override
  void initState() {
    super.initState();

    /// Initialize the timer.
    initTimer();

    model.addState(state);
  }

  /// In case this State object is unmounted from the widget tree.
  @override
  void deactivate() {
    cancelTimer();
  }

  /// IMPORTANT dispose() runs late and cancels the *new* timer
  /// deactivate() is more reliable.
  // @override
  // void dispose() {
//  //   _appStateObject = null;
//  //   cancelTimer();
//  //   super.dispose();
  // }

  @override
  Future<bool> didPopRoute() {
    cancelTimer();
    return super.didPopRoute();
  }

  /// Called when the system puts the app in the background or returns
  /// the app to the foreground.
  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    //
    if (state != AppLifecycleState.resumed) {
      /// AppLifecycleState.paused (may enter the suspending state at any time)
      /// AppLifecycleState.inactive (may be paused at any time)
      /// AppLifecycleState.suspending (Android only)
      cancelTimer();
    }
  }

  /// Called when app returns from the background
  @override
  void resumedLifecycleState() {
    /// Create the Timer again.
    initTimer();
  }

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
      rootState?.dataObject = _wordPair;
    } catch (ex) {
      /// Stop the timer.
      /// Something is not working. Don't have the timer repeat it over and over.
      cancelTimer();

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

  bool _initTimer = false;

  /// Cancel the timer
  void cancelTimer() {
    timer?.cancel();
    _initTimer = false;
  }

  /// Create a Timer to run periodically.
  void initTimer() {
    // Initialize once.
    if (_initTimer) {
      return;
    }

    _initTimer = true;

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
class _WordPair extends StatelessWidget {
  const _WordPair(this.con, {Key? key}) : super(key: key);
  final WordPairsTimer con;
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
