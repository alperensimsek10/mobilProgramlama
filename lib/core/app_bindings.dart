
import 'package:finans_takipp/services/api_service.dart';
import 'package:finans_takipp/services/auth_service.dart';
import 'package:finans_takipp/services/storage_service.dart';
import 'package:get/instance_manager.dart';

class AppBindings extends Bindings{
  @override
  Future<void> dependencies() async {
    await Get.putAsync<StorageService>(() async{
      final service = StorageService();
      await service.init();
      return service;
    });
  
    await Get.putAsync<ApiService>(() async{
      final service = ApiService();
      await service.init();
      return service;
    });

      await Get.putAsync<AuthService>(() async{
      final service = AuthService();
      await service.init();
      return service;
    });
  }
} 