
import 'package:finans_takipp/core/base_controller.dart';
import 'package:finans_takipp/models/app_user.dart';
import 'package:finans_takipp/services/auth_service.dart';
import 'package:get/get.dart';
import 'package:get/state_manager.dart';

class ProfileController  extends BaseController{
  final AuthService _authService = Get.find();
  Rx<AppUser?> get user => _authService.currentUser;
  
}