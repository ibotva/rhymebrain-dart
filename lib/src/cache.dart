import 'dart:js_interop';

import 'package:rhymebrain/rhymebrain.dart';

class FullRhymeResponse {
  RhymeParams parameters;
  Rhyme rhyme;

  FullRhymeResponse({required this.parameters, required this.rhyme});
}

class FullPortmanteausResponse {
  PortmanteausParams parameters;
  Portmanteaus portmanteaus;
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

  void _handleRefresh() {
    if (DateTime.now().isAfter(refreshAt)) {
      rhymesResponses = [];
      portmanteausResponses = [];
      wordInfoResponses = [];
      refreshAt = DateTime.now().add(refreshEvery);
    }
  }

  void setRhymes(FullRhymeResponse response) {
    _handleRefresh();
    rhymesResponses.add(response);
  }

  Rhyme? getRhymes(RhymeParams parameters) {
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
      PortmanteausParams parameters, Portmanteaus portmanteaus) {
    _handleRefresh();
    portmanteausResponses.add(FullPortmanteausResponse(
        parameters: parameters, portmanteaus: portmanteaus));
  }

  Portmanteaus? getPortmanteaus(PortmanteausParams parameters) {
    _handleRefresh();
    try {
      return portmanteausResponses
          .firstWhere((element) => element.parameters == parameters)
          .portmanteaus;
    } catch (error) {
      return null;
    }
  }

  void setWordInfo(WordInfoParams wordInfoParams, WordInfo wordInfo) {
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
