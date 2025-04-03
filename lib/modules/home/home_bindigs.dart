import 'package:finans_takipp/dashboard/dashboard_controller.dart';
import 'package:finans_takipp/profile/profile_controller.dart';
import 'package:get/get.dart';
import 'home_controller.dart'; 

class HomeBindings extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<HomeController>(() => HomeController(),);
    Get.lazyPut<ProfileController>(()=> ProfileController(),);
    Get.lazyPut<DashboardController>(()=>DashboardController());
  }
}
