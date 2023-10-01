import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:lottie/lottie.dart';
import 'package:smart_car_parking/screens/carParkedScreen.dart';

import '../Models/parkingSlotModel.dart';
import '../services/parkingServices.dart';

class TimerDialog extends StatefulWidget {
  CarParkingModel? model;

  TimerDialog({this.model});
  @override
  _TimerDialogState createState() => _TimerDialogState();
}

class _TimerDialogState extends State<TimerDialog> {
  int _remainingSeconds = 180; // 3 minutes
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    _startTimer();
  }

  void _startTimer() {
    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      setState(() {
        if (_remainingSeconds > 0) {
          _remainingSeconds--;
        } else {
          timer.cancel();
          leaveParking();
          Navigator.pop(context); // Close the dialog when the timer completes
        }
      });
    });
  }
void leaveParking() async {
  await ParkingSlotServices().clearReservedParking(widget.model!.uid!);
}
  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  String _formatTime(int seconds) {
    int minutes = seconds ~/ 60;
    int remainingSeconds = seconds % 60;
    return '$minutes:${remainingSeconds.toString().padLeft(2, '0')}';
  }

  @override
  Widget build(BuildContext context) {
    String formattedTime = _formatTime(_remainingSeconds);

    return Container(
      color: Colors.transparent,
      child: AlertDialog(
        title: Text('Reserve Parking Slot'),
        content: Text('Please park your car in : $formattedTime \nIf you will not park your car in given time then your spot will become free again!.'),
        actions: <Widget>[
          TextButton(
            onPressed: () async {
              showDialog(context: context, builder: (ctx)=>AlertDialog(
                content: Lottie.asset("assets/images/parking2.json"),
              ));
              // await ParkingSlotServices().parkCar(widget.model!.uid!);

              Future.delayed(Duration(seconds: 3),(){
                Navigator.pop(context);
                Navigator.pop(context);
                Get.offAll(CarParkedScreen());
              });
            },
            child: Text('Parked'),
          ),
          TextButton(
            onPressed: () async {
              await ParkingSlotServices().clearReservedParking(widget.model!.uid!);
              Navigator.pop(context); // Close the dialog
            },
            child: Text('Cancel'),
          ),
        ],
      ),
    );
  }
}
