import 'dart:developer';

import 'package:get/get.dart';

import '../../data/providers/sql_helper.dart';

class AuthController extends GetxController {
  @override
  void onInit() async {
    super.onInit();
  }

  var uid = 0.obs;
  var loginUser = {}.obs;
  Future<void> register(
      String name, String email, String phoneNumber, String password) async {
    if (name.isEmpty ||
        email.isEmpty ||
        phoneNumber.isEmpty ||
        password.isEmpty) {
      return;
    }
    final result =
        await SQLHelper.createUser(name, email, phoneNumber, password);
    if (result > 0) {
      Get.toNamed("/login");
      Get.snackbar("Success", "Registration successful");
    } else {
      Get.snackbar("Opps!", "User already exists");
    }
  }

  Future<void> login(String email, String password) async {
    log(email.toString());
    log(password.toString());

    if (email.isEmpty || password.isEmpty) {
      return;
    }
    final user = await SQLHelper.fetchUserByEmailAndPassword(email, password);

    if (user.containsKey('error')) {
      final error = user['error'];

      if (error == 'User not found') {
        Get.snackbar("Oops!", "User not found. Please register.");
      } else if (error == 'Incorrect password') {
        Get.snackbar("Oops!", "Incorrect password. Please try again.");
      }
    } else {
      uid.value = user['id'];
      loginUser.value = user;
      Get.offAllNamed("/home");
    }
  }

  Future<void> logout() async {}
}
