
import 'package:finans_takipp/modules/transaction/transaction_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/state_manager.dart';

class SaveButton  extends GetView<TransactionController> {
  const SaveButton({super.key});

  @override
  Widget build(BuildContext context){
    return ElevatedButton.icon(
      onPressed: () async{
      await controller.createTransaction();
    }, 
    label: Text("Kaydet"),
    icon: Icon(Icons.save_rounded),
    );
  }
}