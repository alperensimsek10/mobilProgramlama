
import 'package:finans_takipp/core/base_controller.dart';
import 'package:finans_takipp/routes/app_pages_.dart';
import 'package:finans_takipp/services/auth_service.dart';
import 'package:get/get.dart';

class HomeController extends BaseController{

  final  currentIndex = 0.obs;

  changePage(int index){
    currentIndex.value = index;
  }
  cikisYap() async{
    await Get.find<AuthService>().signOut();
    Get.offAllNamed(AppRoutes.LOGIN);
  }

  void gotoTransaction() {
    Get.toNamed(AppRoutes.TRANSACTION);
  }
}