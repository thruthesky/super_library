# Chat


- [Chat](#chat)
- [Chat Logic](#chat-logic)
  - [User Invitation and Consent](#user-invitation-and-consent)
  - [Chat Room Database Structure](#chat-room-database-structure)
    - [Chat Room Fields](#chat-room-fields)
    - [Example of `users` Field](#example-of-users-field)
  - [Chat Message Database Structure](#chat-message-database-structure)
  - [How Chat Room Works](#how-chat-room-works)
  - [Sending a chat message](#sending-a-chat-message)
- [Settings](#settings)
- [Chat Room](#chat-room)
  - [How to Create a Chat Room](#how-to-create-a-chat-room)
  - [How to Update a Chat Room](#how-to-update-a-chat-room)
  - [Example](#example)
- [How to list my Chat Room List](#how-to-list-my-chat-room-list)
  - [Customizing Chat Room List with Custom Code](#customizing-chat-room-list-with-custom-code)
  - [Customizing Chat Room List with Component](#customizing-chat-room-list-with-component)
- [How to list Open Chat Rooms](#how-to-list-open-chat-rooms)
  - [Customizing Open Chat Room List with Custom Code](#customizing-open-chat-room-list-with-custom-code)
  - [Customizing Open Chat Room List with Component](#customizing-open-chat-room-list-with-component)
- [Opening a chat room screen](#opening-a-chat-room-screen)
- [Inviting a user into a chat room](#inviting-a-user-into-a-chat-room)
- [Chat room leave](#chat-room-leave)
- [Logic of blocking user](#logic-of-blocking-user)
- [UI and UX](#ui-and-ux)
- [Widgets](#widgets)
  - [ChatMessageListView](#chatmessagelistview)
    - [Callback functions on ChatMessageListView](#callback-functions-on-chatmessagelistview)
- [Developer's guide](#developers-guide)
  - [Testing chat room icon](#testing-chat-room-icon)
- [Known Issues](#known-issues)
  - [Chat room update and sync with chat join](#chat-room-update-and-sync-with-chat-join)
  - [No of Chat room message for blocked user](#no-of-chat-room-message-for-blocked-user)
  - [Unblock and new message](#unblock-and-new-message)
  - [Push notification](#push-notification)




# Chat Logic

## User Invitation and Consent

We prevent bad users from sending messages to good users.

## Chat Room Database Structure

- **/chat/rooms/{room-id}**: Chat room information is being saved in the node.

### Chat Room Fields

- `users`: A map of uid list.

Each chat room has a `users` field, which is a map with user IDs (`uid`) as keys and a boolean as values.

### Example of `users` Field

```json
{
  "users": {
    "A": true,
    "B": false
  }
}
```


## Chat Message Database Structure


- **/chat/messages/{room-id}/{message-id}**: chat messages are saved under the `/chat/messages/{room-id}` node.



## How Chat Room Works

1. **Creating a Chat Room**:
    1. When User A starts a chat with User B, a chat room is created with the `users` field.
    2. `A: true` means User A has initiated the chat.
    3. `B: false` means User B has not yet accepted the chat.
2. **Visibility of Chat Room**:
    1. The chat room appears in User A's chat room list.
    2. The chat room does not appear in User B's chat room list until User A sends a message.
3. **Sending a Message**:
    1. When User A sends a message, the chat room becomes visible in User B's chat room list.
4. **User B's Consent**:
    1. Since `B` is `false`, User B sees a confirmation dialog when they tap on the chat room.
    2. If User B accepts, `B` is set to `true`, and the confirmation dialog will no longer appear.

This process ensures that users have control over who can send them messages and join their chat rooms.


## Sending a chat message

- When a chat message is sent,
    - the sender's uid, displayName, photoUrl are saved
        - /chat/messages/(room_id)/(message_id)
        - /chat/joins/(room_user_uid)/(room_id)
    - the no of new message will be increased at
        - `/chat/settings/(room_user_uid) { newMessageCount: 00 }` for total number for new message.
        - `/chat/joins/(room_user_uid)/(room_id): { newMessageCount: 00 }` for the number of each chat room.
    - If it's single chat room,
        - even if there is ther other user is not in the `users` field, it will send a message.
            - This is for the case of:
                - When A sends chat message to B for the first,
                - Then A left the chat room with B,
                - B enters the chat room
                - B sends a message
                  - But the message is not delivered to B
                - It sends a message from B to A even if A is not in the room.
        - Note that when A creates the single chat room with B, A and B are added to the `users` field.



# Settings


- Call `chatVerifiedUserOnly` custom action to set the option that only verified members can send chat messages
    - This is because;
        - There are many abusers; You may think no abusers would use your app. But trust me, there are whole lot of abusers;
        - If anyone can be able to send message, abusers will send bad words, photos, links and they can do more.
        - By calling the `chatVerifiedUserOnly` custom action call in `main.dart`, users who have `verified` field to true in their user documents can send messages and photos;
            - This option must be set the whole chat rooms; not indivisual chat rooms;
            - And this option must includes all kinds of chat data including texts, images and files;
  




# Chat Room

## How to Create a Chat Room

1. **Open Create Chat Room Dialog**:
2. **Call the `createChatRoom` custom action**
    1. Alternatively, use `editChatRoom` which supports both creation and update.
3. **Open the Chat Room**:
    1. After creating the chat room, open it for the user.

## How to Update a Chat Room

1. **Open Update Chat Room Dialog**:
2. Call the `updateChatRoom` custom action.
    1. Alternatively, use `editChatRoom` which supports both creation and update.
3. **Close the Dialog**:
    1. After updating the chat room, close the dialog.



Note that `ChatMessageListView` listens the changes of the chat room data and it update the memory cache. This means, only if the app is displaying the messages of the chat room, the chat room data will be updated into the memory cache. If the user is not displaying the chat room list view, the chat room data in memory cache will not be updated even if the chat room is updated.





## Example

Here is an example of source code for creating or updating a chat room.

```dart
ElevatedButton(
  onPressed: () async {
    if (widget.roomId != null) {
      await updateChatRoom(
        widget.roomId!,
        nameController.text,
        descriptionController.text,
        iconUrl,
        open,
        canInvite,
      );
      Navigator.of(context).pop();
      return;
    }
    final roomId = await createChatRoom(
      nameController.text,
      descriptionController.text,
      iconUrl,
      open,
      canInvite,
    );
    Navigator.of(context).pop();
    showGeneralDialog(
      context: context,
      pageBuilder: (_, __, ___) {
        return ChatRoomScreen(
          roomId: roomId,
        );
      },
    );
  },
  child: const Text('Save'),
```








# How to list my Chat Room List


1. Add **ChatRoomListView** custom widget into body in a screen


2. Use onTap action to open a chat room.



## Customizing Chat Room List with Custom Code

Below is a sample code of how you can use the chat room list view widget.

```dart
ChatRoomListView(
  onTap: (roomId) => showGeneralDialog(
    context: context,
    pageBuilder: (_, __, ___) {
      return ChatRoomScreen(roomId: roomId);
    },
  ),
),
```



## Customizing Chat Room List with Component

1. Make a Component with your own Design

2. Connect your component to Component.chatRoomListTile.

```dart
Component.chatRoomListTile = (join) => ChatRoomListTileWidget(
      roomId: join.roomId,
      name: join.name,
      iconUrl: join.iconUrl,
      displayName: join.displayName,
      photoUrl: join.photoUrl,
      group: join.group,
      single: join.single,
      open: join.open,
      lastMessageAt: join.lastMessageAt,
      lastMessageDeleted: join.lastMessageDeleted,
      lastText: join.lastText,
      lastUrl: join.lastUrl,
      lastProtocol: join.lastProtocol,
      unreadMessageCount: join.unreadMessageCount,
    );
```



# How to list Open Chat Rooms

1. Add OpenChatRoomListView custom widget into body in a screen

2. Use onTap action to open a chat room.


## Customizing Open Chat Room List with Custom Code

Below is a sample code of how you can use the chat room list view widget.

```dart
OpenChatRoomListView(
  onTap: (roomId) => showGeneralDialog(
    context: context,
    pageBuilder: (_, __, ___) {
      return ChatRoomScreen(
        roomId: roomId,
      );
    },
  ),
)
```

## Customizing Open Chat Room List with Component

1. Make a Component with your own Design

2. Connect your component to Component.chatRoomListTile.


```dart
Component.openChatRoomListTile = (room) => OpenChatRoomListTileWidget(
      roomId: room.id,
      name: room.name,
      description: room.description,
      iconUrl: room.iconUrl,
      users: room.users,
      blockedUsers: room.blockedUids,
      masterUsers: room.masterUsers,
      createdAt: room.createdAt,
      updatedAt: room.updatedAt,
      open: room.open,
      openCreatedAt: room.openCreatedAt,
      single: room.single,
      group: room.group,
      lastMessageAt: room.lastMessageAt,
      allMembersCanInvite: room.allMembersCanInvite,
    );
```



# Opening a chat room screen

1. Create a chat room screen with parameter roomId as String

2. Add ChatMessageListView custom widget from Super library and pass the roomId onto it.

3. Add a TextField widget and a Button
   1. Name the TextField as text
   2. When the button is pressed, call sendChatMessage custom action from the super library with the text.

4. Then open the chat room screen by passing a user’s uid. And continue chat.





# Inviting a user into a chat room

1. Add a button on a group chat room to open a user-invite screen.
   1. Pass the chat room id over the user-invite screen.

2. In the user invite screen, you can search a user as described in User search

3. Call the inviteChatUser custom action to invite the user into the chat room.
   1. Pass the room id and the searched user uid.



# Chat room leave

- When user-A leaves the chat room with user-B,
  - The message from user-B will no longer delivered to user-A

- For the user-A to enter the chat room with user-B, user-A must find user-B and enter chat room.
  - Then, the message from user-B will appear in the chat message list view.






# Logic of blocking user

- When a User-A blocks another User-B, 
    - The `blockUser` custom action makes the User-A leaves the chat room with User-B if there is a chat room between A and B.
    - A cannot join the chat room with B.
    - A cannot send a chat message to B.

- User can report a chat room. But there is no way to block a chat room.



# UI and UX

- The login user cannot join the chat room and cannot send message to the blocked users.
    - The super library will throw exceptions

- For blocked user, It is recommended to
    - when the chat button is being pressed, alert the login user before entering the chat room that the other user is blocked;
    - or disable the chat button for the blocked users;
    - If you don't handle the exception,
      - The chat message list view may still display chat messages and the it may look like sending message works.


# Widgets

## ChatMessageListView


### Callback functions on ChatMessageListView

- **onTapProfilePhoto**: This callback function be called a user taps on another user's profile photo. The callback will deliver uid, dsiplayName, photoUrl of the other user.
    - Purpose: Display user public profile screen when the other user's photo is being tapped.





# Developer's guide

## Testing chat room icon

Simply pass the chat room id which has chat room icon url and you will see how it works.

```dart
ChatRoomIcon(
  roomId: '-O9JXcdeMWOaCxOMiKBP',
  width: 60,
  height: 60,
  radius: 24,
),
```




# Known Issues



## Chat room update and sync with chat join


- When the master changes the chat room name or icon, it is updated in the chat room data, but it's not updated in chat joins in realtime.
    - This is not a critical issue and we are planning to fix it some day later.




## No of Chat room message for blocked user

- Login user is A, the other user id B
    - A sent 2 message to B
        - The no of new messages is 2.
        - Then, A blocked B.
            - The no of new messages is still 2.

- This is a known issue. But it's not critical. And this may be fixed sometime later.



## Unblock and new message


- When A unblocks B,
  - The new message of B to A should be delivered.

But as of now, it's not delivered. We will fix it soon.




## Push notification

- To know more about how chat send push notification, refer [Push notification](./push_notifications.md) document.



