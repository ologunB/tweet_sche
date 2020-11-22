import 'package:cached_network_image/cached_network_image.dart';
//import 'package:excel/excel.dart';
//import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:tweet_sche/utils/constants.dart';
import 'package:tweet_sche/utils/sizeCalculator.dart';
import 'package:tweet_sche/utils/styles.dart';
import 'package:tweet_sche/views/subscriber/partial/sub_builder.dart';
import 'dart:io';

import 'package:tweet_sche/widgets/buttonBlue.dart';

class UploadMultiplePosts extends StatefulWidget {
  @override
  _UploadMultiplePostsState createState() => _UploadMultiplePostsState();
}

class _UploadMultiplePostsState extends State<UploadMultiplePosts> {
  List<File> selectedImages = [];
  String selectedAcc;
  List<String> selectedAccs = [];

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        offKeyboard(context);
      },
      child: SubLayoutBuilder(
        title: 'Bulk Upload ',
        body: Padding(
          padding: const EdgeInsets.all(10.0),
          child: ListView(
            children: [
              SizedBox(height: 10),
              ButtonBlue(
                  title: "Upload from Excel file",
                  onPressed: () {
                    getExcelFile(context);
                  }),
              Padding(
                padding: const EdgeInsets.all(5.0),
                child: Center(
                    child: Text(
                  "OR",
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700),
                )),
              ),
              ButtonBlue(
                  title: "Select Multiple Images",
                  onPressed: () {
                    getImageGallery();
                  }),
              SizedBox(height: 10),
              selectedImages.isEmpty
                  ? SizedBox()
                  : Container(
                      height: 150,
                      child: ListView.builder(
                          itemCount: selectedImages.length,
                          shrinkWrap: true,
                          scrollDirection: Axis.horizontal,
                          itemBuilder: (context, index) {
                            return Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Stack(
                                  children: [
                                    ClipRRect(
                                      borderRadius: BorderRadius.circular(15.0),
                                      child: Image.file(selectedImages[index]),
                                    ),
                                    GestureDetector(
                                      onTap: () {
                                        selectedImages
                                            .remove(selectedImages[index]);
                                        setState(() {});
                                      },
                                      child:
                                          Icon(Icons.cancel, color: Colors.red),
                                    )
                                  ],
                                ));
                          }),
                    ),
              TextFormField(
                keyboardType: TextInputType.text,
                maxLength: 280,
                // controller: messageController,
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
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: DropdownButton<String>(
                  value: selectedAcc,
                  hint: Text(
                    "Select Account",
                    style:
                        TextStyle(fontSize: 16, color: Styles.appCanvasColor),
                  ),
                  underline: SizedBox(),
                  iconEnabledColor: Styles.appCanvasColor,
                  dropdownColor: Styles.whiteColor,
                  items: ["Account 1", "Account 2"].map((value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8.0),
                        child: Text(
                          value,
                          style: TextStyle(
                              fontSize: 17,
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
              ),
              selectedAccs.isEmpty
                  ? SizedBox()
                  : Container(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                      height: 100,
                      child: ListView.builder(
                          itemCount: selectedAccs.length,
                          shrinkWrap: true,
                          scrollDirection: Axis.horizontal,
                          itemBuilder: (context, index) {
                            return Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Stack(
                                  children: [
                                    Column(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        ClipRRect(
                                          borderRadius:
                                              BorderRadius.circular(30.0),
                                          child: CachedNetworkImage(
                                            imageUrl: "ere",
                                            height: 60,
                                            width: 60,
                                            placeholder: (context, url) => Image(
                                                image: AssetImage(
                                                    "assets/images/person.png"),
                                                height: 60,
                                                width: 60,
                                                fit: BoxFit.contain),
                                            errorWidget:
                                                (context, url, error) => Image(
                                                    image: AssetImage(
                                                        "assets/images/person.png"),
                                                    height: 60,
                                                    width: 60,
                                                    fit: BoxFit.contain),
                                          ),
                                        ),
                                        Text(selectedAccs[index])
                                      ],
                                    ),
                                    GestureDetector(
                                      onTap: () {
                                        selectedAccs
                                            .remove(selectedAccs[index]);
                                        setState(() {});
                                      },
                                      child:
                                          Icon(Icons.cancel, color: Colors.red),
                                    )
                                  ],
                                ));
                          }),
                    ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text("Start Time / Date",
                    style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Styles.appPrimaryColor)),
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
                        showTimePicker(context: context, initialTime: time)
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
                child: Text("End Date",
                    style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Styles.appPrimaryColor)),
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
                      showDatePicker(
                              context: context,
                              initialDate: initialDate,
                              firstDate: initialDate,
                              lastDate: lastDate)
                          .then((value) {
                        if (value == null) {
                          return;
                        }
                        print(value);
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
            ],
          ),
        ),
      ),
    );
  }

  getExcelFile(context) async {
 /*   FilePickerResult result = await FilePicker.platform
        .pickFiles(type: FileType.custom, allowedExtensions: ['xlsx', 'xls']);

    if (result != null) {
      File file = File(result.files.single.path);
      var bytes = file.readAsBytesSync();
      var excel = Excel.decodeBytes(bytes);

      for (var table in excel.tables.keys) {
        print(table); //sheet Name
        print(excel.tables[table].maxCols);
        print(excel.tables[table].maxRows);
        for (var row in excel.tables[table].rows) {
          print("$row");
        }
      }
    } else {
      // User canceled the picker
    }*/
  }

  Future getImageGallery() async {
 /*  FilePickerResult result = await FilePicker.platform.pickFiles(
        type: FileType.custom,
        allowedExtensions: ['jpeg', 'jpg', 'png'],
        allowMultiple: true);

    if (result == null) return;

    result.files.map((file) => selectedImages.add(File(file.path))).toList();
    setState(() {

    });*/
  }
}
