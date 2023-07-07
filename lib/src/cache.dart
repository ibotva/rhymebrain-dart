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
  List<FullPortmanteausResponse> portmanteausResponse = [];
  List<FullWordInfoResponse> wordInfoResponse = [];
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
      refreshAt = DateTime.now().add(refreshEvery);
    }
  }

  void setRhymes(FullRhymeResponse response) {
    _handleRefresh();
    rhymesResponses.add(response);
  }

  Rhyme? getRhymes(RhymeParams parameters) {
    for (var val in rhymesResponses) {
      if (val.parameters == parameters) {
        return val.rhyme;
      }
    }
    return null;
  }
}
