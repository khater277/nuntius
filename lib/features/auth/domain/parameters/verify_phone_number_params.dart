import 'package:firebase_auth/firebase_auth.dart';

class VerifyPhoneNumberParams {
  final String phoneNumber;
  final Function(PhoneAuthCredential credential) verificationCompleted;
  final Function(FirebaseAuthException error) verificationFailed;
  final Function(String verificationId, int? resendToken) codeSent;

  VerifyPhoneNumberParams({
    required this.phoneNumber,
    required this.verificationCompleted,
    required this.verificationFailed,
    required this.codeSent,
  });
}
