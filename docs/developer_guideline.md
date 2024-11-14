# Developer Guideline

- [Developer Guideline](#developer-guideline)
  - [How to test comment](#how-to-test-comment)
  - [snackbar](#snackbar)
  - [confirm dialog](#confirm-dialog)
  - [error dialog](#error-dialog)
- [Localization](#localization)
  - [Get current locale](#get-current-locale)
- [User](#user)
  - [User data and UserData class](#user-data-and-userdata-class)
  - [Update user profile data](#update-user-profile-data)
  - [To display widgets based on user's login status](#to-display-widgets-based-on-users-login-status)
  - [To display user avatar](#to-display-user-avatar)
    - [User avatar update](#user-avatar-update)
- [Chat](#chat)
  - [Chat Setup](#chat-setup)
  - [Displaying a chat message of a chat room](#displaying-a-chat-message-of-a-chat-room)
  - [Displaying a chat room screen with the chat message list view and chat input box](#displaying-a-chat-room-screen-with-the-chat-message-list-view-and-chat-input-box)
  - [Handling error on sending a chat message](#handling-error-on-sending-a-chat-message)
  - [To display open chat room list](#to-display-open-chat-room-list)
  - [To display my chat room list](#to-display-my-chat-room-list)
  - [To display chat input message box based on the user login status](#to-display-chat-input-message-box-based-on-the-user-login-status)
  - [Creating chat room with chat room ID](#creating-chat-room-with-chat-room-id)
- [Upload](#upload)
  - [UploadImage](#uploadimage)
- [Feed API](#feed-api)
  - [Database Structure](#database-structure)


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



## confirm dialog




## error dialog






# Localization

- Super library uses the default localization of Flutter SDK. And that is how FlutterFlow localize.

- By default, the localization and the related code are in the `super_library/lib/custom_code/actions/locale_api.dart`.
  - If you want to change the default localization,
    - You can edit the `locale_api.dart`
    - Or you can overwrite the locales with `LocalService.instance.add()`.

- The `LocaleService.instance.init()` is called by the `SuperLibrary` constructor. So, it will be available after SuperLibrary is instantiated.

```dart
class _MyApp extends State<MyApp> {
  @override
  void initState() {
    super.initState();
    LocaleService.instance.add({
      'super library': {
        'en': 'Super Library',
        'ko': '슈퍼 라이브러리',
      },
      'language': {
        'en': 'Language',
        'ko': '언어',
      }
    });
  }
  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      routerConfig: router,
      localizationsDelegates: const [
        FFLocalizationsDelegate(),
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        FallbackMaterialLocalizationDelegate(),
        FallbackCupertinoLocalizationDelegate(),
      ],
      supportedLocales: const [
        Locale('en'),
        Locale('ko'),
      ],
    );
  }
}
```

- Then, use like below;

Example:
```dart
ElevatedButton(
  onPressed: () {
    showSnackbar(
      context,
      context.tr('super library'),
    );
  },
  child: Text('language'.tr(context)),
),
```
- Or you can use the `tr` method with a Map type.

Example:
```dart
{
  'en': 'Sign in with phone number',
  'ko': '전화번호로 로그인을 합니다.',
}.tr(context)
```


- You can add the texts directly to the `context.tr` method.

```dart
context.tr({'en': 'oooo', 'ko': 'xxxx'}); // returns the text based on the current language.
```


## Get current locale



```dart
Text('Locale: ${FFLocalizations.of(context).locale.languageCode}'),
```


# User


## User data and UserData class

- The Super Library is designed for FlutterFlow and follows its database structure.
  - FlutterFlow uses Firestore for user data storage.
  - The Super Library focuses on using the Realtime Database.
    - It mirrors user data from Firestore to the Realtime Database.
      - When users update their profiles, the data is saved in the Realtime Database.

- The `UserData` class models user data in the Realtime Database.


## Update user profile data

- To update user profile data, use `UserService.instance.updateProfile` method.

```dart
UserService.instance.updateProfile(
  displayName: displayName,
  photoUrl: photoUrl,
);
```

## To display widgets based on user's login status

- `MyDoc` rebuilds the widget with `null` if:
  - The user's document does not exist (user considered logged out) even if the user logged in
  - The user is not logged in
  - The user is in the middle of logging in (already logged in, but document not yet loaded or while loading)
  - The user has logged in and docuemnt has loaded but the document is empty.

- `MyDoc` rebuilds the widget with user data of `Map<String, dynamic>` type if:
  - The user is logged in and the document is loaded and the document is not empty.

- Use `MyDoc` to display different widgets based on the user's login status.
- `MyDoc` minimizes flickering, making it ideal for conditional rendering.


- Use `MyDoc` to display different widgets based on the user's login status. With `MyDoc`, you can display one widget when the user is logged in and another when they are logged out.
- `MyDoc` minimizes flickering, making it ideal for conditional rendering. So, it is a good idea to use `MyDoc` to display widgets based on the user's login status.


Example:
```dart
return MyDoc(builder: (data) {
  if (data == null) {
    return const Center(
      child: Text('Please sign in to view chat rooms'),
    );
  }
  return OtherWidget( .. );
}
```



## To display user avatar

- Use `UserAvatar` to display a user's photo including login user's photo from the Realtime Database.
  - Note that the user's photo url will be saved into the Firestore and mirrored into the Realtime Database.

- To update the user's photo, use `UserService.instance.profileUpdate` method.

### User avatar update

```dart
import 'package:easy_storage/easy_storage.dart';
import 'package:flutter/material.dart';
import 'package:super_library/custom_code/actions/super_library.dart';
import 'package:super_library/custom_code/widgets/index.dart';

class UserAvatarUpdate extends StatefulWidget {
  const UserAvatarUpdate({super.key});

  @override
  State<UserAvatarUpdate> createState() => _UserAvatarUpdateState();
}

class _UserAvatarUpdateState extends State<UserAvatarUpdate> {
  double progress = 0;
  final double radius = 50;
  @override
  Widget build(BuildContext context) {
    return UploadIconButton.image(
      onUpload: (url) async {
        print('photo url: $url');
        await UserService.instance.updateProfile(photoUrl: url);
        setState(() {
          progress = 0;
        });
      },
      progress: (p) => setState(() => progress = p),
      icon: Stack(
        clipBehavior: Clip.none,
        children: [
          UserAvatar(
            uid: myUid,
            width: 120,
            height: 120,
            radius: radius,
          ),
          Positioned(
            right: -2,
            bottom: -2,
            child: Icon(
              Icons.camera_alt,
              size: 38,
              color: Theme.of(context).colorScheme.secondary,
            ),
          ),
          if (progress != 0)
            ClipRRect(
              borderRadius: BorderRadius.circular(radius),
              child: Container(
                width: 120,
                height: 120,
                color: Colors.black.withOpacity(0.5),
                child: Center(
                  child: Text(
                    '${(progress * 100).toInt()}%',
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                    ),
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }
}
```




# Chat


## Chat Setup

- To allow only verified users send message, do the following;
```dart
ChatService.instance.setVerifiedUserOnly(true);
```



## Displaying a chat message of a chat room

To display a chat room message list, use `ChatMessageListView(uidOrRoomId: ...)`. Pass the other user's UID for a 1:1 chat, or the chat room ID if available. The chat room ID can represent either a 1:1 chat or a group chat.


```dart
ChatMessageListView(uidOrRoomId: '-O7NWCPZH3go57WNDzYn')
```


You can add an event handler when the user's profile photo is being tapped on the chat message bubble. The example below opens a user's public profile when the user's profile photo is tapped.

```dart
ChatMessageListView(
  uidOrRoomId: widget.uidOrRoomId,
  onTapProfilePhoto: (uid, displayName, photoUrl) =>
      showGeneralDialog(
          context: context,
          pageBuilder: (_, __, ___) => PublicProfileScreen(
                uid: uid,
                displayName: displayName,
                photoUrl: photoUrl,
              )),
),
```



## Displaying a chat room screen with the chat message list view and chat input box

To display a chat room screen, you will need to display the chat room message list view and the chat room input box.

```dart
class ChatRoomScreen extends StatefulWidget {
  static const String routeName = '/ChatRoom';
  const ChatRoomScreen({super.key, required this.uidOrRoomId});
  final String uidOrRoomId;

  @override
  State<ChatRoomScreen> createState() => _ChatRoomScreenState();
}

class _ChatRoomScreenState extends State<ChatRoomScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('ChatRoom'),
      ),
      body: Column(
        children: [
          Expanded(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(8, 0, 8, 0),
              child: ChatMessageListView(uidOrRoomId: widget.uidOrRoomId),
            ),
          ),
          ChatMessageInput(uidOrRoomId: widget.uidOrRoomId),
        ],
      ),
    );
  }
}
```

Below is the chat message input widget with photo upload.

```dart
import 'package:cached_network_image/cached_network_image.dart';
import 'package:easy_storage/easy_storage.dart';
import 'package:flutter/material.dart';
import 'package:super_library/custom_code/actions/index.dart';
import 'package:super_library/custom_code/actions/super_library.dart';

class ChatMessageInput extends StatefulWidget {
  const ChatMessageInput({
    super.key,
    required this.uidOrRoomId,
  });

  final String uidOrRoomId;

  @override
  State<ChatMessageInput> createState() => _ChatMessageInputState();
}

class _ChatMessageInputState extends State<ChatMessageInput> {
  final TextEditingController messageController = TextEditingController();
  String? url;
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        if (url != null)
          Container(
            width: 200,
            padding: const EdgeInsets.only(bottom: 8),
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.surface,
            ),
            child: CachedNetworkImage(imageUrl: url!),
          ),
        SafeArea(
          top: false,
          child: Padding(
            padding: EdgeInsets.only(
              bottom: MediaQuery.viewPaddingOf(context).bottom > 0 ? 0 : 8,
            ),
            child: Container(
              margin: const EdgeInsets.fromLTRB(8, 0, 8, 0),
              padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
              decoration: BoxDecoration(
                border: Border.all(
                  color: Theme.of(context).colorScheme.outline,
                  width: 1.4,
                ),
                borderRadius: BorderRadius.circular(18),
              ),
              child: Row(
                children: [
                  UploadIconButton.image(onBeginUpload: () async {
                    if (ChatService.instance.verifiedUserOnly) {
                      if (UserService.instance.isVerified == false) {
                        snackbar(
                          context,
                          '(verified-user-only) '
                          'Only verified user can send a message',
                          error: true,
                        );
                        return false;
                      }
                    }
                  }, onUpload: (url) {
                    this.url = url;
                    setState(() {});
                  }),
                  Expanded(
                    child: TextField(
                        controller: messageController,
                        decoration: const InputDecoration(
                          hintText: 'Input message',
                          border: InputBorder.none,
                        ),
                        onSubmitted: (value) => sendMessage()),
                  ),
                  IconButton(
                    onPressed: sendMessage,
                    icon: const Icon(Icons.send),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }

  sendMessage() async {
    final text = messageController.text;
    final uploadedUrl = url;
    setState(() {
      url = null;
    });
    messageController.clear();
    sendChatMessage(context, widget.uidOrRoomId, text, uploadedUrl, () {});
  }
}
```


## Handling error on sending a chat message

- Sending chat message may produce an error. You can catch error message like below and handle it in anyway you want.

```dart
sendChatMessage(context, widget.uidOrRoomId, text, uploadedUrl,
    (message) async {
  if (message.contains('verified-user-only')) {
    final re = await confirm(
      context: context,
      title: const Text('User Verification Required'),
      message: const Text(
          'You need to verify yourself to send a message.\n\nDo you want to verify now?'),
    );
    if (re == true) {
      if (mounted) {
        showGeneralDialog(
          context: context,
          pageBuilder: (_, __, ___) {
            return const VerificationScreen();
          },
        );
      }
    }
  } else {
    snackbar(context, message, error: true);
  }
});
```






## To display open chat room list

```dart
class OpenChatRoomListScreen extends StatefulWidget {
  const OpenChatRoomListScreen({super.key});

  @override
  State<OpenChatRoomListScreen> createState() => _OpenChatRoomListScreenState();
}

class _OpenChatRoomListScreenState extends State<OpenChatRoomListScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('OpenChatRoomList'),
      ),
      body: OpenChatRoomListView(
        onTap: (roomId) => showGeneralDialog(
          context: context,
          pageBuilder: (_, __, ___) {
            return ChatRoomScreen(uidOrRoomId: roomId);
          },
        ),
      ),
    );
  }
}
```


## To display my chat room list

To display the chat room list, you can show it on the chat room list screen or include it within an IndexedStack on the home screen.

```dart
ChatRoomListView(
  onTap: (roomId) => showGeneralDialog(
    context: context,
    pageBuilder: (_, __, ___) {
      return ChatRoomScreen(uidOrRoomId: roomId);
    },
  ),
),
```





## To display chat input message box based on the user login status

- Use `MyDoc` to display fake chat input message widget if the user is not logged in.

```dart
MyDoc(
  builder: (user) => user == null
      ? const FakeChatMessageInput()
      : const ChatMessageInput(uidOrRoomId: '-O7NWCPZH3go57WNDzYn'),
),
```


Example of `FakeChatMessageInput` widget

```dart
import 'package:flutter/material.dart';
import 'package:philov/screens/user/login.screen.dart';

class FakeChatMessageInput extends StatelessWidget {
  const FakeChatMessageInput({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: () {
        showGeneralDialog(
          context: context,
          pageBuilder: (_, __, ___) => const LoginScreen(),
        );
      },
      child: SafeArea(
        top: false,
        child: Padding(
          padding: EdgeInsets.only(
            bottom: MediaQuery.viewPaddingOf(context).bottom > 0 ? 0 : 8,
          ),
          child: Container(
            margin: const EdgeInsets.fromLTRB(16, 0, 16, 0),
            padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
            decoration: BoxDecoration(
              border: Border.all(
                color: Theme.of(context).colorScheme.outline,
                width: 1.4,
              ),
              borderRadius: BorderRadius.circular(18),
            ),
            child: const Padding(
              padding: EdgeInsets.all(10.0),
              child: Row(
                children: [
                  Icon(Icons.camera_alt),
                  SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      'Input message',
                    ),
                  ),
                  Icon(Icons.send),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
```

## Creating chat room with chat room ID

It is recommended to use the `createChatRoom` function to create a chat room. But if you are source coding with Flutter, you can use the `ChatRoom.create` method to create a chat room. With `ChatRoom.create`, you can set a chat room id.

Example:

```dart
ChatRoom.create(
  id: '-ChatRoomID',
  name: 'All Chat Room',
  description: 'Everyone can chat here',
  iconUrl: null,
  group: true,
  open: true,
  single: false,
  allMembersCanInvite: true,
);
```

Use case:
- When you have accidentally deleted the chat room, you can recover the chat room.



# Upload


- `UploadStorage` provides a way of uploading files into Firebase Stroage service.

- `Upload` widget provides a UI and Logic to upload files.
    - `Upload.image`
    - `Upload.file`
    - `Upload.video`



- Below is an example of custom UI

Example:

```dart
Upload.image(
  onUpload: (url) async {
    print('url: $url');
    await myDoc.update({'idCardUrl': url});
    // widget.onUpdate(VerificationStep.socialLogin);
  },
  child: Column(
    children: [
      Container(
        width: 360,
        height: 200,
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.secondary,
        ),
        child: MyDoc(builder: (data) {
          print(data);
          if (data?['idCardUrl'] != null) {
            return CachedNetworkImage(
              imageUrl: data!['idCardUrl'],
              width: 360,
              height: 200,
              fit: BoxFit.cover,
            );
          }
          return const IdCard();
        }),
      ),
      spaceMd,
      MyDoc(builder: (my) {
        return Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            const Row(
              children: [
                Icon(Icons.camera_alt),
                SizedBox(width: 8),
                Text('Take a photo'),
              ],
            ),
            if (my?['idCardUrl'] != null)
              IconButton(
                onPressed: () async {
                  await UploadService.instance.delete(my!['idCardUrl']);

                  await myDoc
                      .update({'idCardUrl': FieldValue.delete()});
                },
                icon: const Icon(
                  Icons.delete,
                ),
              ),
          ],
        );
      }),
    ],
  ),
),
```



- Below is an example of uploading user avatar

Eaxmaple:

```dart
import 'package:flutter/material.dart';
import 'package:super_library/custom_code/actions/super_library.dart';
import 'package:super_library/custom_code/widgets/index.dart';

class UserAvatarUpdate extends StatefulWidget {
  const UserAvatarUpdate({
    super.key,
    this.photoGallery = true,
  });

  final bool photoGallery;
  @override
  State<UserAvatarUpdate> createState() => _UserAvatarUpdateState();
}

class _UserAvatarUpdateState extends State<UserAvatarUpdate> {
  double progress = 0;
  final double radius = 50;
  @override
  Widget build(BuildContext context) {
    return Upload.image(
      photoGallery: widget.photoGallery,
      onUpload: (url) async {
        print('photo url: $url');
        await UserService.instance.updateProfile(photoUrl: url);
        setState(() {
          progress = 0;
        });
      },
      progress: (p) => setState(() => progress = p),
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          UserAvatar(
            uid: myUid,
            width: 120,
            height: 120,
            radius: radius,
          ),
          Positioned(
            right: -2,
            bottom: -2,
            child: Icon(
              Icons.camera_alt,
              size: 38,
              color: Theme.of(context).colorScheme.secondary,
            ),
          ),
          if (progress > 0 && progress <= 1)
            ClipRRect(
              borderRadius: BorderRadius.circular(radius),
              child: Container(
                width: 120,
                height: 120,
                color: Colors.black.withOpacity(0.5),
                child: Center(
                  child: Text(
                    '${((progress) * 100).toInt()}%',
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                    ),
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }
}
```



## UploadImage


- While you may enjoy using `Upload.image`, you can use `UploadImage` with pre-defined UI/UX.


```dart
UploadImage(
  onUpload: (url) => setState(() => iconUrl = url),
),
```





# Feed API

In this chapter, the Feed functionality is explained. If you are using FlutterFlow without source coding, please refer [Feed API](./feed_api.md) document.


## Database Structure


- `/follow/feed/`
- 




