/// Response part for the getRhymes function on RhymeBrain.com, this is the [Rhyme]
/// of the [word] provided
class Rhyme {
  /// The rhyming word
  String word;

  /// Scores of 300 and above are perfect rhymes, 0-300 means near rhymes or similar sounding consonents
  int score;

  /// String containing the flags that are later converted to [common], [offensive], and [confident]
  String flags;

  /// [syllables] contains estimated number of syllables in [word]
  late int syllables;

  /// Integer that tells you how common the [word] is based on logarithm of frequency of usage in common texts, with the highest possible value as of 6/14/23 is 34.
  int freq;

  /// [word] is offensive if true
  late bool offensive;

  /// [word] may be found in most dictionaries if true
  late bool common;

  /// The pronunciation of the word is known with absolute confidence if true
  late bool confident;
  Rhyme(
      {required this.word,
      required this.score,
      required this.flags,
      required syllables,
      required this.freq}) {
    this.syllables = int.parse(syllables);
    offensive = flags.contains("a");
    common = flags.contains("b");
    confident = flags.contains("c");
  }
}

/// The [Portmanteaus] is a part of the response list for getPortmanteaus function
/// A portmanteaus takes your word, finds more similar words, and merges the two together
class Portmanteaus {

  /// Raw API response for source, a string separated with commans, with the 
  /// given argument wor and the word found by RhymeBrain in said String.
  String source;

  /// Raw API response for the combined strings, (or Portmanteaus) of said source,
  /// This is also separated by commas occassionally, when the API is able to 
  /// generate multiple Portmanteaus
  String combined;

  /// [List] containing each item within the [combined], without the commas
  /// This is meant to be an easy quality of life addition to how the data
  /// is presented.
  late List<String> combinedSplit;

  /// [List] containing each item within [source], without the commas.
  /// This is meant to be an easy quality of life feature.
  late List<String> sourceSplit;

  /// [Portmanteaus] is a similar word combined with provided word
  /// Examples:
  /// ```dart
  /// ```
  Portmanteaus({required this.source, required this.combined}) {
    combinedSplit = combined.split(",");
    sourceSplit = source.split(",");
  }
}

class WordInfo {
  String word;
  String pron;
  String ipa;
  int? freq;
  String flags;

  /// Word is offensive if true
  late bool offensive;

  /// Word may be found in most dictionaries if true
  late bool common;

  /// The pronunciation of the word is known with absolute confidence if true
  late bool confident;
  WordInfo(
      {required this.word,
      required this.pron,
      required this.ipa,
      required this.freq,
      required this.flags}) {
    offensive = flags.contains("a");
    common = flags.contains("b");
    confident = flags.contains("c");
  }
}

class FuzzyRhyme {
  String word1;
  String word2;

  /// [FuzzyRhyme] is a part of the list returned by the getFuzzyRhyme function
  /// on the RhymeBrain.com API
  FuzzyRhyme({required this.word1, required this.word2});
}
