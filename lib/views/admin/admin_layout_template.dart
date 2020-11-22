import 'package:cached_network_image/cached_network_image.dart';
import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:tweet_sche/utils/constants.dart';
import 'package:tweet_sche/utils/styles.dart';
import 'package:tweet_sche/views/subscriber/contact_us/contact_us.dart';
import 'package:tweet_sche/views/subscriber/home/home_view.dart';
import 'package:tweet_sche/views/subscriber/partial/builder.dart';
import 'package:tweet_sche/views/subscriber/posts/post_view.dart';
import 'package:tweet_sche/views/subscriber/settings/settings_view.dart';
import 'package:tweet_sche/views/subscriber/settings/update_profile.dart';
import 'package:tweet_sche/views/subscriber/subscription/subscribe_view.dart';
import 'package:tweet_sche/widgets/authEmailInput.dart';
import 'package:tweet_sche/widgets/authPasswordInput.dart';
import 'package:tweet_sche/widgets/buttonBlue.dart';


class LayoutAdminTemplate extends StatefulWidget {
  @override
  _LayoutAdminTemplateState createState() => _LayoutAdminTemplateState();
}

final GlobalKey<ScaffoldState> adminMainScaffoldKey = GlobalKey<ScaffoldState>();

class _LayoutAdminTemplateState extends State<LayoutAdminTemplate> {
  int _selectedDrawerIndex = 0;
  bool isOpen = true;

  _getDrawerItemWidget(int pos) {
    switch (pos) {
      case 0:
        return HomeView();
      case 1:
        return PostView();
      case 2:
        return PostView();
      case 3:
        return PostView();
      case 4:
        return PostView();
      case 5:
        return SubscribeView();
      case 6:
        return SettingsView();
      case 7:
        return ContactUs();

       default:
        return Center(
            child: MainLayoutBuilder(
          title: "Error",
          body: Text("Error"),
        ));
    }
  }

