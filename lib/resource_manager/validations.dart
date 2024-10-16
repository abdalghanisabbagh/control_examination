abstract class Validations {
  static bool checkEmail(String email) {
    /// Regular expression for email validation
    final RegExp regex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
    return regex.hasMatch(email);
  }

  static bool checkPassword(String password) {
    /// Check if the password meets the criteria
    if (password.isEmpty) {
      return false; // Password cannot be empty
    }

    /// Check password length
    if (password.length < 8) {
      return false; // Password must be at least 8 characters long
    }

    /// Check if password contains at least one uppercase letter
    if (!password.contains(RegExp(r'[A-Z]'))) {
      return false; // Password must contain at least one uppercase letter
    }

    /// Check if password contains at least one lowercase letter
    if (!password.contains(RegExp(r'[a-z]'))) {
      return false; // Password must contain at least one lowercase letter
    }

    /// Check if password contains at least one digit
    if (!password.contains(RegExp(r'[0-9]'))) {
      return false; // Password must contain at least one digit
    }

    /// Check if password contains at least one special character
    if (!password.contains(RegExp(r'[!@#$%^&*(),.?":{}|<>]'))) {
      return false; // Password must contain at least one special character
    }

    return true; // Password meets all criteria
  }

  /// Required Field Validator
  ///
  /// check if value is null or empty
  /// return `Field Is Required` as a [String]
  /// otherwise return `null`
  static String? requiredValidator(String? value) {
    if (value != null) {
      if (value.isEmpty) {
        return 'Field  Is Required';
      }
    } else if (value == null) {
      return 'Field  Is Required';
    }
    return null;
  }

  /// Email Validator
  ///
  /// check if value is null or empty
  /// return `Field Is Required` as a [String]
  /// otherwise return `null`
  static String? validateEmail(String? value) {
    if (value!.isEmpty) {
      return 'Please enter email';
    } else if (!checkEmail(value)) {
      return 'Please enter valid email';
    }
    return null;
  }

  /// Password Validator
  ///
  /// check if value is null or empty
  /// return `Field Is Required` as a [String]
  /// otherwise return `null`
  static String? validatePassword(String? value) {
    if (value!.isEmpty) {
      return 'Please enter password';
    } else if (!checkPassword(value)) {
      return 'Please enter valid password';
    }
    return null;
  }

  /// MultiSelectDropDown Required Field Validator
  ///
  /// check if value is null or empty
  /// return `Field Is Required` as a [String]
  /// otherwise return `null`
  // static String? multiSelectDropDownRequiredValidator(
  //     List<ValueItem<dynamic>>? value) {
  //   if (value == null || value.isEmpty) {
  //     return 'Field Is Required';
  //   }
  //   return null;
  // }
}
