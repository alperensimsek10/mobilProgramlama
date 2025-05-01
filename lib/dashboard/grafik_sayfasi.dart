import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'dashboard_controller.dart';
import 'dart:math';

class GrafikSayfasi extends StatelessWidget {
  final controller = Get.find<DashboardController>();

  GrafikSayfasi({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF26324F),
      appBar: AppBar(
        title: const Text("Aylık Gelir - Gider Grafiği"),
        backgroundColor: const Color(0xFF26324F),
        foregroundColor: Colors.white,
        elevation: 0,
      ),
      body: Obx(() {
        final veriler = controller.aylikGelirGiderListesi;

        if (veriler.isEmpty) {
          return const Center(
            child: Text(
              "Grafik için yeterli veri yok.",
              style: TextStyle(color: Colors.white),
            ),
          );
        }

        final sortedEntries = veriler.entries.toList()
          ..sort((a, b) => a.key.compareTo(b.key));

        return Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              const SizedBox(height: 20),
              Expanded(
                child: BarChart(
                  BarChartData(
                    alignment: BarChartAlignment.spaceEvenly,
                    maxY: _getMaxY(veriler),
                    barTouchData: BarTouchData(
                      enabled: true,
                      touchTooltipData: BarTouchTooltipData(
                        tooltipBgColor: Colors.white24,
                        getTooltipItem: (group, groupIndex, rod, rodIndex) {
                          String label = rodIndex == 0 ? "Gelir" : "Gider";
                          return BarTooltipItem(
                            '$label\n${rod.toY.toStringAsFixed(0)} ₺',
                            const TextStyle(color: Colors.white),
                          );
                        },
                      ),
                    ),
                    titlesData: FlTitlesData(
                      show: true,
                      rightTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
                      topTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
                      bottomTitles: AxisTitles(
                        sideTitles: SideTitles(
                          showTitles: true,
                          getTitlesWidget: (value, meta) => bottomTitles(value, meta, sortedEntries),
                          reservedSize: 32,
                        ),
                      ),
                      leftTitles: AxisTitles(
                        sideTitles: SideTitles(
                          showTitles: true,
                          reservedSize: 48,
                          interval: _getInterval(veriler),
                          getTitlesWidget: leftTitles,
                        ),
                      ),
                    ),
                    borderData: FlBorderData(show: false),
                    barGroups: _generateBarChartGroups(sortedEntries),
                    gridData: FlGridData(
                      show: true,
                      getDrawingHorizontalLine: (value) => FlLine(
                        color: Colors.white12,
                        strokeWidth: 1,
                      ),
                    ),
                  ),
                  swapAnimationDuration: const Duration(milliseconds: 800),
                  swapAnimationCurve: Curves.easeOutBack,
                ),
              ),
            ],
          ),
        );
      }),
    );
  }

  Widget leftTitles(double value, TitleMeta meta) {
    return SideTitleWidget(
      axisSide: meta.axisSide,
      space: 6,
      child: Text(
        '${(value / 1000).toStringAsFixed(0)}K',
        style: const TextStyle(
          color: Colors.white70,
          fontWeight: FontWeight.bold,
          fontSize: 12,
        ),
      ),
    );
  }

  Widget bottomTitles(double value, TitleMeta meta, List<MapEntry<int, Map<String, double>>> sortedEntries) {
    const months = ['Oca', 'Şub', 'Mar', 'Nis', 'May', 'Haz', 'Tem', 'Ağu', 'Eyl', 'Eki', 'Kas', 'Ara'];

    if (value.toInt() < 0 || value.toInt() >= sortedEntries.length) return Container();

    final ayIndex = sortedEntries[value.toInt()].key;

    return SideTitleWidget(
      axisSide: meta.axisSide,
      space: 8,
      child: Text(
        months[ayIndex - 1], // <-- BURASI DÜZELTİLDİ
        style: const TextStyle(
          color: Colors.white70,
          fontWeight: FontWeight.bold,
          fontSize: 12,
        ),
      ),
    );
  }

  double _getMaxY(Map<int, Map<String, double>> veriler) {
    double maxY = 0;
    for (var v in veriler.values) {
      double gelir = v["income"] ?? 0;
      double gider = v["expense"] ?? 0;
      maxY = max(maxY, max(gelir, gider));
    }
    return (maxY * 1.2).ceilToDouble();
  }

  double _getInterval(Map<int, Map<String, double>> veriler) {
    double maxY = _getMaxY(veriler);
    if (maxY <= 2000) return 500;
    if (maxY <= 5000) return 1000;
    if (maxY <= 10000) return 2000;
    return 5000;
  }

  List<BarChartGroupData> _generateBarChartGroups(List<MapEntry<int, Map<String, double>>> sortedEntries) {
    return List.generate(sortedEntries.length, (i) {
      final entry = sortedEntries[i];
      final gelir = entry.value["income"] ?? 0;
      final gider = entry.value["expense"] ?? 0;

      return BarChartGroupData(
        x: i,
        barsSpace: 2,
        barRods: [
          BarChartRodData(
            fromY: 0,
            toY: gelir,
            width: 14,
            borderRadius: BorderRadius.circular(6),
            gradient: const LinearGradient(
              colors: [Colors.cyanAccent, Colors.cyan],
              begin: Alignment.bottomCenter,
              end: Alignment.topCenter,
            ),
          ),
          BarChartRodData(
            fromY: 0,
            toY: gider,
            width: 14,
            borderRadius: BorderRadius.circular(6),
            gradient: const LinearGradient(
              colors: [Colors.pinkAccent, Colors.pink],
              begin: Alignment.bottomCenter,
              end: Alignment.topCenter,
            ),
          ),
        ],
      );
    });
  }
}
