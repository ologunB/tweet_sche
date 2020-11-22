
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:tweet_sche/utils/styles.dart';
import 'package:tweet_sche/views/subscriber/partial/builder.dart';
import 'package:tweet_sche/widgets/buttonBlue.dart';

class SubscribeView extends StatefulWidget {
  @override
  _SubscribeViewState createState() => _SubscribeViewState();
}

class _SubscribeViewState extends State<SubscribeView>
    with TickerProviderStateMixin {
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
        SystemUiOverlayStyle(statusBarColor: Styles.appPrimaryColor));
    return MainLayoutBuilder(
        title: "Subscription",
        body: Scaffold(
          key: scaffoldKey,
          backgroundColor: Styles.appPrimaryColor,
          body: SafeArea(
            child: Container(
              padding: EdgeInsets.symmetric(vertical: 8, horizontal: 8),
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(25),
                      topRight: Radius.circular(25))),
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Select from the packages below",
                          style: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                  ),
                  StaggeredGridView.count(
                    shrinkWrap: true,
                    crossAxisCount: 4,
                    children: [1, 2, 2, 2, 2, 2, 3].map<Widget>((item) {
                      return GestureDetector(
                        onTap: () {
                          onClickPackage(context, item);
                        },
                        child: Padding(
                          padding: const EdgeInsets.all(5.0),
                          child: Container(
                            padding: EdgeInsets.all(10),
                            decoration: BoxDecoration(
                              color: Styles.tintColor1,
                              borderRadius:
                                  BorderRadius.all(Radius.circular(20)),
                            ),
                            child: Column(
                              children: [
                                Text("FREE",
                                    style: TextStyle(
                                        fontSize: 15, color: Colors.black54)),
                                Text("Tweets: 200",
                                    style: TextStyle(
                                        fontSize: 16, color: Colors.black)),
                                Text("Description: ...",
                                    style: TextStyle(
                                        fontSize: 15, color: Colors.black54)),
                                Container(
                                  padding: EdgeInsets.all(8),
                                  decoration: BoxDecoration(
                                      color: Styles.appPrimaryColor,
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(10))),
                                  child: Text("PAY NOW",
                                      style: TextStyle(
                                          fontSize: 16,
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold)),
                                )
                              ],
                              crossAxisAlignment: CrossAxisAlignment.start,
                            ),
                          ),
                        ),
                      );
                    }).toList(),
                    staggeredTiles: [1, 2, 2, 2, 2, 2, 3]
                        .map<StaggeredTile>((_) => StaggeredTile.fit(2))
                        .toList(),
                    mainAxisSpacing: 3.0,
                    crossAxisSpacing: 4.0,
                  )
                ],
              ),
            ),
          ),
        ));
  }

  onClickPackage(BuildContext context, item) {
    showModalBottomSheet(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(30),
          topRight: Radius.circular(30),
        ),
      ),
      context: context,
      builder: (context) => Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
          //     color: Colors.blueAccent,
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
              Text(
                "Are you sure you wanna pay for the selected package?",
                style: TextStyle(fontSize: 16, color: Styles.appPrimaryColor),
              ),              SizedBox(height: 10),

              Text(
                "Plan: Blaze",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 10),
              Text(
                "Price: \$50",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 10),
              Text(
                "Tweets: 2000",
                style: TextStyle(fontSize: 16, color: Colors.black54),
              ),
              SizedBox(height: 10),
              ButtonBlue(
                  title: "PAY",
                  onPressed: () {
                    payNow(context, "plan");
                  }),
              SizedBox(height: 30)
            ],
          ),
        ),
      ),
    );
  }

  void payNow(context, plan) {}
}
