import 'package:adlisting/screens/home.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:adlisting/config/constants.dart';
import 'dart:convert';

class Auth extends GetxController {
  var token = "".obs;
  var userObj = {}.obs;

  login(email, password) {
    //https://adlisting.herokupapp.com/auth/login
    var url = Uri.parse(Constants().API_URL + "/auth/login");

    var input = jsonEncode({
      // converting to Json Object

      "email": email,

      "password": password
    });

    http
        .post(
      url,
      headers: {"Content-Type": "application/json"},
      body: input,
    )
        .then((res) {
      print(res);
      print(res.body);

      // resp holds the information data. (status,token,loginSucces,etc.)
      var resp = jsonDecode(res.body);

      token.value = resp["data"]["token"];
      userObj.assignAll(resp["data"]["user"]);
      Get.offAll(HomeScreen());
    }).catchError((err) {
      print(err);
    });
  }

  register(name, email, mobile, password) {
    //https://adlisting.herokupapp.com/auth/register
    var url = Uri.parse(Constants().API_URL + "/auth/register");

    var input = jsonEncode({
      // converting to Json Object
      "name": name,
      "email": email,
      "mobile": mobile,
      "password": password
    });

    http
        .post(
      url,
      headers: {"Content-Type": "application/json"},
      body: input,
    )
        .then((res) {
      print(res);
      print(res.body);
    }).catchError((err) {
      print(err);
    });
  }
}
