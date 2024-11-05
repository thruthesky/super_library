# Security Rules



## Firestore

```json
    // By defualt, only the user can read his document.
    match /users/{uid} {
      allow read: if uid == request.auth.uid;
      allow write: if uid == request.auth.uid;
    }
```


## Realtime Database Security Rules

```json
{
  "rules": {
    "blocked-users": {
      "$my_uid": {
        "$other_uid": {
          ".read": true,
          ".write": "$my_uid === auth.uid"
        }
      }
    },
  }
}
```