  _onSelectItem(int index) {
    setState(() => _selectedDrawerIndex = index);
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
        SystemUiOverlayStyle(statusBarColor: Styles.appPrimaryColor));
    return GestureDetector(
      onTap: (){
        offKeyboard(context);
      },
      child: Scaffold(
        key: adminMainScaffoldKey,
        drawer: Drawer(
          elevation: 4,
          child: Column(
            children: <Widget>[
              Expanded(
                child: Column(
                  children: <Widget>[
                    GestureDetector(
                      onTap: () {
                        moveTo(context, UpdateProfile());
                      },
                      child: Container(
                        padding: EdgeInsets.all(8),
                        color: Styles.appLightPrimaryColor,
                        child: SafeArea(
                        bottom: false,

                          child: Row(
                            children: <Widget>[
                              Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(30.0),
                                    child: CachedNetworkImage(
                                      imageUrl: imgUrlString ?? "ere",
                                      height: 60,
                                      width: 60,
                                      placeholder: (context, url) => Image(
                                          image: AssetImage(
                                              "assets/images/person.png"),
                                          height: 60,
                                          width: 60,
                                          fit: BoxFit.contain),
                                      errorWidget: (context, url, error) => Image(
                                          image: AssetImage(
                                              "assets/images/person.png"),
                                          height: 60,
                                          width: 60,
                                          fit: BoxFit.contain),
                                    ),
                                  )),
                              Expanded(
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: <Widget>[
                                      Text(
                                        MY_NAME,
                                        style: TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.w600),
                                      ),
                                      Text(
                                        MY_EMAIL,
                                        style: TextStyle(
                                            fontSize: 14,
                                            fontWeight: FontWeight.w500),
                                      ),
                                      Text(
                                        "View Profile",
                                        style: TextStyle(
                                            fontSize: 13,
                                            fontWeight: FontWeight.w500,
                                            color: Colors.blue),
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),

                    InkWell(
                      onTap: () {
                        _onSelectItem(0);
                      },
                      child: ListTile(
                        tileColor: _selectedDrawerIndex == 0
                            ? Styles.appBackground
                            : Colors.white,
                        leading: Icon(EvaIcons.home),
                        title: Text(
                          "Home",
                          style: TextStyle(fontSize: 16),
                        ),
                      ),
                    ),
                    ExpansionPanelList(
                      expansionCallback: (int index, bool isExpanded) {
                        setState(() {
                          isOpen = !isOpen;
                        });
                      },
                      children: [1].map<ExpansionPanel>((item) {
                        return ExpansionPanel(
                            headerBuilder:
                                (BuildContext context, bool isExpanded) {
                              return ListTile(
                                leading: Icon(EvaIcons.briefcase),
                                tileColor: _selectedDrawerIndex == 1 ||
                                        _selectedDrawerIndex == 2 ||
                                        _selectedDrawerIndex == 3 ||
                                        _selectedDrawerIndex == 4
                                    ? Styles.appBackground
                                    : Colors.white,
                                title: Text(
                                  "Posts",
                                  style: TextStyle(fontSize: 16),
                                ),
                              );
                            },
                            body: Column(
                              children: [
                                postWidget("Scheduled", "100", Colors.blue, 1),
                                postWidget("Published", "67", Colors.green, 2),
                                postWidget("Failed", "54", Colors.red, 3),
                                postWidget("Drafts", "22", Colors.grey, 4)
                              ],
                            ),
                            isExpanded: isOpen,
                            canTapOnHeader: true);
                      }).toList(),
                    ),
                    InkWell(
                      onTap: () {
                        _onSelectItem(5);
                      },
                      child: ListTile(
                        tileColor: _selectedDrawerIndex == 5
                            ? Styles.appBackground
                            : Colors.white,
                        leading: Icon(EvaIcons.creditCard),
                        title: Text(
                          "Subscription",
                          style: TextStyle(fontSize: 16),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 18.0, vertical: 8),
                      child: Container(
                        height: 1,
                        color: Colors.grey,
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        _onSelectItem(6);
                      },
                      child: ListTile(
                        tileColor: _selectedDrawerIndex == 6
                            ? Styles.appBackground
                            : Colors.white,
                        leading: Icon(EvaIcons.settings),
                        title: Text(
                          "Settings",
                          style: TextStyle(fontSize: 16),
                        ),
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        _onSelectItem(7);
                      },
                      child: ListTile(
                        tileColor: _selectedDrawerIndex == 7
                            ? Styles.appBackground
                            : Colors.white,
                        leading: Icon(Icons.help),
                        title: Text(
                          "Help and Support",
                          style: TextStyle(fontSize: 16),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SafeArea(
                child: Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: Row(
                    children: [
                      Expanded(
                        child: DropdownButton<String>(
                          hint: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 10.0),
                            child: Text("Add Twitter Account"),
                          ),
                          value: "selectedAccount",
                          underline: SizedBox(),
                          items: [].map((value) {
                            return DropdownMenuItem<String>(
                              value: value,
                              child: Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 8.0),
                                child: Row(
                                  mainAxisSize: MainAxisSize.max,
                                  children: <Widget>[
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: <Widget>[
                                        Text(
                                          value.name,
                                          style: TextStyle(
                                              fontSize: 16,
                                              fontWeight: FontWeight.bold),
                                        ),
                                        Row(
                                          mainAxisSize: MainAxisSize.max,
                                          children: <Widget>[
                                            Text(value.number),
                                            SizedBox(
                                              width: 20,
                                            ),
                                            Text(value.bank)
                                          ],
                                        )
                                      ],
                                      mainAxisSize: MainAxisSize.min,
                                    )
                                  ],
                                ),
                              ),
                            );
                          }).toList(),
                          isExpanded: true,
                          onChanged: (value) {
                            setState(() {
                              //   selectedAccount = value;
                            });
                          },
                        ),
                      ),
                      InkWell(
                        onTap: () {
                          onAddTwitter(context);
                        },
                        child: Container(
                          decoration: BoxDecoration(
                              color: Colors.grey,
                              borderRadius: BorderRadius.circular(10)),
                          child: Icon(
                            Icons.add,
                            color: Colors.white,
                            size: 27,
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
        body: _getDrawerItemWidget(_selectedDrawerIndex),

      ),
    );
  }

  onAddTwitter(context) {
    Navigator.pop(context);
    showModalBottomSheet(
      isScrollControlled: true,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(30),
          topRight: Radius.circular(30),
        ),
      ),
      context: context,
      builder: (context) => Container(
        padding:  MediaQuery.of(context).viewInsets,
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            // shrinkWrap: true,
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              GestureDetector(
                child: Align(
                  alignment: Alignment.topRight,
                  child: Icon(
                    Icons.cancel,
                    color: Colors.red,
                    size: 30,
                  ),
                ),
                onTap: () {
                  Navigator.pop(context);
                },
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  "Enter Twitter Login Details",
                  style: TextStyle(
                      fontSize: 18,
                      color: Styles.appPrimaryColor,
                      fontWeight: FontWeight.bold),
                ),
              ),
              AuthEmailInput(
                hintText: "Email/Username",
                //controller: emailController,
              ),
              SizedBox(height: 8),
              AuthPasswordInput(
                hintText: "Password",
                //  controller: passwordController,
              ),
              SizedBox(height: 8),
              ButtonBlue(
                  title: "LOGIN",
                  onPressed: () {
                    loginTwitter(context);
                  }),
              SizedBox(height: 20)
            ],
          ),
        ),
      ),
    );
  }

  void loginTwitter(context) {}

  Widget postWidget(String title, String amount, Color color, int index) {
    return InkWell(
      onTap: () {
        _onSelectItem(index);
      },
      child: Padding(
        padding: const EdgeInsets.only(left: 0.0),
        child: Container(
          padding: EdgeInsets.all(8),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(0),
              color: _selectedDrawerIndex == index
                  ? Styles.appBackground
                  : Colors.black12.withAlpha(15)),
          child: Row(
            children: [
              SizedBox(width: 65),
              Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5), color: color),
                padding: EdgeInsets.all(7),
                child: Text(
                  amount,
                  style: TextStyle(fontSize: 17),
                ),
              ),
              SizedBox(width: 8),
              Text(
                title,
                style: TextStyle(fontSize: 15),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
