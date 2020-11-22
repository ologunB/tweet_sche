import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hive/hive.dart';
import 'package:tweet_sche/utils/constants.dart';
import 'package:tweet_sche/utils/styles.dart';
import 'package:tweet_sche/views/subscriber/auth/signin_page.dart';
import 'package:tweet_sche/views/subscriber/partial/builder.dart';
import 'package:tweet_sche/views/subscriber/settings/update_profile.dart';
import 'package:url_launcher/url_launcher.dart';

class SettingsView extends StatefulWidget {
  @override
  _SettingsViewState createState() => _SettingsViewState();
}

class _SettingsViewState extends State<SettingsView>
    with TickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
        SystemUiOverlayStyle(statusBarColor: Styles.appPrimaryColor));
    return MainLayoutBuilder(
        title: "General Settings",
        body: Scaffold(
          backgroundColor: Styles.appPrimaryColor,
          body: SafeArea(
            child: Container(
              padding: EdgeInsets.symmetric(vertical: 8, horizontal: 8),
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(25),
                      topRight: Radius.circular(25))),
              child: DefaultTabController(
                length: 2,
                child: Scaffold(
                  backgroundColor: Colors.white,
                  primary: false,
                  appBar: AppBar(
                    primary: false,
                    centerTitle: true,
                    elevation: 0.0,
                    backgroundColor: Colors.white,
                    title: TabBar(
                      indicatorPadding: EdgeInsets.symmetric(vertical: -10),
                      indicatorWeight: 3,
                      indicatorColor: Styles.appCanvasColor,
                      isScrollable: true,
                      labelColor: Styles.appPrimaryColor,
                      tabs: [
                        Text(
                          "ACCOUNT",
                          style: TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.w600,
                              color: Styles.appPrimaryColor),
                        ),
                        Text(
                          "SETTINGS",
                          style: TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.w600,
                              color: Styles.appCanvasColor),
                        ),
                      ],
                    ),
                    // bottom: SizedBox(),
                  ),
                  body: TabBarView(
                    children: [
                      accountWidget(),
                      settingsWidget(),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ));
  }

  Widget accountWidget() {
    return Column(
      children: [
        ListTile(
          title: Text("View Profile"),
          trailing: Icon(Icons.arrow_forward_ios_sharp),
          onTap: () {
            moveTo(context, UpdateProfile());
          },
        ),
        ListTile(
          title: Text("Delete Accounts"),
          trailing: Icon(Icons.arrow_forward_ios_sharp),
          onTap: () {},
        ),
        MY_TYPE == "Admin"
            ? ListTile(
                title: Text("Permissions and Access"),
                trailing: Icon(Icons.arrow_forward_ios_sharp),
                onTap: () {},
              )
            : SizedBox(),
        ListTile(
          title: Text(
            "Logout",
            style: TextStyle(color: Colors.red),
          ),
          trailing: Icon(Icons.arrow_forward_ios_sharp, color: Colors.red),
          onTap: () {
            showTweetDialog(context,
                type: "CONFIRMATION",
                message: "Are you sure you want to logout?",
                onPressed: () {
                  afterLogout();
                });
          },
        ),
      ],
    );
  }


  Widget settingsWidget() {
    return Column(
      children: [
        ListTile(
          title: Text("Terms and Conditions"),
          trailing: Icon(Icons.arrow_forward_ios_sharp),
          onTap: () {},
        ),
        ListTile(
          title: Text("Change Language"),
          trailing: Icon(Icons.arrow_forward_ios_sharp),
          onTap: () {},
        ),
        ListTile(
          title: Text("About Us"),
          trailing: Icon(Icons.arrow_forward_ios_sharp),
          onTap: () {
            showDialog(
                context: context,
                builder: (_) {
                  return AlertDialog(
                    title: Image.asset(
                      "assets/images/logo.png",
                      height: 70,
                    ),
                    content: Text(
                      "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure ",
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 16),
                    ),
                    actions: [
                      FlatButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          child: Text("CLOSE"))
                    ],
                  );
                });
          },
        ),
        ListTile(
          title: Text("Share app"),
          trailing: Icon(Icons.arrow_forward_ios_sharp),
          onTap: () async {
            String _url =
                "https://play.google.com/store/apps/details?id=com.ologunb.fvastalpha&hl=en";
            if (await canLaunch(_url)) {
              await launch(_url);
            } else {
              showSnackBar(context, "Error", "Could not launch $_url");
              throw 'Could not launch $_url';
            }
          },
        ),
      ],
    );
  }

  Future afterLogout() {
  return  FirebaseAuth.instance.signOut().then((a) async {
      final Box userDetailsBox = Hive.box(userDetails);
      userDetailsBox.delete("isLoggedIn");
      userDetailsBox.delete("uid");
      userDetailsBox.delete("email");
      userDetailsBox.delete("name");
      userDetailsBox.delete("type");
      setState(() {

      });

      Navigator.pushAndRemoveUntil(
          context,
          CupertinoPageRoute(builder: (context) => SigninPage()),
              (Route<dynamic> route) => false);
    });
  }

}
