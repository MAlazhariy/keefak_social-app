import 'dart:developer';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:shop_app/layout/social_layout.dart';
import 'package:shop_app/cubit/cubit.dart';
import 'package:shop_app/modules/social_login/login_screen.dart';
import 'package:shop_app/shared/components/constants.dart';
import 'package:shop_app/shared/network/local/cache_helper.dart';
import 'package:shop_app/shared/styles/themes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:hive_flutter/hive_flutter.dart';

Future<void> onBackgroundHandler(RemoteMessage message) async {
  log('onBackgroundMessage: ${message.data.toString()}');
  Fluttertoast.showToast(msg: 'onBackgroundMessage');
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // local DB init & open
  await Hive.initFlutter();
  await Hive.openBox('shop_app');

  // init Firebase
  await Firebase.initializeApp(
      // options: const FirebaseOptions(
      //   apiKey: "AIzaSyDZ8RwjQKQPol5_t6LkWdokmlE_wyxF8E4",
      //   appId: "malazhariy.training.shop_app",
      //   messagingSenderId: "XXX",
      //   projectId: "malazhariy.training.shop_app",
      // ),
      );

  token = await FirebaseMessaging.instance.getToken() ?? '';

  FirebaseMessaging.onMessage.listen((event) {
    log('onMessage: ${event.data.toString()}');
    Fluttertoast.showToast(msg: 'on message');
  });

  FirebaseMessaging.onMessageOpenedApp.listen((event) {
    log('onMessageOpenedApp: ${event.data.toString()}');
    Fluttertoast.showToast(msg: 'onMessageOpenedApp');
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
            ..getUserData()
            ..getPosts(),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: lightTheme,
        darkTheme: darkTheme,
        themeMode: ThemeMode.light,
        home: uId.isEmpty ? SocialLoginScreen() : const SocialLayout(),
      ),
    );
  }
}
