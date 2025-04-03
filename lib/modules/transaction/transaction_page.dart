
import 'package:finans_takipp/modules/transaction/transaction_controller.dart';
import 'package:finans_takipp/modules/transaction/widgets/category_dropdown.dart';
import 'package:finans_takipp/modules/transaction/widgets/date_input.dart';
import 'package:finans_takipp/modules/transaction/widgets/save_button.dart';
import 'package:finans_takipp/modules/transaction/widgets/transaction_type_selector.dart';
import 'package:finans_takipp/profile/widgets/amount_input.dart';
import 'package:finans_takipp/profile/widgets/description_input.dart';
import 'package:finans_takipp/themes/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class TransactionPage  extends GetView<TransactionController>
{
  const TransactionPage({super.key});
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("İşlem Ekle"),),
      body: Obx(() => controller.isLoading 
      ? const Center(
        child: CircularProgressIndicator(),
        )
      :SingleChildScrollView(
        padding: EdgeInsets.all(16),
        child: Form(
          key: controller.formKey,
          child: Column(
            children: [
              TransactionTypeSelector(),
              SizedBox(height: 8,),
              Row(
                children: [
                  Expanded(child: CategoryDropdown()
                  ),
                  IconButton(onPressed: (){}, icon: Icon(Icons.add_circle_outline),
                   color: const Color(0xFFE58E9C),
                  )
                ],
              ),
              SizedBox(
                height: 16,
                ), 
              AmountInput(),
              SizedBox(
                height: 16,
                ),
                DescriptionInput(),
                 SizedBox(
                height: 16,
                ),
                DateInput(),  
                SizedBox(height: 16,),
                SaveButton(),
            ],
          ),
        ),
      )
    ),);
  }
  
}