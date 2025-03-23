
import 'package:finans_takipp/modules/splash/splash_controller.dart';
import 'package:get/instance_manager.dart';

class SplashBindings  extends Bindings{
  @override
  void dependencies() {
    Get.put(SplashController());
  }
}