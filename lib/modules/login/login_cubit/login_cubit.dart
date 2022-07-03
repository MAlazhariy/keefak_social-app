import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:shop_app/cubit/cubit.dart';
import 'package:shop_app/modules/login/login_cubit/login_states.dart';
import 'package:shop_app/shared/components/constants.dart';
import 'package:shop_app/shared/network/local/cache_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SocialLoginCubit extends Cubit<SocialLoginStates> {
  SocialLoginCubit() : super(SocialLoginInitState());

  static SocialLoginCubit get(context) {
    return BlocProvider.of(context);
  }

  bool showPassword = false;
  String passwordShowHide = 'Show';
  bool changePassColor = false;
  bool changeEmailColor = false;
  TextInputType emailKeyboard = TextInputType.emailAddress;

  String emailCounter = '';

  void changeShowPassword() {
    showPassword = !showPassword;
    passwordShowHide = showPassword ? 'Hide' : 'Show';
    emit(SocialLoginChangePasswordVisibility());
  }

  void hidePassword() {
    showPassword = false;
    passwordShowHide = 'Show';
    emit(SocialLoginChangePasswordVisibility());
  }

  void changeColor({
    required bool changeColor,
    required bool isEmail,
  }) {
    isEmail ? changeEmailColor = changeColor : changePassColor = changeColor;
    emit(SocialLoginChangeColor());
  }

  void login({
    required String email,
    required String password,
  }) {
    // loading
    emit(SocialLoginLoading());

    FirebaseAuth.instance
        .signInWithEmailAndPassword(
      email: email,
      password: password,
    ).then((value) async {
      // save uid in cache
      CacheHelper.setSocialUId(value.user!.uid);
      // save uid in global var
      uId = value.user!.uid;
      value.user!.sendEmailVerification();
      var cubit = SocialCubit();
      await cubit.getUserData();
      if(cubit.userModel?.token != token){
        FirebaseFirestore.instance.collection('users').doc(uId).update({
          'token': token,
        });
      }

      emit(SocialLoginSuccessful(value.user!.uid));
    }).catchError((error) {
      log('--Error during SignIn: ${error.toString()}');
      emit(SocialLoginError(error.toString()));
    });
  }
}