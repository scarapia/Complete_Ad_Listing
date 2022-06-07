import 'package:adlisting/services/auth.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:adlisting/config/constants.dart';
import 'dart:convert';
import 'package:image_picker/image_picker.dart';

class User extends GetxController {
  Auth _auth = Get.put(Auth());

  getProfile() {
    var url = Uri.parse(Constants().API_URL + "/user/profile");
    var token = _auth.token;

    http.post(
      url,
      headers: {
        "Content-Type": "application/json",
        "Authorization": "Bearer $token"
      },
    ).then((res) {
      print(res);
      print(res.body);
      var resp = json.decode(res.body);
      _auth.userObj.assignAll(resp["data"]);
    }).catchError((err) {
      print(err);
    });
  }

  updateProfile(input) {
    //https://adlisting.herokupapp.com/user/
    var url = Uri.parse(Constants().API_URL + "/user/");

    var body = json.encode(input);

    var token = _auth.token;

    http
        .patch(
      url,
      headers: {
        "Content-Type": "application/json",
        "Authorization": "Bearer $token"
      },
      body: body,
    )
        .then((res) {
      print(res);
      print(res.body);
      getProfile();
    }).catchError((err) {
      print(err);
    });
  }

  updateDp() async {
    var image = await ImagePicker().pickImage(source: ImageSource.gallery);
    print(image!.path);
    var url = Uri.parse(Constants().API_URL + "/upload/profile");

    var request = http.MultipartRequest("POST", url);
    request.files.add(await http.MultipartFile.fromPath("avatar", image.path));
    var res = await request.send();

    var responseData = await res.stream.toBytes();
    var responseString = String.fromCharCodes(responseData);
    print(json.decode(responseString));
    var jsonObj = json.decode(responseString);
    print(jsonObj["data"]["path"]);
    
    updateProfile({
      "imgURL": jsonObj["data"]["path"]
      });
  }
}
