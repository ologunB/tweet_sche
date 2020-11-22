import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:tweet_sche/utils/styles.dart';
import 'package:tweet_sche/widgets/backButtonBlue.dart';

class SubLayoutBuilder extends StatefulWidget {
  final Widget body;
  final String title;

  SubLayoutBuilder({@required this.title, @required this.body});

  @override
  _SubLayoutBuilderState createState() => _SubLayoutBuilderState();
}

class _SubLayoutBuilderState extends State<SubLayoutBuilder> {
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
          widget.title,
          style: TextStyle(
              color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold),
        ),
      ),
      body: Container(
        //   padding: EdgeInsets.all(8),
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(25), topRight: Radius.circular(25))),
        child: widget.body,
      ),
    );
  }
}
