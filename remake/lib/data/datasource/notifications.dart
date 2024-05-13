import 'package:firebase_messaging/firebase_messaging.dart';

Future<void> handleBackground(RemoteMessage message) async {
  print('title : ${message.notification!.title}');
  print('pesan : ${message.notification!.body}');

  print('payload : ${message.data}');
}

class PushNotificationsServices {
  final FirebaseMessaging _firebase = FirebaseMessaging.instance;

  Future<void> initNotification() async {
    await _firebase.requestPermission();
    final token = await _firebase.getToken();
    print('token anda : $token');
    FirebaseMessaging.onBackgroundMessage(handleBackground);
  }

  Future<void> taskReminder(
      {required String title,
      required String body,
      required DateTime deadline}) async {
    final time = deadline.difference(DateTime.now());

    if (time.isNegative || time.inSeconds <= 0) {
      return;
    }
  }
}
