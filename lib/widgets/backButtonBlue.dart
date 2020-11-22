import 'package:flutter/material.dart';
import 'package:tweet_sche/utils/styles.dart';

class BackButtonBlue extends StatefulWidget {
  @override
  _BackButtonBlueState createState() => _BackButtonBlueState();
}

class _BackButtonBlueState extends State<BackButtonBlue> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Material(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
          // side: BorderSide(color: Colors.red)
        ),
        color: Styles.whiteColor,
        child: InkWell(
          onTap: () {
            Navigator.of(context).pop();
          },
          child: Container(
              padding: EdgeInsets.symmetric(vertical: 12.0, horizontal: 11),
              decoration: BoxDecoration(
                //  color: Color(0xff4b7aed),
                borderRadius: BorderRadius.circular(10.0),
              ),
              child: Center(
                  child: Icon(
                Icons.arrow_back_ios,
                size: 18,
                color: Styles.appPrimaryColor,
              ))),
        ));
  }
}
