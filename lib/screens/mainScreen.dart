import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:smart_car_parking/screens/snackbar.dart';
import 'package:smart_car_parking/services/parkingServices.dart';

import '../controllers/loading.dart';
import '../services/stripe.dart';
import 'loading.dart';

class MainScreen extends StatefulWidget {
  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  TimeOfDay selectedTime = TimeOfDay.now();

  Future<void> _selectTime(BuildContext context) async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: selectedTime,
    );
    if (picked != null && picked != selectedTime)
      setState(() {
        selectedTime = picked;
      });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.deepPurpleAccent.shade700,
        title: Text('Parking Timer'),
      ),
      body:Padding(
        padding: const EdgeInsets.all(30.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            MaterialButton(
              color: Colors.deepPurpleAccent.shade700,
              onPressed: () async {
                int minutes = calculateDateDifference(DateTime.now(), timeOfDayToDateTime(selectedTime))*(-1);
                  int totalAmount = ((minutes)*0.033).round();
                await StripeServices.instance.initialize();
                await StripeServices.instance.startPurchase(5,
                        (isSuccess, message) async {
                      await ParkingSlotServices().parkCar(timeOfDayToDateTime(selectedTime).toString());
                      if (isSuccess) {
                      } else {
                        alertSnackbar("Error Please pay the amount");
                      }
                    },context);

              },child: Text("Park Car",style: TextStyle(color: Colors.white,),),),
          ],
        ),
      ),
    );
  }
  String timeOfDayToString(TimeOfDay time) {
    int totalMinutes = time.hour * 60 + time.minute;
    int seconds = totalMinutes * 60;
    return '${(seconds ~/ 60).toString().padLeft(2, '0')}:' +
        '${(seconds % 60).toString().padLeft(2, '0')}';
  }

  TimeOfDay stringToTimeOfDay(String timeString) {
    List<String> parts = timeString.split(':');
    int totalMinutes = int.parse(parts[0]) * 60 + int.parse(parts[1]);
    int hour = totalMinutes ~/ 60;
    int minute = totalMinutes % 60;
    return TimeOfDay(hour: hour, minute: minute);
  }
  DateTime timeOfDayToDateTime(TimeOfDay time) {
    final now = DateTime.now();
    return DateTime(now.year, now.month, now.day, time.hour, time.minute);
  }

  TimeOfDay dateTimeToTimeOfDay(DateTime dateTime) {
    return TimeOfDay(hour: dateTime.hour, minute: dateTime.minute);
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

  double calculateAmount(double minutes){
    return minutes * 3.33;
  }
}
