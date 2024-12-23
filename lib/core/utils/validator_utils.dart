//created by Waleed (23/10/2024)

import 'package:easy_localization/easy_localization.dart';

class Validators {
  Validators._();
  static String? passwordValidator(String? value) {
    if (value == null || value.isEmpty) {
      return 'valitators.Enter_password'.tr();
    }

    // Check for minimum length of 8 characters
    if (value.length < 8) {
      return 'valitators.Password_must_be_8_chars'.tr();
    }

    // Regular expression to check for at least one uppercase letter
    if (!RegExp(r'^(?=.*[A-Z])').hasMatch(value)) {
      return 'valitators.Uppercase_required'.tr();
    }

    // Regular expression to check for at least one lowercase letter
    if (!RegExp(r'^(?=.*[a-z])').hasMatch(value)) {
      return 'valitators.Lowercase_required'.tr();
    }

    // Regular expression to check for at least one digit
    if (!RegExp(r'^(?=.*\d)').hasMatch(value)) {
      return 'valitators.Number_required'.tr();
    }

    // Regular expression to check for at least one special character
    if (!RegExp(r'^(?=.*[!@#\$&*~])').hasMatch(value)) {
      return 'valitators.Special_char_required'.tr();
    }

    return null;
  }

  static String? emailValidator(String? value) {
    if (value == null || value.isEmpty) {
      return 'valitators.Enter_email'.tr();
    }

    // Regular expression for email validation
    String pattern = r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$';
    RegExp regex = RegExp(pattern);

    if (!regex.hasMatch(value)) {
      return 'valitators.Valid_email_required'.tr();
    }

    return null;
  }

  static String? nameValidator(String? value) {
    if (value == null || value.isEmpty) {
      return 'valitators.Enter_name'.tr(); // Error if the field is empty
    }

    // Regular expression for name validation: only letters and spaces allowed
    String pattern = r"^[a-zA-Z\s\u0621-\u064A]+$"; // Includes Arabic letters
    RegExp regex = RegExp(pattern);

    if (!regex.hasMatch(value)) {
      return 'valitators.Valid_name_required'
          .tr(); // Error if name contains invalid characters
    }

    if (value.length < 2) {
      return 'valitators.Name_must_be_2_chars'
          .tr(); // Error for very short names
    }

    return null; // Return null if the name is valid
  }

  static String? phoneNumberValidator(String? value) {
    if (value == null || value.isEmpty) {
      return "field_can't_be_empty".tr(); // Error if the field is empty
    }

    // Regular expression for phone number validation
    String pattern =
        r'^(010|011|012|015)\d{8}$|^\+20(10|11|12|15)\d{8}$'; // Allows international phone and Egyptian local format numbers
    RegExp regex = RegExp(pattern);

    if (!regex.hasMatch(value)) {
      return 'valitators.Valid_phone_required'
          .tr(); // Error if phone number is invalid
    }

    return null; // Return null if the phone number is valid
  }
}
