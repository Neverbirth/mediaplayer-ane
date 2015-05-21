Adobe AIR Native Extension for Android devices. This is a simple wrapper around MediaPlayer and its audio features, not all of the API is exposed (mainly getTrackInfo), and exceptions are silently caught.

The reason behind this ANE was mainly to work around [this bug](https://bugbase.adobe.com/index.cfm?event=bug&id=2869263), and it's already exposing more features than needed by the developer. If you have any request or issue open a ticket so it can be addressed.