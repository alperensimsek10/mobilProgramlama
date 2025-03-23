
import 'package:finans_takipp/modules/login/login_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get_state_manager/get_state_manager.dart';

class LoginPage extends GetView<LoginController>{
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
  return Scaffold(
    body: Center(
      child: ElevatedButton(
        onPressed: () async{
         await controller.googleIleGirisYap();
      
      }, 
      child: Text("Google ile Giriş Yap")
      ),
      ),
  );
}
}