## 0.0.10-dev.1

- Initial version. (Tobi writing)

- Has basic functionality to call 4 functions i found on RhymeBrain.com API, three documented, one undocumented. There may be other undocumented ones, I am not sure what we are allowed to use are I caution against using getFuzzyRhyme function.

- Docs are messy, but available, I need to update them, and fix all doc strings throughout code.

- I have each type of response coded to a class Object, if the response is a list of objects, then the response class is just each part of the list, sorted during the request function in the client object.

- There is a parameters object with a toMap method, it is encoded as URL parameters and sent to HTTP request.

- I also found that with RhymeBrain.com API, it is important you list the function name before any other arguments, no idea why that crashes it unfortunately.

## 0.0.11-dev.1

- Accidental, must bump version by one to update readme lol.

## 0.0.11-dev.2

- Status badge and Github actions added

## 0.0.11-dev.3

- Bumping version one more time to fix pubdev read me


## 0.1.0-dev.1

- First version I can comfortably say works correctly.

## 0.1.0-dev.2

- Updated `README.md` to reflect changes to features list so I can properly open issues.

- Redid the parameters types to be separate objects.

## 0.1.2

- Version bump.

## 0.1.3

- Finished cache and implemented it to client, it stores the parameters used, and the result, and if the parameters match it returns from cache instead.