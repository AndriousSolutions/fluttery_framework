//
import '../../_test_imports.dart';

import 'package:english_words/english_words.dart';

const _location = '========================== wordpairs_model.dart';

Future<void> wordPairsModelTest(WidgetTester tester) async {
  // debugPrint('====================== Unit Testing WordPairsModel ');
  final model = WordPairsModel();
  final data = model.data;
  expect(data, isInstanceOf<String>(), reason: _location);
  // debugPrint('data: $data $_location');
  final wordPair = model.current;
  expect(wordPair, isInstanceOf<WordPair>(), reason: _location);
  // debugPrint('wordPair.asString: ${wordPair.asString} $_location');
  final suggestions = model.suggestions;
  expect(suggestions, isInstanceOf<List<WordPair>>(), reason: _location);
}
