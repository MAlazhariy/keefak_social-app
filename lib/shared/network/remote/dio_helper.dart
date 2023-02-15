import 'package:dio/dio.dart';
import 'package:shop_app/helpers/firebase_app_key.dart';

class DioHelper {
  static Dio? dio;

  static init() {
    dio = Dio(
      BaseOptions(
        baseUrl: 'https://fcm.googleapis.com/fcm/',
        receiveDataWhenStatusError: false,
      ),
    );
  }

  static Future<Response> pushFCM({
    required String to,
    required String title,
    required String body,
    Map? data,
  }) async {
    if(dio == null){
      await init();
    }

    dio!.options.headers = {
      'Authorization': 'key=AAAANeAm6JQ:APA91bHzS29rVZVey1cGroTjt5w5vS3ok0h3qcGUCY2uOkdaDHVzFyD-4xZmxASjwSiJePjrvWj4h3xnNNwir3ba18FlYlB4xdcJQe0P4w10Kqhax_NIpgFOqCnYOQvv0Kdb1-dl-5vE',
      'Content-Type': 'application/json',
    };

    return await dio!.post(
      'send',
      data: {
        "to": to,
        "notification": {
          "title": title,
          "body": body,
        },
        "android": {
          "priority": "HIGH",
          "notification": {
            "notification_priority": "PRIORITY_MAX",
            "sound": "default",
            "default_sound": true,
            "sticky": true,
            "default_vibrate_timings": true,
          }
        },
        "data": data ??
            {
              "click_action": "FLUTTER_NOTIFICATION_CLICK",
            },
      },
    );
  }
}
