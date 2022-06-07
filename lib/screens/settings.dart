import 'package:adlisting/screens/my-ads.dart';
import 'package:adlisting/screens/profile.dart';
import 'package:adlisting/services/auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';

class SettingsScreen extends StatelessWidget {
  SettingsScreen({Key? key}) : super(key: key);
  Auth _auth = Get.put(Auth());

  openLink(link) async {
    await canLaunch(link) ? launch(link) : throw 'error';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Settings"),
      ),
      body: ListView(
        children: [
          ListTile(
            title: Obx(() =>Text("${_auth.userObj["name"]}")) ,
            subtitle:Obx((() => Text("${_auth.userObj["mobile"]}"))) ,
            leading: Obx(() => CircleAvatar(
              backgroundImage: NetworkImage(
                  "${_auth.userObj["imgURL"]}"),
            ),), 
            trailing: TextButton(
              onPressed: () {
                Get.to(ProfileScreen());
              },
              child: Text("Edit"),
            ),
          ),
          ListTile(
            onTap: () {
              Get.to(MyAdsScreen());
            },
            title: Text("My Ads"),
            leading: Icon(Icons.post_add),
          ),
          ListTile(
            onTap: () {
              openLink("https://pub.dev/");
            },
            title: Text("About us"),
            leading: Icon(Icons.person_outline_outlined),
          ),
          ListTile(
            onTap: () {
              openLink("https://pub.dev/");
            },
              title: Text("Contact Us"), leading: Icon(Icons.contacts_outlined))
        ],
      ),
    );
  }
}
