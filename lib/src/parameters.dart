import 'package:rhymebrain/bin/iso6391.dart';

class RhymeBrainParameters {
  String word;
  String? lang;
  String function;
  int? maxResults;

  RhymeBrainParameters(
      {required this.word,
      this.lang,
      required this.function,
      this.maxResults}) {
    if (!(function == "getRhymes") &&
        !(function == "getWordInfo") &&
        !(function == "getPortmanteaus")) {
      print(
          "[WARNING]: You have not passed a valid function, this may lead to unexpected behavior.");
    }
    if (lang != null) {
      if (!iso6391codes.containsKey(lang)) {
        print(
            "[WARNING]: You have chosen a language that does not fall standard with ISO639-1 language code, they are two letter codes.");
      }
    }
  }

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


