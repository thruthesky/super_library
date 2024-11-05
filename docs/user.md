# User

- [User](#user)
  - [Overview](#overview)
  - [User Authentication](#user-authentication)
  - [UserAvatar](#useravatar)
  - [DisplayName](#displayname)
  - [User List View](#user-list-view)
    - [Alternative Option](#alternative-option)
    - [Customizing the UI](#customizing-the-ui)
    - [Horizontal Scrolling](#horizontal-scrolling)
    - [Examples](#examples)
  - [How to Customize UI Design in UserListView](#how-to-customize-ui-design-in-userlistview)
    - [Step 1: Create UserListIcon Component](#step-1-create-userlisticon-component)
    - [Step 2: Design UserListIcon Component](#step-2-design-userlisticon-component)
    - [Step 3: Create PublicProfileScreen](#step-3-create-publicprofilescreen)
    - [Step 4: Add onTap Action to UserListIcon](#step-4-add-ontap-action-to-userlisticon)
    - [Step 5: Design PublicProfileScreen](#step-5-design-publicprofilescreen)
  - [Different UI Design on Each Screen](#different-ui-design-on-each-screen)
- [User Search](#user-search)
  - [Setting Up User Search](#setting-up-user-search)
  - [Search Options](#search-options)
  - [Note](#note)
  - [Search Users by `display_name` (Case-Insensitive)](#search-users-by-display_name-case-insensitive)
    - [Example Users](#example-users)
    - [Search Criteria](#search-criteria)
    - [Important Note](#important-note)
  - [Functions](#functions)
    - [isAnonymous](#isanonymous)
  - [Blocking User](#blocking-user)
    - [Database structure for Blocking](#database-structure-for-blocking)
    - [blocking a user](#blocking-a-user)
    - [Un-blocking a User](#un-blocking-a-user)
    - [Listing the blocked users](#listing-the-blocked-users)
    - [Usage](#usage)
    - [Displaying the block and unblock buttons](#displaying-the-block-and-unblock-buttons)
    - [To display the list of users that are blocked by login user](#to-display-the-list-of-users-that-are-blocked-by-login-user)
  - [Widgets](#widgets)
    - [BlockedUser](#blockeduser)
  - [Security](#security)

## Overview

- The user's `display_name` and `photo_url` are mirrored from Firestore to the Realtime Database.
- The user's `display_name` is also stored in `display_name_lowercase` (in lowercase) for better searchability in both Firestore and the Realtime Database.

## User Authentication

The Super Library supports Firebase user authentication only.

You can continue using FlutterFlow's authentication methods seamlessly with the Super Library.

## UserAvatar

Use the `UserAvatar` widget to display a user's photo. This widget gets user profile photo url from the Realtime Database.

- **No Photo URL**: If no photo URL is provided, it shows a user icon.
- **Background Color**: The background color is `FlutterFlowTheme.of(context).alternate`.
- **Foreground Color**: The foreground color is `FlutterFlowTheme.of(context).primaryText`.

| No photo url                      | With with photo url                |
| --------------------------------- | ---------------------------------- |
| ![image.png](/images/image_2.png) | ![image.png](/images/image(2).png) |

## DisplayName

Use the `DisplayName` widget to display the display name of a user. This widget displays user's display name from the Realtime Database.

## User List View

To list users from the Realtime Database, use the `UserListView` widget.

### Alternative Option

You can also use the built-in FlutterFlow Backend Query to list users from Firestore. This is a fine option if you are not concerned about the cost.

### Customizing the UI

You have several options to customize the UI design:

- **Default UI**: Use the built-in default UI.
- **Default Component**: Use the default component provided.
- **Custom Component**: Design your own component.

### Horizontal Scrolling

You can make the `UserListView` display and scroll horizontally.

### Examples

For examples, visit the [Super Library Example](https://github.com/thruthesky/super_library_example/tree/main/lib/screens/user).

## How to Customize UI Design in UserListView

### Step 1: Create UserListIcon Component

- **Parameters**:
    - `uid` (String, required)
    - `displayName` (String, required)
    - `photoUrl` (ImagePath, optional)

### Step 2: Design UserListIcon Component

- Customize the design of the `UserListIcon` component as needed.

### Step 3: Create PublicProfileScreen

- **Screen Name**: You can name this screen as you like.

### Step 4: Add onTap Action to UserListIcon

- **Action**: Open the `PublicProfileScreen` when `UserListIcon` is tapped.
- **Customization**: You can add any action and customize the UI/UX as desired.

### Step 5: Design PublicProfileScreen

- Customize the design of the `PublicProfileScreen` as needed.

## Different UI Design on Each Screen

You can design a different UI on each screen by following these steps:

1. **Design the Component**:
    1. Create components to display user in each screen.
2. **Call a Custom Action**:
    1. Use a custom action to set the `userListTile` component.
    2. Example: `Component.userListTile = (user) => ...`

# User Search

The Super Library does not provide UI or code for user search due to FlutterFlow's limitations. Follow these steps to create your own user search:

## Setting Up User Search

1. **Add `display_name_lowercase` Field**:
    1. This field will be automatically saved in the Firestore user document.
    2. Add a field named `display_name_lowercase` in the user schema.
    3. This field will store the lowercase version of the user's `display_name`.
2. **Search Implementation**:
    1. Compare user input in lowercase to the value of `display_name_lowercase`.
    2. Use the `.toLowerCase()` method for comparison.

## Search Options

You can filter/search the user's `display_name_lowercase`:

- **Equality Match**: Exact match.
- **Partial Match**: Match the beginning part of the name.

## Note

This is the nature of how FlutterFlow works, so the Super Library does not provide any UI for this feature. For an example, please see the [Super Library sample project](https://app.flutterflow.io/project/test-super-library-ldkmay).

You can also write custom code to search for users in the Realtime Database.

## Search Users by `display_name` (Case-Insensitive)

### Example Users

Let’s there are users whose display_name are;

- Young One
- younG Two
- You and Me

### Search Criteria

To search for users whose `display_name` begins with "you" (case-insensitive), you can query Firestore on `display_name_lowercase` field and display the results in a `ListView`.

### Important Note

Allowing users to search for other users with a single letter, like `a`, can result in a large number of users being listed. This can lead to spam messages being sent to users whom they don't know. To prevent this, it is recommended to limit the search to words that are longer than 3 or 4 characters. This helps ensure that search results are more specific and reduces the likelihood of spam.

## Functions

### isAnonymous

See the custom actions page

## Blocking User

### Database structure for Blocking

- We use Firestore to manage blocked users by storing user UIDs in the `blockedUsers` field within the user document.
    - This approach is beneficial because:
        - It allows easy determination of whether a user is blocked from the user's own document.
        - The `blockedUsers` field is part of the user's document, so it is automatically loaded and updated in memory, eliminating the need for repeated document reads.
- To use the user blocking feature in FlutterFlow, create a String array field named `blockedUsers` in the Users schema in Firestore.
- Use the `blockUser` and `unblockUser` custom actions to manage blocked users:
    - `blockUser` adds the other user's UID to `blockedUsers` and mirrors the block list in the Realtime Database.
    - `unblockUser` removes the other user's UID from `blockedUsers` and mirrors the block list in the Realtime Database.
- The uid of other user will be saved in the login user's Firestore document like `/users/<uid> { blockedUsers: [ ... ] }`.
    - When the user A blocks the B, B's uid is saved in `/users/A/{ blockedUsers: [ B ] }`.
    - It's the string of uid. Not the reference of the user document.

### blocking a user

- To block a user, you can call `blockUser` custom action to block a user.
- When user-A blocks user-B,
    - The `blockUser` custom action will add B's uid into `blockedUsers` array field in A's fireestore user document.
        - And, mirror the the B's uid at `/blocked-users/A/{ B }` in the Reatime Database.
        - And, if the user A has a single chat room with user-B, it will leave the chat room.

### Un-blocking a User

- The `unblockUser` custom action does the unblocking a user.
    - And it mirror the other user's uid from the Realtime Database.
- To know if a user is blocked or not, simply do the way how the FlutterFlow goes
    - The `blockedUsers` is in the login user's document. Meaning, it will be automatically synced with the `Authenticated User` variable in FlutterFlow.
    - To display if the user is blocked or not, check if the user's uid is in the `blockedUsers` of `Authenticated User`.
        - And if the uid exists, then the user is blocked by the login user and the login user can unblock the user.

### Listing the blocked users

- To list all the users that the login user has blocked, simply list the blocked-users whose uid is in `blockedUsers` in the user's Firestore document.
- And remove the user from blocked-list, call `unblockUser` custom action.
- You may want to see the [flutter code to list blocked users](https://github.com/thruthesky/flutterflow_libraries/blob/main/lib/screens/user/block_user_list.screen.dart).

### Usage

- To know if a user is blocked by the login user in FlutterFlow, dig in `blockedUsers` field in the FlutterFlow authenticated user variable.
- To know if a user is blocked by the login user in source coding, dig in `blockedUsers` field in `UserService.instance.firestoreUserData`.
- You may use `BlockedUser` widget for easy use in the widget tree.

### Displaying the block and unblock buttons

Exmaple: How to show block or unblock buttons based on the user's `blockedUsers` field.

![image.png](/docs/images/image.png)


### To display the list of users that are blocked by login user

Simply display the list of users whose uid is in `blockedUsers` field. You may add a unblock button beside the user's profile photo.







## Widgets

### BlockedUser

This widget listens the login user's document in Firestore and build the UI based on the status of the block.

This widget is usefuly on custom coding. You may not use it in the FlutterFlow canvas directly.

## Security

- We recommend locking the document to prevent unauthorized access. Instead, use the `UserAvatar` and `DisplayName` widgets to display user information.
    - This is because the user document in Firestore may contain private information such as phone numbers or email addresses.
    - And the `UserAvatar` and `DisplayName` access data from the Realtime Database where there should be no private information.