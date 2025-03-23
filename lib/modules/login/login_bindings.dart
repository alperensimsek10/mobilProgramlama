
import 'package:finans_takipp/modules/login/login_controller.dart';
import 'package:get/get_instance/get_instance.dart';
import 'package:get/instance_manager.dart';

class LoginBindings  extends Bindings{
  @override
  void dependencies() {
    Get.lazyPut(() => LoginController(),);
  }
}