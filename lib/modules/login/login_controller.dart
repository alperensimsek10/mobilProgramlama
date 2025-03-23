
import 'package:finans_takipp/core/base_controller.dart';
import 'package:finans_takipp/services/auth_service.dart';
import 'package:get/get.dart';

class LoginController  extends BaseController{
  late final AuthService _authService;

  @override
  void onInit(){
    super.onInit();
    _authService = Get.find<AuthService>();
  }
  googleIleGirisYap() async{
    await _authService.signInWithGoogle();
  }
}