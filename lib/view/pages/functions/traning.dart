// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:line_icons/line_icons.dart';
import 'package:swipeable_tile/swipeable_tile.dart';
import 'package:vibration/vibration.dart';
import 'package:intl/intl.dart';

import '../../../logic/controllers/workout_t_controller.dart';

class Traning extends StatefulWidget {
  const Traning({super.key});

  @override
  State<Traning> createState() => _TraningState();
}

class _TraningState extends State<Traning> {
  WorkoutTController controller = Get.find();
  TextEditingController workoutController = TextEditingController();
  TextEditingController minController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: Container(
        height: size.height,
        width: size.width,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topRight,
            end: Alignment.bottomLeft,
            colors: [
              Color(0xFFE9F8FF),
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
          child: Padding(
            padding: const EdgeInsets.all(10),
            child: Column(
              children: [
                Row(
                  children: [
                    Text(
                      "/Fitness",
                      style: Theme.of(context).textTheme.headlineMedium,
                    ),
                    const Spacer(),
                    Padding(
                      padding: const EdgeInsets.all(4),
                      child: Container(
                        height: 4,
                        width: 40,
                        decoration: BoxDecoration(
                            color: const Color(0xFF4F54BE),
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
                Obx(() => Expanded(
                        child: SizedBox(
                      child: ListView.builder(
                        shrinkWrap: true,
                        itemCount: controller.workOutData.length,
                        itemBuilder: (context, index) {
                          var data = controller.workOutData[index];
                          return Padding(
                            padding: const EdgeInsets.symmetric(vertical: 10),
                            child: SwipeableTile.swipeToTrigger(
                              color: Colors.transparent,
                              // shadow: BoxShadow(
                              //   color: Colors.black.withOpacity(0.35),
                              //   blurRadius: 4,
                              //   offset: Offset(2  , 2),
                              // ),

                              behavior: HitTestBehavior.translucent,
                              direction: SwipeDirection.horizontal,

                              onSwiped: (direction) {
                                // Here call setState to update state

                                if (direction == SwipeDirection.endToStart) {
                                  controller.deleteWorkoutDetails(data['id']);
                                } else {
                                  controller.workouttime.value = data['wtime'];
                                  workoutController.text = data['workoutName'];
                                  minController.text = data['wtime'];
                                  controller.workoutName.value =
                                      data['workoutName'];

                                  showModalBottomSheet(
                                    isScrollControlled: true,
                                    context: context,
                                    builder: (BuildContext context) {
                                      return Container(
                                        // height: size.height * .4,
                                        decoration: const BoxDecoration(
                                          gradient: LinearGradient(
                                            begin: Alignment.topCenter,
                                            end: Alignment.bottomCenter,
                                            colors: [
                                              // Color(0xFFE9F8FF),
                                              // Color(0xFFC4D6F7),
                                              Color(0xFF9FB0F2),
                                              Color(0xFF7A8BE7),
                                              Color(0xFF4F54BE),
                                            ],
                                          ),
                                        ),
                                        padding: EdgeInsets.only(
                                          left: 10,
                                          right: 10,
                                          top: 10,
                                          bottom: MediaQuery.of(context)
                                              .viewInsets
                                              .bottom,
                                        ),
                                        child: Obx(() => Center(
                                              child: SizedBox(
                                                child: Column(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  mainAxisSize:
                                                      MainAxisSize.min,
                                                  children: <Widget>[
                                                    Text(
                                                      "What kind of Exercise you did",
                                                      style: Theme.of(context)
                                                          .textTheme
                                                          .headlineLarge!
                                                          .copyWith(
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold),
                                                      textAlign:
                                                          TextAlign.justify,
                                                    ),
                                                    Padding(
                                                      padding: const EdgeInsets
                                                              .symmetric(
                                                          vertical: 10),
                                                      child: TextFormField(
                                                        controller:
                                                            workoutController,
                                                        onChanged: (value) {
                                                          controller
                                                              .validationWorkoutName(
                                                                  value);
                                                        },
                                                        cursorColor:
                                                            Colors.white,
                                                        decoration:
                                                            InputDecoration(
                                                          border:
                                                              const OutlineInputBorder(
                                                            borderSide:
                                                                BorderSide(),
                                                          ),
                                                          focusedBorder:
                                                              const OutlineInputBorder(
                                                            borderSide:
                                                                BorderSide(
                                                              color:
                                                                  Colors.white,
                                                            ),
                                                          ),
                                                          labelText: 'Name',
                                                          labelStyle:
                                                              Theme.of(context)
                                                                  .textTheme
                                                                  .titleMedium!
                                                                  .copyWith(
                                                                    color: Colors
                                                                        .white,
                                                                  ),
                                                          errorText: controller
                                                                  .workoutError
                                                                  .value
                                                                  .isNotEmpty
                                                              ? controller
                                                                  .workoutError
                                                                  .value
                                                              : null,
                                                        ),
                                                      ),
                                                    ),
                                                    Padding(
                                                      padding: const EdgeInsets
                                                              .symmetric(
                                                          vertical: 10),
                                                      child: TextFormField(
                                                        controller:
                                                            minController,
                                                        inputFormatters: [
                                                          FilteringTextInputFormatter
                                                              .digitsOnly,
                                                          LengthLimitingTextInputFormatter(
                                                              2),
                                                        ],
                                                        keyboardType:
                                                            TextInputType
                                                                .number,
                                                        onChanged: (value) {
                                                          controller
                                                              .validationWorkoutmin(
                                                                  value);
                                                        },
                                                        cursorColor:
                                                            Colors.white,
                                                        decoration:
                                                            InputDecoration(
                                                          border:
                                                              const OutlineInputBorder(
                                                            borderSide:
                                                                BorderSide(),
                                                          ),
                                                          focusedBorder:
                                                              const OutlineInputBorder(
                                                            borderSide:
                                                                BorderSide(
                                                              color:
                                                                  Colors.white,
                                                            ),
                                                          ),
                                                          labelText: 'Minutes ',
                                                          labelStyle:
                                                              Theme.of(context)
                                                                  .textTheme
                                                                  .titleMedium!
                                                                  .copyWith(
                                                                    color: Colors
                                                                        .white,
                                                                  ),
                                                          errorText: controller
                                                                  .workouttimeError
                                                                  .value
                                                                  .isNotEmpty
                                                              ? controller
                                                                  .workouttimeError
                                                                  .value
                                                              : null,
                                                        ),
                                                      ),
                                                    ),
                                                    SizedBox(
                                                      width: size.width,
                                                      child: ElevatedButton(
                                                        child: const Text(
                                                            'Submit'),
                                                        onPressed: () {
                                                          controller
                                                              .updateWorkoutDetails(
                                                                  data['id']);
                                                        },
                                                        style: ElevatedButton
                                                            .styleFrom(
                                                                backgroundColor:
                                                                    const Color(
                                                                        0xFF4F54BE)),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            )),
                                      );
                                    },
                                  );
                                }
                              },
                              backgroundBuilder:
                                  (context, direction, progress) {
                                bool vibrated = false;
                                if (progress.value > 0.9999 && !vibrated) {
                                  Vibration.vibrate(duration: 40);
                                  vibrated = true;
                                } else if (progress.value < 0.9999) {
                                  vibrated = false;
                                }
                                // You can animate background using the progress
                                return AnimatedBuilder(
                                  animation: progress,
                                  builder: (context, child) {
                                    if (direction ==
                                        SwipeDirection.endToStart) {
                                      return AnimatedContainer(
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(15),
                                          color: Colors.red,
                                        ),
                                        alignment: Alignment.centerRight,
                                        duration:
                                            const Duration(milliseconds: 400),
                                        child: Padding(
                                          padding: const EdgeInsets.only(
                                              right: 16.0),
                                          child: Transform.scale(
                                            scale: Tween<double>(
                                              begin: 0.0,
                                              end: 1.2,
                                            )
                                                .animate(
                                                  CurvedAnimation(
                                                    parent: progress,
                                                    curve: const Interval(
                                                        0.5, 1.0,
                                                        curve: Curves.linear),
                                                  ),
                                                )
                                                .value,
                                            child: const Icon(LineIcons.trash),
                                          ),
                                        ),
                                      );
                                    } else {
                                      return AnimatedContainer(
                                        alignment: Alignment.centerLeft,
                                        duration:
                                            const Duration(milliseconds: 400),
                                        decoration: BoxDecoration(
                                          color: Colors.teal,
                                          borderRadius:
                                              BorderRadius.circular(15),
                                        ),
                                        child: Padding(
                                          padding:
                                              const EdgeInsets.only(left: 50.0),
                                          child: Transform.scale(
                                            scale: Tween<double>(
                                              begin: 0.0,
                                              end: 1.2,
                                            )
                                                .animate(
                                                  CurvedAnimation(
                                                    parent: progress,
                                                    curve: const Interval(
                                                        0.5, 1.0,
                                                        curve: Curves.linear),
                                                  ),
                                                )
                                                .value,
                                            child: const Icon(
                                              LineIcons.edit,
                                            ),
                                          ),
                                        ),
                                      );
                                    }
                                  },
                                );
                              },
                              key: UniqueKey(),
                              child: Container(
                                decoration: BoxDecoration(
                                    image: const DecorationImage(
                                      image: AssetImage(
                                          "assets/background/card.png"),
                                      fit: BoxFit.fill,
                                    ),
                                    borderRadius: BorderRadius.circular(15)),
                                padding: const EdgeInsets.all(10),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    CircleAvatar(
                                      maxRadius: 18,
                                      backgroundColor:
                                          Colors.white.withOpacity(.8),
                                      child: const Icon(LineIcons.dumbbell),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: SizedBox(
                                        width: size.width * .33,
                                        child: Text(
                                          data['workoutName'],
                                          overflow: TextOverflow.ellipsis,
                                          style: Theme.of(context)
                                              .textTheme
                                              .titleLarge!
                                              .copyWith(
                                                color: Colors.white,
                                              ),
                                        ),
                                      ),
                                    ),
                                    Text(
                                      "${data['wtime']} Min || ${DateFormat('dd - MM').format(DateTime.parse(data['date'].toString()))}",
                                      style: Theme.of(context)
                                          .textTheme
                                          .titleMedium!
                                          .copyWith(
                                            color: Colors.white,
                                          ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                    )))
              ],
            ),
          ),
        ),
      ),
    );
  }
}
