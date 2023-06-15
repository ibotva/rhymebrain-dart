# RhymeBrain.com API wrapper
This is a API wrapper for RhymeBrain.com written in the Dart programming language, its intended to be a free and easy way to get rhymes for a word using dart. 

Warning: This package does not have a stable version yet, it may not work as intended, please submit an issue if something is wrong with it, it needs more organized and concise documentation as well.

## Features

- Get Rhymes of a word
- Get Portmanteaus's of a word
- Get Info for a word
- Unfinished or Unstarted: Add cache for all functions
- [TODO]: Add comment to rest of response classes
- [TODO]: Add comments to parameters class
- [TODO]: Finish unit tests

## Getting started

> Note: According to [RhymeBrain Documentation](https://rhymebrain.com/api.html), you may only make 350 requests per hour.

Installtion is simple, run `pub get rhymebrain`

## Usage

For any response that has `.offensive`, `.confident`, or `.common`, these are derived from `flags` (which are represented as a string containing the letters `a`, `b`, or/and `c` in RhymeBrain.com) in the response field from RhymeBrain API, these just represent whether the flag is present or not, the rest of the interface should follow pretty closely to the API responses, this is a quality of life feature so you dont have to mess with checking for flags yourself, the raw String flags are also available using `.flags` in some cases.

### How to get rhymes
This returns an array of info about words that rhyme with a given word, in the below, we use the example word "test":
```dart
/// Initialize the client
RhymeBrain rbclient = RhymeBrain();

/// takes optional maxResults integer argument.
/// takes optional lang String, ISO639-1 format.
final List<Rhyme> rhymes = await rbclient.getRhymes(word: "test");

for (var rhyme in rhymes) {
    /// The rhyming word
    print(rhyme.word);

    /// 300+ score is a perfect rhyme, 0-300 is near perfect or consonant
    print(rhyme.score);

    /// Contains each syllable
    print(rhyme.syllables);

    /// Integer that shows how common word is, maximum value is 34 as of 6/14/23.
    print(rhyme.freq);

    /// Boolean that describes whether the word is offensive
    print(info.offensive);

    /// Boolean that describes whether the word is found in most dictionaries
    print(info.common);

    /// Boolean that describes whether RhymeBrain is confident in their pronunciation of the word.
    print(info.confident)
}
```

### How to get Portmanteaus's
This returns an array of Portmanteau's, these are words that are combined together into one word. You pass one word, and it fines words to create Portmanteaus with:
```dart
/// Initialize client
RhymeBrain rbclient = RhymeBrain();

/// takes optional maxResults integer argument.
/// takes optional lang String, ISO639-1 format.
Portmanteau portmanteau = await rbclient.getPortmanteau(word: "test");

/// Basically, the API returns a string of the source words ("test", and the portmanteau), separated with commas, sourceSplit is just an array of the words without commas. You may access raw String with [portmanteau.source] if neccesary.
/// These are the words to be comined into [portmanteau.source]
print(portmanteau.sourceSplit);

/// Same is true as the above comment, except with [portmanteau.combined] being the raw value.
/// This is the Portmanteau's generated (otherwise known as combined words) word.
print(portmanteau.combinedSplit);
```

### How to get Word Info
This returns word info from the RhymeBrain.com API.
```dart
/// Initialize the client
RhymeBrain rbclient = RhymeBrain();

/// Get the words info
WordInfo info = await rbclient.getWordInfo(word: "test");

/// The word you requested info for
print(info.word);

/// Pronunciation of the word
print(info.pron);

/// This is the phonetic transcription of the word
/// Phonetics is basically how a word is pronounced, in a written form, it assigns certain sounds in a word to written text.
print(info.ipa);

/// Frequency tells you how common a word is, with maximum value being 34 as of 6/14/23.
print(info.freq);

/// Boolean that describes whether the word is offensive
print(info.offensive);

/// Boolean that describes whether the word is found in most dictionaries
print(info.common);

/// Boolean that describes whether RhymeBrain is confident in their pronunciation of the word.
print(info.confident)
```

## Additional information

RhymeBrain.com requires you to adknowledge them in your app in some way, shape, or form, in a public manner, when you use their systems as part of your application. Regardless of license, because of these rules, you are required to adknowledge them if you plan on using their service.

Please refer to [RhymeBrain Documentation](https://rhymebrain.com/api.html) for a better understanding of the API, and remember to adknowledge them for usage of their API.

There is also a [ISO639-1](https://github.com/ibotva/rhymebrain-dart/blob/main/lib/bin/iso6391.dart) to refer to for valid country codes.

More information on phonetics:
- [Full International Phonetic Alphabet Chart](https://www.internationalphoneticassociation.org/content/full-ipa-chart)
