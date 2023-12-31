import 'package:rhymebrain/rhymebrain.dart';

Future<void> run() async {
  final rbclient = RhymeBrain();
  final rhymes = await rbclient.getRhymes(RhymeParams(word: "test", maxResults: 10));
  for (var rhyme in rhymes) {
    if (rhyme.score >= 300) {
      print(rhyme.word);
    }
  }
}

void main(List<String> args) {
  run();
}
