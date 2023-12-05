import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_expandable_fab/flutter_expandable_fab.dart';
import 'package:get/get.dart';
import 'package:line_icons/line_icons.dart';
import 'package:sqllitecrud/logic/controllers/food_t_controller.dart';
import 'package:sqllitecrud/logic/controllers/sleep_t_controller.dart';
import 'package:sqllitecrud/logic/controllers/water_t_controller.dart';
import 'package:sqllitecrud/logic/controllers/workout_t_controller.dart';

class Fab extends StatelessWidget {
  const Fab({
    super.key,
    required this.size,
  });
  final size;
  @override
  Widget build(BuildContext context) {
    WorkoutTController workoutTController = Get.find();
    WaterTController waterTController = Get.find();
    FoodTController foodTController = Get.find();
    SleepTController sleepTController = Get.find();
    final key = GlobalObjectKey<ExpandableFabState>(context);
    return RotatedBox(
      quarterTurns: 3,
      child: GestureDetector(
        onTap: () {
          key.currentState!.toggle();
        },
        child: SizedBox(
          height: size.height,
          width: size.width,
          child: ExpandableFab(
            key: key,
            openButtonHeroTag: "op",
            closeButtonHeroTag: "cl",
            type: ExpandableFabType.fan,
            collapsedFabSize: ExpandableFabSize.small,
            fanAngle: 100,
            distance: 130,
            child: const Icon(Icons.add),
            backgroundColor: const Color(0xFF4F54BE),
            collapsedFabShape: const CircleBorder(),
            closeButtonStyle: const ExpandableFabCloseButtonStyle(
              backgroundColor: Color(0xFF7A8BE7),
            ),
            overlayStyle: ExpandableFabOverlayStyle(
              blur: 5,
            ),
            children: [
              RotatedBox(
                quarterTurns: 1,
                child: FloatingActionButton.small(
                  backgroundColor: const Color(0xFF4F54BE),
                  heroTag: "sleep",
                  child: const Icon(LineIcons.bed),
                  onPressed: () {
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
                            bottom: MediaQuery.of(context).viewInsets.bottom,
                          ),
                          child: Center(
                            child: SizedBox(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                mainAxisSize: MainAxisSize.min,
                                children: <Widget>[
                                  Text(
                                    "Had a Good Night?",
                                    style: Theme.of(context)
                                        .textTheme
                                        .headlineLarge!
                                        .copyWith(fontWeight: FontWeight.bold),
                                    textAlign: TextAlign.justify,
                                  ),
                                  Padding(
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 10),
                                      child: SleepTime()),
                                  Padding(
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 10),
                                      child: WaleUpTime()),
                                  SizedBox(
                                    width: size.width,
                                    child: ElevatedButton(
                                      child: const Text('Submit'),
                                      onPressed: () =>
                                          sleepTController.addSleepData(),
                                      style: ElevatedButton.styleFrom(
                                          backgroundColor:
                                              const Color(0xFF4F54BE)),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        );
                      },
                    );
                  },
                ),
              ),
              RotatedBox(
                quarterTurns: 1,
                child: FloatingActionButton.small(
                  backgroundColor: const Color(0xFF4F54BE),
                  heroTag: "food",
                  child: const Icon(LineIcons.gripfireInc),
                  onPressed: () {
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
                            bottom: MediaQuery.of(context).viewInsets.bottom,
                          ),
                          child: Obx(() => Center(
                                child: SizedBox(
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    mainAxisSize: MainAxisSize.min,
                                    children: <Widget>[
                                      Text(
                                        "What did you Eat!?",
                                        style: Theme.of(context)
                                            .textTheme
                                            .headlineLarge!
                                            .copyWith(
                                                fontWeight: FontWeight.bold),
                                        textAlign: TextAlign.justify,
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.symmetric(
                                            vertical: 10),
                                        child: TextFormField(
                                          onChanged:
                                              foodTController.validateFoodName,
                                          cursorColor: Colors.white,
                                          decoration: InputDecoration(
                                            border: const OutlineInputBorder(
                                              borderSide: BorderSide(),
                                            ),
                                            focusedBorder:
                                                const OutlineInputBorder(
                                              borderSide: BorderSide(
                                                color: Colors.white,
                                              ),
                                            ),
                                            labelText: 'Food',
                                            labelStyle: Theme.of(context)
                                                .textTheme
                                                .titleMedium!
                                                .copyWith(
                                                  color: Colors.white,
                                                ),
                                            errorText: foodTController
                                                    .foodNameError
                                                    .value
                                                    .isNotEmpty
                                                ? foodTController
                                                    .foodNameError.value
                                                : null,
                                          ),
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.symmetric(
                                            vertical: 10),
                                        child: TextFormField(
                                          keyboardType: TextInputType.number,
                                          onChanged:
                                              foodTController.validateUnit,
                                          cursorColor: Colors.white,
                                          decoration: InputDecoration(
                                            border: const OutlineInputBorder(
                                              borderSide: BorderSide(),
                                            ),
                                            focusedBorder:
                                                const OutlineInputBorder(
                                              borderSide: BorderSide(
                                                color: Colors.white,
                                              ),
                                            ),
                                            labelText: 'Calories',
                                            labelStyle: Theme.of(context)
                                                .textTheme
                                                .titleMedium!
                                                .copyWith(
                                                  color: Colors.white,
                                                ),
                                            errorText: foodTController
                                                    .unitError.value.isNotEmpty
                                                ? foodTController
                                                    .unitError.value
                                                : null,
                                          ),
                                        ),
                                      ),
                                      SizedBox(
                                        width: size.width,
                                        child: ElevatedButton(
                                          child: Text('Submit'),
                                          onPressed: () {
                                            foodTController.addFood();
                                          },
                                          style: ElevatedButton.styleFrom(
                                              backgroundColor:
                                                  const Color(0xFF4F54BE)),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              )),
                        );
                      },
                    );
                  },
                ),
              ),
              RotatedBox(
                quarterTurns: 1,
                child: FloatingActionButton.small(
                  heroTag: "water",
                  backgroundColor: const Color(0xFF4F54BE),
                  child: const Icon(LineIcons.tint),
                  onPressed: () {
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
                            bottom: MediaQuery.of(context).viewInsets.bottom,
                          ),
                          child: Obx(() => Center(
                                child: SizedBox(
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    mainAxisSize: MainAxisSize.min,
                                    children: <Widget>[
                                      Text(
                                        "How much Glasses of water did you drink",
                                        style: Theme.of(context)
                                            .textTheme
                                            .headlineLarge!
                                            .copyWith(
                                                fontWeight: FontWeight.bold),
                                        textAlign: TextAlign.justify,
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.symmetric(
                                            vertical: 10),
                                        child: TextFormField(
                                          keyboardType: TextInputType.number,
                                          onChanged: waterTController
                                              .validationGlassCount,
                                          cursorColor: Colors.white,
                                          inputFormatters: [
                                            FilteringTextInputFormatter
                                                .digitsOnly,
                                            LengthLimitingTextInputFormatter(2),
                                          ],
                                          decoration: InputDecoration(
                                            border: const OutlineInputBorder(
                                              borderSide: BorderSide(),
                                            ),
                                            focusedBorder:
                                                const OutlineInputBorder(
                                              borderSide: BorderSide(
                                                color: Colors.white,
                                              ),
                                            ),
                                            labelText: 'Glass',
                                            labelStyle: Theme.of(context)
                                                .textTheme
                                                .titleMedium!
                                                .copyWith(
                                                  color: Colors.white,
                                                ),
                                            errorText: waterTController
                                                    .glassCountError
                                                    .value
                                                    .isNotEmpty
                                                ? waterTController
                                                    .glassCountError.value
                                                : null,
                                          ),
                                        ),
                                      ),
                                      SizedBox(
                                        width: size.width,
                                        child: ElevatedButton(
                                          child: const Text('Submit'),
                                          onPressed: () {
                                            waterTController.addWaterData();
                                          },
                                          style: ElevatedButton.styleFrom(
                                              backgroundColor:
                                                  const Color(0xFF4F54BE)),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              )),
                        );
                      },
                    );
                  },
                ),
              ),
              RotatedBox(
                quarterTurns: 1,
                child: FloatingActionButton.small(
                  heroTag: "training",
                  backgroundColor: const Color(0xFF4F54BE),
                  child: const Icon(LineIcons.dumbbell),
                  onPressed: () {
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
                            bottom: MediaQuery.of(context).viewInsets.bottom,
                          ),
                          child: Obx(() => Center(
                                child: SizedBox(
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    mainAxisSize: MainAxisSize.min,
                                    children: <Widget>[
                                      Text(
                                        "What kind of Exercise you did",
                                        style: Theme.of(context)
                                            .textTheme
                                            .headlineLarge!
                                            .copyWith(
                                                fontWeight: FontWeight.bold),
                                        textAlign: TextAlign.justify,
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.symmetric(
                                            vertical: 10),
                                        child: TextFormField(
                                          onChanged: (value) {
                                            workoutTController
                                                .validationWorkoutName(value);
                                          },
                                          cursorColor: Colors.white,
                                          decoration: InputDecoration(
                                            border: const OutlineInputBorder(
                                              borderSide: BorderSide(),
                                            ),
                                            focusedBorder:
                                                const OutlineInputBorder(
                                              borderSide: BorderSide(
                                                color: Colors.white,
                                              ),
                                            ),
                                            labelText: 'Name',
                                            labelStyle: Theme.of(context)
                                                .textTheme
                                                .titleMedium!
                                                .copyWith(
                                                  color: Colors.white,
                                                ),
                                            errorText: workoutTController
                                                    .workoutError
                                                    .value
                                                    .isNotEmpty
                                                ? workoutTController
                                                    .workoutError.value
                                                : null,
                                          ),
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.symmetric(
                                            vertical: 10),
                                        child: TextFormField(
                                          inputFormatters: [
                                            FilteringTextInputFormatter
                                                .digitsOnly,
                                            LengthLimitingTextInputFormatter(2),
                                          ],
                                          keyboardType: TextInputType.number,
                                          onChanged: (value) {
                                            workoutTController
                                                .validationWorkoutmin(value);
                                          },
                                          cursorColor: Colors.white,
                                          decoration: InputDecoration(
                                            border: const OutlineInputBorder(
                                              borderSide: BorderSide(),
                                            ),
                                            focusedBorder:
                                                const OutlineInputBorder(
                                              borderSide: BorderSide(
                                                color: Colors.white,
                                              ),
                                            ),
                                            labelText: 'Minutes ',
                                            labelStyle: Theme.of(context)
                                                .textTheme
                                                .titleMedium!
                                                .copyWith(
                                                  color: Colors.white,
                                                ),
                                            errorText: workoutTController
                                                    .workouttimeError
                                                    .value
                                                    .isNotEmpty
                                                ? workoutTController
                                                    .workouttimeError.value
                                                : null,
                                          ),
                                        ),
                                      ),
                                      SizedBox(
                                        width: size.width,
                                        child: ElevatedButton(
                                          child: const Text('Submit'),
                                          onPressed: () {
                                            workoutTController
                                                .addWorkoutDetails();
                                          },
                                          style: ElevatedButton.styleFrom(
                                              backgroundColor:
                                                  const Color(0xFF4F54BE)),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              )),
                        );
                      },
                    );
                  },
                ),
              ),
            ],
            onOpen: () {
              debugPrint('onOpen');
            },
            afterOpen: () {
              debugPrint('afterOpen');
            },
            onClose: () {
              debugPrint('onClose');
            },
            afterClose: () {
              debugPrint('afterClose');
            },
          ),
        ),
      ),
    );
  }
}

class SleepTime extends StatefulWidget {
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
        text: _selectedTime?.format(context) ?? '',
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

class WaleUpTime extends StatefulWidget {
  @override
  _WaleUpTimeState createState() => _WaleUpTimeState();
}

class _WaleUpTimeState extends State<WaleUpTime> {
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
        text: _selectedTime?.format(context) ?? '',
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
