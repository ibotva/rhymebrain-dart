## 0.0.10

- Initial version. (Tobi writing)

- Has basic functionality to call 4 functions i found on RhymeBrain.com API, three documented, one undocumented. There may be other undocumented ones, I am not sure what we are allowed to use are I caution against using getFuzzyRhyme function.

- Docs are messy, but available, i need to update them, and fix all doc strings throughout code.

- I have each type of response coded to a class Object, if the response is a list of objects, then the response class is just each part of the list, sorted during the request function in the client object.

- There is a parameters object with a toMap method, it is encoded as URL parameters and sent to HTTP request.