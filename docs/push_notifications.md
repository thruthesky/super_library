# Push notifications

The default behavior of FlutterFlow when it send push notifications is to read and write documents in the Firestore.

If your app has a group chat with active 1,000 users, and the app delivers push notifications on each chat, the app will create a document on each push notification and read more than 1,000 document of tokens. Yes, that's for every chat message. If your app has multiple active gruop chats, it will cost more.

We have our custom push notifications cloud functions. That works very much the same as the one provided by FlutterFlow. But it uses the Realtime Database. It will not cost anything by read/write.

You can simply copy and paste it into the Cloud functions menu and deploy.

The cloud functions will send messages by listening to the events of new chat message, comments, likes, and more.




## Installation

- You need to install a few cloud functions from your FlutterFlow dashboard.

### mirrorFcmTokens

- Create a new cloud function from your Cloud Functions in FlutterFlow
- Change the cloud function name as `mirrorFcmTokens`
- Copy the source code of [mirrorFcmTokens](https://raw.githubusercontent.com/thruthesky/super-library-firebase/refs/heads/main/mirror-fcm-tokens/functions/index.js)
- Replace the source code with the copy
- Deploy


### pushNotificationOnChatMessage

- Create a new cloud function from your Cloud Functions in FlutterFlow
- Change the cloud function name as `pushNotificationOnChatMessage`
- Copy the source code of [super library send push notification](https://raw.githubusercontent.com/thruthesky/super-library-firebase/refs/heads/main/send-push-notifications/functions/index.js)
- Replace the source code with the copy
- Deploy


#### How FlutterFlow works with chat push notifications


- In FlutterFlow, every screen(page) is listening the tap event of the push notification banner. The paths of the push notification handler would be
  - `main.dart` calls `_router = createRouter(_appStateNotifier);` inside `MyApp`.
    - `nav.dart` creates FFRoute objects of all the screens(pages) and passes it to `toRouter` as in `.map((r) => r.toRoute(appStateNotifier))`
      - In `nav.dart`, the `toRoute` wraps the the FFRoute screen object with `GoRouter` and handle the async/await if the screne is Future. And it also handles the parameters of the screen(page)
        - Then, the `toRoute` passes the screen(of GoRouter) as the child parameter of the `PushNotificationsHandler` widget.
          - The `PushNotificationsHandler` is a stateful widget that has push notification handler in its initState, and simply returns the child (screen/page) widget.
            - See? every screen is wrapped by `PushNotificationsHandler` widget that does push notification handling.
            - Not that, the push notification handler will extract the `initialPageName` and `parameterData` inside the push notification `data` property.
              - Then, it will open the screen(page) that is identical to `initialPageName` and transform the `parameterData` to pass over the go router's `context.pushNamed(...)` method to pass over the `initialPageName`.



```js
const parameterData = JSON.stringify({ roomId, messageId });
const initialPageName = "ChatRoomScreen"; // The name of the screen you will open.
```


### pushNotificationOnData

- Do the same as `pushNotificationOnChatMessage` except changing the cloud function name to `pushNotificationOnData`.


#### How FlutterFlow works with data push notifications

- When the user taps on the push notification banner on the system tray, it will open `DataDetailScreen` with the `category` and `dataKey` parameters.
  - You may not have a screen named `DataDetailScreen`. Instead you may have `PostDetailScreen` and `BlogDetailScreen` for data view screen.
    - In this case, you need to create a screen named `DataDetailScreen` and when user taps on the push notification banner, the app will open the `DataDetailScreen` with parameters of `category` adn `dataKey`.
      - Then, look into the `category` parameter and decide to redirect any of the screens of `PostDetailsScreen` or `BlogDetailScreen`, or whatever screen.
```js
const parameterData = JSON.stringify({ category, dataKey });
const initialPageName = "DataDetailScreen"; // This page will be opened when the user taps on the push notification banner.
```


### pushNotificationOnComment

- Do the same as `pushNotificationOnChatMessage` except changing the cloud function name to `pushNotificationOnComment`.




## Database structure

### Push notification tokens

- **/mirrored-fcm-tokens**: is the node that will have the tokens. The key is the token. And the value is the user uid. The push tokens are mirrored from the `/users/<uid>/fcm_tokens/` collection.



### Push notification subscriptions

- `/fcm-subscriptions/<group-id>`: is the node that will save all the subscriptions.
  - The `group-id` can be a `category` of data group, a `chat room id`, or it can be somethign else.

- For the `category` of the data group, the uids of the users who subscribe for that category will be saved as a key and the value will be `true`.
  - If the category is `qna` and the user uid is `user-A`, then the data structure is like below.
    - `/fcm-subscriptions/qna { user-A: true }`
  - You can provide an icon to turn on/off on each forum category. Or you can give a user of a subscription settings screen to manage the whole subscription options available in the app.

- For the chat room, the behavior of subscription of the chat room is reversed. Meaning, the user's uid is saved under the `/fcm-subscriptions/<chat-room-id>`, it means the user has unsubscribed the chat room. And when there is no uid saved under the subscription node, the subscription for the user is on.
    - To achieve this,
      - display the subscription icon on when there is no uid under the subscription path.
      - Display the subscription icon off when there is uid under the subscription path.
      - Send push notification (on every chat message) to those users (of the chat room) whose uid is NOT in the subscription path.



- For like of profile
  - Let each user to choose to get push notifications or not when somebody liked on his profile.
  - By default, it's on.


- For like of data
  - Let each user to choose to get push notifications or not when somebody liked on his data.
  - By default, it's on.


- For like of comment
  - Let each user to choose to get push notifications or not when somebody liked on his comment.
  - By default, it's on.


### Push notification icon

Use `PushNotificationIcon` to display the subscription on/off.


