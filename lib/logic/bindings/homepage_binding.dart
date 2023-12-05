import 'package:get/get.dart';
import 'package:sqllitecrud/logic/controllers/auth_controller.dart';
import 'package:sqllitecrud/logic/controllers/calender_controller.dart';

import '../controllers/food_t_controller.dart';
import '../controllers/sleep_t_controller.dart';
import '../controllers/water_t_controller.dart';
import '../controllers/workout_t_controller.dart';

class HomePageBindings implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<CalenderController>(() => CalenderController(), fenix: true);
    Get.lazyPut<FoodTController>(() => FoodTController(), fenix: true);
    Get.lazyPut<SleepTController>(() => SleepTController(), fenix: true);
    Get.lazyPut<WaterTController>(() => WaterTController(), fenix: true);
    Get.lazyPut<WorkoutTController>(() => WorkoutTController(), fenix: true);
  }
}
