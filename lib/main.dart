import 'dart:developer';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shop_app/layout/social_layout.dart';
import 'package:shop_app/cubit/cubit.dart';
import 'package:shop_app/modules/login/login_screen.dart';
import 'package:shop_app/modules/preparing_to_chat_screen/preparing_to_chat_screen.dart';
import 'package:shop_app/modules/preparing_to_post_screen/preparing_to_post_screen.dart';
import 'package:shop_app/shared/components/constants.dart';
import 'package:shop_app/shared/network/local/cache_helper.dart';
import 'package:shop_app/shared/styles/themes/dark_theme.dart';
import 'package:shop_app/shared/styles/themes/light_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/hive_flutter.dart';

import 'models/notifications/notification_comment_model/notification_comment_model.dart';
import 'models/notifications/notification_message_model/notification_message_model.dart';

GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

Future<void> onBackgroundHandler(RemoteMessage message) async {
  log('onBackgroundMessage: ${message.data.toString()}');
  whenTapNotification(message);
}

void whenTapNotification(RemoteMessage message) {
  if (uId.isNotEmpty) {
    if (message.data['type'] == 'message') {
      final _nModel = NotificationMessageModel.fromJson(message.data);

      navigatorKey.currentState!.push(
        MaterialPageRoute(
          builder: (context) => PreparingToChatScreen(nModel: _nModel),
        ),
      );
    } else if (message.data['type'] == 'comment') {
      final _nModel = NotificationCommentModel.fromJson(message.data);

      navigatorKey.currentState!.push(
        MaterialPageRoute(
          builder: (context) => PreparingToPostScreen(nModel: _nModel),
        ),
      );
    }
  }
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // local DB init & open
  await Hive.initFlutter();
  await Hive.openBox('social_app');

  // init Firebase
  await Firebase.initializeApp();

  token = await FirebaseMessaging.instance.getToken() ?? '';
  log('token = "$token"');
  uId = CacheHelper.getSocialUId();

  FirebaseMessaging.onMessage.listen((event) {
    log('onMessage: ${event.data.toString()}');

    if (uId.isNotEmpty) {
      if (event.data['type'] == 'message') {
        final _nModel = NotificationMessageModel.fromJson(event.data);
        Fluttertoast.showToast(msg: '${_nModel.senderName} send you a message');

      } else if (event.data['type'] == 'comment') {
        final _nModel = NotificationCommentModel.fromJson(event.data);
        final  _posts = SocialCubit.get(navigatorKey.currentContext).posts.where((post) => post.postId == _nModel.postId).toList();
        final String postText = _posts.isNotEmpty ? _posts.first.text : '';
        Fluttertoast.showToast(msg: '${_nModel.senderName} commented on your post: (${postText.padRight(12,'')}..)');
      }
    }
  });

  FirebaseMessaging.onMessageOpenedApp.listen((message) {
    log('onMessageOpenedApp: ${message.data.toString()}');
    whenTapNotification(message);
  });

  FirebaseMessaging.onBackgroundMessage(onBackgroundHandler);

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  // final botToastBuilder = BotToastInit();

  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => SocialCubit()
            ..getPosts()
            ..getCurrentUserIfNotExists(),
        ),
      ],
      child: MaterialApp(
        navigatorKey: navigatorKey,
        debugShowCheckedModeBanner: false,
        theme: lightTheme,
        darkTheme: darkTheme,
        themeMode: ThemeMode.light,
        home: uId.isNotEmpty ? const SocialLayout() : SocialLoginScreen(),
      ),
    );
  }
}
