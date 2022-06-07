import 'package:adlisting/screens/login.dart';
import 'package:adlisting/services/auth.dart';
import 'package:adlisting/services/user.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ProfileScreen extends StatefulWidget {
  ProfileScreen({Key? key}) : super(key: key);

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  Auth _auth = Get.put(Auth());
  User _user = Get.put(User());

  var showDp = true;

  TextEditingController _nameCtrl = TextEditingController();
  TextEditingController _emailCtrl = TextEditingController();
  TextEditingController _mobileCtrl = TextEditingController();

  @override
  void initState() {
    super.initState();
    _nameCtrl.text = _auth.userObj["name"];
    _emailCtrl.text = _auth.userObj["email"];
    _mobileCtrl.text = _auth.userObj["mobile"];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Edit Profile"),
          centerTitle: true,
          elevation: 0,
        ),
        body: SingleChildScrollView(
          child: Container(
            child: Column(
              children: [
                showDp
                    ? GestureDetector(
                        onTap: () {
                          _user.updateDp();
                        },
                        child: Container(
                          margin: EdgeInsets.only(top: 16),
                          child: GestureDetector(
                            child: Obx(() => CircleAvatar(
                              radius: 40,
                              backgroundImage:
                                  NetworkImage(_auth.userObj["imgURL"]),
                            ),),  
                          ),
                        ),
                      )
                    : GestureDetector(
                        child: Container(
                          margin: EdgeInsets.only(top: 16),
                          height: 120,
                          width: 120,
                          decoration: BoxDecoration(
                            border: Border.all(
                              color: Colors.grey.shade300,
                            ),
                            borderRadius: BorderRadius.circular(4.0),
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.add_a_photo_outlined,
                                size: 40,
                              ),
                              SizedBox(height: 8),
                              Text(
                                "Tap to upload",
                                textAlign: TextAlign.center,
                              )
                            ],
                          ),
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
                        controller: _nameCtrl,
                        decoration: InputDecoration(
                          hintText: "Full Name",
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
                        controller: _mobileCtrl,
                        decoration: InputDecoration(
                          hintText: "Mobile Number",
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
                        height: 23,
                      ),
                      Container(
                        width: double.infinity,
                        height: 48,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            elevation: 0,
                          ),
                          child: Text("Update Profile"),
                          onPressed: () {
                            _user.updateProfile({
                             "name" : _nameCtrl.text,
                              "email":_emailCtrl.text,
                              "mobile" :_mobileCtrl.text,
                            });
                          },
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Container(
                        width: double.infinity,
                        height: 48,
                        child: TextButton(
                          child: Text("Logout"),
                          onPressed: () {
                            Get.offAll(LoginScreen());
                          },
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ));
  }
}
