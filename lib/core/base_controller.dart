
import 'package:finans_takipp/themes/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:get/state_manager.dart';

class BaseController extends GetxController {
  final _isLoading = false.obs;

  bool get isLoading => _isLoading.value;

  void setLoading(bool value) => _isLoading.value=value;

  void showErrorSnackbar({
    required String message,
    String title = 'Hata',
    Duration duration = const Duration(seconds: 3),
  }) {
    Get.snackbar(
      title,
      message,
      snackPosition: SnackPosition.BOTTOM,
      backgroundColor: Get.isDarkMode ? AppColors.darkExpense : AppColors.expense,
      colorText: Get.isDarkMode ? AppColors.darkTextPrimary : AppColors.textPrimary,
      margin: const EdgeInsets.all(16),
      borderRadius: 8,
      isDismissible: true,
      dismissDirection: DismissDirection.horizontal,
      forwardAnimationCurve: Curves.easeOutBack,
      duration: duration,
      icon: const Icon(
        Icons.error_outline,
        color: Colors.white,
      ),
      overlayBlur: 0.5,
      overlayColor: Colors.black12,
    );
  }
void showSuccessSnackbar({
    required String message,
    String title = 'Başarılı',
    Duration duration = const Duration(seconds: 3),
  }) {
    Get.snackbar(
      title,
      message,
      snackPosition: SnackPosition.BOTTOM,
      backgroundColor: Get.isDarkMode ? const Color.fromARGB(255, 142, 229, 200) : const Color.fromARGB(255, 142, 229, 200),
      colorText: Get.isDarkMode ? AppColors.darkTextPrimary : AppColors.textPrimary,
      margin: const EdgeInsets.all(16),
      borderRadius: 8,
      isDismissible: true,
      dismissDirection: DismissDirection.horizontal,
      forwardAnimationCurve: Curves.easeOutBack,
      duration: duration,
      icon: const Icon(
        Icons.error_outline,
        color: Colors.white,
      ),
      overlayBlur: 0.5,
      overlayColor: Colors.black12,
    );
  }



}
