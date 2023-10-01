import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:smart_car_parking/Models/parkingSlotModel.dart';
import 'package:smart_car_parking/screens/carParkedScreen.dart';
import 'package:smart_car_parking/screens/mainScreen.dart';
import 'package:smart_car_parking/services/stripe.dart';
import '../controllers/loading.dart';
import '../controllers/parkingController.dart';
import '../screens/snackbar.dart';

class ParkingSlotServices {
  final auth = FirebaseAuth.instance;
  final firestore = FirebaseFirestore.instance;

  Future<String> addParkingSlot({required String parkingName,required double latitude,required double longitude,}) async {
    var x = CarParkingModel(
        parkingName: parkingName,
      reservedBy: "",
      latitude: latitude,
      longitude: longitude,
      isReserved: false,
      isParked: false,
      carNumber: ""
    );
    try {
      var user =  firestore.collection("parking_slots").doc(parkingName);
      x.uid = user.id;
      user.set(x.toJson());
      loading(false);
      return user.id;
    } catch (e) {
      loading(false);
      alertSnackbar("Can't create slot");
      return "Can't create slot";
    }
  }
  Stream<CarParkingModel>? streamParkingSlot(String id)  {
    try{
      return firestore
          .collection("parking_slots")
          .doc(id)
          .snapshots()
          .map((event) {
        if(event.data()!=null){
          return CarParkingModel.fromJson(event.data()!);
        }else{
          return CarParkingModel();
        }
      });
    }catch(e){
      return null;
    }
  }
  Stream<List<CarParkingModel>>? streamAllPakringSlots() {
    try {
      return firestore.collection("parking_slots").snapshots().map((event) {
        loading(false);
        List<CarParkingModel> list = [];
        event.docs.forEach((element) {
          final admin = CarParkingModel.fromJson(element.data());
          list.add(admin);
        });
        loading(false);
        return list;
      });
    } catch (e) {
      loading(false);
      return null;
    }
  }

  Future<void> reserveParking(String id,String carNumber) async {
    try{
      loading(true);
      await firestore.collection("parking_slots").doc(id).update(
        {
          "isReserved": true,
          "reservedBy": auth.currentUser!.email,
          "carNumber" : carNumber,
        }
      );
      loading(false);
    }catch(e){
      loading(false);
      alertSnackbar(" not exists");
      return print(e.toString());
    }
  }
  Future<void> clearReservedParking(String id) async {
    try{
      loading(true);
      await firestore.collection("parking_slots").doc(id).update(
          {
            "isReserved": false,
            "reservedBy": "",
            "carNumber" : "",
          }
      );
      loading(false);
    }catch(e){
      loading(false);
      alertSnackbar(" not exists");
      return print(e.toString());
    }
  }
  Future<void> parkCar(String parkUpto,) async {
    try{
      loading(true);
        await firestore.collection("users").doc(auth.currentUser?.uid).update(
            {
              "parkedUpto": parkUpto,
              "registeredOn": DateTime.now().toString(),
              "isParked": true
            });
        Get.to(CarParkedScreen());
        alertSnackbar("Successfully");
        Get.back();
      loading(false);
    }catch(e){
      loading(false);
      alertSnackbar("not exists");
      return print(e.toString());
    }
  }
  Future<void> leaveParking() async {
    try{
      loading(true);
      await firestore.collection("users").doc(auth.currentUser?.uid).update(
          {
            "parkedUpto": "",
            "registeredOn": "",
            "isParked": false
          });
      Get.to(MainScreen());
      alertSnackbar("Successfully");
      Get.back();
      loading(false);
    }catch(e){
      alertSnackbar("Unable to leave parking");
      return print(e.toString());
    }
  }
}
