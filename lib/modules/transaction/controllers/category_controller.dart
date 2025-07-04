

import 'package:flutter/material.dart';
import 'package:finans_takipp/core/base_controller.dart';
import 'package:finans_takipp/models/app_category.dart';
import 'package:finans_takipp/modules/transaction/controllers/transaction_controller.dart';
import 'package:finans_takipp/repositories/category_repository.dart';
import 'package:finans_takipp/utils/icon_helper.dart';
import 'package:get/get.dart';

class CategoryController extends BaseController {

  final categoryName = ''.obs;
  final selectedIcon = ''.obs;
  final formKey = GlobalKey<FormState>();
  final categoryType = ''.obs;
  late final CategoryRepository categoryRepository;

  @override
  void onInit() {
    super.onInit();
    categoryRepository = Get.find<CategoryRepository>();
    categoryType.value = Get.find<TransactionController>().transactionType.value;
    selectedIcon.value = icons.first;
  }

  Future<void> createCategory() async{
    try{
      if(!formKey.currentState!.validate()) return;
      setLoading(true);
      var eklenecekKategori=AppCategory(
        name: categoryName.value,
        icon: selectedIcon.value,
        type: categoryType.value
      );
      var eklenenKategori = await categoryRepository.createCategory(eklenecekKategori);
      Get.back(result: eklenenKategori);
    }catch(e){
      showErrorSnackbar(message: 'Kategori eklenirken hata $e');
    }finally{
      setLoading(false);
    }
  }

}