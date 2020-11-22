import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:tweet_sche/utils/constants.dart';
import 'package:tweet_sche/utils/sizeCalculator.dart';
import 'package:tweet_sche/utils/styles.dart';
import 'package:tweet_sche/views/subscriber/partial/builder.dart';
import 'package:tweet_sche/widgets/buttonBlue.dart';
import 'package:url_launcher/url_launcher.dart';

class ContactUs extends StatefulWidget {
  final String from;

  const ContactUs({Key key, this.from}) : super(key: key);

  @override
  _ContactUsState createState() => _ContactUsState();
}

class _ContactUsState extends State<ContactUs> {
  TextEditingController _messageController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return MainLayoutBuilder(
      title: "Support",
      body: Scaffold(
          body: Container(
        color: Styles.appPrimaryColor,
        child: Container(
          padding: EdgeInsets.all(8),
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(25), topRight: Radius.circular(25))),
          height: double.infinity,
          child: SingleChildScrollView(
            child: Column(
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    "Write your Message",
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.w800),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(10.0),
                  child: TextFormField(
                    keyboardType: TextInputType.text,
                    // maxLength: 280,
                    maxLines: 7,
                    controller: _messageController,
                    style: TextStyle(
                        color: Color(0xff071232),
                        fontWeight: FontWeight.w500,
                        fontSize: sizer(true, 16.0, context)),
                    cursorColor: Color(0xff245DE8),
                    decoration: InputDecoration(
                      contentPadding: EdgeInsets.symmetric(
                          vertical: sizer(false, 20, context),
                          horizontal: sizer(true, 20, context)),
                      fillColor: Color(0xffF3F4F8),
                      hintText: "Write your message...",
                      hintStyle: TextStyle(
                          color: Color(0xff828A95),
                          fontSize: sizer(true, 16.0, context)),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: BorderSide(
                          width: 0,
                          style: BorderStyle.none,
                        ),
                      ),
                      filled: true,
                    ),
                  ),
                ),
                ButtonBlue(
                  title: " SEND  ",
                  onPressed: () async {
                    if (_messageController.text.toString().isEmpty) {
                      showSnackBar(context, "Error", "Message cannot be empty");
                      return;
                    }
                    String _messageTitle = "Messsage To FVAST";
                    String _messageBody = _messageController.text.toString();
                    String _url =
                        "mailto:fvastsupp0rt@gmail.com?subject=$_messageTitle&body=$_messageBody%20";

                    if (await canLaunch(_url)) {
                      await launch(_url);
                    } else {
                      showSnackBar(context, "Error", "Could not launch $_url");

                      throw 'Could not launch $_url';
                    }
                  },
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Padding(
                      padding: EdgeInsets.all(18.0),
                      child: InkWell(
                        child: Image(
                          image: AssetImage("assets/images/instagram.png"),
                          height: 40,
                          width: 40,
                        ),
                        onTap: () async {
                          String _url1 =
                              "http://instagram.com/_u/officialfabatmngt";
                          String _url2 =
                              "http://instagram.com/officialfabatmngt";

                          if (await canLaunch(_url1)) {
                            await launch(_url1);
                          } else {
                            await launch(_url2);
                          }
                        },
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.all(18.0),
                      child: InkWell(
                        child: Image(
                          image: AssetImage("assets/images/facebook.png"),
                          height: 40,
                          width: 40,
                        ),
                        onTap: () async {
                          String _url1 = "fb://profile/100039244757529";
                          String _url2 =
                              "https://www.facebook.com/fabat.mngt.1";

                          if (await canLaunch(_url1)) {
                            await launch(_url1);
                          } else {
                            await launch(_url2);
                          }
                        },
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.all(18.0),
                      child: InkWell(
                        child: Image(
                          image: AssetImage("assets/images/twitter.png"),
                          height: 40,
                          width: 40,
                        ),
                        onTap: () async {
                          String _url1 =
                              "twitter://user?screen_name=fabatmanagement";
                          String _url2 =
                              "https://twitter.com/fabatmanagement?s=09";

                          if (await canLaunch(_url1)) {
                            await launch(_url1);
                          } else {
                            await launch(_url2);
                          }
                        },
                      ),
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 50.0),
                  child: Divider(
                    color: Colors.black.withAlpha(200),
                    height: 16,
                  ),
                ),
                Text(
                  "Reach Us Through",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.w700),
                ),
              ],
            ),
          ),
        ),
      )),
    );
  }
}
