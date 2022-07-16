import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:shop_app/cubit/cubit.dart';
import 'package:shop_app/main.dart';
import 'package:shop_app/models/user_model/user_model.dart';
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

  Future<void> login({
    required String email,
    required String password,
  }) async {
    // loading
    emit(SocialLoginLoading());

    await FirebaseAuth.instance
        .signInWithEmailAndPassword(
      email: email,
      password: password,
    )
        .then((value) async {
      // save uid in cache
      CacheHelper.setSocialUId(value.user!.uid);
      // save uid in global var
      uId = value.user!.uid;
      value.user!.sendEmailVerification();
      var cubit = SocialCubit();
      await cubit.getCurrentUserIfNotExists();
      if (cubit.userModel?.token != token) {
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

  Future<void> loginWithGoogle() async {
    // loading
    emit(SocialLoginWithGoogleLoading());

    // Trigger the authentication flow
    await GoogleSignIn().signIn().then((googleUser) async {
      // Obtain the auth details from the request
      final googleAuth = await googleUser?.authentication;

      // Create a new credential
      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth?.accessToken,
        idToken: googleAuth?.idToken,
      );

      FirebaseAuth.instance
          .signInWithCredential(credential)
          .then((value) async {
        final _user = value.user!;

        // save uid in cache
        CacheHelper.setSocialUId(_user.uid);
        // save uid in global var
        uId = _user.uid;

        await createUserIfNotExists(
          email: _user.email!,
          name: _user.displayName!,
          phone: _user.phoneNumber ?? '',
          image: _user.photoURL ??
              'https://img.freepik.com/free-vector/illustration-user-avatar-icon_53876-5907.jpg?w=740&t=st=1652066539~exp=1652067139~hmac=56c240665794b1798237d08ee1bdf76558858e666f86e98d001747b6ec5b1461',
          cover:
              'https://img.freepik.com/free-vector/hand-drawn-psychedelic-colorful-background_23-2149075812.jpg?w=900&t=st=1652084208~exp=1652084808~hmac=39bc5b885407fed98b7f70b82e221e00a6d31dd531d892337981a8929f74681c',
          context: navigatorKey.currentState!.context,
        ).then((value) {
          emit(SocialLoginWithGoogleSuccessful(_user.uid));
        }).catchError((error) {
          log('--Error when createUserIfNotExists: ${error.toString()}');
          emit(SocialLoginWithGoogleError(error.toString()));
        });
      }).catchError((error) {
        log('--Error when loginWithGoogle: ${error.toString()}');
        emit(SocialLoginWithGoogleError(error.toString()));
      });
    }).catchError((error) {
      log('--Error when loginWithGoogle-GoogleSignIn() : ${error.toString()}');
      emit(SocialLoginWithGoogleError(error.toString()));
    });
  }

  Future<void> loginWithFacebook() async {
    // loading
    emit(SocialLoginWithFacebookLoading());

    // Trigger the sign-in flow
    await FacebookAuth.instance.login().then((loginResult) async {

      // Create a new credential
      final credential = FacebookAuthProvider.credential(loginResult.accessToken!.token);

      FirebaseAuth.instance
          .signInWithCredential(credential)
          .then((value) async {

        final _user = value.user!;

        // save uid in cache
        CacheHelper.setSocialUId(_user.uid);
        // save uid in global var
        uId = _user.uid;

        await createUserIfNotExists(
          email: _user.email!,
          name: _user.displayName!,
          phone: _user.phoneNumber ?? '',
          image: _user.photoURL ??
              'https://img.freepik.com/free-vector/illustration-user-avatar-icon_53876-5907.jpg?w=740&t=st=1652066539~exp=1652067139~hmac=56c240665794b1798237d08ee1bdf76558858e666f86e98d001747b6ec5b1461',
          cover:
          'https://img.freepik.com/free-vector/hand-drawn-psychedelic-colorful-background_23-2149075812.jpg?w=900&t=st=1652084208~exp=1652084808~hmac=39bc5b885407fed98b7f70b82e221e00a6d31dd531d892337981a8929f74681c',
          context: navigatorKey.currentState!.context,
        ).then((value) {
          emit(SocialLoginWithFacebookSuccessful(_user.uid));
        }).catchError((error) {
          log('--Error when createUserIfNotExists: ${error.toString()}');
          emit(SocialLoginWithFacebookError(error.toString()));
        });
      }).catchError((error) {
        log('--Error when loginWithFacebook: ${error.toString()}');
        emit(SocialLoginWithFacebookError(error.toString()));
      });
    }).catchError((error) {
      log('--Error when loginWithFacebook-GoogleSignIn() : ${error.toString()}');
      emit(SocialLoginWithFacebookError(error.toString()));
    });
  }

  Future<void> createUserIfNotExists({
    required String email,
    required String name,
    required String phone,
    required String image,
    required String cover,
    required BuildContext context,
  }) async {
    await FirebaseFirestore.instance
        .collection('users')
        .where('uId', isEqualTo: uId)
        .get()
        .then((value) {
      log('is user exists? : ${value.size}');

      // check if user exists in Firestore
      if (value.size == 1) {
        final _userModel = UserModel.fromJson(value.docs.first.data());
        // save user model in app cubit
        SocialCubit.get(context).userModel = _userModel;

        // save user model in local db
        CacheHelper.setUserModel(_userModel.toMap());

        // check if token is different to update
        if (_userModel.token != token) {
          FirebaseFirestore.instance.collection('users').doc(uId).update({
            'token': token,
          });
        }

      } else if (value.size == 0) {
        // create user model
        final _userModel = UserModel(
          email: email,
          name: name,
          phone: phone,
          uId: uId,
          image: image,
          cover: cover,
          bio: '',
          isEmailVerified: false,
          token: token,
        );

        // add user in Firestore db
        FirebaseFirestore.instance
            .collection('users')
            .doc(uId)
            .set(_userModel.toMap());

        // save user model in app cubit
        SocialCubit.get(context).userModel = _userModel;

        // save user model in local db
        CacheHelper.setUserModel(_userModel.toMap());
      }
    });
  }
}
