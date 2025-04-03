
import 'package:finans_takipp/modules/transaction/transaction_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class DateInput extends GetView<TransactionController>{
  const DateInput({super.key});

  String _formatDate(DateTime date){
    return DateFormat('d MM y').format(date);
  }


  @override
  Widget build(BuildContext context) {
    
    return Obx(()=>ListTile(
      title: Text("Tarih"),
      subtitle: Text(_formatDate(controller.date.value)),
      trailing: Icon(Icons.calendar_today),
      onTap: () async{
        final DateTime? secilenTarih = await showDatePicker(
          context: context,
           firstDate: DateTime.now().subtract(Duration(days: 365),), 
           lastDate: DateTime.now().add(Duration(days: 365))
           );
           
           if(secilenTarih !=null){
            controller.date.value = secilenTarih;
           }
      },

    ));
  }

}