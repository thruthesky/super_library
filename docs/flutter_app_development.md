# Flutter Development

You will learn how to develop apps with the Flutter in this page. If you are only interested in building apps with FlutterFlow, this page is not for you.



- [Flutter Development](#flutter-development)
  - [Introduction](#introduction)
  - [Installation](#installation)
- [Translation and Localization](#translation-and-localization)
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
  - [To display open chat room list](#to-display-open-chat-room-list)
  - [To display my chat room list](#to-display-my-chat-room-list)
  - [To display chat input message box based on the user login status](#to-display-chat-input-message-box-based-on-the-user-login-status)


## Introduction

The Super Library is a powerful package built for FlutterFlow, offering user management, chat, and forum features. While designed for FlutterFlow, it's also compatible with Flutter projects. This guide will help you integrate it into your Flutter application.

The Super Library has minimal data modeling to support JSON-type data in FlutterFlow. Therefore, it's a good idea to build your own data models in your code.



## Installation

- Configure your Flutter project with a Firebase project
- Install `super_library` as dependency

   ```yaml
   dependencies:
     super_library: ^1.0.0  # Replace with the latest version
   ```

- If you see too many problems in the `Problems Tab` in VSCode, you may hide it with `dart.analysisExcludedFolders` settings.



# Translation and Localization

- Super library uses the default localization of Flutter SDK.


- Apply the Flutter SDK localization like below;

```dart
extension StringExtension on String {
  String get t {
    final String v = FFLocalizations.of(globalContext).getText(this);
    if (v.trim().isEmpty) {
      return this;
    }
    return v;
  }
}
class _MyApp extends State<MyApp> {
  @override
  void initState() {
    super.initState();
    TranslationService.instance.add({
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


- Thne, use like below;

```dart
ElevatedButton(
  onPressed: () {
    showSnackbar(
      context,
      'super library'.t,
    );
  },
  child: Text('language'.t),
),
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
              margin: const EdgeInsets.fromLTRB(16, 0, 16, 0),
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
                  UploadIconButton.image(onUpload: (url) {
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
    sendChatMessage(widget.uidOrRoomId, text, uploadedUrl);
  }
}
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
