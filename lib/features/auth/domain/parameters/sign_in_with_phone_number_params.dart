class SignInWithPhoneNumberParams {
  final String verificationId;
  final String smsCode;

  SignInWithPhoneNumberParams({
    required this.verificationId,
    required this.smsCode,
  });
}
