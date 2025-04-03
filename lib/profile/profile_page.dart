import 'package:finans_takipp/profile/widgets/info_card.dart';
import 'package:finans_takipp/services/theme_service.dart';
import 'package:get/get.dart';

import 'profile_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/state_manager.dart';

class ProfilePage extends GetView<ProfileController>{
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body : SingleChildScrollView(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            CircleAvatar(
              radius: 50,
              backgroundImage: NetworkImage(
                controller.user.value?.profilePhoto ?? ''),
            ),
            SizedBox(height: 24,),
            InfoCard(title: 'Adı:', value: controller.user.value?.firstName ?? ''),
            InfoCard(title: 'Soyadı:', value: controller.user.value?.lastName ?? ''),
            InfoCard(title: 'Mail:', value: controller.user.value?.email ?? ''),
            SettingsCard(),
          ]
        ),
      ),
    );
    
  }
}

class SettingsCard extends StatelessWidget {
  SettingsCard({super.key});
  final ThemeService themeService = Get.find<ThemeService>();
  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        leading: Icon(Icons.brightness_6),
        title: Text('Tema'),
        trailing: Obx(()=>Switch(value: themeService.isDarkMode, 
        onChanged: (value) => themeService.toogleTheme())),
      ),
      );
  }
  
}