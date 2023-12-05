import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gradient_slide_to_act/gradient_slide_to_act.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      height: size.height,
      width: size.width,
      decoration: const BoxDecoration(
        image: DecorationImage(
          image: AssetImage(
            "assets/background/bg.png",
          ),
          fit: BoxFit.fill,
        ),
      ),
      child: Scaffold(
          backgroundColor: Colors.transparent,
          body: SafeArea(
              child: Padding(
            padding: const EdgeInsets.all(10),
            child: Column(
              children: [
                Row(
                  children: [
                    Text(
                      "/Notice",
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
                    Padding(
                      padding: const EdgeInsets.all(4),
                      child: Container(
                        height: 4,
                        width: 20,
                        decoration: BoxDecoration(
                            color: Colors.grey.shade700,
                            borderRadius: BorderRadius.circular(10)),
                      ),
                    )
                  ],
                ),
                Divider(
                  thickness: 2,
                  color: Color(0xFF0F0F0F),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    "We Will Help You To Make Habbits.",
                    style: Theme.of(context).textTheme.displayMedium,
                  ),
                ),
                Spacer(),
                Padding(
                  padding: const EdgeInsets.all(10),
                  child: Text(
                    "Transform your life with our app, Develop positive habits, conquer addictions. Track progress, receive reminders, stay motivated, Unlock a happier, healthier you.",
                    style: Theme.of(context).textTheme.titleLarge!.copyWith(
                          color: Colors.white,
                        ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: GradientSlideToAct(
                    width: 400,
                    text: "Slide to Start",
                    textStyle: TextStyle(color: Colors.white, fontSize: 15),
                    backgroundColor: Color(0Xff172663),
                    onSubmit: () {
                      Get.offAndToNamed("/login");
                      // Get.toNamed("/home");
                    },
                    gradient: const LinearGradient(
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                        colors: [
                          Color(0xFFE9F8FF),
                          Color(0xFFC4D6F7),
                          Color(0xFF9FB0F2),
                          Color(0xFF7A8BE7),
                          Color(0xFF4F54BE),
                        ]),
                  ),
                )
              ],
            ),
          ))),
    );
  }
}
