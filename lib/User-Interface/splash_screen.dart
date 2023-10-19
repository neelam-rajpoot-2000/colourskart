// ignore_for_file: unnecessary_null_comparison, use_build_context_synchronously

import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:virtual_casino/User-Interface/dashborad_screen.dart';
import '../Utils/apis.dart';
import 'signin_screen.dart';
import 'package:http/http.dart' as http;

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with TickerProviderStateMixin {
  double height = 0;
  double width = 0;
  String userBalance = "";
  @override
  void initState() {
    startAnimation().then((value) => ());
    Timer(Duration(seconds: 3), () {
      getUserDetails();
    });

    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.landscapeLeft,
      DeviceOrientation.landscapeRight,
    ]);

    super.initState();
  }

  late AnimationController _controller;

  Future startAnimation() async {
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 3),
    )..addListener(() {
        setState(() {});
      });
    _controller.repeat(max: 1);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  String token = "";
  Future getprefs() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    token = preferences.getString("token").toString();
    token == "" || token == "null" || token == null
        ? Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => SignInScreen()))
        : Navigator.pushReplacement(context,
            MaterialPageRoute(builder: (context) => DashBoardScreen()));
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
    return Column(
      children: [
        Container(
          height: height,
          width: width,
          decoration: BoxDecoration(
              image: DecorationImage(
                  image: AssetImage("assets/User-interface/splash.png"),
                  fit: BoxFit.fitHeight)),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                height: 200,
              ),
              Container(
                height: 16,
                width: width * 0.5,
                decoration: BoxDecoration(
                    border: Border.all(
                      color: Color(0xaaFFD399),
                    ),
                    borderRadius: BorderRadius.circular(5)),
                child: Container(
                  margin:
                      const EdgeInsets.symmetric(horizontal: 3, vertical: 4),
                  height: 15,
                  width: width * 0.5,
                  child: LinearProgressIndicator(
                    minHeight: 12,
                    backgroundColor: Colors.transparent,
                    color: Color(0xaaFFD399),
                    value: _controller.value,
                    semanticsLabel: 'Linear progress indicator',
                  ),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Text(
                "Loading...",
                style: TextStyle(
                    fontSize: 18,
                    color: Colors.white,
                    fontWeight: FontWeight.bold),
              )
            ],
          ),
        ),
      ],
    );
  }

  Widget portraitModeWidget() {
    return Column(
      children: [
        Container(
          height: height,
          width: width,
          decoration: BoxDecoration(
              image: DecorationImage(
                  image: AssetImage(
                      "assets/User-interface/Statrting Loader Page (1).png"),
                  fit: BoxFit.cover)),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                height: 200,
              ),
              Container(
                height: 16,
                width: width * 0.9,
                decoration: BoxDecoration(
                    border: Border.all(
                      color: Color(0xaaFFD399),
                    ),
                    borderRadius: BorderRadius.circular(5)),
                child: Container(
                  margin:
                      const EdgeInsets.symmetric(horizontal: 3, vertical: 4),
                  height: 15,
                  width: width * 0.5,
                  child: LinearProgressIndicator(
                    minHeight: 12,
                    backgroundColor: Colors.transparent,
                    color: Color(0xaaFFD399),
                    value: _controller.value,
                    semanticsLabel: 'Linear progress indicator',
                  ),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Text(
                "Loading...",
                style: TextStyle(
                    fontSize: 18,
                    color: Colors.white,
                    fontWeight: FontWeight.bold),
              )
            ],
          ),
        ),
      ],
    );
  }

  var status;

  Future getUserDetails() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    var url = Apis.validateToken;
    var response = await http.post(Uri.parse(url), body: {}, headers: {
      "Authorization": "Bearer ${preferences.getString("token")}",
    });

    if (response.statusCode == 200) {
      getprefs();
      print("==================>${response.body}");
    } else {
      print("------>${response.body}");

      Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (context) => SignInScreen()),
          (route) => false);

      preferences.clear();
      final snackBar = SnackBar(
        backgroundColor: const Color.fromARGB(255, 62, 9, 6),
        content: const Text('Session expired please login again !'),
      );
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    }
  }
}
