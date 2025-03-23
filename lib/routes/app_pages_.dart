import 'package:finans_takipp/modules/home/home_bindigs.dart';
import 'package:finans_takipp/modules/home/home_page.dart';
import 'package:finans_takipp/modules/login/login_bindings.dart';
import 'package:finans_takipp/modules/login/login_page.dart';
import 'package:finans_takipp/modules/splash/splash_bindings.dart';
import 'package:finans_takipp/modules/splash/splash_page.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:get/get.dart';

abstract class AppRoutes{
  static const INITAL = SPLASH;
  static const SPLASH = '/splash';
  static const LOGIN = '/login';
  static const HOME = '/home';
   static const PROFILE = '/profil';
}


class AppPages {
  static final pages = <GetPage>[
    GetPage(name: AppRoutes.SPLASH, 
    page: ()=>SplashPage(), 
    binding: SplashBindings(),
    ),
     GetPage(name: AppRoutes.LOGIN, 
    page: ()=> LoginPage(), 
    binding: LoginBindings(),
    ),
GetPage(name: AppRoutes.HOME, 
    page: ()=>HomePage(), 
    binding: HomeBindings(), 
    ),
    
  ];
}
