import 'package:adlisting/screens/home.dart';
import 'package:adlisting/screens/register.dart';
import 'package:adlisting/services/auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LoginScreen extends StatelessWidget {
  LoginScreen({Key? key}) : super(key: key);

  Auth _auth = Get.put(Auth());
  
  TextEditingController _emailCtrl = TextEditingController(text: "tryx@tryx.com");
  TextEditingController _passwordCtrl = TextEditingController(text: "123456");

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          body: SingleChildScrollView(
        child: Container(
          child: Column(
            children: [
              Container(
                height: MediaQuery.of(context).size.height * 0.4,
                width: double.infinity,
                child: Stack(
                  children: [
                    Align(
                      alignment: Alignment.center,
                      child: Container(
                        width: double.infinity,
                        height: double.infinity,
                        child: Image.asset(
                          "assets/images/background.png",
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    Align(
                      alignment: Alignment.center,
                      child: Container(
                        width: 200,
                        child: Image.asset(
                          "assets/images/logo.png",
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 8,
              ),
              Container(
                padding: EdgeInsets.all(16.0),
                child: Column(
                  children: [
                    TextField(
                      controller: _emailCtrl,
                      decoration: InputDecoration(
                        hintText: "Email Address",
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Colors.grey.shade300,
                            width: 2.0,
                          ),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Colors.grey.shade300,
                            width: 2.0,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 8,
                    ),
                    TextField(
                      controller: _passwordCtrl,
                      decoration: InputDecoration(
                        hintText: "Password",
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Colors.grey.shade300,
                            width: 2.0,
                          ),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Colors.grey.shade300,
                            width: 2.0,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 12,
                    ),
                    Container(
                      width: double.infinity,
                      height: 48,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          elevation: 0,
                        ),
                        child: Text(
                          "Login",
                        ),
                        onPressed: () {
                          _auth.login(_emailCtrl.text, _passwordCtrl.text);
                          // Get.offAll(HomeScreen());
                        },
                      ),
                    ),
                    SizedBox(
                      height: 12,
                    ),
                    TextButton(
                      onPressed: () {
                        Get.to(RegisterScreen());
                      },
                      child: Text("Don't have any account?"),
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      )),
    );
  }
}
