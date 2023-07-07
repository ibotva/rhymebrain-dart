import 'package:rhymebrain/bin/iso6391.dart';

abstract class RhymeBrainParams {
  final List<String> _validFunctions = [
    "getRhymes",
    "getWordInfo",
    "getPortmanteaus",
    "getFuzzyRhymes"
  ];

  String function;

  String word;

  RhymeBrainParams({required this.function, required this.word}) {
    if (!_validFunctions.contains(word)) {
      print("Warning: you have passed an invalid function $function");
    }
  }
}

/// Parameters class following
class RhymeBrainParameters {
  /// [word] you would like to query to RhymeBrain.com
  String word;

  /// [lang] you would like to have results queried in, represented as ISO369-1
  String? lang;

  /// [String] function name you would like to call to RhymeBrain.com
  String function;

  /// Max [int] number of results you would like return
  int? maxResults;

  /// [RhymeBrainParameters] constructor to create parameters for RhymeBrain.
  RhymeBrainParameters(
      {required this.word,
      required this.function,
      this.lang,
      this.maxResults}) {
    /// Checks if the function is listed in RhymeBrain API Documentation and warns if not.
    if (!(function == "getRhymes") &&
        !(function == "getWordInfo") &&
        !(function == "getPortmanteaus")) {
      print(
          "[WARNING]: You have not passed a valid function, this may lead to unexpected behavior.");
    }

    /// Checks if given language code is valid according to ISO639-1 and warns if not.
    if (lang != null) {
      if (!iso6391codes.containsKey(lang)) {
        print(
            "[WARNING]: You have chosen a language that does not fall standard with ISO639-1 language code, they are two letter codes.");
      }
    }
  }

  /// Converts object to a map readable as URL parameters for HTTP library.
  toMap() {
    Map<String, dynamic> map = {"function": function, "word": word};
    if (maxResults != null) {
      map["maxResults"] = maxResults!;
    }
    if (lang != null) {
      map["lang"] = lang!;
    }
    return map;
  }
}
