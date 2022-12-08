import 'package:flutter/foundation.dart';

class UserNotifier with ChangeNotifier {
  String? _email;

  String get email => _email!;

  set setEmail(String email) {
    _email = email;
  }
}
