import 'package:flutter/material.dart';
import 'package:flutter_expandable_fab/flutter_expandable_fab.dart';
import 'package:get/get.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:line_icons/line_icons.dart';

import 'package:sqllitecrud/view/pages/home/dashboard.dart';
import 'package:sqllitecrud/view/pages/home/widgets/fab_button.dart';
import 'package:sqllitecrud/view/pages/profile/profile.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    var selectedIndex = 0.obs;
    return WillPopScope(
      onWillPop: () => onWillPop(context),
      child: Obx(
        () => Scaffold(
          // resizeToAvoidBottomInset: true,
          floatingActionButtonLocation: ExpandableFab.location,
          body: Container(
            height: size.height,
            width: size.width,
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topRight,
                end: Alignment.bottomLeft,
                colors: [
                  Color(0xFFE9F8FF),
                  Color(0xFFC4D6F7),
                  Color(0xFF9FB0F2),
                  Color(0xFF7A8BE7),
                  Color(0xFF4F54BE),
                ],
              ),
              // image: DecorationImage(
              //     image: AssetImage(
              //       "assets/background/bg.png",
              //     ),
              //     fit: BoxFit.fill)
            ),
            child: SafeArea(
              child: Stack(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(10),
                    child: SizedBox(
                      height: size.height,
                      child: Column(
                        children: [
                          Expanded(
                            child: selectedIndex.value == 3
                                ? Profile()
                                : Dashboard(),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 15.0, vertical: 10),
                            child: GNav(
                              haptic: true,
                              rippleColor: Colors.grey[300]!,
                              hoverColor: Colors.grey[100]!,
                              backgroundColor: Colors.transparent,
                              gap: 8,
                              activeColor: Colors.black,
                              iconSize: 24,
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 20, vertical: 10),
                              duration: const Duration(milliseconds: 400),
                              tabBackgroundColor:
                                  Colors.grey[100]!.withOpacity(.3),
                              color: Colors.black,
                              tabs: [
                                const GButton(
                                  icon: LineIcons.home,
                                  text: 'Home',
                                ),
                                GButton(
                                    icon: LineIcons.heart,
                                    text: 'Likes',
                                    onPressed: () {}),
                                const GButton(
                                  icon: LineIcons.search,
                                  text: 'Search',
                                ),
                                const GButton(
                                  icon: LineIcons.user,
                                  text: 'Profile',
                                ),
                              ],
                              selectedIndex: selectedIndex.value,
                              onTabChange: (index) {
                                selectedIndex.value = index;
                                print(selectedIndex.value);
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  selectedIndex.value == 3
                      ? SizedBox()
                      : Positioned(
                          top:
                              1, // Adjust the values as per your desired position
                          right: 1,
                          child: Fab(
                            size: size,
                          ),
                        ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

Future<bool> onWillPop(context) async {
  return (await showDialog(
        context: context,
        builder: (context) => AlertDialog(
          backgroundColor: Colors.teal,
          title: Text('Are you sure?'),
          content: Text('Do you want to exit the App'),
          actions: <Widget>[
            TextButton(
              onPressed: () => Navigator.of(context).pop(false),
              child: Text('No'),
            ),
            TextButton(
              onPressed: () => Navigator.of(context).pop(true),
              child: Text('Yes'),
            ),
          ],
        ),
      )) ??
      false;
}
