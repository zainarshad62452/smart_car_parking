import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:smart_car_parking/constants.dart';
import 'package:smart_car_parking/screens/Auth/signup.dart';
import '../../Services/Authentication.dart';
import '../../controllers/loading.dart';
import '../loading.dart';
import '../theme_helper.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();

    super.dispose();
  }

  double _headerHeight = 250;
  Key _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {

    return
    Stack(
      children: [
        !loading()
            ?
        Scaffold(
          backgroundColor: Colors.white,
          body: SafeArea(
            child: Column(
              children: [
                Expanded(
                  flex: 1,
                  child: Container(
                    decoration: BoxDecoration(
                      image: DecorationImage(image: AssetImage("assets/images/parking.jpg"),fit: BoxFit.cover),
                    ),
                  ),
                ),
                SizedBox(height: 30.0),
                Container(
                  height: 75.0,
                  width: 230.0,
                  padding: EdgeInsets.only(bottom: 20),
                  decoration: BoxDecoration(
                    color: kMainColor,
                    borderRadius: BorderRadius.circular(20.0),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black,
                        offset: Offset(1.0, 0.5),
                        blurRadius: 2.5,
                        spreadRadius: 0.5,
                      ),
                    ]
                  ),
                  child: Center(
                    child: Text(
                      'Parking System',
                      style: TextStyle(color: Colors.white,fontSize: 30),
                    ),
                  ),
                ),
                SizedBox(height: 30.0),
                Expanded(
                  flex: 2,
                  child: Container(
                    padding:EdgeInsets.symmetric(horizontal: 20.0),
                    child: SingleChildScrollView(
                      child: Form(
                          key: _formKey,
                          child: Column(
                            children: [
                              Container(
                                child: TextField(
                                  controller: emailController,
                                  decoration: ThemeHelper().textInputDecoration(
                                      'Email', 'Enter your email'),
                                ),
                                decoration:
                                ThemeHelper().inputBoxDecorationShaddow(),
                              ),
                              SizedBox(height: 30.0),
                              Container(
                                child: TextField(
                                  controller: passwordController,
                                  obscureText: true,
                                  decoration: ThemeHelper().textInputDecoration(
                                      'Password', 'Enter your password'),
                                ),
                                decoration:
                                ThemeHelper().inputBoxDecorationShaddow(),
                              ),
                              SizedBox(height: 15.0),
                              Padding(
                                padding: const EdgeInsets.symmetric(horizontal:50.0),
                                child: Container(
                                  decoration:
                                  ThemeHelper().buttonBoxDecoration(context),
                                  child: ElevatedButton(
                                    style: ThemeHelper().buttonStyle(),
                                    child: Padding(
                                      padding:
                                      EdgeInsets.fromLTRB(40, 10, 40, 10),
                                      child: Text(
                                        'Log In',
                                        style: TextStyle(
                                            fontSize: 20,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.white),
                                      ),
                                    ),
                                    onPressed: () async {
                                      Authentication().signinWithEmail(emailController.text.trim(), passwordController.text.trim());
                                    },
                                  ),
                                ),
                              ),
                              SizedBox(height: 35.0),
                              Padding(
                                padding: const EdgeInsets.symmetric(horizontal:50.0),
                                child: Container(
                                  decoration:
                                  ThemeHelper().buttonBoxDecoration(context),
                                  child: ElevatedButton(
                                    style: ThemeHelper().buttonStyle(),
                                    child: Padding(
                                      padding:
                                      EdgeInsets.fromLTRB(40, 10, 40, 10),
                                      child: Text(
                                        'Sign Up',
                                        style: TextStyle(
                                            fontSize: 20,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.white),
                                      ),
                                    ),
                                    onPressed: () {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  SignupPage()));
                                      },
                                  ),
                                ),
                              ),
                            ],
                          )),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ):
        LoadingWidget(),
        LoadingWidget(),
      ],
    );
  }
}
