import 'dart:developer';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:shop_app/layout/social_layout.dart';
import 'package:shop_app/cubit/cubit.dart';
import 'package:shop_app/modules/login/login_screen.dart';
import 'package:shop_app/modules/preparing_to_chat_screen/preparing_to_chat_screen.dart';
import 'package:shop_app/shared/components/constants.dart';
import 'package:shop_app/shared/network/local/cache_helper.dart';
import 'package:shop_app/shared/styles/themes/dark_theme.dart';
import 'package:shop_app/shared/styles/themes/light_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:hive_flutter/hive_flutter.dart';

import 'models/notifications/notification_message_model/notification_message_model.dart';

GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

Future<void> onBackgroundHandler(RemoteMessage message) async {
  log('onBackgroundMessage: ${message.data.toString()}');

  // Fluttertoast.showToast(msg: 'onBackgroundMessage');
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // local DB init & open
  await Hive.initFlutter();
  await Hive.openBox('social_app');

  // init Firebase
  await Firebase.initializeApp();

  token = await FirebaseMessaging.instance.getToken() ?? '';
  log('token: $token');

  // // When you press on the notification in app bar, it calls onResume.
  // // You can navigate to the desired page as follows

  // void listenToNotification() {
  //   fcm.configure(
  //     onMessage: (Map<String, dynamic> message) async {
  //       print("onMessage: $message");
  //       getPreviousNotifications();
  //     },
  //     onLaunch: (Map<String, dynamic> message) async {
  //       print("onLaunch: $message");
  //     },
  //     onResume: (Map<String, dynamic> message) async {
  //       print("onResume: ${message["data"]}");
  //       SchedulerBinding.instance.addPostFrameCallback((_) {
  //         Navigator.of(GlobalVariable.navState.currentContext)
  //             .push(MaterialPageRoute(
  //             builder: (context) => TimelineView(
  //               campaignId: message["data"]["campaign"],
  //             )));
  //       });
  //     },
  //   );
  // }

  FirebaseMessaging.onMessage.listen((event) {
    log('onMessage: ${event.data.toString()}');
    if (event.data.containsKey('type') && event.data['type'] == 'message') {
      final _nModel = NotificationMessageModel.fromJson(event.data);
      Fluttertoast.showToast(msg: '${_nModel.senderName} sent a message');
    }
  });

  FirebaseMessaging.onMessageOpenedApp.listen((event) async {
    log('onMessageOpenedApp: ${event.data.toString()}');

    if (event.data['type'] == 'message') {
      final _nModel = NotificationMessageModel.fromJson(event.data);

      // await SocialCubit.get(navigatorKey.currentState!.context).getUserIfNotExists(_nModel.senderUid);

      navigatorKey.currentState!.push(
        MaterialPageRoute(
          // builder: (context) => ChattingScreen(
          //   user: SocialCubit.get(navigatorKey.currentState!.context)
          //       .users
          //       .firstWhere(
          //         (user) => user.uId == _nModel.senderUid,
          //   ),
          // ),
          builder: (context) => PreparingToChatScreen(nModel: _nModel),
        ),
      );


    }

    // Fluttertoast.showToast(msg: 'onMessageOpenedApp');
  });

  FirebaseMessaging.onBackgroundMessage(onBackgroundHandler);

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  // final botToastBuilder = BotToastInit();

  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    uId = CacheHelper.getSocialUId();

    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => SocialCubit()
            ..getCurrentUserData()
            ..getPosts(),
        ),
      ],
      child: MaterialApp(
        navigatorKey: navigatorKey,
        debugShowCheckedModeBanner: false,
        theme: lightTheme,
        darkTheme: darkTheme,
        themeMode: ThemeMode.light,
        home: uId.isEmpty ? SocialLoginScreen() : const SocialLayout(),
      ),
    );
  }
}
