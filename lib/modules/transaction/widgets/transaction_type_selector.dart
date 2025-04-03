
import 'package:finans_takipp/modules/transaction/transaction_controller.dart';
import 'package:finans_takipp/themes/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class TransactionTypeSelector  extends GetView<TransactionController>{
  const TransactionTypeSelector({super.key});

  @override
  Widget build (BuildContext context) {
    return Obx(() =>
      SegmentedButton(segments: [
        ButtonSegment(value: 'expense', 
        label: Text("Gider"),
        icon:Icon(Icons.remove_circle_outline)),
        ButtonSegment(
          value: 'income', label: Text('Gelir'),
          icon: Icon(Icons.add_circle_outline)),
      ], selected: {
        controller.TransactionType.value
        },
        onSelectionChanged: (selection) {
          controller.TransactionType.value = selection.first;
        },
        style : ButtonStyle(
          backgroundColor: WidgetStateColor.resolveWith((states) {
            if(states.contains(WidgetState.selected)) {
              return Color(0xFFFF8FA1);
            }else
              return Colors.transparent;
            },
        )),
    )
    );
  }
}