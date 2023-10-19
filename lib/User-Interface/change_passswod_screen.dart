// ignore_for_file: use_build_context_synchronously

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:virtual_casino/Utils/api_helper.dart';
import 'package:virtual_casino/Utils/apis.dart';
import 'package:virtual_casino/Utils/toast.dart';

class ChangePasswordScreen extends StatefulWidget {
  const ChangePasswordScreen({super.key});

  @override
  State<ChangePasswordScreen> createState() => _ChangePasswordScreenState();
}

class _ChangePasswordScreenState extends State<ChangePasswordScreen> {
  double height = 0;
  double width = 0;
  var oldPasswordController = TextEditingController();
  var newPasswordController = TextEditingController();
  var confirmPasswordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    height = MediaQuery.of(context).size.height;
    width = MediaQuery.of(context).size.width;
    return Scaffold(body: OrientationBuilder(builder: (context, oreintation) {
      if (oreintation == Orientation.landscape) {
        return landscapeWidget();
      } else {
        return potraitMode();
      }
    }));
  }

  Widget landscapeWidget() {
    return SingleChildScrollView(
      child: Container(
        height: height,
        width: width,
        decoration: BoxDecoration(color: Colors.black),
        child: Column(
          children: [
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  GestureDetector(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: Container(
                        margin: const EdgeInsets.symmetric(horizontal: 10),
                        alignment: Alignment.center,
                        height: 30,
                        width: 30,
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(100)),
                        child: Icon(
                          Icons.close,
                          color: Colors.black,
                        )),
                  ),
                ],
              ),
            ),
            Text(
              "Change Password",
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 30,
                  fontWeight: FontWeight.bold),
            ),
            Divider(
              thickness: 3,
              color: Color.fromARGB(255, 93, 14, 14),
            ),
            SizedBox(
              height: 10,
            ),
            Container(
              height: height * 0.11,
              width: width * 0.5,
              decoration: BoxDecoration(color: Color(0xaa363636)),
              child: TextField(
                style: TextStyle(color: Colors.white),
                controller: oldPasswordController,
                textAlign: TextAlign.center,
                decoration: InputDecoration(
                  hintText: "Current Password",
                  hintStyle: TextStyle(color: Colors.white),
                  border: InputBorder.none,
                ),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Container(
              height: height * 0.11,
              width: width * 0.5,
              decoration: BoxDecoration(color: Color(0xaa363636)),
              child: TextField(
                style: TextStyle(color: Colors.white),
                controller: newPasswordController,
                textAlign: TextAlign.center,
                decoration: InputDecoration(
                  hintText: "New Password",
                  hintStyle: TextStyle(color: Colors.white),
                  border: InputBorder.none,
                ),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Container(
              height: height * 0.11,
              width: width * 0.5,
              decoration: BoxDecoration(color: Color(0xaa363636)),
              child: TextField(
                style: TextStyle(color: Colors.white),
                controller: confirmPasswordController,
                textAlign: TextAlign.center,
                decoration: InputDecoration(
                  hintText: "Confirm Password",
                  hintStyle: TextStyle(color: Colors.white),
                  border: InputBorder.none,
                ),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            GestureDetector(
              onTap: () {
                changePasswordDetails();
              },
              child: Container(
                height: height * 0.11,
                width: width * 0.5,
                decoration: BoxDecoration(
                    image: DecorationImage(
                        image: AssetImage(
                            'assets/User-interface/Buttons/change_password_button.png'),
                        fit: BoxFit.cover)),
              ),
            )
          ],
        ),
      ),
    );
  }

  //---------Portrait Mode--------------//

  Widget potraitMode() {
    return SingleChildScrollView(
      child: Container(
        height: height,
        width: width,
        decoration: BoxDecoration(color: Colors.black),
        child: Column(
          children: [
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  GestureDetector(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: Container(
                        margin: const EdgeInsets.symmetric(horizontal: 10),
                        alignment: Alignment.center,
                        height: 30,
                        width: 30,
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(100)),
                        child: Icon(
                          Icons.close,
                          color: Colors.black,
                        )),
                  ),
                ],
              ),
            ),
            Text(
              "Change Password",
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 30,
                  fontWeight: FontWeight.bold),
            ),
            Divider(
              thickness: 3,
              color: Color.fromARGB(255, 93, 14, 14),
            ),
            SizedBox(
              height: 10,
            ),
            Container(
              height: height * 0.06,
              width: width * 0.8,
              decoration: BoxDecoration(color: Color(0xaa363636)),
              child: TextField(
                style: TextStyle(color: Colors.white),
                controller: oldPasswordController,
                textAlign: TextAlign.center,
                decoration: InputDecoration(
                  hintText: "Current Password",
                  hintStyle: TextStyle(color: Colors.white),
                  border: InputBorder.none,
                ),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Container(
              height: height * 0.06,
              width: width * 0.8,
              decoration: BoxDecoration(color: Color(0xaa363636)),
              child: TextField(
                style: TextStyle(color: Colors.white),
                controller: newPasswordController,
                textAlign: TextAlign.center,
                decoration: InputDecoration(
                  hintText: "New Password",
                  hintStyle: TextStyle(color: Colors.white),
                  border: InputBorder.none,
                ),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Container(
              height: height * 0.06,
              width: width * 0.8,
              decoration: BoxDecoration(color: Color(0xaa363636)),
              child: TextField(
                style: TextStyle(color: Colors.white),
                controller: confirmPasswordController,
                textAlign: TextAlign.center,
                decoration: InputDecoration(
                  hintText: "Confirm Password",
                  hintStyle: TextStyle(color: Colors.white),
                  border: InputBorder.none,
                ),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            GestureDetector(
              onTap: () {
                changePasswordDetails();
              },
              child: Container(
                height: height * 0.06,
                width: width * 0.8,
                decoration: BoxDecoration(
                    image: DecorationImage(
                        image: AssetImage(
                            'assets/User-interface/Buttons/change_password_button.png'),
                        fit: BoxFit.cover)),
              ),
            )
          ],
        ),
      ),
    );
  }

  //------------------------API INTEGRATE----------------------------//

  Future changePasswordDetails() async {
    var url = Apis.changePasswordApi;
    var body = {
      "currentPassword": oldPasswordController.text,
      "newPassword": newPasswordController.text,
      "confirmPassword": confirmPasswordController.text,
    };
    var response =
        await GlobalFunction.apiPostRequestTokenForUsers(url, body, context);
    var result = jsonDecode(response);
    if (result['status'] == true) {
      oldPasswordController.clear();
      newPasswordController.clear();
      confirmPasswordController.clear();
      DialogUtils.showOneBtn(context, result['message']);
    } else {
      DialogUtils.showOneBtn(context, result['message']);
    }
  }
}
