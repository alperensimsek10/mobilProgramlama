

import 'package:finans_takipp/modules/transaction/transaction_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/state_manager.dart';

class DescriptionInput extends GetView<TransactionController>{
  const DescriptionInput({super.key});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      decoration: InputDecoration(
        labelText: 'Açıklama',
        border: OutlineInputBorder(),
        prefixIcon: Icon(Icons.description_outlined),
        
      ),
      maxLines: 2,
      onChanged: (value) {
        controller.description.value = value;
      },
      validator: (value) {
        if(value == null || value.isEmpty){
          return "Bir Açıklama Giriniz";
        }
        return null;
        
      },
    );
  }

}