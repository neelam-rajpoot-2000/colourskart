// ignore_for_file: use_build_context_synchronously

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:just_audio/just_audio.dart';
import 'package:vibration/vibration.dart';
import 'package:virtual_casino/User-Interface/signin_screen.dart';
import '../Utils/api_helper.dart';
import '../Utils/apis.dart';
import '../Utils/toast.dart';

class SignupScreen extends StatefulWidget {
  bool? playBackgroundMusic=false;
   SignupScreen({super.key,this.playBackgroundMusic});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  double height = 0;
  double width = 0;
  bool passwordLogin = false;
  var userNameController = TextEditingController();
  var passwordController = TextEditingController();
  var mobileController = TextEditingController();

  final audioPlayer = AudioPlayer();
  bool loading = false;

  void startButtonSound() async {
    await audioPlayer.setAsset("assets/Teen-patti/audio/button-click.mp3");
    playTouchSound();
  }

  void playTouchSound() async {
    await audioPlayer.play();
    // await audioPlayer.setVolume(10);
  }

  @override
  void dispose() {
    audioPlayer.dispose();
    super.dispose();
  }

  @override
  void initState() {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.landscapeLeft,
      DeviceOrientation.landscapeRight,
    ]);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    height = MediaQuery.of(context).size.height;
    width = MediaQuery.of(context).size.width;
    return Scaffold(body: OrientationBuilder(builder: (context, orientation) {
      if (orientation == Orientation.landscape) {
        return landscapeModeWidget();
      } else {
        return portraitModeWidget();
      }
    }));
  }

  Widget landscapeModeWidget() {
    return SingleChildScrollView(
      child: Container(
        height: height,
        width: width,
        decoration: BoxDecoration(
          image: DecorationImage(
              image: AssetImage("assets/User-interface/sign-in-background.png"),
              fit: BoxFit.fitHeight),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              height: height * 0.8,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    margin: const EdgeInsets.only(right: 30),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SizedBox(
                          width: 10,
                        ),
                        Container(
                          alignment: Alignment.center,
                          height: 40,
                          width: width * 0.34,
                          decoration: BoxDecoration(
                              border: Border.all(color: Color(0xaaFFD399)),
                              color: Color(0xaa955E1D),
                              borderRadius: BorderRadius.circular(5)),
                          child: Container(
                            height: 40,
                            margin: const EdgeInsets.symmetric(
                                vertical: 0, horizontal: 5),
                            child: TextField(
                              controller: userNameController,
                              style: TextStyle(color: Colors.white),
                              decoration: InputDecoration(
                                  hintText: "User name",
                                  hintStyle: TextStyle(color: Colors.white),
                                  border: InputBorder.none,
                                  fillColor: Colors.white),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Container(
                          alignment: Alignment.center,
                          height: 40,
                          width: width * 0.34,
                          decoration: BoxDecoration(
                              border: Border.all(color: Color(0xaaFFD399)),
                              color: Color(0xaa955E1D),
                              borderRadius: BorderRadius.circular(5)),
                          child: Container(
                            height: 40,
                            margin: const EdgeInsets.symmetric(
                                vertical: 0, horizontal: 5),
                            child: TextField(
                              obscureText: true,
                              controller: passwordController,
                              style: TextStyle(color: Colors.white),
                              keyboardType: TextInputType.visiblePassword,
                              decoration: InputDecoration(
                                  hintText: "Password",
                                  hintStyle: TextStyle(color: Colors.white),
                                  border: InputBorder.none,
                                  fillColor: Colors.white),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Container(
                          alignment: Alignment.center,
                          height: 40,
                          width: width * 0.34,
                          decoration: BoxDecoration(
                              border: Border.all(color: Color(0xaaFFD399)),
                              color: Color(0xaa955E1D),
                              borderRadius: BorderRadius.circular(5)),
                          child: Container(
                            height: 40,
                            margin: const EdgeInsets.symmetric(
                                vertical: 0, horizontal: 5),
                            child: TextField(
                              controller: mobileController,
                              style: TextStyle(color: Colors.white),
                              decoration: InputDecoration(
                                  hintText: "Mobile",
                                  hintStyle: TextStyle(color: Colors.white),
                                  border: InputBorder.none,
                                  fillColor: Colors.white),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        loading == true
                            ? CircularProgressIndicator(
                                color: Colors.white,
                              )
                            : InkWell(
                                onTap: () {
                                        widget.playBackgroundMusic == false
                              ? ''
                              :  Vibration.vibrate();
                                  if (userNameController.text.isEmpty) {
                                    DialogUtils.showOneBtn(
                                        context, "Please enter User name !");
                                  } else if (passwordController.text.isEmpty) {
                                    DialogUtils.showOneBtn(context,
                                        "Password should not be empty !");
                                  } else if (mobileController.text.isEmpty) {
                                    DialogUtils.showOneBtn(context,
                                        "Mobile no should not be empty !");
                                  } else {
                                    getsignUpDetails();
                                  }
                                },
                                child: Container(
                                  height: height * 0.15,
                                  width: width * 0.34,
                                  decoration: BoxDecoration(
                                    image: DecorationImage(
                                        image: AssetImage(
                                            "assets/User-interface/Buttons/signup-button.png"),
                                        fit: BoxFit.fitWidth),
                                  ),
                                ),
                              ),
                        SizedBox(
                          height: 20,
                        ),
                        InkWell(
                          onTap: () {
                                  widget.playBackgroundMusic == false
                              ? ''
                              :  Vibration.vibrate();
                          },
                          child: Text(
                            "Already have an account? LOGIN",
                            style: TextStyle(
                                color: Colors.white,
                                decoration: TextDecoration.underline),
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: const [
                Text(
                  "* By loging you accept you are 18+ and agree our ",
                  style: TextStyle(color: Colors.white, fontSize: 14),
                ),
                Text(
                  "T&C",
                  style: TextStyle(color: Colors.green),
                ),
                Text(
                  " and",
                  style: TextStyle(color: Colors.white),
                ),
                Text(
                  " Privacy Policy",
                  style: TextStyle(color: Colors.green),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }

  Widget portraitModeWidget() {
    return SingleChildScrollView(
      child: Container(
        height: height,
        width: width,
        decoration: BoxDecoration(
          image: DecorationImage(
              image:
                  AssetImage("assets/User-interface/Login-Page-portrait.png"),
              fit: BoxFit.cover),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              height: height * 0.8,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    width: 10,
                  ),
                  Container(
                    height: height * 0.25,
                    width: width * 0.5,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                          image: AssetImage(
                              "assets/User-interface/Mask group 2.png"),
                          fit: BoxFit.cover),
                    ),
                  ),
                  SizedBox(
                    height: 70,
                  ),
                  Container(
                    alignment: Alignment.center,
                    height: 45,
                    width: width * 0.8,
                    decoration: BoxDecoration(
                        border: Border.all(color: Color(0xaaFFD399)),
                        color: Color(0xaa955E1D),
                        borderRadius: BorderRadius.circular(5)),
                    child: Container(
                      height: 40,
                      margin: const EdgeInsets.symmetric(
                          vertical: 0, horizontal: 5),
                      child: TextField(
                        controller: userNameController,
                        style: TextStyle(color: Colors.white),
                        decoration: InputDecoration(
                            hintText: "User name",
                            hintStyle: TextStyle(color: Colors.white),
                            border: InputBorder.none,
                            fillColor: Colors.white),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Container(
                    alignment: Alignment.center,
                    height: 45,
                    width: width * 0.8,
                    decoration: BoxDecoration(
                        border: Border.all(color: Color(0xaaFFD399)),
                        color: Color(0xaa955E1D),
                        borderRadius: BorderRadius.circular(5)),
                    child: Container(
                      height: 40,
                      margin: const EdgeInsets.symmetric(
                          vertical: 0, horizontal: 5),
                      child: TextField(
                        obscureText: true,
                        controller: passwordController,
                        style: TextStyle(color: Colors.white),
                        keyboardType: TextInputType.visiblePassword,
                        decoration: InputDecoration(
                            hintText: "Password",
                            hintStyle: TextStyle(color: Colors.white),
                            border: InputBorder.none,
                            fillColor: Colors.white),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Container(
                    alignment: Alignment.center,
                    height: 45,
                    width: width * 0.8,
                    decoration: BoxDecoration(
                        border: Border.all(color: Color(0xaaFFD399)),
                        color: Color(0xaa955E1D),
                        borderRadius: BorderRadius.circular(5)),
                    child: Container(
                      height: 40,
                      margin: const EdgeInsets.symmetric(
                          vertical: 0, horizontal: 5),
                      child: TextField(
                        controller: mobileController,
                        style: TextStyle(color: Colors.white),
                        decoration: InputDecoration(
                            hintText: "Mobile",
                            hintStyle: TextStyle(color: Colors.white),
                            border: InputBorder.none,
                            fillColor: Colors.white),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  loading == true
                      ? CircularProgressIndicator(
                          color: Colors.white,
                        )
                      : InkWell(
                          onTap: () {
                                  widget.playBackgroundMusic == false
                              ? ''
                              :  Vibration.vibrate();
                            if (userNameController.text.isEmpty) {
                              DialogUtils.showOneBtn(
                                  context, "Please enter User name !");
                            } else if (passwordController.text.isEmpty) {
                              DialogUtils.showOneBtn(
                                  context, "Password should not be empty !");
                            } else if (mobileController.text.isEmpty) {
                              DialogUtils.showOneBtn(
                                  context, "Mobile no should not be empty !");
                            } else {
                              getsignUpDetails();
                            }
                          },
                          child: Container(
                            height: height * 0.13,
                            width: width * 0.8,
                            decoration: BoxDecoration(
                              image: DecorationImage(
                                  image: AssetImage(
                                      "assets/User-interface/Buttons/signup-button.png"),
                                  fit: BoxFit.fitWidth),
                            ),
                          ),
                        ),
                  SizedBox(
                    height: 20,
                  ),
                  InkWell(
                    onTap: () {
                            widget.playBackgroundMusic == false
                              ? ''
                              :  Vibration.vibrate();
                                    Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => SignInScreen()));
                    },
                    child: Text(
                      "Already have an account? LOGIN",
                      style: TextStyle(
                          color: Colors.white,
                          decoration: TextDecoration.underline),
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: const [
                Text(
                  "* By loging you accept you are 18+ and agree our ",
                  style: TextStyle(color: Colors.white, fontSize: 14),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "T&C",
                      style: TextStyle(color: Colors.green),
                    ),
                    Text(
                      " and",
                      style: TextStyle(color: Colors.white),
                    ),
                    Text(
                      " Privacy Policy",
                      style: TextStyle(color: Colors.green),
                    ),
                  ],
                )
              ],
            )
          ],
        ),
      ),
    );
  }

  Future getsignUpDetails() async {
    setState(() {
      loading = true;
    });
    var url = Apis.signupApi;
    var body = {
      "userId": userNameController.text.toString(),
      "password": passwordController.text.toString(),
      "appUrl": "maggibook.com",
      "mobile": mobileController.text.toString(),
      "username": "maggibook.com",
    };
    var response = await GlobalFunction.apiPostRequest(url, body);
    var result = jsonDecode(response);
    if (result['status'] == false) {
      DialogUtils.showOneBtn(context, result['message']);
      setState(() {
        loading = false;
      });
    } else {
      DialogUtils.showOneBtn(context, result['message']);
      userNameController.clear();
      mobileController.clear();
      passwordController.clear();
      setState(() {
        loading = false;
      });
    }
    setState(() {
      loading = false;
    });
  }
}
