import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:loading_overlay/loading_overlay.dart';
import 'package:tweet_sche/utils/constants.dart';
import 'package:tweet_sche/utils/styles.dart';
import 'package:tweet_sche/views/subscriber/auth/signin_page.dart';
import 'package:tweet_sche/widgets/authEmailInput.dart';
import 'package:tweet_sche/widgets/authNameInput.dart';
import 'package:tweet_sche/widgets/authPasswordInput.dart';
import 'package:tweet_sche/widgets/backButtonBlue.dart';
import 'package:tweet_sche/widgets/buttonBlue.dart';
import 'package:tweet_sche/widgets/show_exception_alert_dialog.dart';

class SignupPage extends StatefulWidget {
  @override
  _SignupPageState createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  bool isLoading = false;
  FirebaseAuth _auth = FirebaseAuth.instance;
  final _formKey = GlobalKey<FormState>();
  bool _autoValidate = false;
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

  String selectedType;

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
        SystemUiOverlayStyle(statusBarColor: Styles.tintColor2));
    return GestureDetector(
      onTap: () {
        offKeyboard(context);
      },
      child: LoadingOverlay(
        progressIndicator: CupertinoActivityIndicator(radius: 15),
        isLoading: isLoading,
        color: Styles.appLightPrimaryColor,
        child: Scaffold(
            key: scaffoldKey,
            backgroundColor: Styles.tintColor2,
            body: Container(

              height: MediaQuery.of(context).size.height,
              padding: EdgeInsets.all(20),
              child: ListView(
                shrinkWrap: true,
                children: <Widget>[
                  Row(
                    children: [
                      BackButtonBlue(),
                    ],
                  ),
                  Container(
                    alignment: Alignment.center,
                    height: MediaQuery.of(context).size.height / 5,
                    child: SvgPicture.asset(
                      "assets/images/signup2.svg",
                      width: 250,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 18.0, top: 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Text(
                          "Get Started!",
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
                    "Create a new Account",
                    style: TextStyle(
                      fontSize: 19,
                      fontWeight: FontWeight.bold,
                      color: Styles.appPrimaryColor,
                    ),
                  ),
                ),
                SizedBox(height: 8),
                AuthNameInput(
                  hintText: "Name",
                  controller: nameController,
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
                DropdownButton<String>(
                  hint: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10.0),
                    child: Text("Sign up as "),
                  ),
                  value: selectedType,
                  underline: SizedBox(),
                  items: ["Subscriber", "Admin"].map((value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(
                        "Sign up as $value",
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                    );
                  }).toList(),
                  isExpanded: true,
                  onChanged: (value) {
                    selectedType = value;
                    offKeyboard(context);
                    setState(() {});
                  },
                ),
                SizedBox(height: 15),
                Row(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: GestureDetector(
                        onTap: () {
                          Navigator.pop(context);
                        },
                        child: Text(
                          "Have Account? Sign In",
                          style: TextStyle(
                              color: Styles.appPrimaryColor, fontSize: 16),
                        ),
                      ),
                    ),
                  ],
                ),
                Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8.0),
                    child: ButtonBlue(
                        title: "SIGNUP",
                        onPressed: () {
                          signUp();
                        })),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future signUp() async {
    if(selectedType == null){
      showSnackBar(context, "Error",   "Choose a type");
      return;
    }
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
    await _auth
        .createUserWithEmailAndPassword(
            email: emailController.text, password: passwordController.text)
        .then((value) {
      User user = value.user;

      if (value.user != null) {
        user.sendEmailVerification().then((v) {
          Map<String, Object> mData = Map();
          mData.putIfAbsent("Name", () => nameController.text);
          mData.putIfAbsent("Email", () => emailController.text);
          mData.putIfAbsent("Uid", () => user.uid);
          mData.putIfAbsent("Type", () => selectedType);
          mData.putIfAbsent(
              "Timestamp", () => DateTime.now().millisecondsSinceEpoch);

          FirebaseFirestore.instance
              .collection("All")
              .doc(user.uid)
              .set(mData)
              .then((val) {
            emailController.clear();
            passwordController.clear();
            nameController.clear();
            selectedType = null;

            showTweetDialog(context,
                type: "ALERT",
                message: "User created, Check email for verification.",
                onPressed: () {
              Navigator.pushAndRemoveUntil(
                  context,
                  CupertinoPageRoute(builder: (context) => SigninPage()),
                  (Route<dynamic> route) => false);
            });

            setState(() {
              _autoValidate = false;
              isLoading = false;
            });
            offKeyboard(context);
          }).catchError((e) {
            showExceptionAlertDialog(
                context: context, exception: e, title: "Error");
            setState(() {
              isLoading = false;
            });
          });
        }).catchError((e) {
          showExceptionAlertDialog(
              context: context, exception: e, title: "Error");
          setState(() {
            isLoading = false;
          });
        });
      } else {
        setState(() {
          isLoading = false;
        });
      }
      return;
    }).catchError((e) {
      showExceptionAlertDialog(context: context, exception: e, title: "Error");
      setState(() {
        isLoading = false;
      });
      return;
    });
  }
}
