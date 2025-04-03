import 'package:finans_takipp/models/app_transaction.dart';
import 'package:finans_takipp/models/transaction_params.dart';
import 'package:finans_takipp/services/api_service.dart';
import 'package:get/get.dart';
import 'package:get/state_manager.dart';

class TransactionRepository extends GetxService {
  late ApiService _apiService; // 'final' kaldırıldı

  @override
  void onInit() {
    super.onInit();
    _apiService = Get.find<ApiService>();
  }

  Future<List<AppTransaction>> getTransactions() async {
    final response = await _apiService.get(ApiConstants.transactions);
    if (response.statusCode == 200) {
      var gelenListe = response.data['transactions'] as List;
      return gelenListe.map((transaction) => AppTransaction.fromJson(transaction)).toList();
    }
    throw Exception("Transactionlar getirilirken hata oluştu");
  }

  Future<AppTransaction> createTransaction(Transaction transaction) async {
    final response = await _apiService.post(ApiConstants.transactions, transaction.toJson());
    if (response.statusCode == 201) {
      return AppTransaction.fromJson(response.data); 
    }
    throw Exception("Transactionlar eklenirken hata oluştu");
  }
  
  Future<void> deleteTransaction(String id) async {
  final response = await _apiService.delete("${ApiConstants.transactions}/$id",null);
  if (response.statusCode != 200) {
    throw Exception("Transaction silinirken hata oluştu");
  }
}


} 
