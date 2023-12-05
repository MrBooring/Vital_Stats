import 'package:get/get.dart';
import 'package:sqllitecrud/data/providers/sql_helper.dart';

import 'auth_controller.dart';

class WaterTController extends GetxController {
  var waterData = [].obs;
  var totalWaterGlass = 0.obs;
  AuthController authController = Get.find();
  var glassCount = "".obs;
  var glassCountError = "".obs;
  @override
  void onInit() {
    super.onInit();
    fetchWaterData();

    glassCount.listen((value) {
      validationGlassCount(value);
    });
  }

  validationGlassCount(value) {
    glassCount.value = value;
    if (value.isEmpty) {
      glassCountError.value = "Glass count is required";
    } else {
      glassCountError.value = "";
    }
  }

  fetchWaterData() async {
    final result = await SQLHelper.fetchWaterTrackers(authController.uid.value);
    waterData.value = result;
    print(waterData);

    totalWaterGlass.value = 0;
    for (var entry in waterData) {
      totalWaterGlass.value += int.parse(entry['waterGlass'].toString());
    }
    print('Total Water Glass: $totalWaterGlass');
  }

  addWaterData() async {
    String specificDateTime = DateTime.now().toString();
    DateTime parsedDateTime = DateTime.parse(specificDateTime);

    String time = "${parsedDateTime.hour}:${parsedDateTime.minute}";
    if (glassCount.value != "") {
      await SQLHelper.addWaterTracker(
              authController.uid.value,
              int.parse(glassCount.value.toString()),
              parsedDateTime.toString().split(' ')[0],
              time)
          .then((value) {
        Get.back();
        Get.snackbar("success!", "Water details added successfully");
        fetchWaterData();
        glassCount.value = "";
        glassCountError.value = "";
      });
    } else {
      Get.snackbar("Opps!", "Please add the glass count");
    }
  }

  updateWaterData(int waterid) async {
    String specificDateTime = DateTime.now().toString();
    DateTime parsedDateTime = DateTime.parse(specificDateTime);

    String time = "${parsedDateTime.hour}:${parsedDateTime.minute}";
    if (glassCount.value != "") {
      await SQLHelper.updateWaterTracker(
              waterid,
              int.parse(glassCount.value.toString()),
              parsedDateTime.toString().split(' ')[0],
              time)
          .then((value) {
        Get.back();
        Get.snackbar("success!", "Water details updated successfully");
        fetchWaterData();
        glassCount.value = "";
        glassCountError.value = "";
      });
    } else {
      Get.snackbar("Opps!", "Please add the glass count");
    }
  }

  deleteData(int id) async {
    await SQLHelper.deleteWaterTracker(id).then((value) => fetchWaterData());
  }
}
