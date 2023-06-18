/// Response part for the getRhymes function on RhymeBrain.com, this is the [Rhyme]
/// of the [word] provided
class Rhyme {
  /// The rhyming word
  String word;

  /// Scores of 300 and above are perfect rhymes, 0-300 means near rhymes or similar sounding consonents
  int score;

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

  /// This is a [Rhyme] for a queried word
  Rhyme({ required String flags,
    required String syllables,
    required this.word,
    required this.score,
    required this.freq 
    }) {
      this.syllables = int.parse(syllables);

      /// Pulls apart flags and converts them to booleans.
      offensive = flags.contains("a");
      common = flags.contains("b");
      confident = flags.contains("c");

  }
}

/// The [Portmanteaus] is a part of the response list for getPortmanteaus function
/// A portmanteaus takes your word, finds more similar words, and merges the two together
class Portmanteaus {

  /// [List] containing each [String] item within the [combined], without the commas
  /// This is meant to be an easy quality of life addition to how the data
  /// is presented.
  late List<String> source;

  /// [List] containing each [String] item within [source], without the commas.
  /// This is meant to be an easy quality of life feature.
  late List<String> combined;

  /// [Portmanteaus] is a similar word combined with provided word
  Portmanteaus({ required String source, required String combined }) {
    this.source = source.split(",");
    this.combined = combined.split(",");
  }
}

class WordInfo {

  /// The [word] you asked for info on
  String word;

  /// The pronunciation of the [word]
  String pron;

  /// The phonetic transcription of the [word], represented as a [String]
  String ipa;

  /// The [int] representing how common a [word] is with the highest value being
  /// 34 as of 6/14/23
  int? freq;


  /// [word] is offensive if true
  late bool offensive;

  /// [word] may be found in most dictionaries if true
  late bool common;

  /// The pronunciation of the [word] is known with absolute confidence if true
  late bool confident;
  WordInfo({ required String flags,
    required this.word,
    required this.pron,
    required this.ipa,
    required this.freq 
    }) {
      /// Pulls apart flags and turns them to boolean value
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
  FuzzyRhyme({ required this.word1, required this.word2 });
}
