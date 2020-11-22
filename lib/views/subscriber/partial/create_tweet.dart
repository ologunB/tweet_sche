import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:tweet_sche/utils/constants.dart';
import 'package:tweet_sche/utils/sizeCalculator.dart';
import 'package:tweet_sche/utils/styles.dart';
import 'package:tweet_sche/views/subscriber/partial/set_time_sche.dart';
import 'package:tweet_sche/widgets/backButtonBlue.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

import 'package:giphy_picker/giphy_picker.dart';

class CreateTweet extends StatefulWidget {
  @override
  _CreateTweetState createState() => _CreateTweetState();
}

class _CreateTweetState extends State<CreateTweet> {
  TextEditingController messageController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        offKeyboard(context);
      },
      child: Scaffold(
          backgroundColor: Styles.appPrimaryColor,
          body: SafeArea(
              child: Column(
            //  crossAxisAlignment: CrossAxisAlignment.start,
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
                            moveTo(context, SetTimeSche());
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
                                    "NEXT",
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
              Align(
                alignment: Alignment.topLeft,
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Text(
                    "Schedule Tweet",
                    style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.white),
                  ),
                ),
              ),
              Expanded(
                child: Container(
                    padding: EdgeInsets.symmetric(vertical: 8, horizontal: 8),
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(25),
                            topRight: Radius.circular(25))),
                    child: SingleChildScrollView(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              TextFormField(
                                keyboardType: TextInputType.text,
                                maxLength: 280,
                                controller: messageController,
                                maxLines: 7,
                                style: TextStyle(
                                    color: Color(0xff071232),
                                    fontWeight: FontWeight.w500,
                                    fontSize: sizer(true, 16.0, context)),
                                cursorColor: Color(0xff245DE8),
                                decoration: InputDecoration(
                                  contentPadding: EdgeInsets.symmetric(
                                      vertical: sizer(false, 20, context),
                                      horizontal: sizer(true, 20, context)),
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
                              DropdownButton<String>(
                                value: selectedAcc,
                                hint: Text(
                                  "Select Account",
                                  style: TextStyle(
                                      fontSize: 16,
                                      color: Styles.appCanvasColor),
                                ),
                                underline: SizedBox(),
                                iconEnabledColor: Styles.appCanvasColor,
                                dropdownColor: Styles.whiteColor,
                                items: ["Account 1", "Account 2"].map((value) {
                                  return DropdownMenuItem<String>(
                                    value: value,
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 8.0),
                                      child: Text(
                                        value,
                                        style: TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.bold,
                                            color: Styles.appCanvasColor),
                                      ),
                                    ),
                                  );
                                }).toList(),
                                // isExpanded: true,
                                onChanged: (value) {
                                  selectedAcc = value;

                                  if (!selectedAccs.contains(selectedAcc)) {
                                    selectedAccs.add(selectedAcc);
                                  }
                                  setState(() {});
                                },
                              ),
                              selectedAccs.isEmpty
                                  ? SizedBox()
                                  : Container(
                                      height: 100,
                                      child: ListView.builder(
                                          itemCount: selectedAccs.length,
                                          shrinkWrap: true,
                                          scrollDirection: Axis.horizontal,
                                          itemBuilder: (context, index) {
                                            return Padding(
                                                padding:
                                                    const EdgeInsets.all(8.0),
                                                child: Stack(
                                                  children: [
                                                    Column(
                                                      mainAxisSize:
                                                          MainAxisSize.min,
                                                      children: [
                                                        ClipRRect(
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(
                                                                      30.0),
                                                          child:
                                                              CachedNetworkImage(
                                                            imageUrl: "ere",
                                                            height: 60,
                                                            width: 60,
                                                            placeholder: (context,
                                                                    url) =>
                                                                Image(
                                                                    image: AssetImage(
                                                                        "assets/images/person.png"),
                                                                    height: 60,
                                                                    width: 60,
                                                                    fit: BoxFit
                                                                        .contain),
                                                            errorWidget: (context,
                                                                    url,
                                                                    error) =>
                                                                Image(
                                                                    image: AssetImage(
                                                                        "assets/images/person.png"),
                                                                    height: 60,
                                                                    width: 60,
                                                                    fit: BoxFit
                                                                        .contain),
                                                          ),
                                                        ),
                                                        Text(
                                                            selectedAccs[index])
                                                      ],
                                                    ),
                                                    GestureDetector(
                                                      onTap: () {
                                                        selectedAccs.remove(
                                                            selectedAccs[
                                                                index]);
                                                        setState(() {});
                                                      },
                                                      child: Icon(Icons.cancel,
                                                          color: Colors.red),
                                                    )
                                                  ],
                                                ));
                                          }),
                                    ),
                              selectedPictures.isEmpty
                                  ? SizedBox()
                                  : Container(
                                      height: 150,
                                      child: ListView.builder(
                                          itemCount: selectedPictures.length,
                                          shrinkWrap: true,
                                          scrollDirection: Axis.horizontal,
                                          itemBuilder: (context, index) {
                                            return Padding(
                                                padding:
                                                    const EdgeInsets.all(8.0),
                                                child: Stack(
                                                  children: [
                                                    ClipRRect(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              15.0),
                                                      child: Image.file(
                                                          selectedPictures[
                                                              index]),
                                                    ),
                                                    GestureDetector(
                                                      onTap: () {
                                                        selectedPictures.remove(
                                                            selectedPictures[
                                                                index]);
                                                        setState(() {});
                                                      },
                                                      child: Icon(Icons.cancel,
                                                          color: Colors.red),
                                                    )
                                                  ],
                                                ));
                                          }),
                                    ),
                              selectedGif == null
                                  ? SizedBox()
                                  : Stack(
                                      children: [
                                        GiphyImage.original(
                                          gif: selectedGif,
                                          placeholder:
                                              CupertinoActivityIndicator(
                                            radius: 15,
                                          ),
                                        ),
                                        GestureDetector(
                                          onTap: () {
                                            selectedGif = null;
                                            setState(() {});
                                          },
                                          child: Icon(Icons.cancel,
                                              color: Colors.red),
                                        )
                                      ],
                                    )
                            ],
                          ),
                        ],
                      ),
                    )),
              ),
              bottomBar(context)
            ],
          ))),
    );
  }

  Widget bottomBar(context) {
    return Container(
      padding: EdgeInsets.all(8),
      color: Colors.white,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              GestureDetector(
                onTap: () {
                  if (selectedGif != null) {
                    showSnackBar(
                        context, "Error", "You have to delete the gif");

                    return;
                  }
                  addImage(context);
                },
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Icon(
                    Icons.image_outlined,
                    size: 30,
                    color: Styles.appCanvasColor,
                  ),
                ),
              ),
              GestureDetector(
                onTap: () async {
                  if (selectedPictures.isNotEmpty) {
                    showSnackBar(
                        context, "Error", "You have to delete the pictures");

                    return;
                  }
                  final gif = await GiphyPicker.pickGif(
                      context: context, apiKey: giphyAPIKey);
                  selectedGif = gif;
                  setState(() {});
                },
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Icon(
                    Icons.gif_outlined,
                    size: 30,
                    color: Styles.appCanvasColor,
                  ),
                ),
              ),
              GestureDetector(
                onTap: () {
                  getPresentLocation = !getPresentLocation;
                  if (getPresentLocation) {
                    showSnackBar(context, "Alert", "Location On");
                  }
                  setState(() {});
                },
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Icon(
                    getPresentLocation
                        ? Icons.location_on
                        : Icons.location_on_outlined,
                    size: 30,
                    color: Styles.appCanvasColor,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Icon(
                  Icons.add_circle_outline,
                  size: 30,
                  color: Styles.appCanvasColor,
                ),
              ),
            ],
          ),
          InkWell(
            onTap: () {
              onClickDrafts(context);
            },
            child: Container(
                padding: EdgeInsets.all(8),
                decoration: BoxDecoration(
                    color: Styles.appCanvasColor,
                    borderRadius: BorderRadius.circular(10.0)),
                child: Text(
                  "Drafts",
                  style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.white),
                )),
          )
        ],
      ),
    );
  }

  String selectedAcc;
  GiphyGif selectedGif;
  bool getPresentLocation = false;
  List<String> selectedAccs = [];
  List<File> selectedPictures = [];

  File pickedImage;

  Future getImageGallery() async {
    var img = await ImagePicker.platform.pickImage(source: ImageSource.gallery);

    if (img == null) return;
    File file = File(img.path);
    pickedImage = file;
    selectedPictures.add(pickedImage);
    setState(() {});
  }

  Future getImageCamera() async {
    var img = await ImagePicker.platform.pickImage(source: ImageSource.camera);

    if (img == null) return;
    File file = File(img.path);
    pickedImage = file;
    selectedPictures.add(pickedImage);
    setState(() {});
  }

  Future addImage(context) {
    return showDialog(
        context: context,
        builder: (_) {
          return AlertDialog(
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                InkWell(
                  onTap: () {
                    getImageGallery();
                    Navigator.pop(context);
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text("Choose Image from Gallery"),
                  ),
                ),
                InkWell(
                  onTap: () {
                    getImageCamera();
                    Navigator.pop(context);
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text("Take Image from Camera"),
                  ),
                ),
              ],
            ),
          );
        });
  }

  void onClickDrafts(BuildContext context) {
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
          child: SingleChildScrollView(
            child: Column(
              //shrinkWrap: true,
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
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    "DRAFTS",
                    style: TextStyle(
                        fontSize: 18,
                        color: Styles.appPrimaryColor,
                        fontWeight: FontWeight.bold),
                  ),
                ),
                ListView.builder(
                    physics: ClampingScrollPhysics(),
                    itemCount: 14,
                    shrinkWrap: true,
                    itemBuilder: (context, index) {
                      return GestureDetector(
                        onTap: () {
                          Navigator.pop(context);
                          messageController.text = "Message";
                          setState(() {});
                        },
                        child: Padding(
                          padding:
                              const EdgeInsets.only(left: 3, top: 3, right: 3),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(
                                  "item.message $index",
                                  style: TextStyle(
                                      fontSize: 16, color: Colors.grey[800]),
                                ),
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 8.0),
                                child: Text(
                                  "item.date",
                                  style: TextStyle(
                                      fontSize: 15, color: Colors.red),
                                ),
                              ),
                              Divider(),
                            ],
                          ),
                        ),
                      );
                    }),
                SizedBox(height: 20)
              ],
            ),
          ),
        ),
      ),
    );
  }
}
