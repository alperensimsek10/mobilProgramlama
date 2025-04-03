import 'package:finans_takipp/core/base_controller.dart';
import 'package:finans_takipp/dashboard/dashboard_controller.dart';
import 'package:finans_takipp/models/app_category.dart';
import 'package:finans_takipp/models/transaction_params.dart';
import 'package:finans_takipp/repositories/category_repository.dart';
import 'package:finans_takipp/repositories/transaction_repository.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

class TransactionController extends BaseController {
  final CategoryRepository _categoryRepository = Get.find<CategoryRepository>();
  final TransactionRepository _transactionRepository = Get.find<TransactionRepository>();

  final categories = <AppCategory>[].obs;
  final selectedCategoryId = "".obs;
  final TransactionType = 'expense'.obs;
  final formKey = GlobalKey<FormState>();
  final amount = 0.0.obs;
  final description = "".obs;
  final date = DateTime.now().obs;

  @override
  void onInit() async {
    super.onInit();
    loadCategories();

    ever(TransactionType, 
      (_) {
        getFirstCategory();
      },
    );
  }

  Future createTransaction() async {
    try {
      setLoading(true);

      
      if (!formKey.currentState!.validate()) {
        setLoading(false);
        return;
      }

      final transaction = Transaction(
        id: '',
        amount: amount.value,
        description: description.value,
        type: TransactionType.value,
        date: date.value,
        categoryId: selectedCategoryId.value,
        userId: '',
      );

      var result = await _transactionRepository.createTransaction(transaction);
      print(result.id);
      if (result != null) {
        await Get.find<DashboardController>().refreshDashboard();
        Get.back();

        showSuccessSnackbar(message: 'Transaction Eklendi');
        
      }

    } catch (e) {
      showErrorSnackbar(message: 'Transaction Eklenirken Hata Çıktı');
    } finally {
      setLoading(false);
    }
  }

  Future<void> loadCategories() async {
    setLoading(true);
    try {
      final result = await _categoryRepository.getCategories();

      categories.value = result;

      getFirstCategory();
    } catch (e) {
      showErrorSnackbar(message: e.toString());
    } finally {
      setLoading(false);
    }
  }

  void getFirstCategory() {
    final filteredCategories = categories
        .where((category) => category.type == TransactionType.value)
        .toList();
    if (filteredCategories.isNotEmpty) {
      selectedCategoryId.value = filteredCategories.first.id!;
    } else {
      selectedCategoryId.value = '';
    }
  }

  void clearForm() {
    amount.value = 0.0;
    description.value = '';
    date.value = DateTime.now();
    TransactionType.value = 'expense';
    selectedCategoryId.value = '';
  }
}
