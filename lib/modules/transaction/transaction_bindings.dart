
import 'package:finans_takipp/modules/transaction/controllers/transaction_controller.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/get_instance.dart';

class TransactionBindings extends Bindings{
  @override
  void dependencies() {
    Get.lazyPut(()=>TransactionController());
  }

}
