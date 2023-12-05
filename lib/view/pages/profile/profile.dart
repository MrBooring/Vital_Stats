import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:line_icons/line_icons.dart';
import 'package:sqllitecrud/logic/controllers/auth_controller.dart';

class Profile extends StatefulWidget {
  const Profile({super.key});

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    AuthController authController = Get.find();
    return SizedBox(
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(5),
            child: Container(
              padding: EdgeInsets.all(15),
              decoration: BoxDecoration(
                image: DecorationImage(
                    image: AssetImage("assets/background/profilecard.png"),
                    fit: BoxFit.fill),
                borderRadius: BorderRadius.circular(20),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 8.0),
                        child: CircleAvatar(
                          maxRadius: 50,
                          backgroundImage: AssetImage("assets/images/pp.jpg"),
                        ),
                      ),
                      Column(
                        children: [
                          Text("25",
                              style: Theme.of(context)
                                  .textTheme
                                  .titleMedium!
                                  .copyWith(color: Colors.white)),
                          Text("Age",
                              style: Theme.of(context)
                                  .textTheme
                                  .labelLarge!
                                  .copyWith(color: Colors.white)),
                        ],
                      ),
                      Column(
                        children: [
                          Text("80",
                              style: Theme.of(context)
                                  .textTheme
                                  .titleMedium!
                                  .copyWith(color: Colors.white)),
                          Text("Weight",
                              style: Theme.of(context)
                                  .textTheme
                                  .labelLarge!
                                  .copyWith(color: Colors.white)),
                        ],
                      ),
                      Column(
                        children: [
                          Text("5'9",
                              style: Theme.of(context)
                                  .textTheme
                                  .titleMedium!
                                  .copyWith(color: Colors.white)),
                          Text("Height",
                              style: Theme.of(context)
                                  .textTheme
                                  .labelLarge!
                                  .copyWith(color: Colors.white)),
                        ],
                      ),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 5.0),
                    child: SizedBox(
                      child: Text("${authController.loginUser['name']}",
                          style: Theme.of(context)
                              .textTheme
                              .titleMedium!
                              .copyWith(color: Colors.white)),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 5.0),
                    child: SizedBox(
                      child: Text(
                          "Mobile : ${authController.loginUser['mobile']}",
                          style: Theme.of(context)
                              .textTheme
                              .labelLarge!
                              .copyWith(color: Colors.white)),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 5.0),
                    child: SizedBox(
                      child: Text(
                          "Email : ${authController.loginUser['email']}",
                          style: Theme.of(context)
                              .textTheme
                              .labelLarge!
                              .copyWith(color: Colors.white)),
                    ),
                  ),
                ],
              ),
            ),
          ),
          const Divider(
            thickness: 0,
          ),
          ListTile(
            leading: Icon(LineIcons.userEdit),
            title: Text("Edit Profile"),
          ),
          const Divider(
            thickness: 0,
          ),
          ListTile(
            leading: Icon(LineIcons.cog),
            title: Text("App Settings"),
          ),
          const Divider(
            thickness: 0,
          ),
          ListTile(
            leading: Icon(LineIcons.certificate),
            title: Text("Privicy Policy"),
          ),
          const Divider(
            thickness: 0,
          ),
          ListTile(
            leading: Icon(LineIcons.suitcase),
            title: Text("Terms of Use"),
          ),
        ],
      ),
    );
  }
}
