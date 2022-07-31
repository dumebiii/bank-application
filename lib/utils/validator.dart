class Validators {
  // email validsator

//password validator
  static String? passwordValidator(String? password) {
    if (password!.isEmpty) {
      return 'Enter your password';
    } else if (password.length < 6) {
      return "Password can't be less than 6 characters";
    }
    return null;
  }

  static String? validateTextField(String? val) {
    if (val!.isEmpty) {
      return 'Required Field';
    }
    return null;
  }

  static String? phoneTextField(String? val) {
    if (val!.isEmpty) {
      return 'Required Field';
    } else if (val.length < 10) {
      return "phone number can't be less than 10 characters";
    } else if (val.length > 10) {
      return "phone number can't be more than 10 characters";
    }
    return null;
  }
}
