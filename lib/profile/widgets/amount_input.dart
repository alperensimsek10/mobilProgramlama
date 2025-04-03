

import 'package:finans_takipp/modules/transaction/transaction_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/state_manager.dart';

class AmountInput extends GetView<TransactionController>{
  const AmountInput({super.key});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      decoration: InputDecoration(
        labelText: 'Miktar',
        border: OutlineInputBorder(),
        prefixIcon: Icon(Icons.money_outlined),
        
      ),
      keyboardType: TextInputType.numberWithOptions(decimal: true),
      onChanged: (value) {
        controller.amount.value = double.tryParse(value) ?? controller.amount.value;
      },
      validator: (value) {
        if(value == null || value.isEmpty){
          return "Miktarı Giriniz";
        }
        final amount = double.tryParse(value);
        if(amount == null || amount <=0){
          return "Geçersiz Veri";
        }
        return null;

      },
    );
  }

}