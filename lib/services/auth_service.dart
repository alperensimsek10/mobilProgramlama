import 'package:finans_takipp/services/api_service.dart';
import 'package:finans_takipp/services/storage_service.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:get/get.dart';

class AuthService extends GetxService {
  late final StorageService _storageService;
  late final ApiService _apiService;
  late final GoogleSignIn _googleSignIn; 

  Future<AuthService> init() async {
    _storageService = Get.find<StorageService>();
    _apiService = Get.find<ApiService>();
    _googleSignIn = GoogleSignIn(); 
    return this; 
  }
  signInWithGoogle() async{
    try{
      await _googleSignIn.signOut();
      final GoogleSignInAccount? _googleUser = await _googleSignIn.signIn();
      if(_googleUser == null) return null;
      
      
      final GoogleSignInAuthentication _googleAuthentication = await _googleUser.authentication;
      print("google user ${_googleUser.toString()}");
      print("google auth: ${_googleAuthentication.idToken}");
      


    }catch(e){
      print(e);
    }
  }
}
