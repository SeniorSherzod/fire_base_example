import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../screens/routes.dart';
import '../utils/connstants/app_const.dart';
import '../utils/utility_functions.dart';

class LoginViewModel extends ChangeNotifier {
  bool _isLoading = false;

  bool get loading => _isLoading;

  User? get getUser => FirebaseAuth.instance.currentUser;

  registerUser(
      BuildContext context, {
        required String email,
        required String password,
        required String username,
      }) async {
    if (AppConstants.emailRegExp.hasMatch(email) &&
        AppConstants.passwordRegExp.hasMatch(password)) {
      try {
        _notify(true);
        UserCredential userCredential =
        await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: email,
          password: password,
        );
        if (userCredential.user != null) {
          await FirebaseAuth.instance.currentUser!.updateDisplayName(username);
        }
        _notify(false);
        if (!context.mounted) return;
        Navigator.pushReplacementNamed(context, RouteNames.tabRoute);
      } on FirebaseAuthException catch (e) {
        if (!context.mounted) return;
        showErrorForRegister(e.code, context);
      } catch (error) {
        if (!context.mounted) return;
        showSnackbar(
          context: context,
          message: "Noma'lum xatolik yuz berdi:$error.",
        );
      }
    } else {
      showSnackbar(
        context: context,
        message: "Login yoki Parolni xato kiritdingiz!",
      );
    }
  }

  loginUser(
      BuildContext context, {
        required String email,
        required String password,
      }) async {
    if (AppConstants.emailRegExp.hasMatch(email) &&
        AppConstants.passwordRegExp.hasMatch(password)) {
      try {
        await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: email,
          password: password,
        );
        if (!context.mounted) return;
        Navigator.pushReplacementNamed(context, RouteNames.tabRoute);
      } on FirebaseAuthException catch (err) {
        if (!context.mounted) return;
        showErrorForLogin(err.code, context);
      } catch (error) {
        if (!context.mounted) return;
        showSnackbar(
          context: context,
          message: "Noma'lum xatolik yuz berdi:$error.",
        );
      }
    } else {
      showSnackbar(
        context: context,
        message: "Login yoki Parolni xato kiritdingiz!",
      );
    }
  }

  logout(BuildContext context) async {
    _notify(true);
    await FirebaseAuth.instance.signOut();
    _notify(false);
    if (!context.mounted) return;
    Navigator.pushReplacementNamed(context, RouteNames.loginRoute);
  }

  updateUsername(String username) async {
    _notify(true);
    await FirebaseAuth.instance.currentUser!.updateDisplayName(username);
    _notify(false);
  }

  updateImageUrl(String imagePath) async {
    _notify(true);
    try {
      await FirebaseAuth.instance.currentUser!.updatePhotoURL(imagePath);
    } catch (error) {
      debugPrint("ERROR:$error");
    }
    _notify(false);
  }

  _notify(bool v) {
    _isLoading = v;
    notifyListeners();
  }

//
// verifyEmail(){
//   FirebaseAuth.instance.currentUser.sendEmailVerification();
// }
}