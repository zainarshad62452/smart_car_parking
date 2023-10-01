import 'package:email_validator/email_validator.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:get/get_utils/src/get_utils/get_utils.dart';
import '../../Services/Authentication.dart';
import '../../controllers/loading.dart';
import '../loading.dart';
import '../snackbar.dart';
import '../theme_helper.dart';
import 'login_page.dart';
class SignupPage extends StatefulWidget {
   SignupPage({Key? key,}) : super(key: key);

  @override
  _SignupPageState createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  final formKey = GlobalKey<FormState>();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final repasswordController = TextEditingController();
  final TextEditingController name = TextEditingController();
  final TextEditingController address = TextEditingController();
  final TextEditingController contactNo = TextEditingController();
  final TextEditingController carNo = TextEditingController();

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
    return Stack(
        children: [

    Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: SafeArea(
          child: Column(
            children: [
              Container(
                child: Center(
                  child: Padding(
                    padding: const EdgeInsets.only(right: 28.0),
                    child: Text(
                      'Parking',
                      style: TextStyle(
                          fontSize: 60, fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
                color: Colors.deepPurpleAccent.withOpacity(0.5),
                width: double.infinity,
              ),
              Container(
                child: Padding(
                  padding: const EdgeInsets.only(left: 28.0,top: 20,bottom: 20),
                  child: Text(
                    'Create An Account',
                    style: TextStyle(
                        fontSize: 30, fontWeight: FontWeight.bold),
                  ),
                ),
                width: double.infinity,
              ),
              SizedBox(height: 30.0),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 30.0),
                child: Form(
                    key: formKey,
                    child: Column(
                      children: [
                        Container(
                          child: TextFormField(
                            controller: name,
                            decoration: ThemeHelper().textInputDecoration(
                                'Name', 'Enter your name',true),
                            autovalidateMode:
                            AutovalidateMode.onUserInteraction,
                          ),
                          decoration:
                          ThemeHelper().inputBoxDecorationShaddow(),
                        ),
                        SizedBox(height: 30.0),
                        Container(
                          child: TextFormField(
                            controller: emailController,
                            decoration: ThemeHelper().textInputDecoration(
                                'Email', 'Enter your email',true),
                            autovalidateMode:
                            AutovalidateMode.onUserInteraction,
                            validator: (email) => email != null &&
                                !EmailValidator.validate(email)
                                ? 'Enter a valid email'
                                : null,
                          ),
                          decoration:
                          ThemeHelper().inputBoxDecorationShaddow(),
                        ),
                        SizedBox(height: 30.0),
                        Container(
                          child: TextFormField(
                            controller: contactNo,
                            decoration: ThemeHelper().textInputDecoration(
                                'Contact', 'Enter your Contact No',true),
                            autovalidateMode:
                            AutovalidateMode.onUserInteraction,
                          ),
                          decoration:
                          ThemeHelper().inputBoxDecorationShaddow(),
                        ),
                        SizedBox(height: 30.0),
                        Container(
                          child: TextFormField(
                            controller: passwordController,
                            obscureText: true,
                            decoration: ThemeHelper().textInputDecoration(
                                'Password', 'Enter your password',true),
                            autovalidateMode:
                            AutovalidateMode.onUserInteraction,
                            validator: (value) =>
                            value != null && value.length < 6
                                ? 'Enter min. 6 characters'
                                : null,
                          ),
                          decoration:
                          ThemeHelper().inputBoxDecorationShaddow(),
                        ),
                        SizedBox(height: 30.0),
                        Container(
                          child: TextFormField(
                            controller: repasswordController,
                            obscureText: true,
                            decoration: ThemeHelper().textInputDecoration(
                                'Confirm Password',
                                'Enter your password',true),
                            autovalidateMode:
                            AutovalidateMode.onUserInteraction,
                            validator: (value) =>
                            value != null && value.length < 6
                                ? 'Enter min. 6 characters'
                                : null,
                          ),
                          decoration:
                          ThemeHelper().inputBoxDecorationShaddow(),
                        ),
                        SizedBox(height: 30.0),
                        Container(
                          child: TextFormField(
                            controller: carNo,
                            decoration: ThemeHelper().textInputDecoration(
                                'Car Number',
                                'Enter your Car Number',true),
                            autovalidateMode:
                            AutovalidateMode.onUserInteraction,
                            validator: (value) =>
                            value != null
                                ? 'Enter min. 6 characters'
                                : null,
                          ),
                          decoration:
                          ThemeHelper().inputBoxDecorationShaddow(),
                        ),
                        SizedBox(height: 15.0),
                        Row(
                          children: [
                            Expanded(
                              child: Container(
                                decoration:
                                ThemeHelper().buttonBoxDecoration(context,true),
                                child: ElevatedButton(
                                  style: ThemeHelper().buttonStyle(),
                                  child: Padding(
                                    padding:
                                    EdgeInsets.fromLTRB(40, 10, 40, 10),
                                    child: Text(
                                      'Sign Up',
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          color: Colors.white),
                                    ),
                                  ),
                                  onPressed: () async {
                                    FocusScope.of(context).unfocus();

                                    if(formValidation()) {
                                      Authentication().createAccount(
                                          name: name.text.trim(),
                                          email: emailController.text.trim(),
                                          pass:
                                          passwordController.text.trim(),
                                          contactNo: contactNo.text.trim(),
                                        carNo:carNo.text.trim()

                                      );
                                    }
                                  },
                                ),
                              ),
                            ),
                            SizedBox(width: 10.0,),
                            Expanded(
                              child: Container(
                                decoration:
                                ThemeHelper().buttonBoxDecoration(context,true),
                                child: ElevatedButton(
                                  style: ThemeHelper().buttonStyle(),
                                  child: Padding(
                                    padding:
                                    EdgeInsets.fromLTRB(40, 10, 40, 10),
                                    child: Text(
                                      'Log In',
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          color: Colors.white),
                                    ),
                                  ),
                                  onPressed: (){
                                   Get.offAll(LoginPage());
                                  },
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    )),
              ),
            ],
          ),
        ),
      ),
    ),
          LoadingWidget(),
    ],
    );
  }
  bool formValidation() {
    if (name.text.isEmpty || passwordController.text.isEmpty) {
      alertSnackbar("All fields are required");
      return false;
    } else if (!GetUtils.isEmail(emailController.text)) {
      alertSnackbar("Email is not valid");
      return false;
    }  else if (carNo.text.isEmpty) {
      alertSnackbar("Please enter car number");
      return false;
    } else if (passwordController.text.length < 6) {
      alertSnackbar("Password must be of atleast 6 charachters");
      return false;
    }  else
      return true;
  }
}
