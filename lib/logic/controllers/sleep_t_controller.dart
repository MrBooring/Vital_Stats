import 'package:get/get.dart';
import 'package:sqllitecrud/view/pages/home/widgets/fab_button.dart';

import '../../data/providers/sql_helper.dart';
import 'auth_controller.dart';

class SleepTController extends GetxController {
  AuthController authController = Get.find();
  var sleepData = [].obs;
  var sleepTime = ''.obs;
  var wakeupTime = "".obs;
  @override
  void onInit() {
    super.onInit();

    fetchSleepData();
  }

  fetchSleepData() async {
    final result = await SQLHelper.fetchSleepTrackers(authController.uid.value);
    sleepData.value = result;
    print(sleepData);
  }

  addSleepData() async {
    String specificDateTime = DateTime.now().toString();
    DateTime parsedDateTime = DateTime.parse(specificDateTime);

    String time = "${parsedDateTime.hour}:${parsedDateTime.minute}";
    if (sleepTime.value != "" && wakeupTime.value != "") {
      await SQLHelper.addSleepTracker(authController.uid.value, sleepTime.value,
              wakeupTime.value, parsedDateTime.toString().split(' ')[0], time)
          .then((value) {
        Get.back();
        sleepTime.value = "";
        wakeupTime.value = "";
        Get.snackbar("Success!", "Sleep data added successfully");
        fetchSleepData();
      });
    } else {
      Get.snackbar("Opps!", "Please select the sleep and wakeup times");
    }
  }

  deleteSleep(int id) async {
    await SQLHelper.deleteSleepTracker(id).then((value) {
      print(value);
      fetchSleepData();
    });
  }

  udpateSleep(int sleepId) async {
    String specificDateTime = DateTime.now().toString();
    DateTime parsedDateTime = DateTime.parse(specificDateTime);

    String time = "${parsedDateTime.hour}:${parsedDateTime.minute}";
    if (sleepTime.value != "" && wakeupTime.value != "") {
      await SQLHelper.updateSleepTracker(sleepId, sleepTime.value,
              wakeupTime.value, parsedDateTime.toString().split(' ')[0], time)
          .then((value) {
        Get.back();
        sleepTime.value = "";
        wakeupTime.value = "";
        Get.snackbar("Success!", "Sleep data updated successfully");
        fetchSleepData();
      });
    } else {
      Get.snackbar("Opps!", "Please select the sleep and wakeup times");
    }

    deleteFood(int id) async {
      await SQLHelper.deleteSleepTracker(id).then((value) {
        print(value);
        fetchSleepData();
      });
    }
  }
}
