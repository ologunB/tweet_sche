import 'package:flutter/material.dart';
import 'package:tweet_sche/utils/sizeCalculator.dart';
import 'package:tweet_sche/utils/styles.dart';

class ButtonBlue extends StatefulWidget {
  final String title;
  final GestureTapCallback onPressed;
  ButtonBlue({
    Key key,
    @required this.title,
    @required this.onPressed,
  }) : super(key: key);
  @override
  _ButtonBlueState createState() => _ButtonBlueState();
}

class _ButtonBlueState extends State<ButtonBlue> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Material(
        //   elevation: 5,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
          // side: BorderSide(color: Colors.red)
        ),
        color: Styles.appCanvasColor,
        child: InkWell(
          onTap: widget.onPressed,
          child: AnimatedContainer(
            duration: Duration(seconds: 2),
              padding: EdgeInsets.symmetric(vertical: 17.0),
              decoration: BoxDecoration(
                //   color: Color(0xff245DE8),
                borderRadius: BorderRadius.circular(10.0),
              ),
              child: Center(
                child: Text(
                  widget.title,
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: sizer(true, 16.0, context),
                      fontWeight: FontWeight.w700),
                ),
              )),
        ));
  }
}
