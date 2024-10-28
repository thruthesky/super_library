# Custom Design


To globally apply your design, you can hook your component in the super library initialization.


If you see the code below, the `import` path has a pattern. It always end with `_widget.dart`.


```dart
import '/components/xxx/xxx_widget.dart';
Future initApp() async {
  // Add your function code here!
  SuperLibrary.instance.init(
    getDatabaseUrl: () => '...',
    debug: true,
  );
  Component.userListTile = (user) => UserListIconWidget(
        uid: user.uid,
        displayName: user.displayName,
        photoUrl: user.photoUrl,
      );
}
```


To apply your component design, you can create a custom action like below and call the custom action on page load.


```dart
import 'package:super_library_5mglde/custom_code/actions/super_library.dart';
import '/components/data/data_card/data_card_widget.dart';

Future hookDataCardComponent() async {
  // Add your function code here!

  Component.dataCard = (data) => DataCardWidget(data: data.data);
  return;
}
```