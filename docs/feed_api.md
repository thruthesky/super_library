# Feed API

In this document, the feed functionality for FlutterFlow is explained. If you want to work with the source coding, please refer the [Feed API in Developer Guideline](./developer_guideline.md#feed-api).

## Features

Feed API allows you to follow and unfollow users.
It also gives you an option to get who follow you and who you follow.

- **follow**: Custom action to follow other user.
- **unfollow**: Custom action to unfollow other user you are following.
- **isFollowing**: Custom action to check if you are following the other user.
- **getWhoFollowMe**: Custom action to get a list of users who follow me.
- **getWhoIFollow**: Custom action to get a list of users who I follow.
- **createFeed**: Custom action to create a feed.
- **updateFeed**: Custom action to update a feed.
- **deleteFeed**: Custom action to delete a feed.

## Suggested Use Case

- Showing the feeds of the other users that the current user is following.
- Showing a button to follow/unfollow the other user.
- Display who follow the user and who the user follows.

## How to use follow, unfollow and isFollowing custom actions

```mermaid
flowchart TB
  node_1(["On Page Load"])
  node_2["isFollowing"]
  node_5[("Set Local Page State\nisFollowing (true/false)")]
  node_3[/"FollowButton"\]
  node_4[/"UnfollowButton"\]
  node_6[("set to true\nfollow/whoIfollow/myUid/otherUid = true\nfollow/whoFollowMe/otherUid/myUid = true")]
  node_7[("set to null\nfollow/whoIfollow/myUid/otherUid = null\nfollow/whoFollowMe/otherUid/myUid = null")]
  node_8{"result"}
  node_9{"result"}
  node_11[/"SnackBar with error message"/]
  node_12[/"Snackbar with error message"/]
  node_1 --> node_2
  node_2 --> node_5
  node_5 --"false\nShow FollowButton"--> node_3
  node_5 --"true\nShow UnfollowButton"--> node_4
  node_3 --> node_6
  node_4 --> node_7
  node_6 --> node_8
  node_8 --"onFollow\nSet to true"--> node_5
  node_7 --> node_9
  node_9 --"onUnFollow\nSet to false"--> node_5
  node_8 --"onFailure"--> node_11
  node_9 --"onFailure"--> node_12
```

1. Create a screen named `PublicProfileScreen`.
2. Create a Local page state variable and named it as `isFollowing` with `Boolean` as type.

   ![image.png](./images/feed/feed_is_following_page_state.png)

3. Under the page `On Page Load` trigger add the `isFollowing` custom action.

   - **otherUid**: Pass the uid of the other user.
   - **callback**: This callback will return boolean if you follow or not the other user.

     ![image.png](./images/feed/feed_is_following_on_page_load.png)

   - Inside the `callback` action, add an action that will update the local page state variable `isFollowing` with the return value.

     ![image.png](./images/feed/feed_is_following_callback.png)

4. Next, add a button on the screen and name it as `FollowButton`.

   - Select `FollowButton` widget and under the widget property panel add the custom action `follow` .

     - **otherUid**: Input the other user uid.
     - **onFollow**: This callback will be called if no error on follow action.
     - **onFailure**: This callback will trigger if theres any error on the action with an error message.

       ![image.png](./images/feed/feed_follow.png)

   e.g. **onFollow**

   - (Optional) Show a snack message success follow.
   - Set the local page state variable `isFollowing` to true.

   ![feed_follow_success.png](images/feed/feed_follow_on_follow.png)

   e.g. **onFailure** Show a snack message with the error message..

   ![feed_follow_success.png](images/feed/feed_follow_on_failure.png)

5. Next, Add a button on the screen and name it `UnfollowButton`.

   - Select `UnfollowButton` widget and under the widget property panel add and action and select the custom action `unfollow`.

     - **otherUid**: Input the other user uid.
     - **onUnfollow**: This callback will be called if no error on unfollow action.
     - **onFailure**: This callback will trigger if theres any error on the action with an error message.

       ![image.png](./images/feed/feed_unfollow.png)

   e.g. **onUnfollow**

   - (Optional) Show a snack message success unfollow.
   - Set the local page state variable `isFollowing` to false.

   ![feed_follow_success.png](images/feed/feed_unfollow_on_unfollow.png)

   e.g. **onFailure** Show a snack message with the error message.

   ![feed_follow_success.png](images/feed/feed_unfollow_on_failure.png)

## getWhoFollowMe

## getWhoIFollow

## createFeed

## updateFeed

## deleteFeed
