import 'package:finans_takipp/core/base_controller.dart';
import 'package:finans_takipp/routes/app_pages_.dart';
import 'package:finans_takipp/services/api_service.dart';
import 'package:finans_takipp/services/auth_service.dart';
import 'package:finans_takipp/services/storage_service.dart';
import 'package:get/get.dart';
import 'package:get/instance_manager.dart';
import 'package:get/state_manager.dart';

class SplashController extends BaseController {

  //final areServicesReady = false.obs;
  @override
  void onReady() async{
    super.onReady();
    await waitForServices();
    //areServicesReady.value=true;
    await checkTokenAndRedirect();
  }

  Future<void> waitForServices() async{
    while(!Get.isRegistered<StorageService>() || 
    !Get.isRegistered<ApiService>() || !Get.isRegistered<AuthService>()){
      await Future.delayed(Duration(seconds: 1));
    }

  }
  
  Future<void>checkTokenAndRedirect() async{
    final _authService = Get.find<AuthService>();
    final isAuthenticated = await _authService.isAuthenticated();

    if(isAuthenticated){
      Get.offAllNamed(AppRoutes.HOME);
    }else{
      Get.offAllNamed(AppRoutes.LOGIN);
    }
    Get.offAllNamed(AppRoutes.LOGIN);
  }
}