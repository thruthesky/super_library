// Automatic FlutterFlow imports
import '/backend/schema/enums/enums.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'index.dart'; // Imports other custom actions
import '/flutter_flow/custom_functions.dart'; // Imports custom functions
import 'package:flutter/material.dart';
// Begin custom action code
// DO NOT REMOVE OR MODIFY THE CODE ABOVE!

import 'package:firebase_auth/firebase_auth.dart';

/// Login or register
///
/// Creates a user account if it's not existing.
///
/// [email] is the email of the user.
///
/// [password] is the password of the user.
///
/// [photoUrl] is the photo url of the user. If it's null, then it will be the default photo url.
///
/// [displayName] is the display name of the user. If it's null, then it will be the same as the email.
/// You can put empty string if you want to save it an empty stirng.
///
/// Logic:
/// Try to login with email and password.
///    -> If it's successful, return the user.
///    -> If it fails, create a new user with email and password.
///        -> If a new account is created, then update the user's display name and photo url.
///        -> And return the user.
///        -> If it's failed (to create a new user), throw an error.
///
/// ```dart
/// final email = "${randomString()}@gmail.com";
/// final randomUser = await Test.loginOrRegister(
///   TestUser(
///     displayName: email,
///     email: email,
///     photoUrl: 'https://picsum.photos/id/1/200/200'
///   ),
/// );
/// ```
///
/// Return the user object of firebase auth and whether the user is registered or not.
Future loginOrRegister(
  BuildContext context,
  String email,
  String password,
) async {
  // Add your function code here!
  try {
    // login
    await FirebaseAuth.instance.signInWithEmailAndPassword(
      email: email,
      password: password,
    );
  } catch (e) {
    // create
    try {
      await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email, password: password);
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Failed to create a new user: $e'),
        ),
      );
      rethrow;
    }
  }
}
