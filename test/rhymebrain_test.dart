import 'package:rhymebrain/rhymebrain.dart';
import 'package:test/test.dart';

void main() {
  group("Rhyme Brain Parameters Tests", () {
    setUp(() => {});
    test("Should make getRhyme parameters", () {
      Map<String, dynamic> mappedParams = {
        "word": "test",
        "function": "getRhymes"
      };
      final parameters = RhymeParams(word: "test");
      expect(parameters.toMap(), mappedParams);
      final parameters2 = RhymeParams(word: "test", maxResults: 100);
      mappedParams["maxResults"] = 100;
      expect(parameters2.toMap(), mappedParams);
    });
  });
  group('RhymeBrain Client Tests', () {
    final RhymeBrain rbclient = RhymeBrain();
    setUp(() {
      // Additional setup goes here.
    });
    print("Hello world");
    test("Should find a rhyme for 'best'", () async {
      final rhymes = await rbclient.getRhymes(RhymeParams(word: "best"));

      for (final rhyme in rhymes) {
        expect(rhyme.word, isA<String>(),
            reason: "Could not find rhyme: ${rhyme.word}");
        expect(rhyme.score, isA<int>(),
            reason: "Score is not an int: ${rhyme.score}");
        expect(rhyme.syllables, isA<int>(),
            reason: "Syllables is not an int: ${rhyme.syllables}");
        expect(rhyme.freq, isA<int>(),
            reason: "Frequency is not an int: ${rhyme.freq}");
        expect(rhyme.offensive, isA<bool>(),
            reason: "Offensive is not a boolean: ${rhyme.offensive}");
        expect(rhyme.common, isA<bool>(),
            reason: "Common is not a boolean: ${rhyme.common}");
        expect(rhyme.confident, isA<bool>(),
            reason: "Confident is not a boolean: ${rhyme.confident}");
      }
    });

    test("Should find info for the word 'best'", () async {
      final info = await rbclient.getWordInfo(WordInfoParams(word: "best"));
      expect(info.word, isA<String>(),
          reason: "Word is not a string: ${info.word}");
      expect(info.pron, isA<String>(),
          reason: "Pronunciation is not a string: ${info.pron}");
      expect(info.ipa, isA<String>(),
          reason: "Phonetic translation is not a string: ${info.ipa}");
      expect(info.freq, isA<int>(),
          reason: "Frequency is not an integer: ${info.freq}");
      expect(info.offensive, isA<bool>(),
          reason: "Offensive is not a bool: ${info.offensive}");
      expect(info.common, isA<bool>(),
          reason: "Common is not a bool: ${info.common}");
      expect(info.confident, isA<bool>(),
          reason: "Confident is not a bool: ${info.confident}");
    });

    test("Gets fuzzy rhymes for 'best'", () async {
      final fuzzyrhymes = await rbclient.getFuzzyRhymes(FuzzyRhymeParams(word: "best"));
      for (var fuzzyrhyme in fuzzyrhymes) {
        expect(fuzzyrhyme.word1, isA<String>(),
            reason: "Word one could not be found: ${fuzzyrhyme.word1}");
        expect(fuzzyrhyme.word2, isA<String>(),
            reason: "Word two could not be found: ${fuzzyrhyme.word2}");
      }
    });

    test("Gets a Portmanteaus for 'best'", () async {
      final portmanteaus = await rbclient.getPortmanteaus(PortmanteausParams(word: "best"));
      for (var p in portmanteaus) {
        expect(p.combined, isA<List<String>>());
        expect(p.source, isA<List<String>>());
      }
    });
  });
}
