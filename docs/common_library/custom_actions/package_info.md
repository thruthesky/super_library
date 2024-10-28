# Package Info

This custom action provides an API for querying information about an application package. It works on iOS, Android, and Web.

## Usage

You can use the `packageInfo` action to query information about the application package.

## Response

The `packageInfo` custom action will return the following information in JSON format:

```json
{
  "appName": "app name",
  "packageName": "package name",
  "version": "version",
  "buildNumber": "build number"
}
```


## Example

### Flutter Code

To display package info with Flutter, you can use the following code:

```dart
FutureBuilder(
    future: packageInfo(),
    builder: (context, snapshot) {
      if (snapshot.connectionState == ConnectionState.done) {
        return Column(
          children: [
            Text('Package Info: ${snapshot.data}'),
            const SizedBox(height: 20),
            if (snapshot.data['version'] != null)
              Text('Version: ${snapshot.data['version']}'),
            if (snapshot.data['buildNumber'] != null)
              Text(
                  'Build Number: ${snapshot.data['buildNumber']}'),
          ],
        );
      }
      return const CircularProgressIndicator();
    }),
```
