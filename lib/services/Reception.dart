import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:smart_car_parking/controllers/parkingController.dart';
import 'package:smart_car_parking/screens/Auth/login_page.dart';
import 'package:smart_car_parking/screens/carParkedScreen.dart';
import '../constants.dart';
import '../controllers/loading.dart';
import '../controllers/userController.dart';
import '../screens/mainScreen.dart';

class Reception {
  final auth = FirebaseAuth.instance;
  final firestore = FirebaseFirestore.instance;

  Future<bool> getType() async {
    bool type = false;
    try{
 type =  await firestore
      .collection("users")
      .doc(auth.currentUser!.uid)
      .get()
      .then((value) => value['isParked']??false);
  return type;
  }catch (e){
    return false;
  }
}


  userReception() async {
    loading(false);
    if(FirebaseAuth.instance.currentUser!=null){
      bool type = await getType();
      if(type){
        // Get.put(UserController());
        Get.offAll(CarParkedScreen());
      }else{
        // Get.put(UserController());
        Get.offAll(() =>  MainScreen());
      }

    }else{
      Get.offAll(() => const LoginPage());
    }
  }
}
