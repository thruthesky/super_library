
# Quick Start

To use the Super Library, you need to add initialization code.

## Setup

See the [setup](./setup.md) documnet.


## Why Firebase Databsae URL is Needed


Firebase Realtime Database requires the databaseURL option to run the web applications. If you are running your app in the web debug mode, then you will need the databaseURL setting.


If you see an error message of `Exception: SuperLibrary.databaseURL is null` or `Cannot parse firebase url`, then, you may suspect that there is something wrong with the databaseURL in web running mode. Refer [Trouble Shooting](./trouble_shooting.md) for more details.


### How to set the databaseURL


1. Copy the URL of the Firebase Realtime Database. You can get it from Firebsae console.
2. Paste the url into the `databaseURL` field in the `View Details` of the Project dependencies setting in FlutterFlow.

If you are running in Mobile device like Simulator, Emulator, or physical device, you don't need to set up the `databaseURL`. The `databaseURL` is set by the FlutterFlow in the `google-service.json` and `GoogleService-Info.plist` files.



### Adding the databaseURL in the source code

If you are building apps with Flutter (Not using FlutterFlow), you can add the databaseURL like below;

```dart
SuperLibrary.instance.databaseURL = 'https://xxx-default-rtdb.firebaseio.com';
```



## Explanation

**getDatabaseUrl**: A callback function to return the database URL. It Supports environment variables, which are initialized after initApp is called.
If not using environment variables, simply return the URL as a string.

## Handling Errors

If you see an error like Target of URI doesn't exist: 'package:super_library/custom_code/actions/super_library.dart', run the app with "Exclude from compilation".

## Adding initApp to main.dart
Make sure to add the initApp custom action in your main.dart file.