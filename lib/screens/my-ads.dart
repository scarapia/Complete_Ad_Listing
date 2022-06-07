import 'package:adlisting/custom-widgets/my-ads-card.dart';
import 'package:adlisting/data/my-ads-data.dart';
import 'package:adlisting/screens/manage-ad.dart';
import 'package:adlisting/services/ads.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:timeago/timeago.dart' as timeago;

class MyAdsScreen extends StatefulWidget {
  const MyAdsScreen({Key? key}) : super(key: key);

  @override
  _MyAdsScreenState createState() => _MyAdsScreenState();
}

class _MyAdsScreenState extends State<MyAdsScreen> {
  MyAdsData adsData = MyAdsData();

  List _ads = [];
  Ads _adsCtrl = Get.put(Ads());

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    fetchAds();
  }

  fetchAds() async {
    var resp = await _adsCtrl.fetchMyAds();
    setState(() {
      _ads = resp;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("My Ads"),
      ),
      body: Container(
        padding: EdgeInsets.all(4.0),
        child: _ads.isEmpty
            ? Container(
                alignment: Alignment.center,
                margin: EdgeInsets.only(top: 20),
                child: CircularProgressIndicator(
                  value: 2,
                ))
            : ListView.builder(
                itemCount: _ads.length,
                itemBuilder: (bc, index) {
                  var timesAgo =
                      timeago.format(DateTime.parse(_ads[index]["createdAt"]));
                  return GestureDetector(
                    onTap: () {
                      Get.to(
                          ManageAdScreen(isEdit: true, product: _ads[index]));
                    },
                    child: MyAdsCard(
                      imageURL: _ads[index]['images'][0],
                      title: _ads[index]['title'],
                      price: _ads[index]['price'].toDouble(),
                      timeAgo: timesAgo,
                    ),
                  );
                },
              ),
      ),
    );
  }
}
