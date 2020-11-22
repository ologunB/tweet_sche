import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:loading_overlay/loading_overlay.dart';
import 'package:tweet_sche/utils/styles.dart';
import 'package:tweet_sche/widgets/authEmailInput.dart';
import 'package:tweet_sche/widgets/backButtonBlue.dart';

class UpdateProfile extends StatefulWidget {
  @override
  _UpdateProfileState createState() => _UpdateProfileState();
}

class _UpdateProfileState extends State<UpdateProfile> {
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

  TextEditingController name, email, phone, street, city, plateNumber;
  String avatar;
  bool isLoading = false;

  void getDetails() async {
    DocumentSnapshot doc =
        await FirebaseFirestore.instance.collection('All').doc("MY_UID").get();

    name = TextEditingController(text: doc.data()["Name"]);
    email = TextEditingController(text: doc.data()["Email"]);
    phone = TextEditingController(text: doc.data()["Phone"]);
    street = TextEditingController(text: doc.data()["Street"]);
    city = TextEditingController(text: doc.data()["City"]);
    plateNumber = TextEditingController(text: doc.data()["Plate Number"]);
    avatar = doc.data()["Avatar"];

    isLoading = false;
    setState(() {});
  }

  @override
  void initState() {
    //  getDetails();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Styles.appPrimaryColor,
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.black),
        backgroundColor: Styles.appPrimaryColor,
        elevation: 0.0,
        centerTitle: true,
        leading: Padding(
          padding: const EdgeInsets.all(8.0),
          child: BackButtonBlue(),
        ),
        title: Text(
          "Profile",
          style: TextStyle(
              color: Colors.white, fontSize: 22, fontWeight: FontWeight.bold),
        ),
      ),
      body: LoadingOverlay(
        isLoading: isLoading,
        progressIndicator: CupertinoActivityIndicator(radius: 15),
        child: Column(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(40.0),
              child: Image(
                  image: AssetImage("assets/images/person.png"),
                  height: 80,
                  width: 80,
                  fit: BoxFit.contain),
            ),
            Container(
              alignment: Alignment.center,
              padding: EdgeInsets.all(10),
              child: Text(
                "Richard Miles",
                style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    color: Colors.white),
              ),
            ),
            Expanded(
              child: Container(
                padding: EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(25),
                    topRight: Radius.circular(25),
                  ),
                ),
                child: ListView(
                  children: [
                    Center(
                        child: Text(
                      "Subscription Plan: Blaze",
                      style: TextStyle(fontSize: 20),
                    )),
                    SizedBox(height: 8),
                    AuthEmailInput(
                      hintText: "Email",
                      //  controller: passwordController,
                    ),
                    SizedBox(height: 8),
                    AuthEmailInput(
                      hintText: "Blah Blah",
                      //  controller: passwordController,
                    ),
                    SizedBox(height: 8),
                    AuthEmailInput(
                      hintText: "Bleh Bleh",
                      //  controller: passwordController,
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
