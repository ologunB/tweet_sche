import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:tweet_sche/utils/constants.dart';
import 'package:tweet_sche/utils/styles.dart';
import 'package:tweet_sche/views/admin/admin_layout_template.dart';
import 'package:tweet_sche/views/subscriber/layout_template.dart';
import 'package:tweet_sche/views/subscriber/auth/signin_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await Hive.initFlutter();
  await Hive.openBox(userDetails);
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Scheduler',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        //   primarySwatch: MaterialColor(0xFF7966FF),
        primaryColor: Styles.appPrimaryColor,
        fontFamily: "AvenirNext",
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MyWrapper(),
    );
  }
}

class MyWrapper extends StatefulWidget {
  @override
  _MyWrapperState createState() => _MyWrapperState();
}

class _MyWrapperState extends State<MyWrapper> {
  Box userDetailsBox;
  String uid; bool isLoggedIn;

  @override
  void initState() {
  //  Firebase.initializeApp();
    super.initState();
    userDetailsBox = Hive.box(userDetails);
    assign();
  }

  void assign() async {
    MY_UID = userDetailsBox.get('uid') ?? "";
    MY_NAME = userDetailsBox.get('name') ?? "";
    MY_EMAIL = userDetailsBox.get('email') ?? "";
    MY_TYPE = userDetailsBox.get('type') ?? "";
  }

  @override
  Widget build(BuildContext context) {
    isLoggedIn = userDetailsBox.get('isLoggedIn') ?? false;
    print( MY_UID+MY_NAME+ MY_EMAIL+ MY_TYPE);
    if (!isLoggedIn) {
      return SigninPage();
    } else if (MY_TYPE == "Admin") {
      return LayoutAdminTemplate();
    } else if (MY_TYPE == "Subscriber") {
      return LayoutTemplate();
    }
    return Container();
  }
}
