import 'package:rhymebrain/rhymebrain.dart';

run() async {
  final RhymeBrain rbclient = RhymeBrain();
  final WordInfo info = await rbclient.getWordInfo(WordInfoParams(word: "test"));
  /// The word that you queried, in this case "best"
  print(info.word);

  /// Frequency tells how common the word is based on common texts [int]
  /// Max value as of 6/14/23 is 34.
  print(info.freq);

  /// Phonetic translation of word, in International Phonetic Alphabet
  print(info.ipa);

  /// Pronunciation of the word
  print(info.pron);

  /// Boolean describing whether the rhyming word is offensive [bool]
  print(info.offensive);

  /// Boolean describing whether the rhyming word is found in most dictionaries [bool]
  print(info.common);

  /// Boolean describing whether RhymeBrain is confident in their pronunciation
  print(info.confident);
}

/// Output of that code is as follows:
/// ```
/// best <- word
/// 26 <- freq
/// ˈbɛst <- ipa
/// B EH1 S T <- pron
/// false <- offensive
/// true <- common
/// true <- confident
/// ```

void main(List<String> args) {
  run();
}
