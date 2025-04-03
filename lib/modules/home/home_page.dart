import 'package:animated_bottom_navigation_bar/animated_bottom_navigation_bar.dart';
import 'package:finans_takipp/dashboard/dashboard_page.dart';
import 'package:finans_takipp/modules/home/home_controller.dart';
import 'package:finans_takipp/profile/profile_page.dart';
import 'package:finans_takipp/themes/app_colors.dart';
import 'package:google_fonts/google_fonts.dart'; 
import 'package:flutter/material.dart';
import 'package:get/get_state_manager/src/simple/get_view.dart';
import 'package:get/state_manager.dart';

class HomePage extends GetView<HomeController> {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Finans Takip App",
          style: GoogleFonts.poppins(color: Colors.white),
        ),
        backgroundColor: const Color.fromARGB(255, 174, 124, 191), 
        actions: [
          IconButton(
            onPressed: controller.cikisYap,
            icon: Icon(Icons.logout, color: Colors.white), 
          )
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
      shape: CircleBorder(),
      child: Icon(Icons.add_rounded, size: 32, color:Colors.white),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: Obx(()=>
        AnimatedBottomNavigationBar(
          gapLocation: GapLocation.center,
          backgroundColor: const Color.fromARGB(255, 174, 124, 191),
          icons: [Icons.dashboard_customize_outlined,Icons.person],
          activeIndex: controller.currentIndex.value,
          splashColor: Colors.white,
          activeColor: Colors.white,
          notchSmoothness: NotchSmoothness.softEdge,
          leftCornerRadius: 32,
          rightCornerRadius: 32,
          inactiveColor: Colors.white.withAlpha(100),
          onTap: controller.changePage),
      ),
    );
  }
}
