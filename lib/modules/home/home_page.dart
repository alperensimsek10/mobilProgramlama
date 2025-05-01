import 'package:animated_bottom_navigation_bar/animated_bottom_navigation_bar.dart';
import 'package:finans_takipp/dashboard/dashboard_page.dart';
import 'package:finans_takipp/modules/home/home_controller.dart';
import 'package:finans_takipp/profile/profile_page.dart';
import 'package:finans_takipp/themes/app_colors.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../dashboard/YillikRaporSayfasi.dart';
import '../../dashboard/grafik_sayfasi.dart';

class HomePage extends GetView<HomeController> {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Finza",
          style: GoogleFonts.poppins(color: Colors.white),
        ),
        backgroundColor: const Color.fromARGB(255, 174, 124, 191),
        actions: [
          IconButton(
            icon: const Icon(Icons.insert_chart_outlined_rounded, color: Colors.white),
            tooltip: "Raporu Gör",
            onPressed: () {
              Get.to(() => YillikRaporSayfasi());
            },
          ),
          IconButton(
            icon: const Icon(Icons.bar_chart, color: Colors.white),
            tooltip: "Grafiği Gör",
            onPressed: () {
              Get.to(() => GrafikSayfasi());
            },
          ),
          IconButton(
            onPressed: controller.cikisYap,
            icon: const Icon(Icons.logout, color: Colors.white),
            tooltip: "Çıkış Yap",
          ),
        ],
      ),
      body: Obx(
        () => IndexedStack(
          index: controller.currentIndex.value,
          children: [
            DashboardPage(),
            ProfilePage(),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: controller.gotoTransaction,
        backgroundColor: AppColors.darkHotPink,
        shape: const CircleBorder(),
        child: const Icon(Icons.add_rounded, size: 32, color: Colors.white),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: Obx(
        () => AnimatedBottomNavigationBar(
          gapLocation: GapLocation.center,
          backgroundColor: const Color.fromARGB(255, 174, 124, 191),
          icons: const [
            Icons.dashboard_customize_outlined,
            Icons.person,
          ],
          activeIndex: controller.currentIndex.value,
          splashColor: Colors.white,
          activeColor: Colors.white,
          notchSmoothness: NotchSmoothness.softEdge,
          leftCornerRadius: 32,
          rightCornerRadius: 32,
          inactiveColor: Colors.white.withAlpha(100),
          onTap: controller.changePage,
        ),
      ),
    );
  }
}
