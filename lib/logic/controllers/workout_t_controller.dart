import 'package:get/get.dart';

import '../../data/providers/sql_helper.dart';
import 'auth_controller.dart';

class WorkoutTController extends GetxController {
  AuthController authController = Get.find();
  var workOutData = [].obs;
  var workoutName = "".obs;
  var workoutError = "".obs;
  var workouttime = "".obs;
  var workouttimeError = "".obs;

  var totalworkout = 0.obs;

  @override
  void onInit() {
    super.onInit();
    fetchWorkOutData();
    workoutName.listen((value) {
      validationWorkoutName(value);
    });
    workouttime.listen((value) {
      validationWorkoutmin(value);
    });
  }

  validationWorkoutName(value) {
    workoutName.value = value;
    if (value.isEmpty) {
      workoutError.value = "Workout Name is required";
    } else {
      workoutError.value = "";
    }
  }

  validationWorkoutmin(value) {
    workouttime.value = value;
    if (value.isEmpty) {
      workouttimeError.value = "Workout Minutes is required";
    } else {
      workouttimeError.value = "";
    }
  }

  fetchWorkOutData() async {
    final result =
        await SQLHelper.fetchWorkoutTrackers(authController.uid.value);
    workOutData.value = result;
    print(workOutData);
    totalworkout.value = 0;
    for (var entry in workOutData) {
      totalworkout.value += int.parse(entry['wtime'].toString());
    }
    print('Total workout : $totalworkout');
  }

  addWorkoutDetails() async {
    String specificDateTime = DateTime.now().toString();
    DateTime parsedDateTime = DateTime.parse(specificDateTime);

    String time = "${parsedDateTime.hour}:${parsedDateTime.minute}";
    if (workoutName.value != "" && workouttime.value != "") {
      await SQLHelper.addWorkoutTracker(
              authController.uid.value,
              workoutName.value.toString(),
              workouttime.value.toString(),
              time,
              parsedDateTime.toString().split(' ')[0])
          .then((value) {
        Get.back();
        Get.snackbar("Success!", "Workout details added successfully");
        fetchWorkOutData();
        workoutName.value = "";
        workouttime.value = "";
        workoutError.value = "";
        workouttimeError.value = "";
      });
    } else {
      Get.snackbar("Opps!", "Please add all details");
    }
  }

  updateWorkoutDetails(int workoutid) async {
    String specificDateTime = DateTime.now().toString();
    DateTime parsedDateTime = DateTime.parse(specificDateTime);

    String time = "${parsedDateTime.hour}:${parsedDateTime.minute}";
    if (workoutName.value != "" && workouttime.value != "") {
      await SQLHelper.updateWorkoutTracker(
              workoutid,
              workoutName.value.toString(),
              workouttime.value.toString(),
              time,
              parsedDateTime.toString().split(' ')[0])
          .then((value) {
        Get.back();
        Get.snackbar("Success!", "Workout details updated successfully");
        fetchWorkOutData();
        workoutName.value = "";
        workouttime.value = "";
        workoutError.value = "";
      });
    } else {
      Get.snackbar("Opps!", "Please add all details");
    }
  }

  deleteWorkoutDetails(int id) async {
    await SQLHelper.deleteWorkoutTracker(id).then((value) {
      print(value);
      fetchWorkOutData();
    });
  }
}
