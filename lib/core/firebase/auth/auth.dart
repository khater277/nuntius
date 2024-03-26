import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:nuntius/features/auth/domain/parameters/sign_in_with_phone_number_params.dart';
import 'package:nuntius/features/auth/domain/parameters/verify_phone_number_params.dart';

abstract class AuthViaFirebase {
  Future<UserCredential> signInWithPhoneNumber(
      {required SignInWithPhoneNumberParams signInWithPhoneNumberParams});
  Future<void> verifyPhoneNumber(
      {required VerifyPhoneNumberParams verifyPhoneNumberParams});
}

class AuthViaFirebaseImpl implements AuthViaFirebase {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  @override
  Future<UserCredential> signInWithPhoneNumber(
      {required SignInWithPhoneNumberParams
          signInWithPhoneNumberParams}) async {
    PhoneAuthCredential credential = PhoneAuthProvider.credential(
      verificationId: signInWithPhoneNumberParams.verificationId,
      smsCode: signInWithPhoneNumberParams.smsCode,
    );
    return _auth.signInWithCredential(credential);
  }

  @override
  Future<void> verifyPhoneNumber(
      {required VerifyPhoneNumberParams verifyPhoneNumberParams}) {
    return _auth.verifyPhoneNumber(
      phoneNumber: '+2${verifyPhoneNumberParams.phoneNumber}',
      verificationCompleted: verifyPhoneNumberParams.verificationCompleted,
      verificationFailed: verifyPhoneNumberParams.verificationFailed,
      codeSent: verifyPhoneNumberParams.codeSent,
      timeout: const Duration(seconds: 60),
      codeAutoRetrievalTimeout: (String verificationId) {},
    );
  }
}
