import 'package:flutter/foundation.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

// UserProvider userProvider = UserProvider();
// WalletProvider walletProvider = WalletProvider();
// RewardsProvider rewardsProvider = RewardsProvider();
const AndroidNotificationChannel channel = AndroidNotificationChannel(
  'high_importance_channel',
  'High Importance Notifications',
  importance: Importance.high,
  playSound: true,
);

final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();
var initializationSettingsAndroid =
    const AndroidInitializationSettings('@mipmap/ic_launcher');
// Future<void> firebaseMessagingBackgroundHandler(RemoteMessage message) async {
//   await Firebase.initializeApp();
// }
showNotification(String title, String body) {
  if (kDebugMode) {
    print("NOTIFICATION TITLE IS : $title");
  }
  flutterLocalNotificationsPlugin.show(
      1,
      title,
      body,
      NotificationDetails(
        android: AndroidNotificationDetails(
          channel.id,
          channel.name,
          // AndroidInitializationSettings('@mipmap/ic_launcher');

          // channel.description,
          icon: '@mipmap/ic_launcher',
          playSound: true,
          enableVibration: true,
          importance: Importance.max,
          priority: Priority.high,
        ),
        // iOS:
      ));
}

// onMessageListen(BuildContext context) {
//   FirebaseMessaging.onMessage.listen((RemoteMessage message) {
//     RemoteNotification? notification = message.notification;
//     AndroidNotification? android = message.notification?.android;

//     if (notification != null && android != null) {
//       WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
//         // Provider.of<NotificationsProvider>(context, listen: false)
//         //     .makeHaveUnread();
//         flutterLocalNotificationsPlugin.show(
//             1,
//             "Byte Games",
//             notification.body,
//             NotificationDetails(
//               android: AndroidNotificationDetails(
//                 channel.id,
//                 channel.name,
//                 // AndroidInitializationSettings('@mipmap/ic_launcher');

//                 // channel.description,
//                 icon: '@mipmap/launcher_icon',
//                 playSound: true,
//                 enableVibration: true,
//                 importance: Importance.max,
//                 priority: Priority.high,
//               ),
//               // iOS:
//             ));

//         showCustomFlushbar(notification.body.toString(), Colors.green,
//             Icons.notification_add_rounded, context);
//       });
//     }
//   });
// }
  