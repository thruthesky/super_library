// Automatic FlutterFlow imports
import '/backend/schema/enums/enums.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'index.dart'; // Imports other custom widgets
import '/custom_code/actions/index.dart'; // Imports custom actions
import '/flutter_flow/custom_functions.dart'; // Imports custom functions
import 'package:flutter/material.dart';
// Begin custom widget code
// DO NOT REMOVE OR MODIFY THE CODE ABOVE!

import '/custom_code/actions/super_library.dart';

class PushNotificationIcon extends StatefulWidget {
  const PushNotificationIcon({
    super.key,
    this.width,
    this.height,
    required this.subscriptionId,
    required this.reverse,
  });

  final double? width;
  final double? height;
  final String subscriptionId;
  final bool reverse;

  @override
  State<PushNotificationIcon> createState() =>
      _PushNotificationSubscriptionToggleState();
}

class _PushNotificationSubscriptionToggleState
    extends State<PushNotificationIcon> {
  /// If isReversed == true, meaning, when `true` is saved in `/fcm-subscriptions/{idOrCategory}`,
  /// it will be considered as NOT subscribed. When no data is saved, it will be considered as
  /// subscribed.
  /// Otherwise (isReversed == false), when `true is saved in `/fcm-subscriptions/{idOrCategory}`,
  /// it will be consided as SUBSCRIBED. When no data is saved, it will be considered as NOT
  /// subscribed.
  bool get isReversed => widget.reverse == true;

  bool? isSubscribed;

  static const String _fcmSubscriptionsPath = 'fcm-subscriptions';

  @override
  Widget build(BuildContext context) {
    return Value(
      ref: database
          .ref('/$_fcmSubscriptionsPath/${widget.subscriptionId}/$myUid'),
      onLoading: isSubscribed == null
          ? null
          : IconButton(
              onPressed: isSubscribed! ? turnOff : turnOn,
              icon: Icon(
                isSubscribed!
                    ? Icons.notifications_active
                    : Icons.notifications_off_outlined,
              ),
            ),
      builder: (value, ref) {
        isSubscribed = isReversed ? value != true : value == true;
        return IconButton(
          onPressed: isSubscribed! ? turnOff : turnOn,
          icon: Icon(
            isSubscribed!
                ? Icons.notifications_active
                : Icons.notifications_off_outlined,
          ),
        );
      },
    );
  }

  void turnOn() async {
    await database
        .ref('/$_fcmSubscriptionsPath/${widget.subscriptionId}/$myUid')
        .set(isReversed ? null : true);
  }

  void turnOff() async {
    await database
        .ref('/$_fcmSubscriptionsPath/${widget.subscriptionId}/$myUid')
        .set(isReversed ? true : null);
  }
}
