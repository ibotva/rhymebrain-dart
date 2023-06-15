import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:rhymebrain/src/parameters.dart';
import 'package:rhymebrain/src/responses.dart';

// ignore: duplicate_ignore
/// Basic client to interact with RhymeBrain.come API
///
/// ```
/// final rbclient = RhymeBrain();
/// ```
class RhymeBrain {
  RhymeBrain();

  /// Makes a HTTP GET request to RhymeBrain.com/talk endpoint
  ///
  /// [parameters] are encoded as URL parameters from a [RhymeBrainParameters] object
  /// ```
  /// rbclient.request(RhymeBrainParameters(word: word))
  /// ```
  request(RhymeBrainParameters parameters) async {
    final url = Uri.https("rhymebrain.com", "/talk", parameters.toMap());
    return (await http.get(url)).body;
  }

  /// Returns a list [Rhyme] objects each with its own [Rhyme.word] that rhymes with [word]
  ///
  /// [lang] defaults to English and accepts an ISO639-1 standard code.
  /// [maxResults] defaults on the server side of RhymeBrain.com based on the best number of good sounding rhymes, you may set your own result count as well.
  ///
  /// ```
  /// List<Rhyme> rhymes = rbclient.getRhymes(word: "test");
  /// ```
  FutureOr<List<Rhyme>> getRhymes(
      {required String word, String lang = "en", int? maxResults}) async {
    final parameters = RhymeBrainParameters(
        word: word, function: "getRhymes", lang: lang, maxResults: maxResults);

    final List parsed = json.decode(await request(parameters));

    final List<Rhyme> rhymes = [];

    for (var obj in parsed) {
      rhymes.add(Rhyme(
          word: obj["word"],
          score: obj["score"],
          flags: obj["flags"],
          syllables: obj["syllables"],
          freq: obj["freq"]));
    }

    return rhymes;
  }

  /// Gets [WordInfo] about a given [word]
  ///
  /// [lang] defaults to English and accepts ISO693-1 codes.
  /// ```
  /// WordInfo info = rbclient.getWordInfo(word: "test");
  /// ```
  FutureOr<WordInfo> getWordInfo(
      {required String word, String lang = "en"}) async {
    final parameters =
        RhymeBrainParameters(word: word, function: "getWordInfo", lang: lang);
    final parsed = json.decode(await request(parameters));
    return WordInfo(
        word: parsed["word"],
        pron: parsed["pron"],
        ipa: parsed["ipa"],
        freq: parsed["freq"],
        flags: parsed["flags"]);
  }

  /// Gets a list of [Portmanteaus]'s for a given [word]
  ///
  /// [lang] defaults to Englush and accepts ISO693-1 codes.
  /// [maxResults] defaults to the number of Portmanteaus's RhymeBrain.com can find.
  /// ```
  /// List<Portmanteaus> portmanteausList = rbclient.getPortmanteaus(word: "test");
  /// ```
  FutureOr<List<Portmanteaus>> getPortmanteaus(
      {required String word, String lang = "en", int? maxResults}) async {
    final parameters = RhymeBrainParameters(
        word: word, function: "getPortmanteaus", maxResults: maxResults);
    final parsed = json.decode(await request(parameters));
    final List<Portmanteaus> portmanteausList = [];
    for (var obj in parsed) {
      portmanteausList
          .add(Portmanteaus(source: obj["source"], combined: obj["combined"]));
    }
    return portmanteausList;
  }

  /// This is technically public, and it technically works, but is not written
  /// in the API documentation directly I would use responsibly, and always
  /// credit the author, possibly reach out before using this endpoint.
  /// However, JSONB functions are noted in the docs so i believe these are just
  /// not written in, but still intended to be used.
  FutureOr<List<FuzzyRhyme>> getFuzzyRhymes({required String word}) async {
    final parameters =
        RhymeBrainParameters(word: word, function: "getFuzzyRhymes");
    final parsed = json.decode(await request(parameters));
    final List<FuzzyRhyme> fuzzyrhymes = [];
    for (var obj in parsed) {
      fuzzyrhymes.add(FuzzyRhyme(word1: obj["word1"], word2: obj["word2"]));
    }
    return fuzzyrhymes;
  }
}
