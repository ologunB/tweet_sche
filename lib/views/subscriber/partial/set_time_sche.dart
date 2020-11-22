import 'package:flutter/material.dart';
import 'package:tweet_sche/utils/constants.dart';
import 'package:tweet_sche/utils/sizeCalculator.dart';
import 'package:tweet_sche/utils/styles.dart';
import 'package:tweet_sche/views/subscriber/layout_template.dart';
 import 'package:tweet_sche/widgets/backButtonBlue.dart';

class SetTimeSche extends StatefulWidget {
  @override
  _SetTimeScheState createState() => _SetTimeScheState();
}

class _SetTimeScheState extends State<SetTimeSche> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Styles.appCanvasColor,
        body: GestureDetector(
          onTap: (){
            offKeyboard(context);
          },
          child: SafeArea(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        BackButtonBlue(),
                        Material(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10.0),
                              // side: BorderSide(color: Colors.red)
                            ),
                            color: Styles.whiteColor,
                            child: InkWell(
                              onTap: () {
                                moveToReplace(context, LayoutTemplate());
                              },
                              child: Container(
                                  padding: EdgeInsets.symmetric(
                                      vertical: 12.0, horizontal: 11),
                                  decoration: BoxDecoration(
                                    //  color: Color(0xff4b7aed),
                                    borderRadius: BorderRadius.circular(10.0),
                                  ),
                                  child: Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Text(
                                        "DONE",
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            color: Styles.appPrimaryColor),
                                      ),
                                      Icon(
                                        Icons.arrow_forward_ios,
                                        size: 18,
                                        color: Styles.appPrimaryColor,
                                      )
                                    ],
                                  )),
                            ))
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Text(
                      "Select Frequency",
                      style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.white),
                    ),
                  ),
                  Expanded(
                    child: Container(
                        padding: EdgeInsets.all(  8),
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(25),
                                topRight: Radius.circular(25))),
                        //height: double.infinity,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(height: 10),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text("Repeat Post?",
                                  style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.black)),
                            ),
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  padding: EdgeInsets.all(5),
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                      color: Color(0xffF3F4F8)),
                                  child: DropdownButton<String>(
                                    hint: Text(
                                      "Select...",
                                      style: TextStyle(fontSize: 14),
                                    ),
                                    value: repeatPost,
                                    underline: SizedBox(),
                                    iconEnabledColor: Colors.blueAccent,
                                    dropdownColor: Styles.appBackground,
                                    items: ["Post Once", "Repeat"].map((value) {
                                      return DropdownMenuItem<String>(
                                        value: value,
                                        child: Padding(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 5.0),
                                          child: Text(
                                            value,
                                            style: TextStyle(
                                                fontSize: 15,
                                                fontWeight: FontWeight.w400,
                                                color: Colors.black),
                                          ),
                                        ),
                                      );
                                    }).toList(),
                                    onChanged: (value) {
                                      setState(() {
                                        repeatPost = value;
                                      });
                                    },
                                  ),
                                ),
                                SizedBox(width: 10),
                                repeatPost == "Repeat"
                                    ? AnimatedContainer(
                                  curve: Curves.easeIn,
                                  duration: Duration(seconds: 2),
                                  padding: EdgeInsets.all(5),
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                      color: Color(0xffF3F4F8)),
                                  child: DropdownButton<String>(
                                    value: repeatTimes,
                                    hint: Text(
                                      "Select...",
                                      style: TextStyle(fontSize: 14),
                                    ),
                                    underline: SizedBox(),
                                    iconEnabledColor: Colors.blueAccent,
                                    dropdownColor: Styles.appBackground,
                                    items: [
                                      "Every Day",
                                      "Every Week",
                                      "Once Every year",
                                      "Custom"
                                    ].map((value) {
                                      return DropdownMenuItem<String>(
                                        value: value,
                                        child: Padding(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 5.0),
                                          child: Text(
                                            value,
                                            style: TextStyle(
                                                fontSize: 15,
                                                fontWeight: FontWeight.w400,
                                                color: Colors.black),
                                          ),
                                        ),
                                      );
                                    }).toList(),
// isExpanded: true,
                                    onChanged: (value) {
                                      setState(() {
                                        repeatTimes = value;
                                      });
                                    },
                                  ),
                                )
                                    : SizedBox(),
                              ],
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text("Start Time / Date",
                                  style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.black)),
                            ),
                            Container(
                                padding: EdgeInsets.all(5),
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    color: Color(0xffF3F4F8)),
                                child: GestureDetector(
                                  onTap: () {
                                    DateTime initialDate = DateTime.now();
                                    DateTime lastDate = DateTime(initialDate.year + 1,
                                        initialDate.month, initialDate.day);
                                    TimeOfDay time = TimeOfDay.now();
                                    showDatePicker(
                                        context: context,
                                        initialDate: initialDate,
                                        firstDate: initialDate,
                                        lastDate: lastDate)
                                        .then((value) {
                                      print(value);
                                      if (value == null) {
                                        return;
                                      }
                                      showTimePicker(
                                          context: context, initialTime: time)
                                          .then((presentTime) {
                                        print(presentTime);
                                      });
                                    });
                                  },
                                  child: Padding(
                                    padding: const EdgeInsets.all(10.0),
                                    child: Text(
                                      "Select...",
                                      style: TextStyle(
                                          fontSize: 15,
                                          fontWeight: FontWeight.w400,
                                          color: Colors.black),
                                    ),
                                  ),
                                )),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text("End Time / Date",
                                  style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.black)),
                            ),
                            Container(
                                padding: EdgeInsets.all(5),
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    color: Color(0xffF3F4F8)),
                                child: GestureDetector(
                                  onTap: () {
                                    DateTime initialDate = DateTime.now();
                                    DateTime lastDate = DateTime(initialDate.year + 1,
                                        initialDate.month, initialDate.day);
                                    TimeOfDay time = TimeOfDay.now();
                                    showDatePicker(
                                        context: context,
                                        initialDate: initialDate,
                                        firstDate: initialDate,
                                        lastDate: lastDate)
                                        .then((value) {
                                      print(value);
                                      if (value == null) {
                                        return;
                                      }
                                      showTimePicker(
                                          context: context, initialTime: time)
                                          .then((presentTime) {
                                        print(presentTime);
                                      });
                                    });
                                  },
                                  child: Padding(
                                    padding: const EdgeInsets.all(10.0),
                                    child: Text(
                                      "Select...",
                                      style: TextStyle(
                                          fontSize: 15,
                                          fontWeight: FontWeight.w400,
                                          color: Colors.black),
                                    ),
                                  ),
                                )),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text("How many times between start and end?",
                                  style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.black)),
                            ),
                            Container(
                              width: 80,
                              child: TextFormField(
                                style: TextStyle(
                                    color: Color(0xff071232),
                                    fontWeight: FontWeight.w500,
                                    fontSize: sizer(true, 20.0, context)),
                                maxLength: 3,
                                keyboardType: TextInputType.numberWithOptions(),

                                decoration: InputDecoration(
                                  contentPadding: EdgeInsets.all(10),
                                  fillColor: Color(0xffF3F4F8),
                                  hintText: "?",
                                  counter: SizedBox(),
                                  hintStyle: TextStyle(
                                      color: Color(0xff828A95),
                                      fontSize: sizer(true, 16.0, context)),
                                  focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10),
                                    borderSide: BorderSide(
                                      width: 1.5,
                                      color: Color(0xff245DE8),
                                    ),
                                  ),
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
                          ],
                        )),
                  )
                ],
              )),
        ));
  }

  String repeatPost, repeatTimes;
}
