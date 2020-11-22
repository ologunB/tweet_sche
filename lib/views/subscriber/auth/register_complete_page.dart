import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:tweet_sche/utils/styles.dart';
import 'package:tweet_sche/views/subscriber/layout_template.dart';

class RegisterComplete extends StatefulWidget {
  @override
  _RegisterCompleteState createState() =>
      _RegisterCompleteState();
}

class _RegisterCompleteState
    extends State<RegisterComplete> {
  @override
  void initState() {
    Future.delayed(Duration(seconds: 5)).then((value) => Navigator.of(context)
        .pushReplacement(
            MaterialPageRoute(builder: (context) => LayoutTemplate())));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: InkWell(
        onTap: () {
          Navigator.of(context).pushReplacement(
              MaterialPageRoute(builder: (context) => LayoutTemplate()));
        },
        child: Container(
          padding: EdgeInsets.all(20),
          color: Styles.appPrimaryColor,
          child: Column(
            children: <Widget>[
              Expanded(
                child: Center(
                  child: Text(
                    "You are all set. You can now use the services of PayFast",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.w500),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 18.0),
                child: Center(
                  child: Text(
                    "TAP ANYWHERE TO CONTINUE",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.w400),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
