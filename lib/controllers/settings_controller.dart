
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:task_app/constant.dart';

class SettingController extends GetxController {
  // language

  var storag = GetStorage();
  var langlocal = eng;

  @override
  void onInit() async{
    super.onInit();
    langlocal = await getLanguage;
  }
  //save lang to local storege
   void saveLanguages(String lang)async{
    await storag.write('lang', lang);
   }

  Future<String> get getLanguage async{
     return storag.read('lang');
  }

  void changeLanguge(String langType) {
    saveLanguages(langType);
    if(langlocal == langType){
      return;
    }
    if(langType == arb){
      langlocal = arb;
      saveLanguages(arb);

    }else{
      langlocal = eng;
      saveLanguages(eng);
    }
    update();
  }
}
