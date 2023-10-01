import 'package:get/get.dart';
import 'package:smart_car_parking/Models/parkingSlotModel.dart';

import '../services/parkingServices.dart';



final slotCntr = Get.find<CarParkingController>();

class CarParkingController extends GetxController {
  RxList<CarParkingModel>? allParkingSlots = <CarParkingModel>[].obs;


  @override
  void onReady() {
    initAdminStream();
  }

  initAdminStream() async {
    allParkingSlots!.bindStream(ParkingSlotServices().streamAllPakringSlots()!);
  }
}
