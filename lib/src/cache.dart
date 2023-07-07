import 'package:rhymebrain/rhymebrain.dart';

class FullRhymeResponse {
  RhymeParams parameters;
  List<Rhyme> rhyme;

  FullRhymeResponse({required this.parameters, required this.rhyme});
}

class FullPortmanteausResponse {
  PortmanteausParams parameters;
  List<Portmanteaus> portmanteaus;
  FullPortmanteausResponse(
      {required this.parameters, required this.portmanteaus});
}

class FullWordInfoResponse {
  WordInfoParams parameters;
  WordInfo wordInfo;
  FullWordInfoResponse({required this.parameters, required this.wordInfo});
}

/*
/// Disabled because should not be used.
class FullFuzzyRhymeResponse {
  FuzzyRhymeParams parameters;
  FuzzyRhyme fuzzyRhyme;
  FullFuzzyRhymeResponse({required this.parameters, required this.fuzzyRhyme});
}
*/
class Cache {
  List<FullRhymeResponse> rhymesResponses = [];
  List<FullPortmanteausResponse> portmanteausResponses = [];
  List<FullWordInfoResponse> wordInfoResponses = [];
  /*
  /// Disabled because should not be used
  List<FullFuzzyRhymeResponse> fuzzyRhymeResponse = [];
  */

  DateTime refreshAt = DateTime.now();
  Duration refreshEvery;
  Cache({required this.refreshEvery}) {
    refreshAt = refreshAt.add(refreshEvery);
  }

  void _handleRefresh() async {
    if (DateTime.now().isAfter(refreshAt)) {
      rhymesResponses = [];
      portmanteausResponses = [];
      wordInfoResponses = [];
      refreshAt = DateTime.now().add(refreshEvery);
    }
  }

  void setRhymes(RhymeParams parameters, List<Rhyme> rhyme) async {
    _handleRefresh();
    rhymesResponses.add(FullRhymeResponse(parameters: parameters, rhyme: rhyme));
  }

  List<Rhyme>? getRhymes(RhymeParams parameters) {
    _handleRefresh();
    try {
      return rhymesResponses
          .firstWhere((element) => element.parameters == parameters)
          .rhyme;
    } catch (error) {
      return null;
    }
  }

  void setPortmanteaus(
      PortmanteausParams parameters, List<Portmanteaus> portmanteaus) async {
    _handleRefresh();
    portmanteausResponses.add(FullPortmanteausResponse(
        parameters: parameters, portmanteaus: portmanteaus));
  }

  List<Portmanteaus>? getPortmanteaus(PortmanteausParams parameters) {
    _handleRefresh();
    try {
      return portmanteausResponses
          .firstWhere((element) => element.parameters == parameters)
          .portmanteaus;
    } catch (error) {
      return null;
    }
  }

  void setWordInfo(WordInfoParams wordInfoParams, WordInfo wordInfo) async {
    _handleRefresh();
    wordInfoResponses.add(
        FullWordInfoResponse(parameters: wordInfoParams, wordInfo: wordInfo));
  }

  WordInfo? getWordInfo(WordInfoParams wordInfoParams) {
    _handleRefresh();
    try {
      return wordInfoResponses
          .firstWhere((element) => element.parameters == wordInfoParams)
          .wordInfo;
    } catch (error) {
      return null;
    }
  }
}
