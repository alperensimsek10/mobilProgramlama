import 'package:finans_takipp/core/base_controller.dart';
import 'package:finans_takipp/models/app_transaction.dart';
import 'package:finans_takipp/repositories/transaction_repository.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class DashboardController extends BaseController {
  late final TransactionRepository _transactionRepository;

  final myTransactions = <AppTransaction>[].obs;

  final aylikGelir = 0.0.obs;
  final aylikGider = 0.0.obs;

  final seciliYil = DateTime.now().year.obs;

  // Grafik için her ayın gelir ve giderini tutan yapı
  final aylikGelirGiderListesi = <int, Map<String, double>>{}.obs;

  void yiliDegistir(int yeniYil) {
    seciliYil.value = yeniYil;
    aylikOzet(); // Yıl değişince özetleri yeniden hesapla
  }

  void aylikOzet() {
    aylikGelir.value = 0;
    aylikGider.value = 0;
    aylikGelirGiderListesi.clear();

    var oankiYil = seciliYil.value;
    var oankiAy = DateTime.now().month;

    if (myTransactions.isNotEmpty) {
      for (var tr in myTransactions) {
        if (tr.date == null) continue;

        var ay = tr.date!.month;
        var yil = tr.date!.year;
        var miktar = double.tryParse(tr.amount!) ?? 0.0;

        if (yil != oankiYil) continue; // Sadece seçilen yıl için

        // Her ay için gelir/gider başlangıç değeri
        if (!aylikGelirGiderListesi.containsKey(ay)) {
          aylikGelirGiderListesi[ay] = {"income": 0.0, "expense": 0.0};
        }

        if (tr.type == 'income') {
          aylikGelirGiderListesi[ay]!["income"] =
              (aylikGelirGiderListesi[ay]!["income"] ?? 0) + miktar;
        } else {
          aylikGelirGiderListesi[ay]!["expense"] =
              (aylikGelirGiderListesi[ay]!["expense"] ?? 0) + miktar;
        }

        // Sadece bu ayki toplamlar (bu yıl ve bu ay)
        if (yil == DateTime.now().year && ay == oankiAy) {
          if (tr.type == 'income') {
            aylikGelir.value += miktar;
          } else {
            aylikGider.value += miktar;
          }
        }
      }
    } else {
      aylikGelir.value = 0;
      aylikGider.value = 0;
    }

    debugPrint("📆 Seçilen yıl: $oankiYil");
    debugPrint("🔍 Aylık gelir: ${aylikGelir.value}, gider: ${aylikGider.value}");
    debugPrint("📊 Grafik verisi: $aylikGelirGiderListesi");
  }

  @override
  void onInit() async {
    super.onInit();
    _transactionRepository = Get.find<TransactionRepository>();
    await getTransactions();
  }

  Future<void> refreshDashboard() async {
    await getTransactions();
  }

  Future getTransactions() async {
    try {
      setLoading(true);
      final transactions = await _transactionRepository.getTransactions();
      myTransactions.value = transactions;
      aylikOzet();
    } catch (e) {
      showErrorSnackbar(message: "Veriler getirilirken hata oluştu");
    } finally {
      setLoading(false);
    }
  }

  Future<void> deleteTransactions(String id) async {
    try {
      await _transactionRepository.deleteTransaction(id);
      myTransactions.removeWhere((element) => element.id == id);
      aylikOzet();
      showSuccessSnackbar(message: "Transaction silindi");
    } catch (e) {
      showErrorSnackbar(message: "Veriler silinirken hata oluştu");
    }
  }
}
