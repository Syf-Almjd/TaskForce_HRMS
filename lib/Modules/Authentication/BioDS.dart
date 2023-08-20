import 'package:dart_secure/src/biometricAuth.dart';

Future<bool> BioDS() async {
  var authStatus = await biometricAuth(
      stickyAuth: true,
      biometricOnly: true,
      sensitiveTransaction: true,
      userErrorDialogs: true,
      message: "Please verify your identity to continue!");
  if (authStatus == AuthenticationStatus.successful) {
    return true;
  } else {
    return false;
  }
}
