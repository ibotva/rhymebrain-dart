import 'package:rhymebrain/bin/iso6391.dart';

/// This is a list of [_validFunctions] within RhymeBrain.com
final List<String> _validFunctions = [
  "getRhymes",
  "getWordInfo",
  "getPortmanteaus",
  "getFuzzyRhymes"
];

const String defaultLanguageCode = "en";

_langWarningHandler(String lang) async {
  if (!iso6391codes.containsKey(lang)) {
    print("Warning: You have chosen an invalid language code $lang");
  }
}

abstract class RhymeBrainParams {
  /// The function to be queried.
  String function;

  /// The word to be queried.
  String word;

  RhymeBrainParams({required this.function, required this.word}) {
    if (!_validFunctions.contains(word)) {
      print("Warning: you have passed an invalid function $function");
    }
  }

  Map<String, dynamic> _toMap({int? maxResults, String? lang}) {
    Map<String, dynamic> map = {"function": function, "word": word};
    if (maxResults != null) {
      map["maxResults"] = maxResults;
    }
    if (lang != null) {
      map["lang"] = lang;
    }
    return map;
  }
}

/// [RhymeParams] builds parameters for rhymebrain api
class RhymeParams extends RhymeBrainParams {
  /// ISO639-1 Language Code
  String lang;

  /// Max number of results to return.
  int? maxResults;

  /// [word] is the word you would like queried
  /// [lang] is an ISO369-1 code, and defaults to "en" (English)
  /// [maxResults] OPTIONAL max number of results to return.
  ///
  /// ```
  /// RhymeParams(
  ///   word: "test",
  ///   maxResults: 100
  /// );
  /// ```
  RhymeParams({
    required String word,
    this.lang = defaultLanguageCode,
    this.maxResults,
  }) : super(function: _validFunctions[0], word: word) {
    _langWarningHandler(lang);
  }

  /// Returns [Map] that HTTP lib can read.
  toMap() {
    return _toMap(maxResults: maxResults, lang: lang);
  }
}

/// [WordInfoParams] creates parameters for rhymebrain api
class WordInfoParams extends RhymeBrainParams {
  /// ISO639-1 Language Code
  String lang;

  /// [word] is the word you would like queried
  /// [lang] is an ISO369-1 code, and defaults to "en" (English)
  ///
  /// ```
  /// WordInfoParams(
  ///   word: "test"
  /// );
  /// ```
  WordInfoParams({required String word, this.lang = defaultLanguageCode})
      : super(function: _validFunctions[1], word: word) {
    _langWarningHandler(lang);
  }

  /// Returns [Map] that HTTP lib can read.
  toMap() {
    return _toMap(lang: lang);
  }
}

/// [PortmanteausParams] creates parameters for rhymebrain api
class PortmanteausParams extends RhymeBrainParams {
  /// ISO639-1 Language Code
  String lang;

  /// Max results to return
  int? maxResults;

  /// [lang] is an ISO369-1 code, and defaults to "en" (English)
  /// [maxResults] OPTIONAL max ammount of results to return
  /// [word] is the word you would like to query
  ///
  /// ```
  /// PortmanteausParams(maxResults: 100, word: "test");
  /// ```
  PortmanteausParams(
      {this.lang = defaultLanguageCode, this.maxResults, required String word})
      : super(function: _validFunctions[2], word: word) {
    _langWarningHandler(lang);
  }

  /// Returns [Map] that HTTP lib can read.
  toMap() {
    return _toMap(lang: lang, maxResults: maxResults);
  }
}

/// This is for fuzzy rhymes, this is non-official
/// and I advise against the use of it without
/// prior permission from RhymeBrain.com
class FuzzyRhymeParams extends RhymeBrainParams {
  /// [word] is the word you would like queried
  ///
  /// ```
  /// FuzzyRhymeParams(word: "test");
  /// ```
  FuzzyRhymeParams({required String word})
      : super(function: _validFunctions[3], word: word);

  /// Returns [Map] that HTTP lib can read.
  Map<String, dynamic> toMap() {
    return _toMap();
  }
}
