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
      'Authorization': 'key=${FirebaseKey.kFirebaseAppKey}',
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
