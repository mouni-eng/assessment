import 'package:flutter/foundation.dart';

void printLn(Object? object) {
  if (kDebugMode) {
    print(object);
  }
}

class Validate {
  static String? validateEmail(String? value) {
    const pattern = r"(?:[a-z0-9!#$%&'*+/=?^_`{|}~-]+(?:\.[a-z0-9!#$%&'"
        r'*+/=?^_`{|}~-]+)*|"(?:[\x01-\x08\x0b\x0c\x0e-\x1f\x21\x23-\x5b\x5d-'
        r'\x7f]|\\[\x01-\x09\x0b\x0c\x0e-\x7f])*")@(?:(?:[a-z0-9](?:[a-z0-9-]*'
        r'[a-z0-9])?\.)+[a-z0-9](?:[a-z0-9-]*[a-z0-9])?|\[(?:(?:(2(5[0-5]|[0-4]'
        r'[0-9])|1[0-9][0-9]|[1-9]?[0-9]))\.){3}(?:(2(5[0-5]|[0-4][0-9])|1[0-9]'
        r'[0-9]|[1-9]?[0-9])|[a-z0-9-]*[a-z0-9]:(?:[\x01-\x08\x0b\x0c\x0e-\x1f\'
        r'x21-\x5a\x53-\x7f]|\\[\x01-\x09\x0b\x0c\x0e-\x7f])+)\])';
    final regex = RegExp(pattern);

    if (value!.isEmpty) {
      return 'Please enter valid email';
    } else if (value.isNotEmpty && !regex.hasMatch(value)) {
      return 'Please enter valid email';
    } else {
      return null;
    }
  }

  static String? validatePassword(String? value) {
    RegExp regex = RegExp(
        r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~_%]).{8,}$');
    if (value!.isEmpty || value.length < 8) {
      return 'Please enter valid password';
    } else {
      if (!regex.hasMatch(value)) {
        return 'Please enter valid password';
      } else {
        return null;
      }
    }
  }

  static List<String> getBulletPoints() {
    return [
      "Must contain at least one upercase & sympol",
      "Must contain more than 8 characters",
    ];
  }
}
