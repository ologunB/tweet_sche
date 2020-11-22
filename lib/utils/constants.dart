import 'dart:math';

import 'package:flushbar/flushbar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:tweet_sche/widgets/buttonBlue.dart';
import 'package:tweet_sche/widgets/buttonRed.dart';

String MY_NAME, MY_UID, MY_EMAIL, MY_IMAGE, MY_NUMBER, MY_TYPE;
const userDetails = 'user_details';
var imgUrlString =
    "https://firebasestorage.googleapis.com/v0/b/fvast-d08d6.appspot.com/o/logo.png?alt=media&token=6b63a858-7625-4640-a79a-b0b0fd5c04a8";

showSnackBar(context, String title, String msg) {
  Flushbar(
    title: title,
    message: msg,
    margin: EdgeInsets.all(8),
    flushbarStyle: FlushbarStyle.FLOATING,
    flushbarPosition: FlushbarPosition.TOP,
    duration: Duration(seconds: 2),
    borderRadius: 8,
    backgroundColor: title == "Error" ? Colors.red : Colors.blue,
  ).show(context);
}

String validateEmail(value) {
  Pattern pattern =
      r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
  RegExp regex = new RegExp(pattern);
  if (!regex.hasMatch(value)) {
    return 'Enter Valid Email';
  } else if (value.isEmpty) {
    return 'Please enter your email!';
  } else
    return null;
}

String ravePublicKey = "FLWPUBK_TEST-4775239fc89f256ef2f24cddcebc17e1-X";
String raveEncryptKey = "FLWSECK_TEST079f656d190b";
String oneOnlineSignalKey = "c25d99bb-1ab2-462f-a7b3-827ac97c7563";
String giphyAPIKey = "QnNdfJczSYZujc9nx1iIfzYk9PDt5erj";

String greeting() {
  var hour = DateTime.now().hour;
  if (hour < 12) {
    return 'Morning';
  }
  if (hour < 17) {
    return 'Afternoon';
  }
  return 'Evening';
}

String timeAgo(DateTime d) {
  Duration diff = DateTime.now().difference(d);
  if (diff.inDays > 365)
    return "${(diff.inDays / 365).floor()} ${(diff.inDays / 365).floor() == 1 ? "year" : "years"} ago";
  if (diff.inDays > 30)
    return "${(diff.inDays / 30).floor()} ${(diff.inDays / 30).floor() == 1 ? "month" : "months"} ago";
  if (diff.inDays > 7)
    return "${(diff.inDays / 7).floor()} ${(diff.inDays / 7).floor() == 1 ? "week" : "weeks"} ago";
  if (diff.inDays > 0)
    return "${diff.inDays} ${diff.inDays == 1 ? "day" : "days"} ago";
  if (diff.inHours > 0)
    return "${diff.inHours} ${diff.inHours == 1 ? "hour" : "hours"} ago";
  if (diff.inMinutes > 0)
    return "${diff.inMinutes} ${diff.inMinutes == 1 ? "minute" : "minutes"} ago";
  return "just now";
}

String timeConvert(double d) {
  if (d < 1) return "1 hour";
  if (d > 120) return ">5 days";
  if (d > 96) return "4 days";
  if (d > 72) return ">3 days";
  if (d > 48) return ">2 days";
  if (d > 24) return ">1 day";
  if (d < 24) return "${d.ceil()} hours";
  return "";
}

const chars = "abcdefghijklmnopqrstuvwxyz0123456789";

String randomString() {
  Random rnd = Random(DateTime.now().millisecondsSinceEpoch);
  String result = "";
  for (var i = 0; i < 12; i++) {
    result += chars[rnd.nextInt(chars.length)];
  }
  return result;
}

String presentDate() {
  return DateFormat("EEE MMM d").format(DateTime.now());
}

String presentDateTime() {
  return DateFormat("EEE MMM d, HH:mm").format(DateTime.now());
}

final commaFormat = new NumberFormat("#,##0", "en_US");


offKeyboard(context) {
  FocusScopeNode currentFocus = FocusScope.of(context);

  if (!currentFocus.hasPrimaryFocus) {
    currentFocus.unfocus();
    return;
  }
  currentFocus.unfocus();
}

RoundedRectangleBorder Box30Edge = RoundedRectangleBorder(
  borderRadius: BorderRadius.only(
    topLeft: Radius.circular(30),
    topRight: Radius.circular(30),
  ),
);

showTweetDialog(context, {type, message, onPressed}) {
  showDialog(
      context: context,
      builder: (_) {
        return AlertDialog(
          title: Text(
            type ?? "",
            textAlign: TextAlign.center,
            style: TextStyle(color: Colors.black, fontSize: 18, fontWeight: FontWeight.bold),
          ),
          content: Text(
            message,
            textAlign: TextAlign.center,
            style: TextStyle(color: Colors.black, fontSize: 18),
          ),
          actions: <Widget>[
            type == "CONFIRMATION" ?  ButtonRed(
                title: "  CANCEL  ",
                onPressed: () {
                    Navigator.of(context).pop()  ;
                }): SizedBox(),
            ButtonBlue(
                title:   type == "CONFIRMATION" ? "     YES     ": "    OK    ",
                onPressed: () {
                  onPressed == null ? Navigator.of(context).pop() : onPressed();
                })
          ],
        );
      });
}
