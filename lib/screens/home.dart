import 'package:adlisting/custom-widgets/ad-card.dart';
import 'package:adlisting/data/ads-data.dart';
import 'package:adlisting/screens/ad-detail.dart';
import 'package:adlisting/screens/manage-ad.dart';
import 'package:adlisting/screens/settings.dart';
import 'package:adlisting/services/ads.dart';
import 'package:adlisting/services/auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:timeago/timeago.dart' as timeago;

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  Auth _auth = Get.put(Auth());
  Ads _adsCtrl = Get.put(Ads());
  List _ads = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    fetchAds();
  }

  fetchAds() async {
    //fetch All the Ads
    var resp = await _adsCtrl.fetchAds();
    setState(() {
      _ads = resp;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Ads Listing"),
        actions: [
          IconButton(
            onPressed: () {
              fetchAds();
            },
            icon: Icon(Icons.refresh),
          ),
          GestureDetector(
            onTap: () {
              Get.to(SettingsScreen());
            },
            child: Obx(
              () => CircleAvatar(
                radius: 16,
                backgroundImage: NetworkImage(_auth.userObj["imgURL"]),
              ),
            ),
          )
        ],
      ),
      body: Container(
        padding: EdgeInsets.all(8.0),
        child:
            //_ads.length ==0 ? Container():
            _ads.isEmpty
                ? Container(
                    alignment: Alignment.center,
                    margin: EdgeInsets.only(top: 20),
                    child: CircularProgressIndicator(
                      value: 2,
                    ))
                : GridView.builder(
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        mainAxisSpacing: 8,
                        crossAxisSpacing: 8,
                        childAspectRatio: 0.75),
                    itemCount: _ads.length,
                    itemBuilder: (bc, index) {
                      var timesAgo = timeago
                          .format(DateTime.parse(_ads[index]["createdAt"]));
                      return GestureDetector(
                        onTap: () {
                          // var timeAgo = timeago.format(_ads[index]["createdAt"]);
                          Get.to(
                            AdDetailScreen(
                              title: _ads[index]["title"],
                              images: _ads[index]["images"],
                              price: (_ads[index]["price"]).toDouble(),
                              authorName: _ads[index]["authorName"],
                              timeAgo: timesAgo,
                              mobile: _ads[index]["mobile"],
                              description: _ads[index]["description"],
                            ),
                          );
                        },
                        child: AdCard(
                          imageURL: _ads[index]["images"][0],
                          title: _ads[index]["title"],
                          price: (_ads[index]["price"]).toDouble(),
                        ),
                      );
                    },
                  ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Get.to(ManageAdScreen(
            isEdit: false,
            product: {},
          ));
        },
        child: Icon(
          Icons.add_a_photo_outlined,
        ),
      ),
    );
  }
}
