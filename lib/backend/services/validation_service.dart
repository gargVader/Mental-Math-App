import 'package:get/get.dart';

mixin Validators {
  String? emailValidator(String? value) {
    if (!GetUtils.isEmail(value.toString())) {
      return 'Enter a valid email';
    }
    return null;
  }

  String? passwordValidator(String? value) {
    if (value!.length < 6) {
      return 'Password length is too short';
    }
    return null;
  }

  bool discountValidator(String value) {
    final double discount = double.parse(value);
    if (discount <= 0 && discount > 100) {
      return false;
    }
    return true;
  }
}
