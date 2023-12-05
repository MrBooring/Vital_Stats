import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sqllitecrud/logic/controllers/login_controller.dart';

class LoginPage extends StatelessWidget {
  final LoginController loginController = Get.find();

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
        body: Obx(
      () => Container(
        height: size.height,
        width: size.width,
        decoration: const BoxDecoration(
            image: DecorationImage(
                image: AssetImage(
                  "assets/background/bg.png",
                ),
                fit: BoxFit.fill)),
        child: SafeArea(
          child: Padding(
            padding: EdgeInsets.all(16.0),
            child: Column(
              // mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Row(
                  children: [
                    Text(
                      "/Login",
                      style: Theme.of(context).textTheme.headlineMedium,
                    ),
                    Spacer(),
                    Padding(
                      padding: const EdgeInsets.all(4),
                      child: Container(
                        height: 4,
                        width: 40,
                        decoration: BoxDecoration(
                            color: Color(0xFF4F54BE),
                            borderRadius: BorderRadius.circular(10)),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(4),
                      child: Container(
                        height: 4,
                        width: 20,
                        decoration: BoxDecoration(
                            color: Colors.grey.shade700,
                            borderRadius: BorderRadius.circular(10)),
                      ),
                    ),
                  ],
                ),
                Divider(
                  thickness: 2,
                  color: Color(0xFF0F0F0F),
                ),
                Spacer(),
                TextFormField(
                  onChanged: loginController.emailValidation,
                  keyboardType: TextInputType.emailAddress,
                  cursorColor: Colors.white,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderSide: BorderSide(),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Colors.white,
                      ),
                    ),
                    labelText: 'Email',
                    labelStyle:
                        Theme.of(context).textTheme.titleMedium!.copyWith(
                              color: Colors.white,
                            ),
                    errorText: loginController.emailError.value.isNotEmpty
                        ? loginController.emailError.value
                        : null,
                  ),
                ),
                SizedBox(height: 16.0),
                TextFormField(
                  onChanged: loginController.passwordValidation,
                  keyboardType: TextInputType.visiblePassword,
                  obscureText: true,
                  decoration: InputDecoration(
                    labelText: 'Password',
                    labelStyle:
                        Theme.of(context).textTheme.titleMedium!.copyWith(
                              color: Colors.white,
                            ),
                    border: OutlineInputBorder(
                      borderSide: BorderSide(),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Colors.white,
                        width: 1,
                      ),
                    ),
                    errorText: loginController.passwordError.value.isNotEmpty
                        ? loginController.passwordError.value
                        : null,
                  ),
                ),
                SizedBox(height: 16.0),
                ElevatedButton(
                  onPressed: () {
                    FocusScope.of(context).unfocus();
                    loginController.login();
                  },
                  child: Text('Login'),
                  style: ElevatedButton.styleFrom(
                      backgroundColor: Color(0xFF4F54BE)),
                ),
                Spacer(),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("Don't have an account? "),
                    GestureDetector(
                      onTap: () {
                        Get.toNamed("/register");
                      },
                      child: Text(
                        'Register',
                        style: TextStyle(
                          color: Colors.blue,
                          decoration: TextDecoration.underline,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    ));
  }
}
