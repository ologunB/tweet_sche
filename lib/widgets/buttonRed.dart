import 'package:flutter/material.dart';
import 'package:tweet_sche/utils/sizeCalculator.dart';

class ButtonRed extends StatefulWidget {
  final String title;
  final GestureTapCallback onPressed;
  ButtonRed({
    Key key,
    @required this.title,
    @required this.onPressed,
  }) : super(key: key);
  @override
  _ButtonRedState createState() => _ButtonRedState();
}

class _ButtonRedState extends State<ButtonRed> {
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
        color: Colors.red,
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
