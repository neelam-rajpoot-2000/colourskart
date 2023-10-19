import 'dart:core';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:just_audio/just_audio.dart';

import '../DragonTiger/Constants/images_constant_dt.dart';
import '../Widgets/customText.dart';

class DialogUtils {
  static DialogUtils instance = DialogUtils.internal();

  DialogUtils.internal();

  factory DialogUtils() => instance;

  static void showError(BuildContext context, PlatformException exception) {
    String? error =
        exception.code.isNotEmpty ? exception.code : exception.message;

    showDialog(
        context: context,
        builder: (_) {
          return AlertDialog(
            title: Text(error ?? "unexpected error"),
            actions: <Widget>[
              TextButton(
                child: Text("OK"),
                onPressed: () => Navigator.pop(context),
              ),
            ],
          );
        });
  }

  static void showResultLucky7(
      BuildContext context,
      cardImage1,
      cardDetail,
      hContainer,
      wContainer,
      hCard,
      wCard,
      hClose,
      wClose,
      hCloseBg,
      wCloseBg,roundIdList,heightRoundId,  Function funName) {
    showDialog(
        context: context,
        builder: (_) {
          var height = MediaQuery.of(context).size.height;
          var width = MediaQuery.of(context).size.width;
          return AlertDialog(
            backgroundColor: Colors.transparent,
            content: Stack(
              alignment: Alignment.center,
              children: [
                Container(
                  padding: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                  height: hContainer,
                  width: wContainer,
                  // width: width * 0.4,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    gradient: LinearGradient(
                      colors: const <Color>[
                        Color(0xff180010),
                        Color(0xff3F042B),
                      ],
                    ),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      CustomText(
                        text: "RESULT",
                        fontWeight: FontWeight.w600,
                        color: Colors.white,
                        fontSize: 17.0,
                        textAlign: TextAlign.center,
                      ),
                    
                      Image.network(
                        "http://admin.kalyanexch.com/images/cards/$cardImage1.png",
                        height: hCard,
                        width: wCard,
                      ),
                       CustomText(text: 'Round ID: ${roundIdList}',fontSize:heightRoundId,color: Colors.white,fontWeight: FontWeight.bold),
       
                      Container(
                        // width: width * 9,
                        padding:
                            EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5),
                            color: Color(0xff57003D)),
                        child: CustomText(
                          text: "$cardDetail".replaceAll("||", "  |  "),
                          fontWeight: FontWeight.w700,
                          color: Colors.white60,
                          fontSize: 09.0,
                          textAlign: TextAlign.center,
                        ),
                      )
                    ],
                  ),
                ),
                  Positioned(
                      right: width * 0.005,
                      top: 2,
                      child: InkWell(
                         onTap: () {
                    HapticFeedback.vibrate();

              
              
                          Navigator.pop(context);
                          funName;
                      
                  },
                        child: Image.asset(
                          "assets/User-interface/close-button.png",
                          scale: 4,
                        ),
                      ),
                    ),
                ],
            ),
          );
        });
  }

 static void showResultDT(
      BuildContext context,
      cardImage1,
      cardImage2,
      cardDetail,
      cardDetail2,
      cardDetail3,
     roundIdList) {
    showDialog(
        context: context,
        builder: (_) {
          var height = MediaQuery.of(context).size.height;
          var width = MediaQuery.of(context).size.width;
          return AlertDialog(
            backgroundColor: Colors.transparent,
            content:
                Stack(
                  children: [
                    Container(
                     // padding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                     height:     height * 0.26,
                          width:            width * 0.9,
                         
                                    
                      // width: width * 0.4,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                       image: DecorationImage(
                            image: AssetImage(DragonTigerImages.pastResult),
                            fit: BoxFit.fill)
                      ),
                      child:  Padding(
        padding: EdgeInsets.only(top: height * 0.04),
        child: Column(
          children: [
                 Padding(
              padding: EdgeInsets.only(left:width*0.25,top:height*0.015),
              child: Row(
                    children: [
                       Image.network(
                              "http://admin.kalyanexch.com/images/cards/$cardImage1.png",
                             height: height * 0.09,
                      width: width * 0.12,
                            ),
                            SizedBox(width: width*0.1,),
                             Image.network(
                              "http://admin.kalyanexch.com/images/cards/$cardImage2.png",
                           height: height * 0.09,
                      width: width * 0.12,
                            ),
                    ],
              ),
            ),
            SizedBox(height: height*0.0,),
             CustomText(
               text: 'Round ID: ${roundIdList}',
                    fontSize: 12,
                    color: Colors.white,
                    fontWeight: FontWeight.bold),
      
            Padding(
              padding: EdgeInsets.only(left: width*0.07,top: height*0.04),
              child: Row(
               
                    children: [
                       CustomText(
                                text: "$cardDetail".replaceAll("||", "|"),
                                fontWeight: FontWeight.w700,
                                color: Colors.white60,
                                fontSize: 6.0,
                                textAlign: TextAlign.center,
                              ),
                              SizedBox(width: width
                              *0.05,),
                               CustomText(
                                text: "$cardDetail2".replaceAll("||", "|"),
                                fontWeight: FontWeight.w700,
                                color: Colors.white60,
                                fontSize: 6.0,
                                textAlign: TextAlign.center,
                                                   ),
                                     SizedBox(width: width
                              *0.05,),             
                                                    CustomText(
                                text: "$cardDetail3".replaceAll("||", "|"),
                                fontWeight: FontWeight.w700,
                                color: Colors.white60,
                                fontSize: 6.0,
                                textAlign: TextAlign.center,
                                                   ),
                    ],
              ),
            )
          ],
        ),
      ),
              ),
                   Positioned(
                      right: width * 0.005,
                      top: 2,
                      child: InkWell(
                         onTap: () {
                     Navigator.pop(context);
                    HapticFeedback.vibrate();
                      
                  },
                        child: Image.asset(
                          "assets/User-interface/close-button.png",
                          scale: 4,
                        ),
                      ),
                    ),
                  ],
                ),
               
       
          );
        });
  }

  static void showResultDTLand(
      BuildContext context,
      cardImage1,
      cardImage2,
      cardDetail,
      cardDetail2,
      cardDetail3,
     roundIdList) {
    showDialog(
        context: context,
        builder: (_) {
          var height = MediaQuery.of(context).size.height;
          var width = MediaQuery.of(context).size.width;
          return AlertDialog(
            backgroundColor: Colors.transparent,
            content:
              Stack(
                  children: [
                    Container(
                  padding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                 height: height * 0.54,
                      width:          width * 0.40,
                        
                             
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                   image: DecorationImage(
                        image: AssetImage(DragonTigerImages.pastResult),
                        fit: BoxFit.fill)
                  ),
                  child:   Padding(
        padding: EdgeInsets.only(top: height * 0.05),
        child: Column(
          children: [
                Padding(
              padding: EdgeInsets.only(left:width*0.15,top:height*0.04),
              child: Row(
                    children: [
                       Image.network(
                          "http://admin.kalyanexch.com/images/cards/$cardImage1.png",
                         height: height * 0.14,
                 // width: width * 0.19,
                        ),
                            SizedBox(width: width*0.07,),
                             Image.network(
                          "http://admin.kalyanexch.com/images/cards/$cardImage2.png",
                         height: height * 0.14,
                //  width: width * 0.14,
                        ),
                    ],
              ),
            ),
                     SizedBox(height: height*0.03,),
              CustomText(
               text: 'Round ID: ${roundIdList}',
                    fontSize: 12,
                    color: Colors.white,
                    fontWeight: FontWeight.bold),
      
            Padding(
              padding: EdgeInsets.only(left: width*0.03,top: height*0.11),
              child: Row(
               
                    children: [
                       CustomText(
                                text: "$cardDetail".replaceAll("||", "|"),
                                fontWeight: FontWeight.w700,
                                color: Colors.white60,
                                fontSize: 6.0,
                                textAlign: TextAlign.center,
                              ),
                              SizedBox(width: width
                              *0.06,),
                               CustomText(
                                text: "$cardDetail2".replaceAll("||", "|"),
                                fontWeight: FontWeight.w700,
                                color: Colors.white60,
                                fontSize: 6.0,
                                textAlign: TextAlign.center,
                                                   ),
                                                      SizedBox(width: width
                              *0.065,),
                                                    CustomText(
                                text: "$cardDetail3".replaceAll("||", "|"),
                                fontWeight: FontWeight.w700,
                                color: Colors.white60,
                                fontSize: 6.0,
                                textAlign: TextAlign.center,
                                                   ),
                    ],
              ),
            )
          ],
        ),
      ),
              ),
                Positioned(
                      right: width * 0.005,
                      top: 2,
                      child: InkWell(
                         onTap: () {
                     Navigator.pop(context);
                    HapticFeedback.vibrate();
                      
                  },
                        child: Image.asset(
                          "assets/User-interface/close-button.png",
                          scale: 4,
                        ),
                      ),
                    ),
                
                  ],
                ),
             
                    );
        });
  }

  
  static void showOneBtn(BuildContext context, String titleText) {
    showDialog(
        context: context,
        builder: (_) {
          return AlertDialog(
            backgroundColor: Colors.transparent,
            content: Stack(
              alignment: Alignment.center,
              children: [
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.7,
                  width: MediaQuery.of(context).size.width * 0.4,
                  child: Stack(
                    children: [
                      Container(
                        margin: const EdgeInsets.symmetric(vertical: 22),
                        height: MediaQuery.of(context).size.height * 0.5,
                        width: MediaQuery.of(context).size.width * 0.4,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            image: DecorationImage(
                                image: AssetImage(
                                    "assets/User-interface/Popup.png"),
                                fit: BoxFit.fitHeight)),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              children: [
                                SizedBox(
                                  height: 10,
                                ),
                                Text(
                                  "Notice",
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold),
                                ),
                                SizedBox(
                                  height: 30,
                                ),
                                Container(
                                  margin: const EdgeInsets.symmetric(
                                    horizontal: 20,
                                  ),
                                  child: Text(
                                    titleText,
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 15,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                              ],
                            ),
                            InkWell(
                              onTap: () {
                                Navigator.pop(context);
                              },
                              child: Container(
                                  margin:
                                      const EdgeInsets.symmetric(vertical: 10),
                                  height: 40,
                                  width: 80,
                                  decoration: BoxDecoration(
                                      image: DecorationImage(
                                          image: AssetImage(
                                              "assets/User-interface/Buttons/ok-button.png")))),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
               
                 Positioned(
                      right:  MediaQuery.of(context).size.width  * 0.005,
                      top: 2,
                      child: InkWell(
                         onTap: () {
                     Navigator.pop(context);
                    HapticFeedback.vibrate();
                      
                  },
                        child: Image.asset(
                          "assets/User-interface/close-button.png",
                          scale: 4,
                        ),
                      ),
                    ),
                
              ],
            ),
          );
        });
  }

  static void showOneBtnPortrait(BuildContext context, String titleText) {
    showDialog(
        context: context,
        builder: (_) {
          return AlertDialog(
            backgroundColor: Colors.transparent,
            content: Stack(
              alignment: Alignment.center,
              children: [
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.4,
                  width: MediaQuery.of(context).size.width * 0.8,
                  child: Stack(
                    children: [
                      Container(
                        margin: const EdgeInsets.symmetric(vertical: 22),
                        height: MediaQuery.of(context).size.height * 0.25,
                        width: MediaQuery.of(context).size.width * 0.9,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            image: DecorationImage(
                                image: AssetImage(
                                    "assets/User-interface/Popup.png"),
                                fit: BoxFit.fitHeight)),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              children: [
                                SizedBox(
                                  height: 10,
                                ),
                                Text(
                                  "Notice",
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold),
                                ),
                                SizedBox(
                                  height: 30,
                                ),
                                Container(
                                  margin: const EdgeInsets.symmetric(
                                    horizontal: 20,
                                  ),
                                  child: Text(
                                    titleText,
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 15,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                              ],
                            ),
                          
                          ],
                        ),
                      ),
                      Positioned(
                      right:  MediaQuery.of(context).size.width  * 0.005,
                      top: 2,
                      child: InkWell(
                         onTap: () {
                     Navigator.pop(context);
                    HapticFeedback.vibrate();
                      
                  },
                        child: Image.asset(
                          "assets/User-interface/close-button.png",
                          scale: 4,
                        ),
                      ),
                    ),
                
                    ],
                  ),
                ),
              ],
            ),
          );
        });
  }

  static void showconfirmBet(BuildContext context, Function onBet) {
    showDialog(
        context: context,
        builder: (_) {
          return AlertDialog(
            backgroundColor: Colors.transparent,
            content: Stack(
              alignment: Alignment.center,
              children: [
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.7,
                  width: MediaQuery.of(context).size.width * 0.4,
                  child: Stack(
                    children: [
                      Container(
                        margin: const EdgeInsets.symmetric(vertical: 22),
                        height: MediaQuery.of(context).size.height * 0.5,
                        width: MediaQuery.of(context).size.width * 0.4,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            image: DecorationImage(
                                image: AssetImage(
                                    "assets/User-interface/Popup.png"),
                                fit: BoxFit.fitHeight)),
                        child: Column(
                          children: [
                            Column(
                              children: const [
                                SizedBox(
                                  height: 10,
                                ),
                                Text(
                                  "Are you sure want to continue ?",
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 40,
                            ),
                            Container(
                              margin: const EdgeInsetsDirectional.symmetric(
                                  horizontal: 20),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  InkWell(
                                    onTap: () {
                                      Navigator.pop(context);
                                    },
                                    child: Container(
                                      alignment: Alignment.center,
                                      margin: const EdgeInsets.symmetric(
                                          vertical: 10),
                                      height: 40,
                                      width: 80,
                                      decoration: BoxDecoration(
                                          color: Colors.red,
                                          borderRadius:
                                              BorderRadius.circular(10)),
                                      child: Text(
                                        "Cancel",
                                        style: TextStyle(color: Colors.white),
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    width: 50,
                                  ),
                                  InkWell(
                                    onTap: () {
                                      onBet;
                                      Navigator.pop(context);
                                    },
                                    child: Container(
                                      alignment: Alignment.center,
                                      margin: const EdgeInsets.symmetric(
                                          vertical: 10),
                                      height: 40,
                                      width: 80,
                                      decoration: BoxDecoration(
                                          color: Colors.green,
                                          borderRadius:
                                              BorderRadius.circular(10)),
                                      child: Text(
                                        "Confirm",
                                        style: TextStyle(color: Colors.white),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                InkWell(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: Container(
                    alignment: Alignment.topRight,
                    height: MediaQuery.of(context).size.height * 0.6,
                    width: MediaQuery.of(context).size.width * 0.42,
                    margin: const EdgeInsets.only(left: 10, bottom: 20),
                    child: Container(
                        alignment: Alignment.center,
                        height: 40,
                        width: 40,
                        decoration: BoxDecoration(
                            image: DecorationImage(
                                image: AssetImage(
                                    "assets/User-interface/Buttons/close-button.png")))),
                  ),
                ),
              ],
            ),
          );
        });
  }

  static void betSucessfulllyPlaced(
      BuildContext context,
      double heightImage,
      double widthImage,
      double height,
      double width,
      double heightClick,
      double widthClick) {
    showDialog(
        context: context,
        builder: (_) {
          return AlertDialog(
            backgroundColor: Colors.transparent,
            content: Stack(
              alignment: Alignment.center,
              children: [
                SizedBox(
                  height: heightImage,
                  width: widthImage,
                  child: Stack(
                    children: [
                      Container(
                        margin: const EdgeInsets.symmetric(vertical: 22),
                        height: height,
                        width: width,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            image: DecorationImage(
                                image: AssetImage(
                                    "assets/User-interface/Popup.png"),
                                fit: BoxFit.fitHeight)),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              children: [
                                SizedBox(
                                  height: 10,
                                ),
                                Text(
                                  "Notice",
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold),
                                ),
                                SizedBox(
                                  height: 30,
                                ),
                                Container(
                                  margin: const EdgeInsets.symmetric(
                                    horizontal: 20,
                                  ),
                                  child: Text(
                                    "Bet Successfully Placed !!",
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 15,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                              ],
                            ),
                            InkWell(
                              onTap: () {
                                Navigator.pop(context);
                                Navigator.pop(context);
                              },
                              child: Container(
                                  margin:
                                      const EdgeInsets.symmetric(vertical: 10),
                                  height: 40,
                                  width: 80,
                                  decoration: BoxDecoration(
                                      image: DecorationImage(
                                          image: AssetImage(
                                              "assets/User-interface/Buttons/ok-button.png")))),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                InkWell(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: Container(
                    alignment: Alignment.topRight,
                    height: heightClick,
                    width: widthClick,
                    margin: const EdgeInsets.only(left: 10, bottom: 20),
                    child: Container(
                        alignment: Alignment.center,
                        height: 40,
                        width: 40,
                        decoration: BoxDecoration(
                            image: DecorationImage(
                                image: AssetImage(
                                    "assets/User-interface/Buttons/close-button.png")))),
                  ),
                ),
              ],
            ),
          );
        });
  }

  static void showResult(
    BuildContext context,
    String titleText,
    cardImage1,
    cardImage2,
    cardImage3,
    cardImage4,
    cardImage5,
    cardImage6,
    winner,
    roundId,
    showPopUp,
  ) {
    showDialog(
        context: context,
        builder: (_) {
          instance;
          showPopUp == false ? Navigator.pop(context) : "";
          return AlertDialog(
            backgroundColor: Colors.transparent,
            content: Stack(
              alignment: Alignment.center,
              children: [
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.7,
                  width: MediaQuery.of(context).size.width * 0.4,
                  child: Stack(
                    children: [
                      Container(
                        margin: const EdgeInsets.symmetric(vertical: 22),
                        height: MediaQuery.of(context).size.height * 0.5,
                        width: MediaQuery.of(context).size.width * 0.4,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            image: DecorationImage(
                                image: AssetImage(
                                    "assets/Teen-patti/images/past-result.png"),
                                fit: BoxFit.fitHeight)),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              children: [
                                SizedBox(
                                  height: 10,
                                ),
                                SizedBox(
                                  height: 30,
                                ),
                                Container(
                                  margin: const EdgeInsets.symmetric(
                                    horizontal: 20,
                                  ),
                                  child: Text(
                                    "Round Id : $roundId",
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 12,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Image.network(
                                  "http://admin.kalyanexch.com/images/cards/$cardImage1.png",
                                  height: 50,
                                ),
                                SizedBox(
                                  width: 5,
                                ),
                                Image.network(
                                  "http://admin.kalyanexch.com/images/cards/$cardImage2.png",
                                  height: 50,
                                ),
                                SizedBox(
                                  width: 5,
                                ),
                                Image.network(
                                  "http://admin.kalyanexch.com/images/cards/$cardImage3.png",
                                  height: 50,
                                ),
                                SizedBox(
                                  width: 15,
                                ),
                                Image.network(
                                  "http://admin.kalyanexch.com/images/cards/$cardImage4.png",
                                  height: 50,
                                ),
                                SizedBox(
                                  width: 5,
                                ),
                                Image.network(
                                  "http://admin.kalyanexch.com/images/cards/$cardImage5.png",
                                  height: 50,
                                ),
                                SizedBox(
                                  width: 5,
                                ),
                                Image.network(
                                  "http://admin.kalyanexch.com/images/cards/$cardImage6.png",
                                  height: 50,
                                ),
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Container(
                                  alignment: Alignment.center,
                                  margin: const EdgeInsets.symmetric(
                                      vertical: 5, horizontal: 20),
                                  height:
                                      MediaQuery.of(context).size.height * 0.07,
                                  width:
                                      MediaQuery.of(context).size.width * 0.15,
                                  decoration: BoxDecoration(
                                      color: winner == "1"
                                          ? Color(0xaa008000)
                                          : Colors.transparent,
                                      border: Border.all(
                                          color: Color(0xaa3A0F6D), width: 2)),
                                  child: Text(
                                    "Player A",
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 13,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                                Container(
                                  alignment: Alignment.center,
                                  margin: const EdgeInsets.symmetric(
                                      vertical: 5, horizontal: 20),
                                  height:
                                      MediaQuery.of(context).size.height * 0.07,
                                  width:
                                      MediaQuery.of(context).size.width * 0.15,
                                  decoration: BoxDecoration(
                                      color: winner == "2"
                                          ? Color(0xaa008000)
                                          : Colors.transparent,
                                      border: Border.all(
                                          color: Color(0xaa3A0F6D), width: 2)),
                                  child: Text(
                                    "Player B",
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 13,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                              ],
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
               
                Positioned(
                      right:  MediaQuery.of(context).size.width  * 0.005,
                      top: 2,
                      child: InkWell(
                         onTap: () {
                     Navigator.pop(context);
                    HapticFeedback.vibrate();
                      
                  },
                        child: Image.asset(
                          "assets/User-interface/close-button.png",
                          scale: 4,
                        ),
                      ),
                    ),
                
              ],
            ),
          );
        });
  }

  static void showResultPortrait(
    BuildContext context,
    String titleText,
    cardImage1,
    cardImage2,
    cardImage3,
    cardImage4,
    cardImage5,
    cardImage6,
    winner,
    roundId,
  ) {
    showDialog(
        context: context,
        builder: (_) {
          return AlertDialog(
            backgroundColor: Colors.transparent,
            content: SizedBox(
              height: MediaQuery.of(context).size.height * 0.5,
              width: MediaQuery.of(context).size.width * 0.99,
              child: Stack(
                children: [
                  Container(
                    margin: const EdgeInsets.symmetric(vertical: 22),
                    height: MediaQuery.of(context).size.height * 0.4,
                    width: MediaQuery.of(context).size.width * 0.7,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        image: DecorationImage(
                            image: AssetImage(
                                "assets/Teen-patti/images/past-result.png"),
                            fit: BoxFit.fitHeight)),
                    child: Column(
                      children: [
                        Column(
                          children: [
                            SizedBox(
                              height: 10,
                            ),
                            SizedBox(
                              height: 40,
                            ),
                            Container(
                              margin: const EdgeInsets.symmetric(
                                horizontal: 20,
                              ),
                              child: Text(
                                "Round Id : $roundId",
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 12,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 40,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Image.network(
                              "http://admin.kalyanexch.com/images/cards/$cardImage1.png",
                              height: 40,
                            ),
                            SizedBox(
                              width: 5,
                            ),
                            Image.network(
                              "http://admin.kalyanexch.com/images/cards/$cardImage2.png",
                              height: 40,
                            ),
                            SizedBox(
                              width: 5,
                            ),
                            Image.network(
                              "http://admin.kalyanexch.com/images/cards/$cardImage3.png",
                              height: 40,
                            ),
                            SizedBox(
                              width: 15,
                            ),
                            Image.network(
                              "http://admin.kalyanexch.com/images/cards/$cardImage4.png",
                              height: 40,
                            ),
                            SizedBox(
                              width: 5,
                            ),
                            Image.network(
                              "http://admin.kalyanexch.com/images/cards/$cardImage5.png",
                              height: 40,
                            ),
                            SizedBox(
                              width: 5,
                            ),
                            Image.network(
                              "http://admin.kalyanexch.com/images/cards/$cardImage6.png",
                              height: 40,
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 40,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                              alignment: Alignment.center,
                              margin: const EdgeInsets.symmetric(
                                  vertical: 0, horizontal: 20),
                              height: MediaQuery.of(context).size.height * 0.05,
                              width: MediaQuery.of(context).size.width * 0.2,
                              decoration: BoxDecoration(
                                  color: winner == "1"
                                      ? Color(0xaa008000)
                                      : Colors.transparent,
                                  border: Border.all(
                                      color: Color(0xaa3A0F6D), width: 2)),
                              child: Text(
                                "Team A",
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 13,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                            Container(
                              alignment: Alignment.center,
                              margin: const EdgeInsets.symmetric(
                                  vertical: 0, horizontal: 20),
                              height: MediaQuery.of(context).size.height * 0.05,
                              width: MediaQuery.of(context).size.width * 0.2,
                              decoration: BoxDecoration(
                                  color: winner == "2"
                                      ? Color(0xaa008000)
                                      : Colors.transparent,
                                  border: Border.all(
                                      color: Color(0xaa3A0F6D), width: 2)),
                              child: Text(
                                "Team B",
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 13,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                 
                  Positioned(
                      right:  MediaQuery.of(context).size.width  * 0.005,
                      top: 2,
                      child: InkWell(
                         onTap: () {
                     Navigator.pop(context);
                    HapticFeedback.vibrate();
                      
                  },
                        child: Image.asset(
                          "assets/User-interface/close-button.png",
                          scale: 4,
                        ),
                      ),
                    ),
                
                ],
              ),
            ),
          );
        });
  }

   static void showResultAmar(
    BuildContext context,
    String titleText,
    cardImage1,
    roundId,
  ) {
    showDialog(
        context: context,
        builder: (_) {
          return AlertDialog(
            backgroundColor: Colors.transparent,
            content: Stack(
              alignment: Alignment.center,
              children: [
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.7,
                  width: MediaQuery.of(context).size.width * 0.4,
                  child: Stack(
                    children: [
                      Container(
                        margin: const EdgeInsets.symmetric(vertical: 22),
                        height: MediaQuery.of(context).size.height * 0.5,
                        width: MediaQuery.of(context).size.width * 0.4,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            image: DecorationImage(
                                image: AssetImage(
                                    "assets/User-interface/amarResultBackground.png"),
                                fit: BoxFit.fitHeight)),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Image.network(
                              "http://admin.kalyanexch.com/images/cards/$cardImage1.png",
                              height: 50,
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            Text(
                              "Round Id : $roundId",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 12),
                            ),
                            Container(
                              alignment: Alignment.center,
                              margin: const EdgeInsets.symmetric(
                                horizontal: 20,
                              ),
                              height: 80,
                              decoration: BoxDecoration(
                                  image: DecorationImage(
                                      image: AssetImage(
                                          "assets/User-interface/amar-result-type.png"))),
                              child: Text(
                                titleText.replaceAll("||", "  |  "),
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 15,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
               
                Positioned(
                      right:  MediaQuery.of(context).size.width  * 0.005,
                      top: 2,
                      child: InkWell(
                         onTap: () {
                     Navigator.pop(context);
                    HapticFeedback.vibrate();
                      
                  },
                        child: Image.asset(
                          "assets/User-interface/close-button.png",
                          scale: 4,
                        ),
                      ),
                    ),
                
              ],
            ),
          );
        });
  }

  static void showResultAmarPortrait(
      BuildContext context, String titleText, cardImage1, roundId) {
    showDialog(
        context: context,
        builder: (_) {
          return AlertDialog(
            backgroundColor: Colors.transparent,
            content: Stack(
              alignment: Alignment.center,
              children: [
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.4,
                  width: MediaQuery.of(context).size.width,
                  child: Stack(
                    children: [
                      Container(
                        margin: const EdgeInsets.symmetric(vertical: 22),
                        height: MediaQuery.of(context).size.height * 0.4,
                        width: MediaQuery.of(context).size.width * 0.99,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            image: DecorationImage(
                                image: AssetImage(
                                    "assets/User-interface/amarResultBackground.png"),
                                fit: BoxFit.fitHeight)),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Image.network(
                              "http://admin.kalyanexch.com/images/cards/$cardImage1.png",
                              height: 50,
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            Text(
                              "Round Id : $roundId",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 12),
                            ),
                            Container(
                              alignment: Alignment.center,
                              margin: const EdgeInsets.symmetric(
                                horizontal: 20,
                              ),
                              height: 80,
                              decoration: BoxDecoration(
                                  image: DecorationImage(
                                      image: AssetImage(
                                          "assets/User-interface/amar-result-type.png"))),
                              child: Text(
                                titleText.replaceAll("||", "  |  "),
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 12,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
               
                Positioned(
                      right:  MediaQuery.of(context).size.width  * 0.005,
                      top: 2,
                      child: InkWell(
                         onTap: () {
                     Navigator.pop(context);
                    HapticFeedback.vibrate();
                      
                  },
                        child: Image.asset(
                          "assets/User-interface/close-button.png",
                          scale: 4,
                        ),
                      ),
                    ),
                
              ],
            ),
          );
        });
  }
static void showBetHistory(BuildContext context) {
    showDialog(
        context: context,
        builder: (_) {
          return AlertDialog(
            backgroundColor: Colors.transparent,
            content: Stack(
              alignment: Alignment.center,
              children: [
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.8,
                  width: MediaQuery.of(context).size.width * 0.4,
                  child: Stack(
                    children: [
                      Container(
                        margin: const EdgeInsets.symmetric(vertical: 22),
                        height: MediaQuery.of(context).size.height * 0.8,
                        width: MediaQuery.of(context).size.width * 0.4,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            image: DecorationImage(
                                image: AssetImage(
                                    "assets/Teen-patti/images/drawer-background.png"),
                                fit: BoxFit.cover)),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              children: [
                                SizedBox(
                                  height: 10,
                                ),
                                SizedBox(
                                  height: 30,
                                ),
                                Container(
                                  margin: const EdgeInsets.symmetric(
                                    horizontal: 20,
                                  ),
                                  child: Text(
                                    "MY BET",
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 15,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                Container(
                                  height:
                                      MediaQuery.of(context).size.height * 0.4,
                                  width:
                                      MediaQuery.of(context).size.width * 0.38,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(5),
                                      border: Border.all(
                                        color: Color(0xaa9919D2),
                                      )),
                                  child: Column(
                                    children: [
                                      Container(
                                        color: Color(0xaa380F6B),
                                        child: Container(
                                          margin: const EdgeInsets.symmetric(
                                            horizontal: 10,
                                          ),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: const [
                                              Text(
                                                "PLAYER",
                                                style: TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 12,
                                                ),
                                              ),
                                              Text(
                                                "ODD",
                                                style: TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 12,
                                                ),
                                              ),
                                              Text(
                                                "AMOUNT",
                                                style: TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 12,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                      SizedBox(
                                        height: 10,
                                      ),
                                      Container(
                                        margin: const EdgeInsets.symmetric(
                                            horizontal: 10, vertical: 0),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: const [
                                            Text(
                                              "Lucifer",
                                              style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 12,
                                              ),
                                            ),
                                            Text(
                                              "0.00",
                                              style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 12,
                                              ),
                                            ),
                                            Text(
                                              "500000",
                                              style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 12,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      Container(
                                        margin: const EdgeInsets.symmetric(
                                            horizontal: 10),
                                        child: Divider(
                                          color: Color(0xaa9919D2),
                                          thickness: 1,
                                        ),
                                      ),
                                      Container(
                                        margin: const EdgeInsets.symmetric(
                                            horizontal: 10, vertical: 0),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: const [
                                            Text(
                                              "Lucifer",
                                              style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 12,
                                              ),
                                            ),
                                            Text(
                                              "0.00",
                                              style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 12,
                                              ),
                                            ),
                                            Text(
                                              "500000",
                                              style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 12,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      Container(
                                        margin: const EdgeInsets.symmetric(
                                            horizontal: 10),
                                        child: Divider(
                                          color: Color(0xaa9919D2),
                                          thickness: 1,
                                        ),
                                      ),
                                      Container(
                                        margin: const EdgeInsets.symmetric(
                                            horizontal: 10, vertical: 0),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: const [
                                            Text(
                                              "Lucifer",
                                              style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 12,
                                              ),
                                            ),
                                            Text(
                                              "0.00",
                                              style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 12,
                                              ),
                                            ),
                                            Text(
                                              "500000",
                                              style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 12,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      Container(
                                        margin: const EdgeInsets.symmetric(
                                            horizontal: 10),
                                        child: Divider(
                                          color: Color(0xaa9919D2),
                                          thickness: 1,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
               
                Positioned(
                      right:  MediaQuery.of(context).size.width  * 0.005,
                      top: 2,
                      child: InkWell(
                         onTap: () {
                     Navigator.pop(context);
                    HapticFeedback.vibrate();
                      
                  },
                        child: Image.asset(
                          "assets/User-interface/close-button.png",
                          scale: 4,
                        ),
                      ),
                    ),
                
              ],
            ),
          );
        });
  }

  static void showBetHistoryPotrait(BuildContext context) {
    showDialog(
        context: context,
        builder: (_) {
          return AlertDialog(
            backgroundColor: Colors.transparent,
            content: Stack(
              alignment: Alignment.center,
              children: [
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.6,
                  width: MediaQuery.of(context).size.width * 0.9,
                  child: Stack(
                    children: [
                      Container(
                        margin: const EdgeInsets.symmetric(vertical: 22),
                        height: MediaQuery.of(context).size.height * 0.4,
                        width: MediaQuery.of(context).size.width * 0.9,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            image: DecorationImage(
                                image: AssetImage(
                                    "assets/Teen-patti/images/drawer-background.png"),
                                fit: BoxFit.cover)),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              children: [
                                SizedBox(
                                  height: 10,
                                ),
                                SizedBox(
                                  height: 30,
                                ),
                                Container(
                                  margin: const EdgeInsets.symmetric(
                                    horizontal: 20,
                                  ),
                                  child: Text(
                                    "MY BET",
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 15,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                Container(
                                  height:
                                      MediaQuery.of(context).size.height * 0.3,
                                  width:
                                      MediaQuery.of(context).size.width * 0.7,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(5),
                                      border: Border.all(
                                        color: Color(0xaa9919D2),
                                      )),
                                  child: Column(
                                    children: [
                                      Container(
                                        color: Color(0xaa380F6B),
                                        child: Container(
                                          margin: const EdgeInsets.symmetric(
                                            horizontal: 10,
                                          ),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: const [
                                              Text(
                                                "PLAYER",
                                                style: TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 12,
                                                ),
                                              ),
                                              Text(
                                                "ODD",
                                                style: TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 12,
                                                ),
                                              ),
                                              Text(
                                                "AMOUNT",
                                                style: TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 12,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                      SizedBox(
                                        height: 10,
                                      ),
                                      Container(
                                        margin: const EdgeInsets.symmetric(
                                            horizontal: 10, vertical: 0),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: const [
                                            Text(
                                              "Lucifer",
                                              style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 12,
                                              ),
                                            ),
                                            Text(
                                              "0.00",
                                              style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 12,
                                              ),
                                            ),
                                            Text(
                                              "500000",
                                              style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 12,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      Container(
                                        margin: const EdgeInsets.symmetric(
                                            horizontal: 10),
                                        child: Divider(
                                          color: Color(0xaa9919D2),
                                          thickness: 1,
                                        ),
                                      ),
                                      Container(
                                        margin: const EdgeInsets.symmetric(
                                            horizontal: 10, vertical: 0),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: const [
                                            Text(
                                              "Lucifer",
                                              style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 12,
                                              ),
                                            ),
                                            Text(
                                              "0.00",
                                              style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 12,
                                              ),
                                            ),
                                            Text(
                                              "500000",
                                              style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 12,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      Container(
                                        margin: const EdgeInsets.symmetric(
                                            horizontal: 10),
                                        child: Divider(
                                          color: Color(0xaa9919D2),
                                          thickness: 1,
                                        ),
                                      ),
                                      Container(
                                        margin: const EdgeInsets.symmetric(
                                            horizontal: 10, vertical: 0),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: const [
                                            Text(
                                              "Lucifer",
                                              style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 12,
                                              ),
                                            ),
                                            Text(
                                              "0.00",
                                              style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 12,
                                              ),
                                            ),
                                            Text(
                                              "500000",
                                              style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 12,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      Container(
                                        margin: const EdgeInsets.symmetric(
                                            horizontal: 10),
                                        child: Divider(
                                          color: Color(0xaa9919D2),
                                          thickness: 1,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                
                Positioned(
                      right:  MediaQuery.of(context).size.width  * 0.005,
                      top: 2,
                      child: InkWell(
                         onTap: () {
                     Navigator.pop(context);
                    HapticFeedback.vibrate();
                      
                  },
                        child: Image.asset(
                          "assets/User-interface/close-button.png",
                          scale: 4,
                        ),
                      ),
                    ),
                
              ],
            ),
          );
        });
  }

  static void showTwoBtn(BuildContext context, String titleText,
      Function accept, Function decline) {
    showDialog(
        context: context,
        builder: (_) {
          return AlertDialog(
            title: Text(titleText),
            actions: <Widget>[
              TextButton(
                  child: Text("Accept"),
                  onPressed: () {
                    accept(null);
                    Navigator.pop(context);
                  }),
              TextButton(
                  child: Text("Decline"),
                  onPressed: () {
                    decline(null);
                    Navigator.pop(context);
                  }),
            ],
          );
        });
  }

  static void showResultDTL(
    BuildContext context,
    String titleText,
    cardImage1,
    cardImage2,
    cardImage3,
    winner,
    roundId,
    detail2,
    detail3,
  ) {
    showDialog(
        context: context,
        builder: (_) {
          return AlertDialog(
            backgroundColor: Colors.transparent,
            content: Stack(
              alignment: Alignment.center,
              children: [
                Container(
                  alignment: Alignment.center,
                  height: MediaQuery.of(context).size.height * 0.7,
                  width: MediaQuery.of(context).size.width * 0.9,
                  child: Stack(
                    children: [
                      Container(
                        margin: const EdgeInsets.symmetric(vertical: 22),
                        height: MediaQuery.of(context).size.height * 0.6,
                        width: MediaQuery.of(context).size.width * 0.6,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            image: DecorationImage(
                                image: AssetImage(
                                    "assets/dragonTigerLion/tableImges/result-backgroud.png"),
                                fit: BoxFit.fitWidth)),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              children: [
                                SizedBox(
                                  height: 10,
                                ),
                                Container(
                                  margin: const EdgeInsets.symmetric(
                                    horizontal: 20,
                                  ),
                                  child: Text(
                                    "RESULT",
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Image.network(
                                  "http://admin.kalyanexch.com/images/cards/$cardImage1.png",
                                  height: 50,
                                ),
                                SizedBox(
                                  width: 50,
                                ),
                                Image.network(
                                  "http://admin.kalyanexch.com/images/cards/$cardImage2.png",
                                  height: 50,
                                ),
                                SizedBox(
                                  width: 50,
                                ),
                                Image.network(
                                  "http://admin.kalyanexch.com/images/cards/$cardImage3.png",
                                  height: 50,
                                ),
                                SizedBox(
                                  width: 15,
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 8,
                            ),
                            Text(
                              "RoundId : $roundId",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 12),
                            ),
                            SizedBox(
                              height: 8,
                            ),
                            Container(
                              alignment: Alignment.center,
                              margin: const EdgeInsets.symmetric(
                                horizontal: 20,
                              ),
                              height: 70,
                              width: MediaQuery.of(context).size.width * 0.5,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  border: Border.all(
                                    color: Color(0xaa45B8E8),
                                  )),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "  WINNER  |     DRAGON      |      TIGER      |        LION  ",
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 15,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  SizedBox(
                                    height: 5,
                                  ),
                                  Container(
                                    margin: const EdgeInsets.symmetric(
                                        horizontal: 10),
                                    height: 40,
                                    width:
                                        MediaQuery.of(context).size.width * 0.7,
                                    child: Text(
                                      "$winner        |    ${titleText.replaceAll('||', ',')}     |   ${detail2.replaceAll('||', ',')}   |   ${detail3.replaceAll('||', ',')}  ",
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 10,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(
                              height: 8,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
               
                Positioned(
                      right:  MediaQuery.of(context).size.width  * 0.005,
                      top: 2,
                      child: InkWell(
                         onTap: () {
                     Navigator.pop(context);
                    HapticFeedback.vibrate();
                      
                  },
                        child: Image.asset(
                          "assets/User-interface/close-button.png",
                          scale: 4,
                        ),
                      ),
                    ),
                
              ],
            ),
          );
        });
  }

  static void showResultDTLPortrait(
    BuildContext context,
    String titleText,
    cardImage1,
    cardImage2,
    cardImage3,
    winner,
    roundId,
    detail2,
    detail3,
  ) {
    showDialog(
        context: context,
        builder: (_) {
          return AlertDialog(
            backgroundColor: Colors.transparent,
            content: Stack(
              alignment: Alignment.center,
              children: [
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.4,
                  width: MediaQuery.of(context).size.width * 0.93,
                  child: Stack(
                    children: [
                      Container(
                        margin: const EdgeInsets.symmetric(vertical: 22),
                        height: MediaQuery.of(context).size.height * 0.3,
                        width: MediaQuery.of(context).size.width * 0.65,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            image: DecorationImage(
                                image: AssetImage(
                                    "assets/dragonTigerLion/tableImges/result-backgroud.png"),
                                fit: BoxFit.fitHeight)),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              children: [
                                SizedBox(
                                  height: 10,
                                ),
                                Container(
                                  margin: const EdgeInsets.symmetric(
                                    horizontal: 20,
                                  ),
                                  child: Text(
                                    "RESULT",
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 12,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Image.network(
                                  "http://admin.kalyanexch.com/images/cards/$cardImage1.png",
                                  height: 50,
                                ),
                                SizedBox(
                                  width: 15,
                                ),
                                Image.network(
                                  "http://admin.kalyanexch.com/images/cards/$cardImage2.png",
                                  height: 50,
                                ),
                                SizedBox(
                                  width: 15,
                                ),
                                Image.network(
                                  "http://admin.kalyanexch.com/images/cards/$cardImage3.png",
                                  height: 50,
                                ),
                                SizedBox(
                                  width: 15,
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 3,
                            ),
                            Text(
                              "winner : $winner",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 12),
                            ),
                            SizedBox(
                              height: 4,
                            ),
                            Container(
                              alignment: Alignment.center,
                              margin: const EdgeInsets.symmetric(
                                horizontal: 20,
                              ),
                              height: 60,
                              width: MediaQuery.of(context).size.width * 0.6,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  border: Border.all(
                                    color: Color(0xaa45B8E8),
                                  )),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "   DRAGON   |  TIGER  |  LION  ",
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 15,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  SizedBox(
                                    height: 5,
                                  ),
                                  Container(
                                    margin: const EdgeInsets.symmetric(
                                        horizontal: 5),
                                    height: 20,
                                    width:
                                        MediaQuery.of(context).size.width * 0.7,
                                    child: Text(
                                      "   ${titleText.replaceAll('||', ',')}  |   ${detail2.replaceAll('||', ',')} |   ${detail3.replaceAll('||', ',')}  ",
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 7,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(
                              height: 8,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
               
                Positioned(
                      right:  MediaQuery.of(context).size.width  * 0.005,
                      top: 2,
                      child: InkWell(
                         onTap: () {
                     Navigator.pop(context);
                    HapticFeedback.vibrate();
                      
                  },
                        child: Image.asset(
                          "assets/User-interface/close-button.png",
                          scale: 4,
                        ),
                      ),
                    ),
                
              ],
            ),
          );
        });
  }

  static void showResultBollyWood(
    BuildContext context,
    cardImage1,
    roundId,
    details,
  ) {
    showDialog(
        context: context,
        builder: (_) {
          return AlertDialog(
            backgroundColor: Colors.transparent,
            content: Stack(
              alignment: Alignment.center,
              children: [
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.7,
                  width: MediaQuery.of(context).size.width * 0.4,
                  child: Stack(
                    children: [
                      Container(
                        margin: const EdgeInsets.symmetric(vertical: 22),
                        height: MediaQuery.of(context).size.height * 0.5,
                        width: MediaQuery.of(context).size.width * 0.4,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            image: DecorationImage(
                                image: AssetImage(
                                    "assets/bollywoodTable/current-result-background.png"),
                                fit: BoxFit.fitHeight)),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              children: [
                                SizedBox(
                                  height: 10,
                                ),
                                Container(
                                  margin: const EdgeInsets.symmetric(
                                    horizontal: 20,
                                  ),
                                  child: Text(
                                    "RESULT",
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 14,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Image.network(
                                  "http://admin.kalyanexch.com/images/cards/$cardImage1.png",
                                  height: 50,
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 5,
                            ),
                            Container(
                              margin: const EdgeInsets.symmetric(
                                horizontal: 20,
                              ),
                              child: Text(
                                "Round Id : $roundId",
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 12,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Container(
                              alignment: Alignment.center,
                              margin: const EdgeInsets.symmetric(
                                horizontal: 20,
                              ),
                              height: 50,
                              width: MediaQuery.of(context).size.width * 0.9,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  border: Border.all(
                                    color: Color(0xaa89560C),
                                  )),
                              child: Text(
                                details.replaceAll("||", "  |  "),
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 14,
                                    fontWeight: FontWeight.bold),
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
                
                Positioned(
                      right:  MediaQuery.of(context).size.width  * 0.005,
                      top: 2,
                      child: InkWell(
                         onTap: () {
                     Navigator.pop(context);
                    HapticFeedback.vibrate();
                      
                  },
                        child: Image.asset(
                          "assets/User-interface/close-button.png",
                          scale: 4,
                        ),
                      ),
                    ),
                
              ],
            ),
          );
        });
  }

  static void showResultBollyWoodPortrait(
    BuildContext context,
    cardImage1,
    roundId,
    details,
  ) {
    showDialog(
        context: context,
        builder: (_) {
          return AlertDialog(
            backgroundColor: Colors.transparent,
            content: Stack(
              alignment: Alignment.center,
              children: [
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.4,
                  width: MediaQuery.of(context).size.width * 0.9,
                  child: Stack(
                    children: [
                      Container(
                        margin: const EdgeInsets.symmetric(vertical: 22),
                        height: MediaQuery.of(context).size.height * 0.4,
                        width: MediaQuery.of(context).size.width * 0.62,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            image: DecorationImage(
                                image: AssetImage(
                                    "assets/bollywoodTable/current-result-background.png"),
                                fit: BoxFit.fitHeight)),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              children: [
                                SizedBox(
                                  height: 10,
                                ),
                                Container(
                                  margin: const EdgeInsets.symmetric(
                                    horizontal: 20,
                                  ),
                                  child: Text(
                                    "RESULT",
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 14,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Image.network(
                                  "http://admin.kalyanexch.com/images/cards/$cardImage1.png",
                                  height: 50,
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 5,
                            ),
                            Container(
                              margin: const EdgeInsets.symmetric(
                                horizontal: 20,
                              ),
                              child: Text(
                                "Round Id : $roundId",
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 12,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Container(
                              alignment: Alignment.center,
                              margin: const EdgeInsets.symmetric(
                                horizontal: 20,
                              ),
                              height: 50,
                              width: MediaQuery.of(context).size.width * 0.9,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  border: Border.all(
                                    color: Color(0xaa89560C),
                                  )),
                              child: Text(
                                details.replaceAll("||", "  |  "),
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 10,
                                    fontWeight: FontWeight.bold),
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
               
                Positioned(
                      right:  MediaQuery.of(context).size.width  * 0.005,
                      top: 2,
                      child: InkWell(
                         onTap: () {
                     Navigator.pop(context);
                    HapticFeedback.vibrate();
                      
                  },
                        child: Image.asset(
                          "assets/User-interface/close-button.png",
                          scale: 4,
                        ),
                      ),
                    ),
                
              ],
            ),
          );
        });
  }

}

class Appcolors {
  static const primaryColor = Color(0xfff87439);
  static const secondaryColor = Color(0xff012060);
  static const whiteColor = Color.fromARGB(255, 243, 243, 245);
}
