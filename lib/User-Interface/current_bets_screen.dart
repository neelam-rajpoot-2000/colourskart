import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:vibration/vibration.dart';
import 'package:virtual_casino/data/model/current_bet_model.dart';

import '../Utils/api_helper.dart';
import '../Utils/apis.dart';

class CurrentBetsScreen extends StatefulWidget {
  bool? playBackgroundMusic=false;
   CurrentBetsScreen({super.key, playBackgroundMusic});

  @override
  State<CurrentBetsScreen> createState() => _CurrentBetsScreenState();
}

class _CurrentBetsScreenState extends State<CurrentBetsScreen> {
  double height = 0;
  double width = 0;
  String entries = "25";
  bool loading = false;
  bool allButton = true;
  bool backButton = false;
  bool layButton = false;
  List<CurrentBetsModel> currentBetList = [];

  List listNames = [
    {"unit": "25", "action": true},
    {"unit": "50", "action": true},
    {"unit": "100", "action": true},
    {"unit": "200", "action": true},
    {"unit": "500", "action": true},
  ];
  @override
  void initState() {
    getCurrentBetDetails();
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.landscapeLeft,
      DeviceOrientation.portraitUp,
      DeviceOrientation.landscapeRight,
    ]);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    height = MediaQuery.of(context).size.height;
    width = MediaQuery.of(context).size.width;
    return Scaffold(body: OrientationBuilder(builder: (context, oreintation) {
      if (oreintation == Orientation.landscape) {
        return landscapeWidget();
      } else {
        return portraitMode();
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
          SizedBox(
            height: 10,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SizedBox(),
              Text(
                "Current Unsettle Bets",
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.bold),
              ),
              GestureDetector(
                onTap: () {
                       widget.playBackgroundMusic == false
                              ? ''
                              :  Vibration.vibrate();
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
              )
            ],
          ),
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    GestureDetector(
                      onTap: () {
                             widget.playBackgroundMusic == false
                              ? ''
                              :  Vibration.vibrate();
                        setState(() {
                          allButton = true;
                          backButton = false;
                          layButton = false;
                        });
                        getCurrentBetDetails();
                      },
                      child: Column(
                        children: [
                          Text(
                            'All',
                            style: TextStyle(color: Colors.white, fontSize: 18),
                          ),
                          allButton == true
                              ? SizedBox(
                                  height: 5,
                                  width: width * 0.1,
                                  child: Divider(
                                    thickness: 3,
                                    color: Color(0xaaFAD461),
                                  ),
                                )
                              : SizedBox(),
                        ],
                      ),
                    ),
                    SizedBox(
                      width: 40,
                    ),
                    GestureDetector(
                      onTap: () {
                             widget.playBackgroundMusic == false
                              ? ''
                              :  Vibration.vibrate();
                        setState(() {
                          allButton = false;
                          backButton = true;
                          layButton = false;
                        });
                        getCurrentBetDetails();
                      },
                      child: Column(
                        children: [
                          Text(
                            'Back',
                            style: TextStyle(color: Colors.white, fontSize: 18),
                          ),
                          backButton == true
                              ? SizedBox(
                                  height: 5,
                                  width: width * 0.1,
                                  child: Divider(
                                    thickness: 3,
                                    color: Color(0xaaFAD461),
                                  ),
                                )
                              : SizedBox(),
                        ],
                      ),
                    ),
                    SizedBox(
                      width: 40,
                    ),
                    InkWell(
                      onTap: () {
                             widget.playBackgroundMusic == false
                              ? ''
                              :  Vibration.vibrate();
                        setState(() {
                          allButton = false;
                          backButton = false;
                          layButton = true;
                        });
                        getCurrentBetDetails();
                      },
                      child: Column(
                        children: [
                          Text(
                            'Lay',
                            style: TextStyle(color: Colors.white, fontSize: 18),
                          ),
                          layButton == true
                              ? SizedBox(
                                  height: 5,
                                  width: width * 0.1,
                                  child: Divider(
                                    thickness: 3,
                                    color: Color(0xaaFAD461),
                                  ),
                                )
                              : SizedBox(),
                        ],
                      ),
                    ),
                  ],
                ),

                // Container(
                //   margin: const EdgeInsets.symmetric(),
                //   child: Row(
                //     children: [
                //       Container(
                //         alignment: Alignment.center,
                //         height: 20,
                //         width: 20,
                //         decoration: BoxDecoration(
                //             border: Border.all(color: Colors.white),
                //             borderRadius: BorderRadius.circular(100)),
                //         child: Container(
                //           height: 13,
                //           width: 13,
                //           decoration: BoxDecoration(
                //               color: Colors.blue,
                //               border: Border.all(color: Colors.white),
                //               borderRadius: BorderRadius.circular(100)),
                //         ),
                //       ),
                //       SizedBox(
                //         width: 10,
                //       ),
                //       Text(
                //         "Matched",
                //         style: TextStyle(color: Colors.white, fontSize: 14),
                //       ),
                //       SizedBox(
                //         width: 30,
                //       ),
                //       Container(
                //         alignment: Alignment.center,
                //         height: 20,
                //         width: 20,
                //         decoration: BoxDecoration(
                //             border: Border.all(color: Colors.white),
                //             borderRadius: BorderRadius.circular(100)),
                //         child: Container(
                //           height: 13,
                //           width: 13,
                //           decoration: BoxDecoration(
                //               color: Colors.black,
                //               border: Border.all(color: Colors.white),
                //               borderRadius: BorderRadius.circular(100)),
                //         ),
                //       ),
                //       SizedBox(
                //         width: 10,
                //       ),
                //       Text(
                //         "Deleted",
                //         style: TextStyle(color: Colors.white, fontSize: 14),
                //       ),
                //     ],
                //   ),
                // ),

                Container(
                  margin:
                      const EdgeInsets.symmetric(horizontal: 0, vertical: 20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Text(
                            "Show",
                            style: TextStyle(color: Colors.white),
                          ),
                          SizedBox(
                            width: 3,
                          ),
                          Container(
                            decoration: BoxDecoration(
                                border: Border.all(color: Colors.white),
                                borderRadius: BorderRadius.circular(4)),
                            width: width * 0.15,
                            height: height * 0.1,
                            child: DropdownButton(
                              underline: const SizedBox(),
                              dropdownColor: Colors.black,
                              value: entries,
                              icon: const Icon(
                                Icons.keyboard_arrow_down,
                                color: Colors.white,
                              ),
                              items: listNames.map((items) {
                                return DropdownMenuItem(
                                  value: items['unit'],
                                  child: SizedBox(
                                    height: height * 0.09,
                                    width: width * 0.11,
                                    child: Container(
                                      margin: const EdgeInsets.symmetric(
                                          horizontal: 10),
                                      alignment: Alignment.centerLeft,
                                      child: Text(
                                        items['unit'],
                                        style: TextStyle(color: Colors.white),
                                      ),
                                    ),
                                  ),
                                );
                              }).toList(),
                              // After selecting the desired option,it will
                              // change button value to selected value
                              onChanged: (newValue) {
                                setState(() {
                                  entries = newValue.toString();
                                });
                                getCurrentBetDetails();
                              },
                            ),
                          ),
                          SizedBox(
                            width: 5,
                          ),
                          Text(
                            "Entries",
                            style: TextStyle(color: Colors.white),
                          ),
                          SizedBox(
                            width: 10,
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 0),
            width: width,
            height: 40,
            color: Color(0xaa292929),
            child: Row(
              children: [
                Container(
                        width: width / 16,
                  margin: const EdgeInsets.symmetric(horizontal: 4),
                  child: Text("Sports",
                  textAlign: TextAlign.center,

                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 13,
                      )),
                ),
              
                Container(
                        width: width / 5,
                  margin: const EdgeInsets.symmetric(horizontal: 4),
                  child: Text("Event Name",
                  textAlign: TextAlign.center,

                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 13,
                      )),
                ),
               
                Container(
                        width: width / 7,
                  margin: const EdgeInsets.symmetric(horizontal: 4),
                  child: Text("Market Name",
                  textAlign: TextAlign.center,

                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 13,
                      )),
                ),
              
                Container(
                        width: width / 9,
                  margin: const EdgeInsets.symmetric(horizontal: 4),
                  child: Text("Nation",
                  textAlign: TextAlign.center,

                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 13,
                      )),
                ),
              
                Container(
                        width: width / 9,
                  margin: const EdgeInsets.symmetric(horizontal: 4),
                  child: Text("User Rate",
                  textAlign: TextAlign.center,

                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 13,
                      )),
                ),
               
                Container(
                        width: width / 8,
                  margin: const EdgeInsets.symmetric(horizontal: 1),
                  child: Text("Amount",
                  textAlign: TextAlign.center,

                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 13,
                      )),
                ),
               
                Container(
                        width: width / 9,
                  margin: const EdgeInsets.symmetric(horizontal: 1),
                  child: Text("Place Date",
                  textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 13,
                      )),
                ),
             
              ],
            ),
          ),
          loading == true
              ? Column(
                  children: const [
                    Text(
                      "Loading....",
                      style: TextStyle(color: Colors.white),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    CircularProgressIndicator(
                      color: Colors.white,
                    ),
                  ],
                )
              : currentBetList.isEmpty
                  ? Text(
                      "No data Found !!",
                      style: TextStyle(color: Colors.white),
                    )
                  : SizedBox(
                      height: height * 0.5,
                      width: width,
                      child: ListView.builder(
                          itemCount: currentBetList.length,
                          itemBuilder: (context, index) {
                            var items = currentBetList[index];
                            return Column(
                              children: [
                                Row(
                                  children: [
                                    Container(
                                      width: width /16,
                                      margin: const EdgeInsets.symmetric(
                                          horizontal: 4),
                                      child: Text(items.sportName.toString(),
                                      textAlign: TextAlign.center,
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 11,
                                          )),
                                    ),
                                
                                    Container(
                                    width: width / 5,
                                      margin: const EdgeInsets.symmetric(
                                          horizontal: 4),
                                      child: Text(items.eventName.toString(),
                                         textAlign: TextAlign.center,
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 11,
                                          )),
                                    ),
                                 
                                    Container(
                                  width: width / 8,
                                      margin: const EdgeInsets.symmetric(
                                          horizontal: 4),
                                      child: Text(items.marketname.toString(),
                                         textAlign: TextAlign.center,
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 11,
                                          )),
                                    ),
                                 
                                    Container(
                                         width: width / 7,
                                      margin: const EdgeInsets.symmetric(
                                          horizontal: 4),
                                      child: Text(items.nation.toString(),
                                         textAlign: TextAlign.center,
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 11,
                                          )),
                                    ),
                                  
                                    Container(
                               width: width / 12,
                                      margin: const EdgeInsets.symmetric(
                                          horizontal: 4),
                                      child: Text(items.rate.toString(),
                                         textAlign: TextAlign.center,
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 11,
                                          )),
                                    ),
                                
                                    Container(
                                      alignment: Alignment.center,
                                     width: width / 7,
                                      margin: const EdgeInsets.symmetric(
                                          horizontal: 1),
                                      child: Text(items.amount.toString(),
                                         textAlign: TextAlign.center,
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 11,
                                          )),
                                    ),
                                 
                                    Container(
                                      alignment: Alignment.center,
                                    
                                      margin: const EdgeInsets.symmetric(
                                          horizontal: 1),
                                      child: Text(items.time.toString(),
                                         textAlign: TextAlign.center,
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 11,
                                          )),
                                    ),
                                   
                                  ],
                                ),
                                Divider(
                                  color: Color(0xaa2E2E2E),
                                  thickness: 1,
                                ),
                              ],
                            );
                          }),
                    ),
        ],
      ),
    ));
  }

  Widget portraitMode() {
    return SingleChildScrollView(
        child: Container(
      height: height,
      width: width,
      decoration: BoxDecoration(color: Colors.black),
      child: Column(
        children: [
          SizedBox(
            height: 10,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SizedBox(),
              Text(
                "Current Bets",
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.bold),
              ),
              GestureDetector(
                onTap: () {
                       widget.playBackgroundMusic == false
                              ? ''
                              :  Vibration.vibrate();
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
              )
            ],
          ),
          SizedBox(
            height: 20,
          ),
          // Container(
          //   margin: const EdgeInsets.symmetric(horizontal: 20),
          //   child: Row(
          //     mainAxisAlignment: MainAxisAlignment.start,
          //     children: [
          //       Container(
          //         alignment: Alignment.center,
          //         height: 20,
          //         width: 20,
          //         decoration: BoxDecoration(
          //             border: Border.all(color: Colors.white),
          //             borderRadius: BorderRadius.circular(100)),
          //         child: Container(
          //           height: 13,
          //           width: 13,
          //           decoration: BoxDecoration(
          //               color: Colors.blue,
          //               border: Border.all(color: Colors.white),
          //               borderRadius: BorderRadius.circular(100)),
          //         ),
          //       ),
          //       SizedBox(
          //         width: 10,
          //       ),
          //       Text(
          //         "Matched",
          //         style: TextStyle(color: Colors.white, fontSize: 14),
          //       ),
          //       SizedBox(
          //         width: 30,
          //       ),
          //       Container(
          //         alignment: Alignment.center,
          //         height: 20,
          //         width: 20,
          //         decoration: BoxDecoration(
          //             border: Border.all(color: Colors.white),
          //             borderRadius: BorderRadius.circular(100)),
          //         child: Container(
          //           height: 13,
          //           width: 13,
          //           decoration: BoxDecoration(
          //               color: Colors.black,
          //               border: Border.all(color: Colors.white),
          //               borderRadius: BorderRadius.circular(100)),
          //         ),
          //       ),
          //       SizedBox(
          //         width: 10,
          //       ),
          //       Text(
          //         "Deleted",
          //         style: TextStyle(color: Colors.white, fontSize: 14),
          //       ),
          //     ],
          //   ),
          // ),

          SizedBox(
            height: 20,
          ),
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Row(
                  children: [
                    GestureDetector(
                      onTap: () {
                             widget.playBackgroundMusic == false
                              ? ''
                              :  Vibration.vibrate();
                        setState(() {
                          allButton = true;
                          backButton = false;
                          layButton = false;
                        });
                        getCurrentBetDetails();
                      },
                      child: Column(
                        children: [
                          Text(
                            'All',
                            style: TextStyle(color: Colors.white, fontSize: 18),
                          ),
                          allButton == true
                              ? SizedBox(
                                  height: 5,
                                  width: width * 0.1,
                                  child: Divider(
                                    thickness: 3,
                                    color: Color(0xaaFAD461),
                                  ),
                                )
                              : SizedBox(),
                        ],
                      ),
                    ),
                    SizedBox(
                      width: 40,
                    ),
                    GestureDetector(
                      onTap: () {
                             widget.playBackgroundMusic == false
                              ? ''
                              :  Vibration.vibrate();
                        setState(() {
                          allButton = false;
                          backButton = true;
                          layButton = false;
                        });
                        getCurrentBetDetails();
                      },
                      child: Column(
                        children: [
                          Text(
                            'Back',
                            style: TextStyle(color: Colors.white, fontSize: 18),
                          ),
                          backButton == true
                              ? SizedBox(
                                  height: 5,
                                  width: width * 0.1,
                                  child: Divider(
                                    thickness: 3,
                                    color: Color(0xaaFAD461),
                                  ),
                                )
                              : SizedBox(),
                        ],
                      ),
                    ),
                    SizedBox(
                      width: 40,
                    ),
                    InkWell(
                      onTap: () {
                             widget.playBackgroundMusic == false
                              ? ''
                              :  Vibration.vibrate();
                        setState(() {
                          allButton = false;
                          backButton = false;
                          layButton = true;
                        });
                        getCurrentBetDetails();
                      },
                      child: Column(
                        children: [
                          Text(
                            'Lay',
                            style: TextStyle(color: Colors.white, fontSize: 18),
                          ),
                          layButton == true
                              ? SizedBox(
                                  height: 5,
                                  width: width * 0.1,
                                  child: Divider(
                                    thickness: 3,
                                    color: Color(0xaaFAD461),
                                  ),
                                )
                              : SizedBox(),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Text(
                      "Show",
                      style: TextStyle(color: Colors.white),
                    ),
                    SizedBox(
                      width: 3,
                    ),
                    Container(
                      decoration: BoxDecoration(
                          border: Border.all(color: Colors.white),
                          borderRadius: BorderRadius.circular(4)),
                      width: width * 0.5,
                      height: height * 0.06,
                      child: DropdownButton(
                        underline: const SizedBox(),
                        dropdownColor: Colors.black,
                        value: entries,
                        icon: const Icon(
                          Icons.keyboard_arrow_down,
                          color: Colors.white,
                        ),
                        items: listNames.map((items) {
                          return DropdownMenuItem(
                            value: items['unit'],
                            child: SizedBox(
                              height: height * 0.09,
                              width: width * 0.4,
                              child: Container(
                                margin:
                                    const EdgeInsets.symmetric(horizontal: 10),
                                alignment: Alignment.centerLeft,
                                child: Text(
                                  items['unit'],
                                  style: TextStyle(color: Colors.white),
                                ),
                              ),
                            ),
                          );
                        }).toList(),
                        // After selecting the desired option,it will
                        // change button value to selected value
                        onChanged: (newValue) {
                          setState(() {
                            entries = newValue.toString();
                          });
                          getCurrentBetDetails();
                        },
                      ),
                    ),
                    SizedBox(
                      width: 5,
                    ),
                    Text(
                      "Entries",
                      style: TextStyle(color: Colors.white),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                  ],
                ),
              ],
            ),
          ),
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 0),
            width: width,
            height: 40,
            color: Color(0xaa292929),
            child: Row(
              children: [
                Container(
                  margin: const EdgeInsets.symmetric(horizontal: 2),
                  child: Text("Sports",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 12,
                      )),
                ),
              
                Container(
                  width: width /5,
                  margin: const EdgeInsets.symmetric(horizontal: 2),
                  child: Text("Event Name",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 13,
                      )),
                ),
             
                Container(
               width: width /5,
                  margin: const EdgeInsets.symmetric(horizontal: 2),
                  child: Text("Market Name",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 13,
                      )),
                ),
               
                Container(
                    width: width /6,
                  margin: const EdgeInsets.symmetric(horizontal: 2),
                  child: Text("Nation",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 12,
                      )),
                ),
              
                Container(
                    width: width /10,
                  margin: const EdgeInsets.symmetric(horizontal: 2),
                  child: Text("User Rate",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 12,
                      )),
                ),
               
                Container(
                    width: width /7,
                  margin: const EdgeInsets.symmetric(horizontal: 1),
                  child: Text("Amount",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 12,
                      )),
                ),
              
              ],
            ),
          ),
          SizedBox(
            height: 10,
          ),
          loading == true
              ? Column(
                  children: const [
                    Text(
                      "Loading....",
                      style: TextStyle(color: Colors.white),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    CircularProgressIndicator(
                      color: Colors.white,
                    ),
                  ],
                )
              : currentBetList.isEmpty
                  ? Text(
                      "No data Found !!",
                      style: TextStyle(color: Colors.white),
                    )
                  : SizedBox(
                      height: height * 0.6,
                      width: width,
                      child: ListView.builder(
                          itemCount: currentBetList.length,
                          itemBuilder: (context, index) {
                            var items = currentBetList[index];
                            return Column(
                              children: [
                             
                                Row(
                                  children: [
                                    Container(
                                      width: width/13,
                                      margin: const EdgeInsets.symmetric(
                                          horizontal: 4),
                                      child: Text(items.sportName.toString(),
                                         textAlign: TextAlign.center,
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 9,
                                          )),
                                    ),
                                 
                                    Container(
                                    width: width/5,
                                      margin: const EdgeInsets.symmetric(
                                          horizontal: 4),
                                      child: Text(items.eventName.toString(),
                                         textAlign: TextAlign.center,
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 9,
                                          )),
                                    ),
                                
                                    Container(
                                       width: width/5,
                                      margin: const EdgeInsets.symmetric(
                                          horizontal: 4),
                                      child: Text(items.marketname.toString(),
                                         textAlign: TextAlign.center,
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 9,
                                          )),
                                    ),
                                 
                                    Container(
                                     width: width/7,
                                      margin: const EdgeInsets.symmetric(
                                          horizontal: 4),
                                      child: Text(items.nation.toString(),
                                      textAlign: TextAlign.center,
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 9,
                                          )),
                                    ),
                                  
                                    Container(
                                   width: width/10,
                                      margin: const EdgeInsets.symmetric(
                                          horizontal: 4),
                                      child: Text(items.rate.toString(),
                                         textAlign: TextAlign.center,
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 9,
                                          )),
                                    ),
                                  
                                    Container(
                                      alignment: Alignment.center,
                          width: width/7,
                                      margin: const EdgeInsets.symmetric(
                                          horizontal: 1),
                                      child: Text(items.amount.toString(),
                                         textAlign: TextAlign.center,
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 9,
                                          )),
                                    ),
                                  ],
                                ),
                                Divider(
                                  color: Color(0xaa2E2E2E),
                                  thickness: 1,
                                ),
                              ],
                            );
                          }),
                    ),
        ],
      ),
    ));
  }

  //-------------API Call----------------//

  Future getCurrentBetDetails() async {
    setState(() {
      loading = true;
    });
    var url = Apis.unsettledBetsApi;
    var body = {
      "betType": allButton == true
          ? "1"
          : backButton == true
              ? "2"
              : layButton == true
                  ? "3"
                  : "",
      "noOfRecords": int.parse(entries),
      "sportType": 2,
      "index": 0,
      "isDeleted": false
    };
    var response = await GlobalFunction.apiPostRequestToken(url, body);
    var result = jsonDecode(response);
    if (result['status'] == true) {
      var list = result['data']['dataList'] as List;
      setState(() {
        currentBetList.clear();
        var listdata = list.map((e) => CurrentBetsModel.fromJson(e)).toList();
        currentBetList.addAll(listdata);
        loading = false;
      });
    } else {
      setState(() {
        loading = false;
      });
    }
    setState(() {
      loading = false;
    });
  }
}
