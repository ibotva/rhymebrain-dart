import 'package:rhymebrain/rhymebrain.dart';

class FullRhymeResponse {
  RhymeParams parameters;
  Rhyme rhyme;

  FullRhymeResponse({required this.parameters, required this.rhyme});
}

class Cache {
  List<FullRhymeResponse> rhymesResponses = [];
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
