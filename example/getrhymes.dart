import 'package:rhymebrain/rhymebrain.dart';

Future<void> run() async {
  final RhymeBrain rbclient = RhymeBrain();

  final List<Rhyme> rhymes = await rbclient.getRhymes(RhymeParams(word: "test", maxResults: 10));

  for (final rhyme in rhymes) {

    /// The rhyming word [String]
    print(rhyme.word);
    
    /// Score of how close of a rhyme it is [int]
    /// 300+ is a perfect rhyme
    /// 0-300 is a near-perfect rhyme or consonant
    print(rhyme.score);

    /// Frequency tells how common the word is based on common texts [int]
    /// Max value as of 6/14/23 is 34.
    print(rhyme.freq);

    /// The estimated number of syllables in the rhyming word [int]
    print(rhyme.syllables);

    /// Boolean describing whether the rhyming word is offensive [bool]
    print(rhyme.offensive);

    /// Boolean describing whether the rhyming word is found in most dictionaries [bool]
    print(rhyme.common);

    /// Boolean describing whether RhymeBrain is confident in their pronunciation
    print(rhyme.confident);
  }
}

/// This is the output for the first item in the Rhyme list.
/// ```
/// test <- word
/// 300 <- score
/// 25 <- freq
/// 1 <- syllables
/// false <- offensive
/// true <- common
/// true <- confident
/// ```
void main(List<String> args) {
  run();
}
