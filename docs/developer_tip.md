# Developer Tips




## How to test comment

- To test a comment creation, you would do something below;

```dart
final data = await Data.read('-O9sbecifMDVM5uBqVmL');
print(data.data);
await showModalBottomSheet(
    isScrollControlled: true,
    backgroundColor: Colors.transparent,
    enableDrag: false,
    context: context,
    builder: (context) {
    return GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: Padding(
        padding: MediaQuery.viewInsetsOf(context),
        child: ReplyForm(data: data.data),
        ),
    );
    },
);
```


- To create a comment under the first level comment

```dart
final parent = await Comment.read('-OA6v73mJrhnwYDQSAAK');
await showModalBottomSheet(
    isScrollControlled: true,
    backgroundColor: Colors.transparent,
    enableDrag: false,
    context: context,
    builder: (context) {
    return GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: Padding(
        padding: MediaQuery.viewInsetsOf(context),
        child: ReplyForm(data: parent!.toJson()),
        ),
    );
    },
);
```


- Create a data and its comment

```dart
createData(
  context,
  'cat-a',
  'title',
  'content',
  [],
  {},
  (k) async {
    print('Data created with key: $k');
    final data = await readData(context, k);
    createComment(context, data, 'a', [], {}, (commentKey) async {
      print('Comment created with key: $commentKey');
    }, null);
  },
  (e) async => print(e),
);
```



## snackbar

- FlutterFlow has `showSnackbar` method and you can use it.
- Super library has `snackbar` method which is similiar to `showSnackbar`.
  - `snackbar` supports maximum of two lines while `showSnackbar` supports onlye one line.
  - `snackbar` displays the elipsis while `showSnackbar` displays overflow.
  - `snackbar` has `error` option to display the snackbar with error background.


