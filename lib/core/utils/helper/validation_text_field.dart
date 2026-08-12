import 'dart:developer';

import 'package:flutter/cupertino.dart';

class ValidationTextField {
  static String? Function(String?)? email() {
    return (value) {
      if (value == null || value.isEmpty) {
        return 'pls enter email';
      }
      if (!value.contains("@")) {
        return "Enter a valid email";
      }
      return null;
    };
  }

  static String? Function(String?)? phoneNumber() {
    return (value) {
      if (value == null || value.isEmpty) {
        return 'Please enter your phone number';
      }
      if (!value.startsWith("0")) {
        return 'Phone number must start with 0';
      }
      log("value.length${value.length}");
      if (value.length < 11) {
        return 'Phone number must be at least 11 digits';
      }
      return null;
    };
  }

  static String? Function(String?)? name() {
    return (value) {
      if (value == null || value.isEmpty) {
        return 'Please enter your username';
      }
      if (value.length < 3) {
        return 'Username must be at least 3 characters long';
      }
      return null;
    };
  }

  static String? Function(String?)? password() {
    return (String? value) {
      if (value == null || value.isEmpty) {
        return "Please enter a password";
      }
      if (value.length < 8) {
        return "Password must be at least 8 characters long";
      }
      // Optional: Add more validation rules
      if (!RegExp(r'^(?=.*[A-Z])(?=.*\d).+$').hasMatch(value)) {
        return "Password must contain at least one uppercase letter and one number";
      }
      return null;
    };
  }

  static String? Function(String?)? confirmPassword(
    TextEditingController controller,
  ) {
    return (value) {
      if (value == null || value.isEmpty) {
        return 'Please enter your confirm password';
      }
      if (value.length < 8) {
        return 'Username must be at least 8 characters long';
      }
      if (value != controller.text) {
        return 'Passwords do not match';
      }
      return null;
    };
  }

  static String? Function(DateTime?)? birthday() {
    return (value) {
      if (value == null) return 'Please select birthday';
      final age =
          DateTime.now().year - value.year; // Rough check; full in use case
      if (age < 18) return 'You must be at least 18 years old';
      return null;
    };
  }
}
