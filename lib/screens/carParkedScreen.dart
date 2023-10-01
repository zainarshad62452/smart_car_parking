import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:smart_car_parking/controllers/userController.dart';
import 'package:smart_car_parking/screens/loading.dart';
import 'package:smart_car_parking/screens/mainScreen.dart';
import 'package:smart_car_parking/screens/snackbar.dart';
import 'package:smart_car_parking/services/parkingServices.dart';

import '../services/stripe.dart';

class CarParkedScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    Get.put(UserController());
    return  Scaffold(
      backgroundColor: Colors.deepPurpleAccent.shade200,
      appBar: AppBar(
        elevation: 0.0,
        backgroundColor: Colors.deepPurpleAccent,
        title: const Text("Parking Info"),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(width: double.infinity,),
            Container(
              margin: const EdgeInsets.all(20.0 ),
              padding: const EdgeInsets.all(10.0),
              decoration: BoxDecoration(
                color: Colors.brown.shade200,
                borderRadius: BorderRadius.circular(30.0),
              ),
              child: const Text("Car Parked",style: TextStyle(fontSize: 60),),
            ),
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: CircleAvatar(
                radius: MediaQuery.of(context).size.width/2,
                backgroundColor: Colors.deepPurpleAccent.shade700,
                child: Image.asset("assets/images/car.png"),
              ),
            ),

            MaterialButton(onPressed: () async {
             int minutes = calculateDateDifference(DateTime.now(),DateTime.parse(userCntr.user!.value.parkedUpto!));
             int totalTimes = calculateDateDifference(DateTime.parse(userCntr.user!.value.parkedOn!),DateTime.parse(userCntr.user!.value.parkedUpto!));
             double calculatedFares = calculateFare(totalTimes);
             if(minutes>calculatedFares){
               await StripeServices.instance.initialize();
               await StripeServices.instance.startPurchase(minutes*0.333,
                       (isSuccess, message) async {
                     if (isSuccess) {
                       await ParkingSlotServices().leaveParking();
                     } else {
                       alertSnackbar("Error Please pay by cash");
                     }
                   },context);

             }else{
               await ParkingSlotServices().leaveParking();
               Get.offAll( MainScreen());
             }

            },child: Container(
              margin: const EdgeInsets.all(20.0 ),
              padding: const EdgeInsets.all(10.0),
              decoration: BoxDecoration(
                color: Colors.yellowAccent.shade700,
                borderRadius: BorderRadius.circular(30.0),
              ),
              child: const Text("Leave Parking",style: TextStyle(fontSize: 50),),
            ),)
          ],
        ),
      ),
    );
  }
  int calculateDateDifference(DateTime givenDate,DateTime now) {
    // Get the current date and time
    DateTime currentDate = now;

    // Calculate the difference in minutes
    int differenceInMinutes = givenDate.difference(currentDate).inMinutes;
    if(differenceInMinutes>=0){
      return 0;
    }else{
      return differenceInMinutes;
    }
  }

  double calculateFare(int minutes){
    int amount = 10 * minutes;
    return amount/60;

  }
}
