# Feed API

In this document, the feed functionality for FlutterFlow is explained. If you want to work with the source coding, please refer the [Feed API in Developer Guideline](./developer_guideline.md#feed-api).

## Features

Feed API allows you to follow and unfollow users. It also gives you an option to get who follow you and who you follow.

- **isFollowing**: Custom action to check if you are following the other user.
- **follow**: Custom action to follow other user.
- **unfollow**: Custom action to unfollow other user you are following.

- **getWhoFollowMe**: Custom action to get a list of users who follow me.
- **getWhoIFollow**: Custom action to get a list of users who I follow.
- **createFeed**: Custom action to create a feed.
- **updateFeed**: Custom action to update a feed.
- **deleteFeed**: Custom action to delete a feed.

## Suggested Use Case

- Showing the feeds of the other users that the current user is following.
- Showing a button to follow/unfollow the other user.
- Display who follow the user and who the user follows.
- Create Feed after a Data is created.
- Update Feed after a Data is updated.
- Delete Feed after a Data is deleted.

## How to use follow, unfollow and isFollowing custom actions

- Create a screen named `PublicProfileScreen`.
- Create a Local page state variable and named it as `isFollowing` with `Boolean` as type.

  ![image.png](./images/feed/feed_is_following_page_state.png)

- Under the page `On Page Load` trigger add the `isFollowing` custom action.

  - **otherUid**: Pass the uid of the other user.
  - **callback**: This callback will return boolean if you follow or not the other user.

    ![image.png](./images/feed/feed_is_following_on_page_load.png)

  - Inside the `callback` action, add an action that will update the local page state variable `isFollowing` with the return value.

    ![image.png](./images/feed/feed_is_following_callback.png)

- Next, add a button on the screen and name it as `FollowButton` change the text to `Follow`.

  - Select `FollowButton` widget and under the widget property panel add the custom action `follow` .

    - **otherUid**: Input the other user uid.
    - **onFollow**: This callback will be called if no error on follow action.
    - **onFailure**: This callback will trigger if theres any error on the action with an error message.

      ![image.png](./images/feed/feed_follow.png)

  e.g. **onFollow**

  - (Optional) Show a snack message success follow.
  - Set the local page state variable `isFollowing` to true.

    ![image.png](images/feed/feed_follow_on_follow.png)

  e.g. **onFailure** Show a snack message with the error message..

  ![image.png](images/feed/feed_follow_on_failure.png)

- Next, Add a button on the screen and name it `UnfollowButton` change the text to `Unfollow`.

  - Select `UnfollowButton` widget and under the widget property panel add and action and select the custom action `unfollow`.

    - **otherUid**: Input the other user uid.
    - **onUnfollow**: This callback will be called if no error on unfollow action.
    - **onFailure**: This callback will trigger if theres any error on the action with an error message.

      ![image.png](./images/feed/feed_unfollow.png)

  e.g. **onUnfollow**

  - (Optional) Show a snack message success unfollow.
  - Set the local page state variable `isFollowing` to false.

  ![image.png](images/feed/feed_unfollow_on_unfollow.png)

  e.g. **onFailure** Show a snack message with the error message.

  ![image.png](images/feed/feed_unfollow_on_failure.png)

- Lastly, to show only the button that is needed. we will wrap this two button with contidinal widget. and the select the isFollowing local state for the condition.

  ![image.png](images/feed/feed_follow_if.png)

- And the widget tree will look like below.

  ![image.png](images/feed/feed_follow_if_tree.png)

- Run the app and it should toggle from Follow to Unfollow when the button is clicked.

## How to display users who follow me

- Create a new screen named `WhoFollowMeScreen`.
- Get the List of users who follow me using the `getWhoFollowMe` custom action.

  - First select the page and add an action `On Page Load` trigger, then add the `getWhoFollowMe` custom action and set the `Action Output Variable Name` e.g `getWhoFollowMeOutput`.

    ![image.png](images/feed/feed_get_who_follow_me.png)

  - Then rebuild the current page once the data is loaded. We add another action `Update Page State` no need to set any field, just change the `Update Type` to `Rebuild Current Page`.

    ![image.png](images/feed/feed_get_who_follow_me_rebuild.png)

- Sample Setup to display the users who follow me.

  - On the widget tree add a `Row Widget` or `Column Widget`, in this case we will use a `Row Widget`.
  - Inside the `Row widget` add a `Column Widget`.
  - Inside the `Column Widget` add the `UserAvatarComponent` and `UserDisplayNameComponent`.
  - Your Widget Tree will look like below.

    ![image.png](images/feed/feed_get_who_follow_me_tree.png)

- **Important!** To avoid null error, first we need to check if the `getWhoFollowMeOutput` Action output has value. You can either hide the row when the output is not set or you can wrap the row with conditional widget and display empty message if the output is not set or empty.

  - In this example we will just hide the Row if the output is not set.

  - First Select the `Row Widget`,

  - Under the widget properties, enable the visibility set the condition by navigating to action output, select `getWhoFollowMeOutput` and from the available option select `Is Set and Not Empty` and confirm.

    ![image.png](images/feed/feed_get_who_follow_me_row_visibility.png)

- Next to use the `getWhoFollowMeOutput` action output, on the Property Panel click the 4th Tab (Generate Dynamic Children tab).
- Input Variable Name. e.g. `whoFollowMe`
- Next set the `Value` by Navigating to `Action Outputs` and in the Available Options select the `getWhoFollowMeOutput` that we set from the `On Page Load` trigger and click confirm.

  ![image.png](images/feed/feed_get_who_follow_me_generate_children.png)

- Then click `Save`, this will promt that this action will generate its children dynamically and click `Ok`.

  ![image.png](images/feed/feed_get_who_generate_children_confirm.png)

- Now we can use the `whoFollowMe` variable inside the UserAvatarComponent and UserDisplayNameComponent.
- Select the `UserAvatarComponent` from the widget tree

  - Set the variable for the `uid`, select the `whoFollowMe Item` from the source.

    ![alt text](images/feed/feed_get_who_follow_me_item.png)

  - First Available Options select `JSON Path`.
  - For the JSON Path input `$.uid`.
  - Then on the next Available Options select `No Further Changes`.

    ![image.png](images/feed/feed_get_who_follow_me_avatar.png)

- Do the same with the `UserDisplayNameComponent`.

  ![image.png](images/feed/feed_get_who_follow_me_name.png)

- Your canvas should look like this. Run the app and if you have followers, then it should display the avatar and display name of the followers.

  ![image.png](images/feed/feed_get_who_follow_me_canvas.png)

## How to display users who I follow

- Create another screen named `WhoIFollowScreen`.
- Get the List of users who I follow using the `getWhoIFollow` custom action.

  - Select the page then add an action `On Page Load` trigger, then add the `getWhoIFollow` custom action and set the `Action Output Variable Name` e.g `getWhoIFollowOutput`.

    ![image.png](images/feed/feed_get_who_i_follow.png)

  - Then rebuild the current page once the data is loaded. We add another action `Update Page State` no need to set any field, just change the `Update Type` to `Rebuild Current Page`.

    ![image.png](images/feed/feed_get_who_i_follow_rebuild.png)

- Sample Setup to display the users who I follow.

  - This time we will use `Column Widget`, since newly created screen has `Column Widget` we dont need to add anymore.
  - Inside the `Column Widget`, add a `Row Widget`.
  - Then inside the `Row Widget` add the `UserAvatarComponent` and `UserDisplayNameComponent`.
  - Your Widget Tree will look like below.

    ![image.png](images/feed/feed_get_who_i_follow_tree.png)

- **Important!** To avoid null error, first we need to check if the `getWhoIFollowOutput` Action output has value. You can either hide the Column when the output is not set or you can wrap the Column with conditional widget and display empty message if the output is not set or empty.

- First Select the `Column Widget`

- Under the widget properties, enable the visibility set the condition by navigating to action output, select `getWhoIFollowOutput` and from the available option select `Is Set and Not Empty` and confirm.

  ![image.png](images/feed/feed_get_who_i_follow_column_visibility.png)

- Next to use the `getWhoIFollowOutput` action output, on the Property Panel click the 4th Tab (Generate Dynamic Children tab).
- Input Variable Name. e.g. `whoIFollow`
- Next set the `Value` by Navigating to `Action Outputs` and in the Available Options select the `getWhoIFollowOutput` that we set from the `On Page Load` trigger and click confirm.

- Then click `Save`, this will promt that this action will generate its children dynamically and click `Ok`.

  ![image.png](images/feed/feed_get_who_generate_children_confirm.png)

- Now we can use the `whoIFollow` variable inside the UserAvatarComponent and UserDisplayNameComponent.

- Select the `UserAvatarComponent` from the widget tree

  - Set the variable for the `uid`, select the `whoFollowMe Item` from the source.

    ![alt text](images/feed/feed_get_who_i_follow_item.png)

  - First Available Options select `No Further Changes` then confirm.

    ![image.png](images/feed/feed_get_who_i_follow_avatar.png)

- Do the same with the `UserDisplayNameComponent`.

  ![image.png](images/feed/feed_get_who_i_follow_name.png)

- Your canvas should look like this. Run the app and if you have followers, then it should display the avatar and display name of the followers.

  ![image.png](images/feed/feed_get_who_i_follow_canvas.png)

## How to use createFeed

Feed is often use after a data was created. e.g. A user post a data, then we create the feed of this user followers using the information from the data.

Created feeds will have the following fields and will be added to followers feed of the current user:

/follow/feed/$otherUid/$dataKey

```json
/follow
    /feed
        /$otherUid
            /$dataKey
                {
                    "content": "data content",
                    "createdAt": "data createdAt",
                    "displayName": "Author display name",
                    "photoUrl": "Author photo url",
                    "uid": "Author uid",
                    "urls": ["data urls",],
                    "updatedAt": "data updatedAt"
                }
```

- After a `Data` is created using `createData` Custom Action. It will call the `onCreate` callback that has the `key` of Data that was created. (To know more about `createData` refer to [createData](/super_library/data/#createdata))

  ![alt text](images/feed/feed_create_data_callback.png)

- Inside the `onCreate` callback we will read the Data first by adding the Custom Action `readData` and passing the `key` from the callback parameter into the key input parameter.

  ![alt text](images/feed/feed_create_data_key.png)

- Then we name the Action Output Variable Name e.g. `readDataOutput`. (To know more about `readData` refer to [readData](/super_library/data/#readdata))

  ![alt text](images/feed/feed_create_read.png)

- After reading the Data we can pass the Action Output `readDataOutput` to create feed to followers using the `createFeed` Custom Action.

  ![alt text](images/feed/feed_create.png)

## How to use updateFeed

Feed is often use after a data was updated. e.g. A user edit a data, and we update the feed of this user followers.

- After a `Data` is updated using `updateData` Custom Action. It will call the `onUpdate` callback that has the `key` of Data that was updated. (To know more about `updateData` refer to [updateData](/super_library/data/#updatedata))

  ![alt text](images/feed/feed_update_data_callback.png)

- Inside the `onUpdate` callback we will read the Data first by adding the Custom Action `readData` and pass the same `dataKey` to the key input parameter. And named the Action Output Variable Name e.g. `readDataForFeedUpdate`

  ![alt text](images/feed/feed_update_read.png)

- After reading the Data we can pass the Action Output `readDataForFeedUpdate` to update the followers feed using the `updateFeed` Custom Action.

  ![alt text](images/feed/feed_update.png)

## How to use deleteFeed

delete field requires $dataKey

## How to list feeds
