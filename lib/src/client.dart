import 'dart:async';
import 'dart:convert';
import 'dart:js_interop';
import 'package:http/http.dart' as http;
import 'package:rhymebrain/src/cache.dart';
import 'package:rhymebrain/src/parameters.dart';
import 'package:rhymebrain/src/responses.dart';

// ignore: duplicate_ignore
/// Basic client to interact with RhymeBrain.come API
///
/// ```
/// final rbclient = RhymeBrain();
/// ```
class RhymeBrain {
  Cache? cache;
  RhymeBrain({this.cache});

  /// Makes a HTTP GET request to RhymeBrain.com/talk endpoint
  ///
  /// [parameters] are encoded as URL parameters from a [RhymeBrainParameters] object
  /// ```
  /// rbclient.request(RhymeBrainParameters(word: word))
  /// ```
  request(dynamic parameters) async {
    final url = Uri.https("rhymebrain.com", "/talk", parameters.toMap());
    return (await http.get(url)).body;
  }

  /// Returns a list of [Rhyme] objects each with its own [Rhyme.word] that rhymes with [word]
  ///
  /// [lang] defaults to English and accepts an ISO639-1 standard code.
  /// [maxResults] defaults on the server side of RhymeBrain.com based on the best number of good sounding rhymes, you may set your own result count as well.
  ///
  /// ```
  /// List<Rhyme> rhymes = rbclient.getRhymes(word: "test");
  /// ```
  FutureOr<List<Rhyme>> getRhymes(RhymeParams parameters) async {
    if (cache != null) {
      var rhymes = cache?.getRhymes(parameters);
      if (!rhymes.isNull) {
        return rhymes!;
      }
    }
    final List parsed = json.decode(await request(parameters));

    final List<Rhyme> rhymes = [];

    /// Creates a new [Rhyme] object to each item on the list and adds it to rhymes
    for (var obj in parsed) {
      rhymes.add(Rhyme(
          word: obj["word"],
          score: obj["score"],
          flags: obj["flags"],
          syllables: obj["syllables"],
          freq: obj["freq"]));
    }

    if (cache != null) {
      cache?.setRhymes(parameters, rhymes);
    }

    return rhymes;
  }

  /// Gets [WordInfo] about a given [word]
  ///
  /// [lang] defaults to English and accepts ISO693-1 codes.
  /// ```
  /// WordInfo info = rbclient.getWordInfo(word: "test");
  /// ```
  FutureOr<WordInfo> getWordInfo(WordInfoParams parameters) async {
    if (cache != null) {
      var wordInfo = cache?.getWordInfo(parameters);
      if (!wordInfo.isNull) {
        return wordInfo!;
      }
    }
    final parsed = json.decode(await request(parameters));

    final wordInfo = WordInfo(
        word: parsed["word"],
        pron: parsed["pron"],
        ipa: parsed["ipa"],
        freq: parsed["freq"],
        flags: parsed["flags"]);

    if (cache != null) {
      cache?.setWordInfo(parameters, wordInfo);
    }

    return wordInfo;
  }

  /// Gets a list of [Portmanteaus]'s for a given [word]
  ///
  /// [lang] defaults to Englush and accepts ISO693-1 codes.
  /// [maxResults] defaults to the number of Portmanteaus's RhymeBrain.com can find.
  /// ```
  /// List<Portmanteaus> portmanteausList = rbclient.getPortmanteaus(word: "test");
  /// ```
  FutureOr<List<Portmanteaus>> getPortmanteaus(
      PortmanteausParams parameters) async {
    if (cache != null) {
      final portmanteaus = cache?.getPortmanteaus(parameters);
      if (portmanteaus.isNull) {
        return portmanteaus!;
      }
    }
    final parsed = json.decode(await request(parameters));

    final List<Portmanteaus> portmanteausList = [];

    for (var obj in parsed) {
      portmanteausList
          .add(Portmanteaus(source: obj["source"], combined: obj["combined"]));
    }

    if (cache != null) {
      cache?.setPortmanteaus(parameters, portmanteausList);
    }

    return portmanteausList;
  }

  /// This is technically public, and it technically works, but is not written
  /// in the API documentation directly I would use responsibly, and always
  /// credit the author, possibly reach out before using this endpoint.
  /// However, JSONB functions are noted in the docs so i believe these are just
  /// not written in, but still intended to be used.
  FutureOr<List<FuzzyRhyme>> getFuzzyRhymes(FuzzyRhymeParams parameters) async {
    final parsed = json.decode(await request(parameters));

    final List<FuzzyRhyme> fuzzyrhymes = [];

    for (var obj in parsed) {
      fuzzyrhymes.add(FuzzyRhyme(word1: obj["word1"], word2: obj["word2"]));
    }

    return fuzzyrhymes;
  }
}
