
import 'package:dio/dio.dart';
import 'package:finans_takipp/services/storage_service.dart';
import 'package:get/instance_manager.dart';
import 'package:get/state_manager.dart';


abstract class ApiConstants{
static const baseUrl = 'https://gelir-gider-backend.onrender.com/api';
static const String login = '/auth/google';
static const String profile = '/auth/profile';
static const String categories = '/categories';
static const String transactions = '/transactions';
static const String serverClientId = '65749887627-ob62fhhrlcde0f1sf22vanm9dllbbvkp.apps.googleusercontent.com';
}


class ApiService extends GetxService{
  late StorageService _storageService;
  late Dio _dio;

  Future<ApiService> init() async {
    _storageService = Get.find<StorageService>();
    _dio = Dio(BaseOptions(
      baseUrl: ApiConstants.baseUrl,
      connectTimeout: Duration(seconds: 60),
      receiveTimeout: Duration(seconds: 60),
      contentType: "application/json"
    ));
    
    _dio.interceptors.add(InterceptorsWrapper(
      onRequest: (options, handler) async{
        final token = _storageService.getValue<String>(StorageKeys.userToken);
        if(token != null){
          options.headers['Authorization'] = 'Bearer $token';
        }
        return handler.next(options);
      },
      onError: (error, handler) async{
        if(error.response?.statusCode == 401){
          await _storageService.remove(StorageKeys.userToken);
        }
        return handler.next(error);
      },
    ));
    return this;
  }

  Future<Response> get(String path,
  {
    Map<String, dynamic>? queryParameters,
    Options? options,
  }) async{
    try{
      return await _dio.get(path, queryParameters: queryParameters,options: options);

    }catch(e){
      print("Dio get error $e");
      rethrow;
    }
  }
Future<Response> post(
  String path,
  dynamic data, {
  Map<String, dynamic>? queryParameters,
  Options? options,
}) async {
  try {
    return await _dio.post(
      path,
      data: data, 
      queryParameters: queryParameters,
      options: options,
    );
  } catch (e) {
    print("Dio post error $e");
    rethrow;
  }
}



 Future<Response> put(
    String path,
    dynamic data,
  {
    Map<String, dynamic>? queryParameters,
    Options? options,
  }) async{
    try{
      return await _dio.put(path,
      data: data,
        queryParameters: queryParameters,options: options);

    }catch(e){
      print("Dio post error $e");
      rethrow;
    }
  }
   Future<Response> delete(
    String path,
    dynamic data,
  {
    Map<String, dynamic>? queryParameters,
    Options? options,
  }) async{
    try{
      return await _dio.delete(path,
      data: data,
        queryParameters: queryParameters,options: options);

    }catch(e){
      print("Dio post error $e");
      rethrow;
    }
  }


}