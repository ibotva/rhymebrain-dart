import 'package:rhymebrain/rhymebrain.dart';

Future<void> run() async {
  final RhymeBrain rbclient = RhymeBrain();

  final List<Portmanteaus> portmanteausList =
      await rbclient.getPortmanteaus(PortmanteausParams(word: "test"));

  for (final portmanteau in portmanteausList) {
    /// Any word based on the original word and new source word are in this list
    print(portmanteau.combined);
    print(portmanteau.source);
  }
}

/// Here is the output for the first six responses Portmanteaus's returned
/// ```
/// [best, estimate] <- sourceSplit
/// [bestimate] <- combinedSplit
/// [best, estimated] <- sourceSplit
/// [bestimated] <- combinedSplit
/// [best, estimates] <- sourceSplit
/// [bestimates] <- combinedSplit
/// ```

void main(List<String> args) {
  run();
}
