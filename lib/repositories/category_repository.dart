
import 'package:finans_takipp/models/app_category.dart';
import 'package:finans_takipp/services/api_service.dart';
import 'package:get/get.dart';
import 'package:get/state_manager.dart';
import 'app_category.dart';

class CategoryRepository  extends GetxService{
  late final ApiService _apiService;

 @override
  void onInit() {
    super.onInit();
    _apiService = Get.find<ApiService>();
  }

Future<List<AppCategory>> getCategories() async {
  final response = await _apiService.get(ApiConstants.categories);
  if (response.statusCode == 200) {
    var gelenListe = response.data as List;
    return gelenListe
        .map((category) => AppCategory.fromJson(category)) // Burada düzeltme yapıldı
        .toList();
  }
  throw Exception("Kategoriler getirilirken bir hata oluştu");
  }

Future<AppCategory> createCategory(AppCategory category) async {
  final response = await _apiService.post(
    ApiConstants.categories,
    category.toJson(), 
  );

  if (response.statusCode == 201) {
    return AppCategory.fromJson(response.data);
  } else {
    throw Exception("Kategori oluşturulurken bir hata oluştu: ${response.statusCode}");
  }
}
}