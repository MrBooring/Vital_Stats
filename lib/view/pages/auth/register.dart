import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sqllitecrud/logic/controllers/register_controller.dart';

class RegisterPage extends StatelessWidget {
  final RegisterController _registerController = Get.find();

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
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Row(
                  children: [
                    Text(
                      "/Register",
                      style: Theme.of(context).textTheme.headlineMedium,
                    ),
                    Spacer(),
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
                  ],
                ),
                Divider(
                  thickness: 2,
                  color: Color(0xFF0F0F0F),
                ),
                Spacer(),
                TextFormField(
                  onChanged: _registerController.nameValidation,
                  keyboardType: TextInputType.name,
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
                    labelStyle:
                        Theme.of(context).textTheme.titleMedium!.copyWith(
                              color: Colors.white,
                            ),
                    labelText: 'Name',
                    errorText: _registerController.nameError.value.isNotEmpty
                        ? _registerController.nameError.value
                        : null,
                  ),
                ),
                SizedBox(height: 16.0),
                TextFormField(
                  onChanged: _registerController.emailValidation,
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
                    labelStyle:
                        Theme.of(context).textTheme.titleMedium!.copyWith(
                              color: Colors.white,
                            ),
                    labelText: 'Email',
                    errorText: _registerController.emailError.value.isNotEmpty
                        ? _registerController.emailError.value
                        : null,
                  ),
                ),
                SizedBox(height: 16.0),
                TextFormField(
                  onChanged: _registerController.mobileValidation,
                  cursorColor: Colors.white,
                  keyboardType: TextInputType.phone,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderSide: BorderSide(),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Colors.white,
                      ),
                    ),
                    labelStyle:
                        Theme.of(context).textTheme.titleMedium!.copyWith(
                              color: Colors.white,
                            ),
                    labelText: 'Mobile',
                    errorText: _registerController.mobileError.value.isNotEmpty
                        ? _registerController.mobileError.value
                        : null,
                  ),
                ),
                SizedBox(height: 16.0),
                TextFormField(
                  onChanged: _registerController.passwordValidation,
                  keyboardType: TextInputType.visiblePassword,
                  obscureText: true,
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
                    labelStyle:
                        Theme.of(context).textTheme.titleMedium!.copyWith(
                              color: Colors.white,
                            ),
                    labelText: 'Password',
                    errorText:
                        _registerController.passwordError.value.isNotEmpty
                            ? _registerController.passwordError.value
                            : null,
                  ),
                ),
                SizedBox(height: 16.0),
                ElevatedButton(
                  onPressed: _registerController.register,
                  child: Text('Register'),
                  style: ElevatedButton.styleFrom(
                      backgroundColor: Color(0xFF4F54BE)),
                ),
                Spacer(),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("Already have an account? "),
                    GestureDetector(
                      onTap: () {
                        Get.back();
                      },
                      child: Text(
                        'Login',
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
