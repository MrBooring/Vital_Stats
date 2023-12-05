import 'package:get/get.dart';
import 'package:sqllitecrud/logic/controllers/auth_controller.dart';

class LoginController extends GetxController {
  var email = ''.obs;
  var password = ''.obs;
  var emailError = ''.obs;
  var passwordError = ''.obs;

  @override
  void onInit() {
    super.onInit();
    email.listen((value) {
      emailValidation(value);
    });
    password.listen((value) {
      passwordValidation(value);
    });
  }

  //same thing

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

  login() async {
    AuthController authController = Get.find();

    if (emailError.value.isEmpty && passwordError.value.isEmpty) {
      authController.login(email.value.toString(), password.value.toString());
    }
  }
}
