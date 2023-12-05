import 'package:get/get.dart';
import 'package:sqllitecrud/logic/controllers/auth_controller.dart';

import '../../data/providers/sql_helper.dart';

class FoodTController extends GetxController {
  AuthController authController = Get.find();
  var foodName = "".obs;
  var unit = "".obs;
  var foodNameError = "".obs;
  var unitError = "".obs;

  var foods = [].obs;

  var totalCal = 0.obs;

  @override
  void onInit() async {
    super.onInit();
    foodName.listen((value) {
      validateFoodName(value);
    });
    unit.listen((value) {
      validateUnit(value);
    });
    fetchFoods();
  }

  fetchFoods() async {
    print(authController.uid.value);
    final result = await SQLHelper.fetchFoodTrackers(authController.uid.value);
    foods.value = result.map((foodTracker) => foodTracker).toList();
    print(foods);
    totalCal.value = 0;
    for (var entry in foods) {
      totalCal.value += int.parse(entry['unit'].toString());
    }
    print('Total Water Glass: $totalCal');
  }

  validateFoodName(String value) {
    foodName.value = value;
    if (value.isEmpty) {
      foodNameError.value = "Food Name is required";
    } else {
      foodNameError.value = "";
    }
  }

  deleteFood(int value) async {
    await SQLHelper.deleteFoodTracker(value).then((value) => fetchFoods());
  }

  validateUnit(String value) {
    unit.value = value;
    if (value.isEmpty) {
      unitError.value = "Calories is required";
    } else {
      unitError.value = "";
    }
  }

  addFood() async {
    String specificDateTime = DateTime.now().toString();
    DateTime parsedDateTime = DateTime.parse(specificDateTime);

    String time = "${parsedDateTime.hour}:${parsedDateTime.minute}";
    if (foodName.value.isNotEmpty && unit.value.isNotEmpty) {
      await SQLHelper.addFoodTracker(
        authController.uid.value,
        foodName.value.toString(),
        unit.value.toLowerCase(),
        parsedDateTime.toString().split(' ')[0],
        time,
      ).then((value) {
        Get.back();
        foodName.value = "";
        unit.value = "";
        foodNameError.value = "";
        unitError.value = "";
        fetchFoods();
        Get.snackbar("Success!", "Food added successfully");
      });
    } else {
      Get.snackbar("Opps!", "Please add all Details");
    }
  }

  updateFood(int foodId) async {
    String specificDateTime = DateTime.now().toString();
    DateTime parsedDateTime = DateTime.parse(specificDateTime);

    String time = "${parsedDateTime.hour}:${parsedDateTime.minute}";
    if (foodName.value.isNotEmpty && unit.value.isNotEmpty) {
      await SQLHelper.updateFoodTracker(
        foodId,
        foodName.value.toString(),
        unit.value.toLowerCase(),
        parsedDateTime.toString().split(' ')[0],
        time,
      ).then((value) {
        Get.back();
        foodName.value = "";
        unit.value = "";
        foodNameError.value = "";
        unitError.value = "";
        fetchFoods();
        Get.snackbar("Success!", "Food updated successfully");
      });
    } else {
      Get.snackbar("Opps!", "Please add all Details");
    }
  }
}
