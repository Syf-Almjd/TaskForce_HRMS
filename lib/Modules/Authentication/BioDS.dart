
import 'package:dart_secure/dart_secure.dart';

Future<bool> BioDS() async {
  var authStatus = await biometricAuth(
      stickyAuth: true,
      biometricOnly: false,
      sensitiveTransaction: true,
      userErrorDialogs: true,
      message: "Please verify your identity to continue!");
  if (authStatus == AuthenticationStatus.successful) {
    return true;
  } else {
    return false;
  }
}
