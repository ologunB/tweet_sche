
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:tweet_sche/utils/constants.dart';
import 'package:tweet_sche/utils/sizeCalculator.dart';
import 'package:tweet_sche/utils/styles.dart';
import 'package:tweet_sche/views/subscriber/partial/builder.dart';
import 'package:tweet_sche/views/subscriber/partial/sub_builder.dart';
import 'package:tweet_sche/views/subscriber/posts/post_view.dart';
import 'package:tweet_sche/widgets/carousel_slider.dart';


class HomeView extends StatefulWidget {
  @override
  _HomeViewState createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  bool isAdmin = MY_TYPE == "Admin";
  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
        SystemUiOverlayStyle(statusBarColor: Styles.appPrimaryColor));
    return MainLayoutBuilder(
        title: "Home",
        body: Scaffold(
          backgroundColor: Styles.appPrimaryColor,
          body: SingleChildScrollView(
            child: Container(
              padding: EdgeInsets.all(8),
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(25),
                      topRight: Radius.circular(25))),
              child: SafeArea(
                child: Column(
                  children: [
                    CarouselSlider(
                      // height: MediaQuery.of(context).size.height / 3,
                      autoPlay: true,
                      enableInfiniteScroll: true,
                      enlargeCenterPage: true,
                      pauseAutoPlayOnTouch: Duration(seconds: 5),
                      items: [1, 1, 1].map((i) {
                        return Builder(
                          builder: (context) {
                            return Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Container(
                                  decoration: BoxDecoration(
                                      boxShadow: [
                                        BoxShadow(
                                            blurRadius: 5,
                                            color: Colors.black12,
                                            spreadRadius: 5)
                                      ],
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(15)),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(
                                        "POST ADS HERE",
                                        style: TextStyle(fontSize: 18),
                                      ),
                                    ],
                                  )),
                            );
                          },
                        );
                      }).toList(),
                    ),
                    mediumVerticalSpacer(),
                    isAdmin ? SizedBox(): Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Details",
                            style: TextStyle(
                                fontSize: 16, fontWeight: FontWeight.bold),
                          ),
                          Text(
                            "See more...",
                            style: TextStyle(fontSize: 14, color: Colors.grey),
                          )
                        ],
                      ),
                    ),
                    isAdmin ? SizedBox():  Container(
                        child: Container(
                      decoration: BoxDecoration(
                          color: Styles.appCanvasColor,
                          borderRadius: BorderRadius.all(Radius.circular(10))),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              children: [
                                Text(
                                  "Subscription Type:",
                                  style: TextStyle(
                                      fontSize: 13, color: Colors.white),
                                ),
                                mediumVerticalSpacer(),
                                Text(
                                  "FLEX",
                                  style: TextStyle(
                                      fontSize: 16, color: Colors.white),
                                ),
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              children: [
                                Text(
                                  "Days Left:",
                                  style: TextStyle(
                                      fontSize: 13, color: Colors.white),
                                ),
                                mediumVerticalSpacer(),
                                Text(
                                  "31",
                                  style: TextStyle(
                                      fontSize: 16, color: Colors.white),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    )),

                    isAdmin ? SizedBox():  mediumVerticalSpacer(),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Today's Task",
                            style: TextStyle(
                                fontSize: 16, fontWeight: FontWeight.bold),
                          ),
                          GestureDetector(
                            onTap: () {
                              moveTo(
                                  context,
                                  SubLayoutBuilder(
                                      title: "Scheduled Posts",
                                      body: PostViewBody()));
                            },
                            child: Text(
                              "See all...",
                              style:
                                  TextStyle(fontSize: 14, color: Colors.grey),
                            ),
                          )
                        ],
                      ),
                    ),
                    ListView.builder(
                        physics: ClampingScrollPhysics(),
                        itemCount: 4,
                        shrinkWrap: true,
                        itemBuilder: (context, index) {
                          return Padding(
                            padding: const EdgeInsets.all(5.0),
                            child: IntrinsicHeight(
                              child: Row(
                                children: [
                                  Column(
                                    children: [
                                      Container(
                                          padding: EdgeInsets.all(5),
                                          decoration: BoxDecoration(
                                              color: colorList[4 + index],
                                              borderRadius: BorderRadius.all(
                                                  Radius.circular(20))),
                                          child: Icon(
                                            Icons.check,
                                            color: Colors.white,
                                          )),
                                      VerticalDivider(
                                        width: 2,
                                        thickness: 4,
                                        // height: 100,
                                        color: colorList[4 + index],
                                      ),
                                      Container(
                                        width: 2,
                                        height: 120,
                                        color: colorList[4 + index],
                                      ),
                                    ],
                                    //  crossAxisAlignment: CrossAxisAlignment.,
                                    mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                  ),
                                  SizedBox(width: 10),
                                  Expanded(
                                    child: GestureDetector(
                                      onTap: () {
                                        onClickPost(context, "item");
                                      },
                                      child: Container(
                                        padding: EdgeInsets.all(10),
                                        decoration: BoxDecoration(
                                            color: colorList[index],
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(20))),
                                        child: Column(
                                          children: [
                                            Text("@MasterTope",
                                                style: TextStyle(
                                                    fontSize: 16,
                                                    color: Colors.black54)),
                                            Text(
                                                "You can for instance animate the size of the padding around the button. I would use circular containers around the IconButton.",
                                                style: TextStyle(
                                                    fontSize: 17,
                                                    color: Colors.black)),
                                            Row(
                                              children: [
                                                Text("30 minutes",
                                                    style: TextStyle(
                                                        fontSize: 15,
                                                        color:
                                                        Colors.black54)),
                                                Container(
                                                  padding: EdgeInsets.all(8),
                                                  decoration: BoxDecoration(
                                                      color:
                                                      colorList[4 + index]
                                                          .withAlpha(255),
                                                      borderRadius:
                                                      BorderRadius.all(
                                                          Radius.circular(
                                                              10))),
                                                  child: Text("Done",
                                                      style: TextStyle(
                                                          fontSize: 15,
                                                          color: Colors.white,
                                                          fontWeight:
                                                          FontWeight
                                                              .bold)),
                                                )
                                              ],
                                              mainAxisAlignment:
                                              MainAxisAlignment
                                                  .spaceBetween,
                                            )
                                          ],
                                          crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                        ),
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            ),
                          );
                        }),
                  ],
                ),
              ),
            ),
          ),
        ));
  }

  List<Color> colorList = [
    Styles.tintColor1,
    Styles.tintColor2,
    Styles.tintColor3,
    Styles.tintColor4,
    Styles.tintColor5,
    Styles.tintColor6,
    Styles.tintColor7,
    Styles.tintColor8,
  ];

  onClickPost(BuildContext context, item) {
    showModalBottomSheet(
      isScrollControlled: true,
      shape: Box30Edge,
      context: context,
      builder: (context) => Container(
        padding: MediaQuery.of(context).viewInsets,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    GestureDetector(
                      child: Icon(
                        Icons.cancel,
                        color: Colors.red,
                        size: 30,
                      ),
                      onTap: () {
                        Navigator.pop(context);
                      },
                    ),
                    Container(
                      padding: EdgeInsets.all(8),
                      decoration: BoxDecoration(
                          color: Styles.appPrimaryColor,
                          borderRadius: BorderRadius.all(Radius.circular(15))),
                      child: Text("Edit",
                          style: TextStyle(
                              fontSize: 15,
                              color: Colors.white,
                              fontWeight: FontWeight.bold)),
                    )
                  ],
                ),
                Padding(
                  padding: EdgeInsets.all(10.0),
                  child: TextFormField(
                    keyboardType: TextInputType.text,
                    // maxLength: 280,
                    maxLines: 4,
                   // controller: editingController,
                    style: TextStyle(
                        color: Color(0xff071232),
                        fontWeight: FontWeight.w500,
                        fontSize: sizer(true, 18.0, context)),
                    cursorColor: Color(0xff245DE8),
                    decoration: InputDecoration(
                      contentPadding: EdgeInsets.symmetric(
                          vertical: sizer(false, 10, context),
                          horizontal: sizer(true, 10, context)),
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
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    "Status: Upcoming in 10 minutes",
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                ),
                Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      children: [
                        Text("Notification:",
                            style: TextStyle(
                                fontSize: 16,
                                color: Colors.black54,
                                fontWeight: FontWeight.bold)),
                        SizedBox(width: 10),
                        Checkbox(value: true, onChanged: (a) {})
                      ],
                    )),
                GestureDetector(
                  onTap: () {
                    showTweetDialog(context,
                        type: "CONFIRMATION",
                        message: "Do you want to cancel the Schedule?",
                        onPressed: () {
                          Navigator.pop(context);
                        });
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5),
                        color: Colors.red,
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: <Widget>[
                          Padding(
                            padding: const EdgeInsets.all(5.0),
                            child: Icon(
                              Icons.close,
                              color: Colors.white,
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              "Cancel Schedule",
                              style:
                              TextStyle(fontSize: 15, color: Colors.white),
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 30),
              ],
            ),
          ),
        ),
      ),
    );
  }

}
