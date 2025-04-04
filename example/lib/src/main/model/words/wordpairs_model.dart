//
import '/src/view.dart';

import '/src/controller.dart';

import 'package:english_words/english_words.dart';

/// Representing the data source (the model) of this App's design pattern.
class WordPairsModel extends StateXController {
  ///
  factory WordPairsModel([StateX? state]) => _this ??= WordPairsModel._(state);
  WordPairsModel._(super.state) {
    words = _EnglishWords();
    _counter = 0;
    onPressed();
  }
  static WordPairsModel? _this;

  ///
  // ignore: library_private_types_in_public_api
  late _EnglishWords words;
  late int _counter;

  int _index = 0;

  /// data for the name generator app.
  String get data => words.current.asPascalCase;

  /// First of the pair
  String get firstWord => words.current.first;

  /// Second of the pair
  String get secondWord => words.current.second;

  ///
  void onPressed() => words.build(_counter++);

  ///
  List<WordPair> get suggestions => words.suggestions;

  ///
  Set<WordPair> get saved => words.saved;

  ///
  WordPair get current => words.current;

  ///
  String get title => current.asPascalCase;

  ///
  Icon get icon => words.icon;

  ///
  Widget get trailing => icon;

  ///
  void build(int i) => words.build(i);

  ///
  Iterable<Widget> tiles({TextStyle style = const TextStyle(fontSize: 25)}) =>
      words.saved.map(
        (WordPair pair) {
          Widget widget;
          if (App.useCupertino) {
            widget = CupertinoListTile(title: Text(pair.asPascalCase));
          } else {
            widget = ListTile(
              title: Text(
                pair.asPascalCase,
                style: style,
              ),
            );
          }
          return widget;
        },
      );

  ///
  void onTap(int i) => setState(() {
        words.onTap(i);
      });

  /// Supply one of the saved word pairs
  WordPair getWordPair() {
    final list = saved.toList();
    _index++;
    if (_index >= list.length) {
      _index = 0;
    }
    return list.isEmpty ? WordPair('', '') : list[_index];
  }

  /// Return an example of 'saved' word pair
  Widget get wordPair {
    // Iterate through the saved word pairs
    final twoWords = getWordPair();
    return Text(
      twoWords.asString,
      style: TextStyle(
        color: Colors.red,
        fontSize: Theme.of(state!.context).textTheme.headlineMedium!.fontSize,
      ),
    );
  }
}

//
class _EnglishWords {
  //
  List<WordPair> get suggestions => _suggestions;
  final _suggestions = <WordPair>[];

  Set<WordPair> get saved => _saved;
  final Set<WordPair> _saved = <WordPair>{};

  int get index => _index;
  late int _index;

  void build(int i) {
    _index = i ~/ 2;
    if (_index >= _suggestions.length) {
      _suggestions.addAll(generateWordPairs().take(10));
    }
  }

  WordPair get current => _suggestions[_index];

  Icon get icon {
    final bool alreadySaved = _saved.contains(_suggestions[_index]);
    return Icon(
      alreadySaved ? Icons.favorite : Icons.favorite_border,
      color: alreadySaved ? Colors.red : null,
    );
  }

  void onTap(int i) {
    final int index = i ~/ 2;
    // ignore: unnecessary_nullable_for_final_variable_declarations
    final WordPair? pair = _suggestions[index];
    if (pair == null) {
      return;
    }
    if (_saved.contains(_suggestions[index])) {
      _saved.remove(pair);
    } else {
      _saved.add(pair);
    }
  }
}
