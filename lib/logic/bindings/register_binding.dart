import 'package:get/get.dart';
import 'package:sqllitecrud/logic/controllers/register_controller.dart';

class RegisterBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<RegisterController>(() => RegisterController(), fenix: true);
  }
}
