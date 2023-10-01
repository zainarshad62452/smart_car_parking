import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import 'package:smart_car_parking/screens/splash_screen.dart';

import 'controllers/loading.dart';
import 'controllers/parkingController.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Get.put(LoadingController());
  Get.put(CarParkingController());
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return Sizer(builder: ((context, orientation, deviceType) {
      return GetMaterialApp(
        theme: ThemeData(
          fontFamily: "Brand-Bold"
        ),
        debugShowCheckedModeBanner: false,
        title: 'Smart Car Parking',
        home: SplashScreen(title: 'Smart Car Parking',),
      );
    }));

  }
}

