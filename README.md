# RhymeBrain.com API wrapper [![Dart](https://github.com/ibotva/rhymebrain-dart/actions/workflows/dart.yml/badge.svg)](https://github.com/ibotva/rhymebrain-dart/actions/workflows/dart.yml)
This is a API wrapper for RhymeBrain.com written in the Dart programming language, its intended to be a free and easy way to get rhymes for a word using dart. 

Warning: This package does not have a stable version yet, it may not work as intended, please submit an issue if something is wrong with it, it needs more organized and concise documentation as well.

## Features

- Get Rhymes of a word
- Get Portmanteaus's of a word
- Get Info for a word

## Future Features

- Cache

## Getting started

> Note: According to [RhymeBrain Documentation](https://rhymebrain.com/api.html), you may only make 350 requests per hour.

Installtion is simple, run `dart pub add rhymebrain`

[Pub.dev RhymeBrain Library](https://pub.dev/packages/rhymebrain)

## Usage

For any response that has `.offensive`, `.confident`, or `.common`, these are derived from `flags` (which are represented as a string containing the letters `a`, `b`, or/and `c` in RhymeBrain.com) in the response field from RhymeBrain API, these just represent whether the flag is present or not, the rest of the interface should follow pretty closely to the API responses, this is a quality of life feature so you dont have to mess with checking for flags yourself, the raw String flags are also available using `.flags` in some cases.

Basic Usage:
```dart
final rbclient = RhymeBrain();
```

### How to get rhymes
[Detailed Example](https://github.com/ibotva/rhymebrain-dart/blob/main/example/getrhymes.dart)
This returns an array of info about words that rhyme with a given word, in the below, we use the example word "test":
```dart
await rbclient.getRhymes(RhymeParams(word: "test", maxResults?: 100));
```

### How to get Portmanteaus
[Detailed Example](https://github.com/ibotva/rhymebrain-dart/blob/main/example/getportmanteaus.dart)
This returns an array of Portmanteau's, these are words that are combined together into one word. You pass one word, and it fines words to create Portmanteaus with:
```dart
await rbclient.getPortmanteaus(PortmanteausParams(word: "test"));
```

### How to get Word Info
[Detailed Example](https://github.com/ibotva/rhymebrain-dart/blob/main/example/getinfo.dart)
```dart
await rbclient.getWordInfo(WordInfoParams(word: "test"));
```

## Additional information

RhymeBrain.com requires you to adknowledge them in your app in some way, shape, or form, in a public manner, when you use their systems as part of your application. Regardless of license, because of these rules, you are required to adknowledge them if you plan on using their service.

Please refer to [RhymeBrain Documentation](https://rhymebrain.com/api.html) for a better understanding of the API, and remember to adknowledge them for usage of their API.

There is also a [ISO639-1](https://github.com/ibotva/rhymebrain-dart/blob/main/lib/bin/iso6391.dart) to refer to for valid country codes.

More information on phonetics:
- [Full International Phonetic Alphabet Chart](https://www.internationalphoneticassociation.org/content/full-ipa-chart)
