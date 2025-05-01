import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:finans_takipp/dashboard/dashboard_controller.dart';
import 'package:finans_takipp/dashboard/grafik_sayfasi.dart';

class YillikRaporSayfasi extends StatelessWidget {
  final DashboardController controller = Get.find();

  final List<String> aylar = [
    "Ocak", "Şubat", "Mart", "Nisan", "Mayıs", "Haziran",
    "Temmuz", "Ağustos", "Eylül", "Ekim", "Kasım", "Aralık"
  ];

  double getToplamGelir(Map<int, Map<String, double>> data) {
    return data.values.fold(0.0, (sum, e) => sum + (e["income"] ?? 0.0));
  }

  double getToplamGider(Map<int, Map<String, double>> data) {
    return data.values.fold(0.0, (sum, e) => sum + (e["expense"] ?? 0.0));
  }

  String enYuksekGelirAyi(Map<int, Map<String, double>> data) {
    if (data.isEmpty) return "-";
    int ay = data.entries
        .reduce((a, b) => (a.value["income"] ?? 0) > (b.value["income"] ?? 0) ? a : b)
        .key;
    return aylar[ay - 1];
  }

  String enYuksekGiderAyi(Map<int, Map<String, double>> data) {
    if (data.isEmpty) return "-";
    int ay = data.entries
        .reduce((a, b) => (a.value["expense"] ?? 0) > (b.value["expense"] ?? 0) ? a : b)
        .key;
    return aylar[ay - 1];
  }

