import 'package:get/get.dart';
import 'package:sqllitecrud/logic/controllers/food_t_controller.dart';
import 'package:sqllitecrud/logic/controllers/sleep_t_controller.dart';
import 'package:sqllitecrud/logic/controllers/water_t_controller.dart';
import 'package:sqllitecrud/logic/controllers/workout_t_controller.dart';

class HomeBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<FoodTController>(() => FoodTController(), fenix: true);
    Get.lazyPut<SleepTController>(() => SleepTController(), fenix: true);
    Get.lazyPut<WaterTController>(() => WaterTController(), fenix: true);
    Get.lazyPut<WorkoutTController>(() => WorkoutTController(), fenix: true);
  }
}
