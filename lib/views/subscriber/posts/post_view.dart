import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:tweet_sche/utils/constants.dart';
import 'package:tweet_sche/utils/sizeCalculator.dart';
import 'package:tweet_sche/utils/styles.dart';
import 'package:tweet_sche/views/subscriber/partial/builder.dart';

class PostView extends StatefulWidget {
  @override
  _PostViewState createState() => _PostViewState();
}

class _PostViewState extends State<PostView> with TickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
        SystemUiOverlayStyle(statusBarColor: Styles.appPrimaryColor));
    return MainLayoutBuilder(title: "Scheduled Posts", body: PostViewBody());
  }
}

class PostViewBody extends StatefulWidget {
  @override
  _PostViewBodyState createState() => _PostViewBodyState();
}

class _PostViewBodyState extends State<PostViewBody> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Styles.appPrimaryColor,
      body: SingleChildScrollView(
        child: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              DropdownButton<String>(
                value: selectedMonth,
                underline: SizedBox(),
                iconEnabledColor: Colors.white,
                dropdownColor: Styles.appCanvasColor,
                items: monthsList.map((value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                      child: Text(
                        value,
                        style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.white),
                      ),
                    ),
                  );
                }).toList(),
                // isExpanded: true,
                onChanged: (value) {
                  setState(() {
                    selectedMonth = value;
                  });
                },
              ),
              Container(
                height: 80,
                child: ListView.builder(
                    itemCount: 10,
                    scrollDirection: Axis.horizontal,
                    shrinkWrap: true,
                    itemBuilder: (context, index) {
                      return GestureDetector(
                        onTap: () {
                          selectedDate = index;
                          setState(() {});
                        },
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Container(
                            decoration: BoxDecoration(
                                color: selectedDate == index
                                    ? Colors.white
                                    : Styles.appCanvasColor,
                                borderRadius:
                                    BorderRadius.all(Radius.circular(10))),
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Center(
                                child: Text(
                                  "MON\n12",
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      fontSize: 16,
                                      color: selectedDate == index
                                          ? Styles.appCanvasColor
                                          : Colors.white,
                                      fontWeight: FontWeight.w600),
                                ),
                              ),
                            ),
                          ),
                        ),
                      );
                    }),
              ),
              Container(
                padding: EdgeInsets.all(8),
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
                            "Today's Task",
                            style: TextStyle(
                                fontSize: 17, fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      child: ListView.builder(
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
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
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

  List<String> monthsList = [
    "Jan, 2020",
    "Feb, 2020",
    "March, 2020",
    "May, 2020",
    "June, 2020",
    "July, 2020",
    "Sept, 2020",
    "Oct, 2020",
    "Nov, 2020",
    "Dec, 2020",
  ];
  String selectedMonth = "March, 2020";
  int selectedDate = 3;

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
                    controller: editingController,
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

  TextEditingController editingController = TextEditingController(
      text:
          "You can for instance animate the size of the padding around the button. I would use circular containers around the IconButton");
}
