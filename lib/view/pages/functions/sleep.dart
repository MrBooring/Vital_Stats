import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:line_icons/line_icon.dart';
import 'package:line_icons/line_icons.dart';
import 'package:sqllitecrud/logic/controllers/sleep_t_controller.dart';
import 'package:swipeable_tile/swipeable_tile.dart';
import 'package:vibration/vibration.dart';

class SleepTracker extends StatefulWidget {
  const SleepTracker({super.key});

  @override
  State<SleepTracker> createState() => _SleepTrackerState();
}

class _SleepTrackerState extends State<SleepTracker> {
  SleepTController controller = Get.find();
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
        ),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(10),
            child: Column(
              children: [
                Row(
                  children: [
                    Text(
                      "/Sleep",
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
                        itemCount: controller.sleepData.length,
                        itemBuilder: (context, index) {
                          var data = controller.sleepData[index];
                          // " ${data['wakeUpTime']} - ${data['time']}"

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
                                  //delete
                                  controller.deleteSleep(data['id']);
                                } else {
                                  controller.wakeupTime.value =
                                      data['wakeUpTime'];
                                  controller.sleepTime.value =
                                      data['sleepTime'];
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
                                        child: Center(
                                          child: SizedBox(
                                            child: Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              mainAxisSize: MainAxisSize.min,
                                              children: <Widget>[
                                                Text(
                                                  "Had a Good Night?",
                                                  style: Theme.of(context)
                                                      .textTheme
                                                      .headlineLarge!
                                                      .copyWith(
                                                          fontWeight:
                                                              FontWeight.bold),
                                                  textAlign: TextAlign.justify,
                                                ),
                                                Padding(
                                                    padding: const EdgeInsets
                                                            .symmetric(
                                                        vertical: 10),
                                                    child: SleepTime(
                                                        wtime:
                                                            data['sleepTime'])),
                                                Padding(
                                                    padding: const EdgeInsets
                                                            .symmetric(
                                                        vertical: 10),
                                                    child: WakeUpTime(
                                                        wtime: data[
                                                            'wakeUpTime'])),
                                                SizedBox(
                                                  width: size.width,
                                                  child: ElevatedButton(
                                                    child: const Text('Submit'),
                                                    onPressed: () =>
                                                        controller.udpateSleep(
                                                            data['id']),
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
                                        ),
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
                                            child: Icon(LineIcons.trash),
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
                                            child: Icon(
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
                                    image: DecorationImage(
                                      image: AssetImage(
                                          "assets/background/card.png"),
                                      fit: BoxFit.fill,
                                    ),
                                    borderRadius: BorderRadius.circular(15)),
                                padding: EdgeInsets.all(10),
                                child: Row(
                                  children: [
                                    CircleAvatar(
                                      maxRadius: 18,
                                      backgroundColor:
                                          Colors.white.withOpacity(.8),
                                      child: Icon(LineIcons.bed),
                                    ),
                                    SizedBox(
                                      width: size.width * .15,
                                    ),
                                    Text(
                                        "Sleep : ${data['sleepTime']} - Wake : ${data['wakeUpTime']}  ",
                                        style: Theme.of(context)
                                            .textTheme
                                            .titleMedium!
                                            .copyWith(
                                              color: Colors.white,
                                            )),
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

class SleepTime extends StatefulWidget {
  final wtime;

  const SleepTime({super.key, required this.wtime});
  @override
  _SleepTimeState createState() => _SleepTimeState();
}

class _SleepTimeState extends State<SleepTime> {
  SleepTController sleepTController = Get.find();
  TimeOfDay? _selectedTime;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      cursorColor: Colors.white,
      readOnly: true,
      onTap: () async {
        final TimeOfDay? time = await showTimePicker(
          context: context,
          initialTime: TimeOfDay.now(),
        );

        if (time != null) {
          setState(() {
            _selectedTime = time;
          });

          sleepTController.sleepTime.value = time.toString().substring(
              time.toString().indexOf('(') + 1, time.toString().indexOf(')'));
        }
      },
      decoration: InputDecoration(
        border: const OutlineInputBorder(
          borderSide: BorderSide(color: Colors.white),
        ),
        focusedBorder: const OutlineInputBorder(
          borderSide: BorderSide(
            color: Colors.white,
          ),
        ),
        labelText: 'Sleep Time',
        labelStyle: Theme.of(context)
            .textTheme
            .titleMedium
            ?.copyWith(color: Colors.white),
      ),
      controller: TextEditingController(
        text: _selectedTime?.format(context) ?? widget.wtime,
      ),
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Please select a time';
        }
        return null;
      },
    );
  }
}

class WakeUpTime extends StatefulWidget {
  final wtime;

  const WakeUpTime({super.key, required this.wtime});
  @override
  _WakeUpTimeState createState() => _WakeUpTimeState();
}

class _WakeUpTimeState extends State<WakeUpTime> {
  SleepTController sleepTController = Get.find();
  TimeOfDay? _selectedTime;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      cursorColor: Colors.white,
      readOnly: true,
      onTap: () async {
        final TimeOfDay? time = await showTimePicker(
          context: context,
          initialTime: TimeOfDay.now(),
        );

        if (time != null) {
          setState(() {
            _selectedTime = time;
          });

          sleepTController.wakeupTime.value = time.toString().substring(
              time.toString().indexOf('(') + 1, time.toString().indexOf(')'));
        }
      },
      decoration: InputDecoration(
        border: const OutlineInputBorder(
          borderSide: BorderSide(color: Colors.white),
        ),
        focusedBorder: const OutlineInputBorder(
          borderSide: BorderSide(
            color: Colors.white,
          ),
        ),
        labelText: 'Wakeup Time',
        labelStyle: Theme.of(context)
            .textTheme
            .titleMedium
            ?.copyWith(color: Colors.white),
      ),
      controller: TextEditingController(
        text: _selectedTime?.format(context) ?? widget.wtime,
      ),
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Please select a time';
        }
        return null;
      },
    );
  }
}
