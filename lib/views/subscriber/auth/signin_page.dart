import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hive/hive.dart';
import 'package:loading_overlay/loading_overlay.dart';
import 'package:tweet_sche/utils/constants.dart';
import 'package:tweet_sche/utils/styles.dart';
import 'package:tweet_sche/views/admin/admin_layout_template.dart';
import 'package:tweet_sche/views/subscriber/auth/signup_page.dart';
import 'package:tweet_sche/views/subscriber/layout_template.dart';
import 'package:tweet_sche/widgets/authEmailInput.dart';
import 'package:tweet_sche/widgets/authPasswordInput.dart';
import 'package:tweet_sche/widgets/buttonBlue.dart';
import 'package:tweet_sche/widgets/button_green.dart';
import 'package:tweet_sche/widgets/show_exception_alert_dialog.dart';

class SigninPage extends StatefulWidget {
  @override
  _SigninPageState createState() => _SigninPageState();
}

class _SigninPageState extends State<SigninPage> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController forgetPassController = TextEditingController();
  bool isLoading = false;
  FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final _formKey = GlobalKey<FormState>();
  bool _autoValidate = false;
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
        SystemUiOverlayStyle(statusBarColor: Styles.appBackground));
    return GestureDetector(
      onTap: () {
        //  offKeyboard(context);
      },
      child: LoadingOverlay(
        progressIndicator: CupertinoActivityIndicator(radius: 15),
        isLoading: isLoading,
        color: Styles.appLightPrimaryColor,
        child: Scaffold(
            key: scaffoldKey,
            backgroundColor: Styles.appBackground,
            body: Container(
              height: MediaQuery.of(context).size.height,
              padding: EdgeInsets.all(20),
              child: ListView(
                children: <Widget>[
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Container(
                        alignment: Alignment.center,
                        height: MediaQuery.of(context).size.height / 3,
                        child: SvgPicture.asset(
                          "assets/images/login_img.svg",
                          width: 250,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(bottom: 18.0, top: 10),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Text(
                              "Welcome Back!",
                              style: TextStyle(
                                  fontSize: 22,
                                  fontWeight: FontWeight.bold,
                                  color: Styles.appPrimaryColor),
                            ),
                          ],
                          mainAxisSize: MainAxisSize.max,
                        ),
                      ),
                      SizedBox(height: 8),
                    ],
                  ),
                ],
              ),
            ),
            resizeToAvoidBottomPadding: false,
            bottomNavigationBar: bottomSheet(context)),
      ),
    );
  }

  Widget bottomSheet(context) {
    return Form(
      key: _formKey,
      autovalidate: _autoValidate,
      child: SafeArea(
        child: Container(
          padding: MediaQuery.of(context).viewInsets,
          decoration: BoxDecoration(
              color: Styles.whiteColor,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(30),
                topRight: Radius.circular(30),
              )),
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: ListView(
              shrinkWrap: true,
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    "Login to your Account",
                    style: TextStyle(
                      fontSize: 19,
                      fontWeight: FontWeight.bold,
                      color: Styles.appPrimaryColor,
                    ),
                  ),
                ),
                SizedBox(height: 8),
                AuthEmailInput(
                  hintText: "Email",
                  controller: emailController,
                ),
                SizedBox(height: 8),
                AuthPasswordInput(
                  hintText: "Password",
                  controller: passwordController,
                ),
                SizedBox(height: 8),
                Row(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: GestureDetector(
                        onTap: () {
                          forgetPassword(context);
                        },
                        child: Text(
                          "Forgot Password?",
                          style: TextStyle(
                              color: Styles.appPrimaryColor, fontSize: 14),
                        ),
                      ),
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                  child: Row(
                    children: [
                      Flexible(
                        flex: 2,
                        child: ButtonBlue(
                            title: "LOGIN",
                            onPressed: () {
                              signIn(context);
                            }),
                      ),
                      SizedBox(width: 10),
                      Flexible(
                        flex: 1,
                        child: ButtonGreen(
                            title: "SIGNUP",
                            onPressed: () {
                              moveTo(context, SignupPage());
                            }),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  forgetPassword(context) {
    showModalBottomSheet(
      isScrollControlled: true,
      shape: Box30Edge,
      context: context,
      builder: (context) => Container(
        padding: MediaQuery.of(context).viewInsets,
        child: Padding(
          padding: const EdgeInsets.all(10.0),
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
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  "Enter your email",
                  style: TextStyle(
                      fontSize: 20,
                      color: Styles.appPrimaryColor,
                      fontWeight: FontWeight.bold),
                ),
              ),
              Material(
                child: AuthEmailInput(
                  hintText: "Email",
                  controller: forgetPassController,
                ),
              ),
              SizedBox(height: 8),
              ButtonBlue(
                  title: "RESET PASSWORD",
                  onPressed: () {
                    resetEmail();
                  }),
              SizedBox(height: 50)
            ],
          ),
        ),
      ),
    );
  }

  void signIn(context) async {

    _formKey.currentState.save();
    _formKey.currentState.validate();

    setState(() {
      _autoValidate = true;
    });

    if (!_formKey.currentState.validate()) {
      return;
    }

    offKeyboard(context);
    setState(() {
      isLoading = true;
    });
    await _firebaseAuth
        .signInWithEmailAndPassword(
            email: emailController.text, password: passwordController.text)
        .then((value) {
      User user = value.user;

      if (value.user != null) {
        if (!value.user.emailVerified) {
          setState(() {
            isLoading = false;
          });

          showSnackBar(context, "Alert", "Email not verified");

          _firebaseAuth.signOut();
          return;
        }
        FirebaseFirestore.instance
            .collection('All')
            .doc(user.uid)
            .get()
            .then((document) {
          print(document.data().length);
          MY_UID = document.data()["Uid"];
          MY_EMAIL = document.data()["Email"];
          MY_NAME = document.data()["Name"];
          MY_TYPE = document.data()["Type"];
          putInDB(MY_UID, MY_EMAIL, MY_NAME, MY_TYPE);

          Navigator.pushAndRemoveUntil(
              context,
              CupertinoPageRoute(
                  builder: (context) => MY_TYPE == "Subscriber"
                      ? LayoutTemplate()
                      : LayoutAdminTemplate()),
              (Route<dynamic> route) => false);
        }).catchError((e) {
          setState(() {
            isLoading = false;
          });
          showExceptionAlertDialog(
              context: context, exception: e, title: "Error");
        });
      } else {
        setState(() {
          isLoading = false;
        });
        _firebaseAuth.signOut();
      }
      return;
    }).catchError((e) {
      setState(() {
        isLoading = false;
      });
      _firebaseAuth.signOut();
      showExceptionAlertDialog(context: context, exception: e, title: "Error");

      return;
    });
  }

  void putInDB(String uid, String email, String name, String type) async {
    final Box userDetailsBox = Hive.box(userDetails);
    userDetailsBox.put("isLoggedIn", true);
    userDetailsBox.put("uid", uid);
    userDetailsBox.put("type", type);
    userDetailsBox.put("email", email);
    userDetailsBox.put("name", name);
    setState(() {});
  }

  void resetEmail() async {
    if (forgetPassController.text.isEmpty) {
      showSnackBar(context, "Error", "Email cannot be empty");
      return;
    }
    Navigator.pop(context);
    offKeyboard(context);
    setState(() {
      isLoading = true;
    });
    await _firebaseAuth
        .sendPasswordResetEmail(email: forgetPassController.text)
        .then((value) {
      setState(() {
        isLoading = false;
      });
      forgetPassController.clear();

      showSnackBar(context, "Alert", "Reset email sent, Check mail");
    }).catchError((e) {
      setState(() {
        isLoading = false;
      });
      showExceptionAlertDialog(context: context, title: "Error", exception: e);
    });
  }
}
