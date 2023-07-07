
import 'package:rhymebrain/bin/iso6391.dart';

/// This is a list of [_validFunctions] within RhymeBrain.com
final List<String> _validFunctions = [
  "getRhymes",
  "getWordInfo",
  "getPortmanteaus",
  "getFuzzyRhymes"
];

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

/// Parameters class for getRhymes function.
class RhymeParams extends RhymeBrainParams {
  String lang;
  int? maxResults;

  /// ```
  ///  GetRhymeParams(
  ///   word: "test",
  ///   lang?: "en",
  ///   maxResults?: 30
  /// )
  /// ```
  RhymeParams({
    required String word,
    this.lang = "en",
    this.maxResults,
  }) : super(function: _validFunctions[0], word: word) {
    _langWarningHandler(lang);
  }

  /// Returns [Map] that HTTP lib can read.
  
  toMap() {
    return _toMap(maxResults: maxResults, lang: lang);
  }
}

class WordInfoParams extends RhymeBrainParams {
  String lang;

  WordInfoParams({required String word, this.lang = "en"})
      : super(function: _validFunctions[1], word: word) {
    _langWarningHandler(lang);
  }

  /// Returns [Map] that HTTP lib can read.
  
  toMap() {
    return _toMap(lang: lang);
  }
}

class PortmanteausParams extends RhymeBrainParams {
  String lang;
  int? maxResults;

  PortmanteausParams(
      {required this.lang, this.maxResults, required String word})
      : super(function: _validFunctions[2], word: word) {
    _langWarningHandler(lang);
  }

  /// Returns [Map] that HTTP lib can read.
  
  toMap() {
    return _toMap(lang: lang, maxResults: maxResults);
  }
}

class FuzzyRhymeParams extends RhymeBrainParams {
  FuzzyRhymeParams({required String word})
      : super(function: _validFunctions[3], word: word);
    
  
  Map<String, dynamic> toMap() {
    return _toMap();
  }
}