  double getOrtalamaNet(Map<int, Map<String, double>> data) {
    if (data.isEmpty) return 0.0;
    final toplam = data.values.fold(0.0, (sum, e) => sum + ((e["income"] ?? 0) - (e["expense"] ?? 0)));
    return toplam / data.length;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Yıllık Rapor"),
        centerTitle: true,
        backgroundColor: const Color.fromARGB(255, 174, 124, 191),
        actions: [
          IconButton(
            icon: const Icon(Icons.bar_chart, color: Colors.white),
            tooltip: "Grafiği Gör",
            onPressed: () {
              Get.to(() => GrafikSayfasi());
            },
          ),
        ],
      ),
      body: Obx(() {
        final gelirGider = controller.aylikGelirGiderListesi;
        final seciliYil = controller.seciliYil.value;

        final toplamGelir = getToplamGelir(gelirGider);
        final toplamGider = getToplamGider(gelirGider);
        final toplamNet = toplamGelir - toplamGider;

        return Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: DropdownButton<int>(
                value: seciliYil,
                items: [2023, 2024, 2025, 2026].map((yil) {
                  return DropdownMenuItem(
                    value: yil,
                    child: Text("$yil"),
                  );
                }).toList(),
                onChanged: (yeniYil) {
                  if (yeniYil != null) {
                    controller.yiliDegistir(yeniYil);
                  }
                },
                isExpanded: true,
              ),
            ),
            if (gelirGider.isEmpty)
              const Expanded(child: Center(child: Text("Veri bulunamadı.")))
            else
              Expanded(
                child: ListView.builder(
                  itemCount: 12,
                  itemBuilder: (context, index) {
                    final ay = index + 1;
                    final ayAdi = aylar[index];
                    final data = gelirGider[ay];

                    if (data == null) {
                      return Card(
                        elevation: 2,
                        margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                        child: ListTile(
                          leading: const Icon(Icons.info_outline, color: Colors.red),
                          title: Text("$ayAdi $seciliYil"),
                          subtitle: const Text("Bu ay için veri yok."),
                        ),
                      );
                    }

                    final gelir = data["income"] ?? 0.0;
                    final gider = data["expense"] ?? 0.0;
                    final net = gelir - gider;

                    return Card(
                      elevation: 3,
                      margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                      color: net >= 0 ? Colors.green.shade200 : Colors.red.shade200,
                      child: ListTile(
                        leading: Icon(Icons.calendar_month, color: Colors.purple.shade400),
                        title: Text(
                          "$ayAdi $seciliYil",
                          style: const TextStyle(fontWeight: FontWeight.bold, color: Colors.black),
                        ),
                        subtitle: Padding(
                          padding: const EdgeInsets.only(top: 6),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text("Gelir: ${gelir.toStringAsFixed(2)}₺",
                                  style: const TextStyle(color: Colors.black, fontWeight: FontWeight.w600)),
                              Text("Gider: ${gider.toStringAsFixed(2)}₺",
                                  style: const TextStyle(color: Colors.black, fontWeight: FontWeight.w600)),
                              Text("Net Kazanç: ${net.toStringAsFixed(2)}₺",
                                  style: const TextStyle(color: Colors.black, fontWeight: FontWeight.w600)),
                            ],
                          ),
                        ),
                        trailing: IconButton(
                          icon: const Icon(Icons.info_outline, color: Colors.black87),
                        onPressed: () {
                          showModalBottomSheet(
                            context: context,
                            shape: const RoundedRectangleBorder(
                              borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
                            ),
                            backgroundColor: Colors.white,
                            builder: (context) {
                              String tavsiye;
                              if (gelir > gider) {
                                tavsiye = "Bu ay iyi bir tasarruf yapmışsınız. Aynı şekilde devam edin.";
                              } else if (gelir == gider) {
                                tavsiye = "Gelir ve gider dengede. Harcamaları azaltarak birikim yapabilirsiniz.";
                              } else {
                                tavsiye = "Giderler gelirden fazla. Giderlerinizi gözden geçirmenizi öneririz.";
                              }

                              return Padding(
                                padding: const EdgeInsets.all(20.0),
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Center(
                                      child: Container(
                                        width: 50,
                                        height: 5,
                                        decoration: BoxDecoration(
                                          color: Colors.grey[400],
                                          borderRadius: BorderRadius.circular(10),
                                        ),
                                      ),
                                    ),
                                    const SizedBox(height: 20),
                                    Text(
                                      "$ayAdi $seciliYil Değerlendirme",
                                      style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold,color: Colors.black),
                                    ),
                                    const SizedBox(height: 10),
                                    Text("📥 Gelir: ${gelir.toStringAsFixed(2)}₺",style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14, color: Colors.black),),
                                    Text("📤 Gider: ${gider.toStringAsFixed(2)}₺",style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14, color: Colors.black),),
                                    Text.rich(
                                      TextSpan(
                                        children: [
                                          const TextSpan(
                                            text: "💰 Net: ",
                                            style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 15,
                                              color: Colors.black,
                                            ),
                                          ),
                                          TextSpan(
                                            text: "${net.toStringAsFixed(2)}₺",
                                            style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 14,
                                              color: net >= 0 ? Colors.green : Colors.red,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),


                                    const SizedBox(height: 12),
                                    Text("💡 Tavsiye:",
                                        style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16, color: Colors.black)),
                                    Text(
                                      tavsiye,
                                      style: const TextStyle(fontSize: 15,color: Colors.black),
                                    ),
                                    const SizedBox(height: 10),
                                  ],
                                ),
                              );
                            },
                          );
                        },
                        ),
                      ),
                    );
                  },
                ),
              ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Card(
                elevation: 4,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                color: Colors.grey.shade100,
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text("📊 Toplam Yıllık Özet",
                          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.black)),
                      const SizedBox(height: 10),
                      Text("Toplam Gelir: ${toplamGelir.toStringAsFixed(2)}₺",
                          style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w600, color: Colors.black)),
                      Text("Toplam Gider: ${toplamGider.toStringAsFixed(2)}₺",
                          style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w600, color: Colors.black)),
                      Text("Net Kazanç: ${toplamNet.toStringAsFixed(2)}₺",
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w700,
                            color: toplamNet >= 0 ? Colors.green : Colors.red,
                          )),
                      const SizedBox(height: 10),
                      Text("En Yüksek Gelir: ${enYuksekGelirAyi(gelirGider)}",
                          style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w600, color: Colors.black)),
                      Text("En Yüksek Gider: ${enYuksekGiderAyi(gelirGider)}",
                          style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w600, color: Colors.red)),
                      Text("Ortalama Aylık Net Kazanç: ${getOrtalamaNet(gelirGider).toStringAsFixed(2)}₺",
                          style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w600, color: Colors.black)),
                    ],
                  ),
                ),
              ),
            ),
          ],
        );
      }),
    );
  }
}
