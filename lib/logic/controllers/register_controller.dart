import 'package:get/get.dart';
import 'package:sqllitecrud/logic/controllers/auth_controller.dart';

class RegisterController extends GetxController {
  var name = ''.obs;
  var email = ''.obs;
  var password = ''.obs;
  var mobile = ''.obs;
  var nameError = ''.obs;
  var emailError = ''.obs;
  var passwordError = ''.obs;
  var mobileError = ''.obs;

  @override
  void onInit() {
    super.onInit();
    name.listen((value) {
      nameValidation(value);
    });
    email.listen((value) {
      emailValidation(value);
    });
    password.listen((value) {
      passwordValidation(value);
    });
    mobile.listen((value) {
      mobileValidation(value);
    });
  }

  nameValidation(String val) {
    name.value = val;
    nameError.value = '';
    if (val.isEmpty) {
      nameError.value = 'Name is required';
    } else {
      nameError.value = '';
    }
  }

  emailValidation(String val) {
    email.value = val;
    emailError.value = '';
    if (val.isEmpty) {
      emailError.value = 'Email is required';
    } else if (!val.isEmail) {
      emailError.value = 'Invalid email format';
    } else {
      emailError.value = '';
    }
  }

  passwordValidation(String val) {
    password.value = val;
    passwordError.value = '';
    if (val.isEmpty) {
      passwordError.value = 'Password is required';
    } else if (val.length < 8) {
      passwordError.value = 'Password should be at least 8 characters long';
    } else {
      passwordError.value = '';
    }
  }

  mobileValidation(String val) {
    mobile.value = val;
    mobileError.value = '';
    if (val.isEmpty) {
      mobileError.value = 'Mobile number is required';
    } else if (!RegExp(r'^[0-9]{10}$').hasMatch(val)) {
      mobileError.value = 'Invalid mobile number';
    } else {
      mobileError.value = '';
    }
  }

  void register() {
    AuthController authController = Get.find();
    if (nameError.value.isEmpty &&
        emailError.value.isEmpty &&
        passwordError.value.isEmpty &&
        mobileError.value.isEmpty) {
      authController.register(name.value.toString(), email.value.toString(),
          mobile.value.toString(), password.value.toString());
    }
  }
}
