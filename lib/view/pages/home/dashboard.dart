import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';
import 'package:sqllitecrud/logic/controllers/auth_controller.dart';
import 'package:sqllitecrud/logic/controllers/calender_controller.dart';
import 'package:sqllitecrud/logic/controllers/food_t_controller.dart';
import 'package:sqllitecrud/logic/controllers/water_t_controller.dart';
import 'package:sqllitecrud/logic/controllers/workout_t_controller.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({super.key});

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  @override
  Widget build(BuildContext context) {
    final currentTime = DateTime.now();
    final currentTimeFormatted = DateFormat('HH:mm').format(currentTime);
    final currentHour = int.parse(currentTimeFormatted.split(':')[0]);

    String greetingMessage = '';

    if (currentHour >= 0 && currentHour < 12) {
      greetingMessage = 'Good Morning';
    } else if (currentHour >= 12 && currentHour < 18) {
      greetingMessage = 'Good Afternoon';
    } else {
      greetingMessage = 'Good Evening';
    }
    AuthController authController = Get.find();
    Size size = MediaQuery.of(context).size;
    CalenderController ccontroller = Get.find();
    WaterTController waterTController = Get.find();
    WorkoutTController workoutTController = Get.find();
    FoodTController foodTController = Get.find();
    return SizedBox(
      child: Column(
        children: [
          Row(
            children: [
              const Padding(
                padding: EdgeInsets.all(1),
                child: CircleAvatar(
                  maxRadius: 25,
                  backgroundColor: Colors.blue,
                  backgroundImage: AssetImage("assets/images/pp.jpg"),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      greetingMessage,
                      style: Theme.of(context)
                          .textTheme
                          .titleLarge
                          ?.copyWith(fontWeight: FontWeight.bold),
                    ),
                    Text(
                      "${authController.loginUser['name']}",
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                  ],
                ),
              ),
            ],
          ),
          const Divider(
            thickness: 2,
            color: Color(0xFF0F0F0F),
          ),
          SizedBox(
              height: size.height * .18,
              child: ScrollablePositionedList.builder(
                itemScrollController: ccontroller.itemcontroller,
                // itemPositionsListener: ccontroller.itemlistner,
                itemCount: ccontroller.dates.length,
                scrollDirection: Axis.horizontal,
                itemBuilder: (context, index) {
                  return Obx(() => Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 15),
                        child: GestureDetector(
                          onTap: () {
                            ccontroller.onDateChanged(index);
                            ccontroller.scrollToItem(index);
                          },
                          child: Container(
                            decoration: BoxDecoration(
                                shape: BoxShape.rectangle,
                                borderRadius:
                                    BorderRadius.circular(size.height * .04),
                                image: const DecorationImage(
                                    image: AssetImage(
                                        "assets/background/calendercard.png"),
                                    fit: BoxFit.fill),
                                boxShadow: ccontroller.seletedDateindex.value ==
                                        index
                                    ? [
                                        BoxShadow(
                                          color: Colors.grey.withOpacity(0.5),
                                          spreadRadius: 2, // Spread radius
                                          blurRadius: 2, // Blur radius
                                          offset: const Offset(0, 3),
                                        ),
                                      ]
                                    : [
                                        BoxShadow(
                                          color: Colors.grey.withOpacity(0.5),
                                          spreadRadius: 2, // Spread radius
                                          blurRadius: 5, // Blur radius
                                          offset: const Offset(0, 3),
                                        ),
                                      ]),
                            // elevation:
                            //     ? 20
                            //     : 3,
                            margin: EdgeInsets.fromLTRB(
                              size.height * .03,
                              size.height * .015,
                              size.height * .03,
                              size.height * .03,
                            ),
                            child: Center(
                              child: Align(
                                alignment: Alignment.topLeft,
                                child: SizedBox(
                                  // height: size.height * .03,
                                  width: size.width * .2,
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                      vertical: 10,
                                    ),
                                    child: Column(
                                      children: [
                                        Text(
                                            ccontroller.dates[index].toString(),
                                            style: Theme.of(context)
                                                .textTheme
                                                .titleMedium!
                                                .copyWith(color: Colors.white)),
                                        Text(ccontroller.days[index].toString(),
                                            style: Theme.of(context)
                                                .textTheme
                                                .labelSmall!
                                                .copyWith(color: Colors.white)),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ));
                },
              )),
          const Divider(
            thickness: 0,
          ),
          GestureDetector(
            onTap: () {
              Get.toNamed("/Traning");
            },
            child: Container(
              height: size.height * .2,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                image: const DecorationImage(
                  image: AssetImage("assets/background/exercsetracker.png"),
                  fit: BoxFit.fill,
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  vertical: 30,
                  horizontal: 20,
                ),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Obx(() => Text(
                          (workoutTController.totalworkout / 60)
                              .toStringAsFixed(2),
                          style: Theme.of(context)
                              .textTheme
                              .displayMedium!
                              .copyWith(
                                color: Colors.white,
                                fontStyle: FontStyle.italic,
                              ),
                        )),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Hours",
                            style: Theme.of(context)
                                .textTheme
                                .headlineSmall!
                                .copyWith(
                                  color: Colors.white,
                                  fontStyle: FontStyle.italic,
                                ),
                          ),
                          Text(
                            "of Traning",
                            style: Theme.of(context)
                                .textTheme
                                .headlineSmall!
                                .copyWith(
                                  color: Colors.white,
                                  fontStyle: FontStyle.italic,
                                ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          const Divider(
            thickness: 0,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SizedBox(
                child: GestureDetector(
                  onTap: () {
                    Get.toNamed("/waterTracker");
                  },
                  child: Container(
                    height: size.height * .33,
                    width: size.width * .45,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      image: const DecorationImage(
                        image: AssetImage("assets/background/water.png"),
                        fit: BoxFit.fill,
                      ),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: Column(
                        children: [
                          SizedBox(
                            height: size.height * .15,
                          ),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Obx(() => Text(
                                    "${waterTController.totalWaterGlass}",
                                    style: Theme.of(context)
                                        .textTheme
                                        .displayMedium!
                                        .copyWith(
                                          color: Colors.white,
                                          fontStyle: FontStyle.italic,
                                        ),
                                  )),
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 10),
                                child: Column(
                                  children: [
                                    SizedBox(
                                      height: size.height * .03,
                                    ),
                                    Text(
                                      "",
                                      style: Theme.of(context)
                                          .textTheme
                                          .headlineSmall!
                                          .copyWith(
                                            color: Colors.white,
                                            fontStyle: FontStyle.italic,
                                          ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                          Text(
                            "Glass of Water Intake",
                            style: Theme.of(context)
                                .textTheme
                                .titleLarge!
                                .copyWith(
                                  color: Colors.white,
                                  fontStyle: FontStyle.italic,
                                ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(
                child: Column(
                  children: [
                    GestureDetector(
                      onTap: () {
                        Get.toNamed("/foodTracker");
                      },
                      child: Container(
                        height: size.height * .15,
                        width: size.width * .45,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          image: const DecorationImage(
                            image: AssetImage("assets/background/food.png"),
                            fit: BoxFit.fill,
                          ),
                        ),
                        child: Padding(
                          padding:
                              EdgeInsets.symmetric(horizontal: 15, vertical: 1),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Obx(() => Text(
                                    "${foodTController.totalCal}",
                                    style: Theme.of(context)
                                        .textTheme
                                        .headlineLarge!
                                        .copyWith(
                                          color: Colors.white,
                                          fontStyle: FontStyle.italic,
                                        ),
                                  )),
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 10),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    SizedBox(
                                      height: size.height * .015,
                                    ),
                                    Text(
                                      "Calories",
                                      style: Theme.of(context)
                                          .textTheme
                                          .titleMedium!
                                          .copyWith(
                                            color: Colors.white,
                                            fontStyle: FontStyle.italic,
                                          ),
                                    ),
                                    Text(
                                      "Ingested",
                                      style: Theme.of(context)
                                          .textTheme
                                          .titleSmall!
                                          .copyWith(
                                            color: Colors.white,
                                            fontStyle: FontStyle.italic,
                                          ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    const Divider(
                      thickness: 0,
                    ),
                    GestureDetector(
                      onTap: () {
                        Get.toNamed("/sleepTracker");
                      },
                      child: Container(
                        height: size.height * .15,
                        width: size.width * .45,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          image: const DecorationImage(
                            image: AssetImage("assets/background/sleep.png"),
                            fit: BoxFit.fill,
                          ),
                        ),
                        child: Padding(
                          padding: EdgeInsets.symmetric(
                              horizontal: 10, vertical: size.height * .008),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Text(
                                    "39",
                                    style: Theme.of(context)
                                        .textTheme
                                        .displaySmall!
                                        .copyWith(
                                          color: Colors.white,
                                          fontStyle: FontStyle.italic,
                                        ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 5),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          "Hours",
                                          style: Theme.of(context)
                                              .textTheme
                                              .titleMedium!
                                              .copyWith(
                                                color: Colors.white,
                                                fontStyle: FontStyle.italic,
                                              ),
                                        ),
                                        Text(
                                          "of Snooze",
                                          style: Theme.of(context)
                                              .textTheme
                                              .titleSmall!
                                              .copyWith(
                                                color: Colors.white,
                                                fontStyle: FontStyle.italic,
                                              ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: size.height * .01,
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const Spacer(),
        ],
      ),
    );
  }
}
