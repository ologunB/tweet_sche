import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:tweet_sche/utils/constants.dart';
import 'package:tweet_sche/utils/styles.dart';
import 'package:tweet_sche/views/admin/admin_layout_template.dart';
import 'package:tweet_sche/views/admin/upload_excel/upload_multiple_excel.dart';

import '../layout_template.dart';
import 'create_tweet.dart';
import 'notification_page.dart';

class MainLayoutBuilder extends StatefulWidget {
  final Widget body;
  final String title;

  MainLayoutBuilder({@required this.title, @required this.body});

  @override
  _MainLayoutBuilderState createState() => _MainLayoutBuilderState();
}

bool isFabOpened = false;

class _MainLayoutBuilderState extends State<MainLayoutBuilder>
    with TickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
        SystemUiOverlayStyle(statusBarColor: Styles.appPrimaryColor));
    return GestureDetector(
      onTap: () {
        offKeyboard(context);
        if (isFabOpened) animate();
      },
      child: Scaffold(
        backgroundColor: Styles.appPrimaryColor,

        appBar: AppBar(
          elevation: 0.0,
          centerTitle: true,
          actions: [
            GestureDetector(
              onTap: () {
                moveTo(context, NotificationPage());
              },
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Icon(
                  Icons.notifications,
                  color: Colors.white,
                ),
              ),
            )
          ],
          leading: GestureDetector(
            child: Icon(
              EvaIcons.menu,
              color: Colors.white,
            ),
            onTap: () {
              offKeyboard(context);
              MY_TYPE == "Admin"
                  ? adminMainScaffoldKey.currentState.openDrawer()
                  : cusMainScaffoldKey.currentState.openDrawer();
            },
          ),
          title: Text(
            widget.title,
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
        ),
        body: Opacity(opacity: isFabOpened ? 0.2 : 1, child: widget.body),
        floatingActionButton: fab(context),
        floatingActionButtonAnimator: FloatingActionButtonAnimator.scaling,
      ),
    );
  }

  Widget fab(context) {
    if (MY_TYPE != "Admin") {
      return subscriberFAB(
          onPressed: () {
            moveTo(context, CreateTweet());
          },
          color: Styles.appPrimaryColor);
    } else {
      return adminFAB();
    }
  }

  AnimationController subAnimationController;
  AnimationController adminAnimationController;
  Animation<Color> _buttonColor;
  Animation<double> _translateButton;
  Curve _curve = Curves.easeOut;
  double _fabHeight = 56.0;

  @override
  void initState() {
    super.initState();
    subAnimationController = AnimationController(
      vsync: this,
      duration: Duration(seconds: 2),
    )
      ..forward()
      ..repeat(reverse: true);

    adminAnimationController =
        AnimationController(vsync: this, duration: Duration(milliseconds: 500))
          ..addListener(() {
            setState(() {});
          });
    _buttonColor = ColorTween(
      begin: Styles.appPrimaryColor,
      end: Colors.red,
    ).animate(CurvedAnimation(
      parent: adminAnimationController,
      curve: Interval(
        0.00,
        1.00,
        curve: Curves.linear,
      ),
    ));

    _translateButton = Tween<double>(
      begin: _fabHeight,
      end: -14.0,
    ).animate(CurvedAnimation(
      parent: adminAnimationController,
      curve: Interval(
        0.0,
        0.75,
        curve: _curve,
      ),
    ));
  }

  @override
  void dispose() {
    subAnimationController.dispose();
    adminAnimationController.dispose();
    super.dispose();
  }

  Widget subscriberFAB({onPressed, color}) {
    return GestureDetector(
      onTap: () {
        onPressed();
      },
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
            child: AnimatedBuilder(
          animation: subAnimationController,
          builder: (context, child) {
            return Container(
              decoration: BoxDecoration(
                color: color.withOpacity(0.5),
                borderRadius: BorderRadius.circular(20),
              ),
              child: Padding(
                padding: EdgeInsets.all(8.0 * subAnimationController.value),
                child: child,
              ),
            );
          },
          child: Container(
            decoration: BoxDecoration(
              color: color,
              borderRadius: BorderRadius.circular(20),
            ),
            padding: EdgeInsets.all(5),
            child: Icon(isFabOpened ? Icons.close : Icons.add,
                color: Colors.white, size: 30),
          ),
        )),
      ),
    );
  }

  Widget adminFAB() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      children: <Widget>[
        Transform(
          transform: Matrix4.translationValues(
            0.0,
            _translateButton.value * 2.0,
            0.0,
          ),
          child: isFabOpened
              ? GestureDetector(
                  onTap: () {
                    animate();
                    moveTo(context, CreateTweet());
                  },
                  child: Container(
                    padding: EdgeInsets.all(8),
                    decoration: BoxDecoration(
                        color: Styles.appPrimaryColor,
                        borderRadius: BorderRadius.all(Radius.circular(10))),
                    child: Text("Schedule Tweet",
                        style: TextStyle(
                            fontSize: 16,
                            color: Colors.white,
                            fontWeight: FontWeight.bold)),
                  ),
                )
              : SizedBox(),
        ),
        Transform(
          transform: Matrix4.translationValues(
            0.0,
            _translateButton.value,
            0.0,
          ),
          child: isFabOpened
              ? GestureDetector(
                  onTap: () {
                    animate();

                    moveTo(context, UploadMultiplePosts());
                  },
                  child: Container(
                    padding: EdgeInsets.all(8),
                    decoration: BoxDecoration(
                        color: Styles.appPrimaryColor,
                        borderRadius: BorderRadius.all(Radius.circular(10))),
                    child: Text("Bulk Tweet Upload",
                        style: TextStyle(
                            fontSize: 16,
                            color: Colors.white,
                            fontWeight: FontWeight.bold)),
                  ),
                )
              : SizedBox(),
        ),
        subscriberFAB(
          color: _buttonColor.value,
          onPressed: animate,
        ),
      ],
    );
  }

  animate() {
    if (!isFabOpened) {
      adminAnimationController.forward();
    } else {
      adminAnimationController.reverse();
    }
    isFabOpened = !isFabOpened;
  }
}
