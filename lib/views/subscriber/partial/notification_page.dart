import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:tweet_sche/models/notification.dart';
import 'package:tweet_sche/utils/constants.dart';
import 'package:tweet_sche/views/subscriber/partial/sub_builder.dart';

class NotificationPage extends StatefulWidget {
  @override
  _NotificationPageState createState() => _NotificationPageState();
}

class _NotificationPageState extends State<NotificationPage> {
  @override
  Widget build(BuildContext context) {
    return SubLayoutBuilder(
        title: "Notifications",
        body: StreamBuilder<QuerySnapshot>(
          stream: FirebaseFirestore.instance
              .collection("Utils")
              .doc("Notification")
              .collection(MY_UID)
              .orderBy("Timestamp", descending: true)
              .snapshots(),
          builder: (context, snapshot) {
            if (snapshot.hasError) return new Text('Error: ${snapshot.error}');
            switch (snapshot.connectionState) {
              case ConnectionState.waiting:
                return Container(
                  alignment: Alignment.center,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      CupertinoActivityIndicator(radius: 12),
                      SizedBox(height: 30),
                      Text(
                        "Getting Data",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.w500,
                            fontSize: 16),
                      ),
                      SizedBox(height: 30),
                    ],
                  ),
                );
              default:
                //  updateDetails(snapshot.data.documents.length);
                return snapshot.data.docs.isEmpty
                    ? Container(
                        alignment: Alignment.center,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Image.asset("assets/images/empty_list.png"),
                            SizedBox(height: 30),
                            Text(
                              "No Notifications!",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.w500,
                                  fontSize: 16),
                            ),
                            SizedBox(height: 30),
                          ],
                        ),
                      )
                    : ListView(
                        children: snapshot.data.docs.map((document) {
                          MyNotification item = MyNotification.map(document);
                          return Padding(
                            padding: const EdgeInsets.only(
                                left: 3, top: 3, right: 3),
                            child: Card(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Text(
                                      item.message,
                                      style: TextStyle(
                                          fontSize: 16,
                                          color: Colors.grey[800]),
                                    ),
                                  ),
                                  Divider(),
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Text(
                                      item.date,
                                      style: TextStyle(
                                          fontSize: 15, color: Colors.red),
                                    ),
                                  )
                                ],
                              ),
                            ),
                          );
                        }).toList(),
                      );
            }
          },
        ));
  }
}
