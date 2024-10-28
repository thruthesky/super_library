# showAppUpdateDialog

The `showAppUpdateDialog` custom action displays a dialog prompting the user to update the app.

## Parameters

- `title`: the title of the dialog
- `message`: the message of the dialog 
- `logoUrl`: URL to display a logo at the top of the dialog.
- `alertAgainInterval`: Interval in minutes to alert the user again. The default value is 1000 (16.6 hours). For testing, you can set it to 0 to always show the dialog.

## Flutter Code Example

```dart
SchedulerBinding.instance.addPostFrameCallback((_) async {
  await common_library_1i4ez9_actions.showAppUpdateDialog(
    context,
    'NEW AI COOL',
    'Un-install and install again AI COOL',
    'https://picsum.photos/250?image=9',
    false,
    false,
    0,
    () async {},
    () async {},
    () async {},
  );
});