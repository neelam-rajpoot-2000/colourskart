// ignore_for_file: use_build_context_synchronously
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:share_plus/share_plus.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:virtual_casino/AmarAkhbarAnthony/amar_play_room.dart';
import 'package:virtual_casino/DragonTigerLion/dragon_l_playroom.dart';
import 'package:virtual_casino/Lucky7/lucky_play_room.dart';
import 'package:virtual_casino/Teen-Patti/teen_patti_play_room.dart';
import 'package:virtual_casino/User-Interface/change_passswod_screen.dart';
import 'package:virtual_casino/User-Interface/current_bets_screen.dart';
import 'package:virtual_casino/User-Interface/my_account.dart';
import 'package:virtual_casino/User-Interface/profile_screen.dart';
import 'package:virtual_casino/User-Interface/signin_screen.dart';
import 'package:virtual_casino/User-Interface/withdraw_screen.dart';
import 'package:virtual_casino/Utils/api_helper.dart';
import 'package:virtual_casino/Utils/apis.dart';
import 'package:virtual_casino/data/model/gamelist_model.dart';

import '../BollyWoodTable/bolllywood_playroom.dart';
import '../DragonTiger/dragon_tiger_play_room.dart';
import '../OneVirtualTeenPatti/one_virtual_teen_patti.dart';
import 'add_cash_screen.dart';

class DashBoardScreen extends StatefulWidget {
  const DashBoardScreen({
    Key? key,
  }) : super(key: key);

  @override
  State<DashBoardScreen> createState() => _DashBoardScreenState();
}

class _DashBoardScreenState extends State<DashBoardScreen>
    with WidgetsBindingObserver {
  var gameSound = "assets/Teen-patti/audio/bgm.mp3";
  double height = 0;
  double width = 0;
  List<GameListModel> gameList = [];
  final GlobalKey<ScaffoldState> _globalKey = GlobalKey<ScaffoldState>();
  double mainBalance = 0;
  String userBalance = "";
  String liablity = "";
  String userName = "";

  @override
  void initState() {
    getuserBalance();
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.landscapeLeft,
      DeviceOrientation.landscapeRight,
      DeviceOrientation.portraitUp,
    ]);
    getGameListDetails();
    super.initState();
  }

  shareApp() async {
    await Share.share("This is for test", subject: "");
  }

  @override
  Widget build(BuildContext context) {
    height = MediaQuery.of(context).size.height;
    width = MediaQuery.of(context).size.width;

    return Scaffold(
        key: _globalKey,
        drawerEnableOpenDragGesture: false,
        drawer: Drawer(
          child: drawerWidget(),
        ),
        body: OrientationBuilder(builder: (context, oreintation) {
          if (oreintation == Orientation.landscape) {
            return landscapeWidget();
          } else {
            return potraitMode();
          }
        }));
  }

  Widget potraitMode() {
    return SingleChildScrollView(
      child: Container(
        height: height,
        width: width,
        decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage("assets/User-interface/dashboard.png"),
                fit: BoxFit.fitHeight)),
        child: SizedBox(
          height: height,
          width: width,
          child: Column(
            children: [
              headerWidgetPortrait(),
              bodyWidgetPortrait(),
              bottomWidgetPortrait(),
            ],
          ),
        ),
      ),
    );
  }

  Widget landscapeWidget() {
    return SingleChildScrollView(
      child: Container(
        height: height,
        width: width,
        decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage("assets/User-interface/dashboard.png"),
                fit: BoxFit.fitHeight)),
        child: SizedBox(
          height: height,
          width: width,
          child: Column(
            children: [
              headerWidget(),
              bodyWidget(),
              bottomWidget(),
            ],
          ),
        ),
      ),
    );
  }

  Widget headerWidget() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        SizedBox(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              InkWell(
                onTap: () {
                  _globalKey.currentState!.openDrawer();
                },
                child: Container(
                  margin:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                  alignment: Alignment.center,
                  height: 40,
                  width: 30,
                  child: Image.asset(
                    "assets/User-interface/Buttons/menu-button.png",
                    scale: 0.7,
                  ),
                ),
              ),
              Container(
                alignment: Alignment.center,
                height: 50,
                width: 100,
                decoration: BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage(
                        "assets/User-interface/user-name.png",
                      ),
                      scale: 0.1),
                ),
                child: Text(
                  userName,
                  style: TextStyle(color: Colors.white, fontSize: 10),
                ),
              ),
              SizedBox(
                width: 20,
              ),
            ],
          ),
        ),
        Container(
          alignment: Alignment.center,
          height: 50,
          width: 180,
          decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage(
                  "assets/User-interface/user_amount.png",
                ),
                scale: 0.1),
          ),
          child: Padding(
            padding: const EdgeInsets.only(left: 8.0),
            child: Text(
              userBalance,
              style: TextStyle(color: Colors.white),
            ),
          ),
        ),
        // Row(
        //   children: [
        //     InkWell(
        //       onTap: () {
        //         // _globalKey.currentState!.openDrawer();
        //       },
        //       child: Container(
        //         margin:
        //             const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
        //         alignment: Alignment.center,
        //         height: 60,
        //         width: 60,
        //         child: Image.asset(
        //           "assets/User-interface/dashboard-icons/free-spin.png",
        //           scale: 1,
        //         ),
        //       ),
        //     ),
        //     InkWell(
        //       onTap: () {
        //         // _globalKey.currentState!.openDrawer();
        //       },
        //       child: Container(
        //         margin:
        //             const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
        //         alignment: Alignment.center,
        //         height: 60,
        //         width: 60,
        //         child: Image.asset(
        //           "assets/User-interface/dashboard-icons/achievement.png",
        //           scale: 1,
        //         ),
        //       ),
        //     ),
        //     InkWell(
        //       onTap: () {
        //         // _globalKey.currentState!.openDrawer();
        //       },
        //       child: Container(
        //         margin:
        //             const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
        //         alignment: Alignment.center,
        //         height: 60,
        //         width: 60,
        //         child: Image.asset(
        //           "assets/User-interface/dashboard-icons/cash-image.png",
        //           scale: 1,
        //         ),
        //       ),
        //     ),
        //     InkWell(
        //       onTap: () {},
        //       child: Container(
        //         margin:
        //             const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
        //         alignment: Alignment.center,
        //         height: 60,
        //         width: 60,
        //         child: Image.asset(
        //           "assets/User-interface/dashboard-icons/invite-image.png",
        //           scale: 1,
        //         ),
        //       ),
        //     ),
        //     InkWell(
        //       onTap: () {},
        //       child: Container(
        //         margin:
        //             const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
        //         alignment: Alignment.center,
        //         height: 60,
        //         width: 60,
        //         child: Image.asset(
        //           "assets/User-interface/dashboard-icons/invite2-image.png",
        //           scale: 1,
        //         ),
        //       ),
        //     ),
        //   ],
        // ),
      ],
    );
  }

  Widget headerWidgetPortrait() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            InkWell(
              onTap: () {
                _globalKey.currentState!.openDrawer();
              },
              child: Container(
                margin:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                alignment: Alignment.center,
                height: 40,
                width: 40,
                child: Image.asset(
                  "assets/User-interface/Buttons/menu-button.png",
                  scale: 0.7,
                ),
              ),
            ),
            Container(
              alignment: Alignment.center,
              height: 70,
              width: 120,
              decoration: BoxDecoration(
                image: DecorationImage(
                    image: AssetImage(
                      "assets/User-interface/user-name.png",
                    ),
                    scale: 0.1),
              ),
              child: Text(
                userName,
                style: TextStyle(color: Colors.white, fontSize: 10),
              ),
            ),
            SizedBox(
              width: 45,
            ),
            Container(
              alignment: Alignment.center,
              height: 40,
              width: 160,
              decoration: BoxDecoration(
                image: DecorationImage(
                    image: AssetImage(
                      "assets/User-interface/user_amount.png",
                    ),
                    fit: BoxFit.fitWidth,
                    scale: 0.1),
              ),
              child: Padding(
                padding: const EdgeInsets.only(left: 10.0),
                child: Text(
                  userBalance,
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ),
          ],
        ),
        // Row(
        //   children: [
        //     InkWell(
        //       onTap: () {
        //         // _globalKey.currentState!.openDrawer();
        //       },
        //       child: Container(
        //         margin:
        //             const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
        //         alignment: Alignment.center,
        //         height: 60,
        //         width: 60,
        //         child: Image.asset(
        //           "assets/User-interface/dashboard-icons/free-spin.png",
        //           scale: 1,
        //         ),
        //       ),
        //     ),
        //     InkWell(
        //       onTap: () {
        //         // _globalKey.currentState!.openDrawer();
        //       },
        //       child: Container(
        //         margin:
        //             const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
        //         alignment: Alignment.center,
        //         height: 60,
        //         width: 60,
        //         child: Image.asset(
        //           "assets/User-interface/dashboard-icons/achievement.png",
        //           scale: 1,
        //         ),
        //       ),
        //     ),
        //     InkWell(
        //       onTap: () {
        //         // _globalKey.currentState!.openDrawer();
        //       },
        //       child: Container(
        //         margin:
        //             const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
        //         alignment: Alignment.center,
        //         height: 60,
        //         width: 60,
        //         child: Image.asset(
        //           "assets/User-interface/dashboard-icons/cash-image.png",
        //           scale: 1,
        //         ),
        //       ),
        //     ),
        //     InkWell(
        //       onTap: () {},
        //       child: Container(
        //         margin:
        //             const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
        //         alignment: Alignment.center,
        //         height: 60,
        //         width: 60,
        //         child: Image.asset(
        //           "assets/User-interface/dashboard-icons/invite-image.png",
        //           scale: 1,
        //         ),
        //       ),
        //     ),
        //     InkWell(
        //       onTap: () {},
        //       child: Container(
        //         margin:
        //             const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
        //         alignment: Alignment.center,
        //         height: 60,
        //         width: 60,
        //         child: Image.asset(
        //           "assets/User-interface/dashboard-icons/invite2-image.png",
        //           scale: 1,
        //         ),
        //       ),
        //     ),
        //   ],
        // ),
      ],
    );
  }

  Widget bodyWidget() {
    return Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Container(
        alignment: Alignment.center,
        height: height * 0.6,
        width: width * 0.2,
        child: Image.asset("assets/User-interface/bet-girl.png"),
      ),
      SizedBox(
          height: height * 0.55,
          width: width * 0.8,
          child: GridView.builder(
              itemCount: gameList.length,
              scrollDirection: Axis.horizontal,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2, crossAxisSpacing: 10, mainAxisSpacing: 15),
              itemBuilder: (BuildContext context, int index) {
                var items = gameList[index];
                return InkWell(
                    onTap: () {
                      if (items.gameId == 15) {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => TeenPattiPlayRoom(
                                      matchID: items.gameId.toString(),
                                      gameCode: items.gameCode.toString(),
                                    )));
                      }
                      if (items.gameId == 12) {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => PlayRoomLucky7Screen(   matchId: items.gameId.toString(),
                                      gameCode: items.gameCode.toString(),)));
                      }
                      if (items.gameId == 20) {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => AmarPlayRoom(
                                      matchId: items.gameId.toString(),
                                      gameCode: items.gameCode.toString(),
                                    )));
                      }
                      if (items.gameId == 31) {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => DragonTigerLionPlayRoom(
                                     matchID: items.gameId.toString(),
                                      gameCode: items.gameCode.toString(),
                                    )));
                      }
                                if (items.gameId == 14) {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => DragonTigerPlayRoom(
                                          matchId: items.gameId.toString(),
                                      gameCode: items.gameCode.toString(),
                                    )));
                      }
                        if (items.gameId == 24) {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => OpenVertualTeenPAtti(
                                          matchId: items.gameId.toString(),
                                      gameCode: items.gameCode.toString(),
                                    )));
                      }
                         if (items.gameId == 13) {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => BollyWoodTablePlayRoom(
                                      matchID: items.gameId.toString(),
                                      gameCode: items.gameCode.toString(),
                                    )));
                      }
                    },
                    child: Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(
                              color: Color.fromARGB(255, 226, 109, 25)),
                          image: DecorationImage(
                              image: NetworkImage(items.imageUrl.toString()),
                              fit: BoxFit.fill)),
                      // child: Center(
                      //     child: Text(
                      //   '${items.gameName}',
                      //   style: TextStyle(
                      //       color: Colors.white,
                      //       fontSize: 13,
                      //       fontWeight: FontWeight.bold),
                      //   textAlign: TextAlign.center,
                      // )),
                    ));
              }))
    ]);
  }

  Widget bodyWidgetPortrait() {
    return Column(crossAxisAlignment: CrossAxisAlignment.center, children: [
      Container(
        alignment: Alignment.center,
        height: height * 0.28,
        width: width * 0.8,
        child: Image.asset("assets/User-interface/bet-girl.png"),
      ),
      SizedBox(
          height: height * 0.42,
          width: width * 0.8,
          child: GridView.builder(
              itemCount: gameList.length,
              scrollDirection: Axis.vertical,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  childAspectRatio: 01.4,
                  crossAxisCount: 3,
                  crossAxisSpacing: 10,
                  mainAxisSpacing: 15),
              itemBuilder: (BuildContext context, int index) {
                var items = gameList[index];
                return InkWell(
                    onTap: () {
                      if (items.gameId == 15) {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => TeenPattiPlayRoom(
                                      matchID: items.gameId.toString(),
                                      gameCode: items.gameCode.toString(),
                                    )));
                      }
                      if (items.gameId == 12) {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => PlayRoomLucky7Screen(
                                       matchId: items.gameId.toString(),
                                      gameCode: items.gameCode.toString(),
                                )));
                      }
                      if (items.gameId == 20) {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => AmarPlayRoom(
                                      matchId: items.gameId.toString(),
                                      gameCode: items.gameCode.toString(),
                                    )));
                      }
                      if (items.gameId == 31) {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => DragonTigerLionPlayRoom(
                                          matchID: items.gameId.toString(),
                                      gameCode: items.gameCode.toString(),
                                    )));
                      }
                       if (items.gameId == 14) {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => DragonTigerPlayRoom(
                                          matchId: items.gameId.toString(),
                                      gameCode: items.gameCode.toString(),
                                    )));
                      }
                        if (items.gameId == 24) {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => OpenVertualTeenPAtti(
                                          matchId: items.gameId.toString(),
                                      gameCode: items.gameCode.toString(),
                                    )));

                                    
                      }
                         if (items.gameId == 13) {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => BollyWoodTablePlayRoom(
                                      matchID: items.gameId.toString(),
                                      gameCode: items.gameCode.toString(),
                                    )));
                      }
                    },
                    child: Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(
                              color: Color.fromARGB(255, 226, 109, 25)),
                          image: DecorationImage(
                              image: NetworkImage(items.imageUrl.toString()),
                              fit: BoxFit.fill)),
                    ));
              }))
    ]);
  }

  Widget bottomWidget() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Container(
          margin: const EdgeInsets.symmetric(horizontal: 10),
          child: Row(
            children: [
              // InkWell(
              //   onTap: () {
              //     // _globalKey.currentState!.openDrawer();
              //   },
              //   child: Container(
              //     margin: const EdgeInsets.only(left: 0, top: 30),
              //     alignment: Alignment.center,
              //     height: 40,
              //     width: 40,
              //     child: Image.asset(
              //       "assets/User-interface/dashboard-icons/help-icon.png",
              //       scale: 1,
              //     ),
              //   ),
              // ),
              // InkWell(
              //   onTap: () {
              //     // _globalKey.currentState!.openDrawer();
              //   },
              //   child: Container(
              //     margin: const EdgeInsets.only(left: 5, top: 30),
              //     alignment: Alignment.center,
              //     height: 40,
              //     width: 40,
              //     child: Image.asset(
              //       "assets/User-interface/dashboard-icons/headphone-icon.png",
              //       scale: 1,
              //     ),
              //   ),
              // ),
              // InkWell(
              //   onTap: () {
              //     // _globalKey.currentState!.openDrawer();
              //   },
              //   child: Container(
              //     margin: const EdgeInsets.only(left: 5, top: 30),
              //     alignment: Alignment.center,
              //     height: 40,
              //     width: 40,
              //     child: Image.asset(
              //       "assets/User-interface/dashboard-icons/gift-icon.png",
              //       scale: 1,
              //     ),
              //   ),
              // ),
              // InkWell(
              //   onTap: () {
              //     // _globalKey.currentState!.openDrawer();
              //   },
              //   child: Container(
              //     margin: const EdgeInsets.only(left: 5, top: 30),
              //     alignment: Alignment.center,
              //     height: 40,
              //     width: 40,
              //     child: Image.asset(
              //       "assets/User-interface/dashboard-icons/message-icon.png",
              //       scale: 1,
              //     ),
              //   ),
              // ),
              InkWell(
                onTap: () {
                  shareApp();
                },
                child: Container(
                  margin: const EdgeInsets.only(left: 5, top: 30),
                  alignment: Alignment.center,
                  height: 40,
                  width: 40,
                  child: Image.asset(
                    "assets/User-interface/dashboard-icons/share-icon.png",
                    scale: 1,
                  ),
                ),
              ),
              InkWell(
                onTap: () {
                  // _globalKey.currentState!.openDrawer();
                },
                child: Container(
                  margin: const EdgeInsets.only(left: 5, top: 30),
                  alignment: Alignment.center,
                  height: 40,
                  width: 40,
                  child: Image.asset(
                    "assets/User-interface/dashboard-icons/setting-icon.png",
                    scale: 1,
                  ),
                ),
              ),
              InkWell(
                onTap: () {
                  // _globalKey.currentState!.openDrawer();
                },
                child: Container(
                  margin: const EdgeInsets.only(left: 5, top: 30),
                  alignment: Alignment.center,
                  height: 40,
                  width: 40,
                  child: Image.asset(
                    "assets/User-interface/dashboard-icons/wallet-image.png",
                    scale: 1,
                  ),
                ),
              ),
            ],
          ),
        ),
        SizedBox(
          width: width * 0.27,
        ),
        Row(
          children: [
            InkWell(
              onTap: () {
               Navigator.push(
    context,
    MaterialPageRoute(builder: (context) => const WithdrawScreen()),
  );
              },
              child: Container(
                margin: const EdgeInsets.only(left: 0, top: 30),
                alignment: Alignment.center,
                height: height * 0.1,
                width: width * 0.16,
                child: Image.asset(
                  "assets/User-interface/Buttons/withdraw-button.png",
                  // scale: 1,
                ),
              ),
            ),
            InkWell(
              onTap: () {
                // _globalKey.currentState!.openDrawer();
                Navigator.push(
    context,
    MaterialPageRoute(builder: (context) => const AddCashScreen()),
  );
              },
              child: Container(
                margin: const EdgeInsets.only(left: 0, top: 30),
                alignment: Alignment.center,
                height: height * 0.1,
                width: width * 0.16,
                child: Image.asset(
                  "assets/User-interface/Buttons/add-cash-button.png",
                  // scale: 1,
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget bottomWidgetPortrait() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            InkWell(
              onTap: () {
                        Navigator.push(
    context,
    MaterialPageRoute(builder: (context) => const WithdrawScreen()),
  );
                // _globalKey.currentState!.openDrawer();
              },
              child: Container(
                margin: const EdgeInsets.only(left: 0, top: 0),
                alignment: Alignment.center,
                height: height * 0.1,
                width: width * 0.3,
                child: Image.asset(
                  "assets/User-interface/Buttons/withdraw-button.png",
                  // scale: 1,
                ),
              ),
            ),
            SizedBox(
              width: 10,
            ),
            InkWell(
              onTap: () {
                        Navigator.push(
    context,
    MaterialPageRoute(builder: (context) => const AddCashScreen()),
  );
                // _globalKey.currentState!.openDrawer();
              },
              child: Container(
                margin: const EdgeInsets.only(left: 0, top: 0),
                alignment: Alignment.center,
                height: height * 0.1,
                width: width * 0.3,
                child: Image.asset(
                  "assets/User-interface/Buttons/add-cash-button.png",
                  // scale: 1,
                ),
              ),
            ),
          ],
        ),
        Container(
          margin: const EdgeInsets.symmetric(horizontal: 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // InkWell(
              //   onTap: () {
              //     // _globalKey.currentState!.openDrawer();
              //   },
              //   child: Container(
              //     margin: const EdgeInsets.only(left: 0, top: 30),
              //     alignment: Alignment.center,
              //     height: 40,
              //     width: 40,
              //     child: Image.asset(
              //       "assets/User-interface/dashboard-icons/help-icon.png",
              //       scale: 1,
              //     ),
              //   ),
              // ),
              // InkWell(
              //   onTap: () {
              //     // _globalKey.currentState!.openDrawer();
              //   },
              //   child: Container(
              //     margin: const EdgeInsets.only(left: 5, top: 30),
              //     alignment: Alignment.center,
              //     height: 40,
              //     width: 40,
              //     child: Image.asset(
              //       "assets/User-interface/dashboard-icons/headphone-icon.png",
              //       scale: 1,
              //     ),
              //   ),
              // ),
              // InkWell(
              //   onTap: () {
              //     // _globalKey.currentState!.openDrawer();
              //   },
              //   child: Container(
              //     margin: const EdgeInsets.only(left: 5, top: 30),
              //     alignment: Alignment.center,
              //     height: 40,
              //     width: 40,
              //     child: Image.asset(
              //       "assets/User-interface/dashboard-icons/gift-icon.png",
              //       scale: 1,
              //     ),
              //   ),
              // ),
              // InkWell(
              //   onTap: () {
              //     // _globalKey.currentState!.openDrawer();
              //   },
              //   child: Container(
              //     margin: const EdgeInsets.only(left: 5, top: 30),
              //     alignment: Alignment.center,
              //     height: 40,
              //     width: 40,
              //     child: Image.asset(
              //       "assets/User-interface/dashboard-icons/message-icon.png",
              //       scale: 1,
              //     ),
              //   ),
              // ),
              InkWell(
                onTap: () {
                  shareApp();
                },
                child: Container(
                  margin: const EdgeInsets.only(
                    left: 5,
                  ),
                  alignment: Alignment.center,
                  height: 40,
                  width: 40,
                  child: Image.asset(
                    "assets/User-interface/dashboard-icons/share-icon.png",
                    scale: 1,
                  ),
                ),
              ),
              InkWell(
                onTap: () {
                  // _globalKey.currentState!.openDrawer();
                },
                child: Container(
                  margin: const EdgeInsets.only(
                    left: 5,
                  ),
                  alignment: Alignment.center,
                  height: 40,
                  width: 40,
                  child: Image.asset(
                    "assets/User-interface/dashboard-icons/setting-icon.png",
                    scale: 1,
                  ),
                ),
              ),
              InkWell(
                onTap: () {},
                child: Container(
                  margin: const EdgeInsets.only(
                    left: 5,
                  ),
                  alignment: Alignment.center,
                  height: 40,
                  width: 40,
                  child: Image.asset(
                    "assets/User-interface/dashboard-icons/wallet-image.png",
                    scale: 1,
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget drawerWidget() {
    return ListView(
      physics: NeverScrollableScrollPhysics(),
      children: [
        Container(
          height: height,
          width: width,
          decoration: BoxDecoration(
              image: DecorationImage(
            image: AssetImage("assets/User-interface/dashboard.png"),
            fit: BoxFit.fitHeight,
          )),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              InkWell(
                onTap: () {
                  Navigator.pop(context);
                },
                child: Container(
                  alignment: Alignment.centerRight,
                  height: height * 0.09,
                  width: width,
                  decoration: BoxDecoration(color: Colors.black),
                  child: Padding(
                    padding: const EdgeInsets.only(right: 5),
                    child: Image.asset(
                      "assets/User-interface/Buttons/close-button.png",
                      scale: 0.8,
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              InkWell(
                onTap: () async {
                  Navigator.push(context, _createRouteProfile());
                },
                child: Container(
                  margin:
                      const EdgeInsets.symmetric(horizontal: 30, vertical: 10),
                  child: Text(
                    "Profile",
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.bold),
                  ),
                ),
              ),
              InkWell(
                onTap: () async {
                  Navigator.push(context, _createRoute());
                },
                child: Container(
                  margin:
                      const EdgeInsets.symmetric(horizontal: 30, vertical: 10),
                  child: Text(
                    "Account Statement",
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.bold),
                  ),
                ),
              ),
              InkWell(
                onTap: () async {
                  Navigator.push(context, _createRouteCurrentBets());
                },
                child: Container(
                  margin:
                      const EdgeInsets.symmetric(horizontal: 30, vertical: 10),
                  child: Text(
                    "Current Bets",
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.bold),
                  ),
                ),
              ),
              InkWell(
                onTap: () async {},
                child: Container(
                  margin:
                      const EdgeInsets.symmetric(horizontal: 30, vertical: 10),
                  child: Text(
                    "Activity Log",
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.bold),
                  ),
                ),
              ),
              InkWell(
                onTap: () async {
                  Navigator.push(context, _createRouteChangePassword());
                },
                child: Container(
                  margin:
                      const EdgeInsets.symmetric(horizontal: 30, vertical: 10),
                  child: Text(
                    "Change Password",
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.bold),
                  ),
                ),
              ),
              Divider(
                color: Color.fromARGB(255, 184, 50, 50),
              ),
              SizedBox(
                height: 10,
              ),
              InkWell(
                onTap: () async {
                  getlogout();
                },
                child: Container(
                  margin:
                      const EdgeInsets.symmetric(horizontal: 30, vertical: 10),
                  child: Text(
                    "Logout",
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

// ---------------------Logout Function ---------------------//

  void getlogout() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    String token = "";
    setState(() {
      token = preferences.getString('token').toString();
    });

    if (token == "" && token == "null") {
    } else {
      preferences.clear();
      Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (context) => SignInScreen()),
          (route) => false);
      final snackBar = SnackBar(
        backgroundColor: const Color.fromARGB(255, 62, 9, 6),
        content: const Text('Logout Sucessfully !'),
      );
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    }
  }

  Route _createRoute() {
    return PageRouteBuilder(
      pageBuilder: (context, animation, secondaryAnimation) =>
          const MyAccountPage(),
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        const begin = Offset(0.0, 1.0);
        const end = Offset.zero;
        const curve = Curves.ease;

        var tween =
            Tween(begin: begin, end: end).chain(CurveTween(curve: curve));

        return SlideTransition(
          position: animation.drive(tween),
          child: child,
        );
      },
    );
  }

  Route _createRouteProfile() {
    return PageRouteBuilder(
      pageBuilder: (context, animation, secondaryAnimation) =>
          const ProfileScreen(),
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        const begin = Offset(0.0, 1.0);
        const end = Offset.zero;
        const curve = Curves.ease;

        var tween =
            Tween(begin: begin, end: end).chain(CurveTween(curve: curve));

        return SlideTransition(
          position: animation.drive(tween),
          child: child,
        );
      },
    );
  }

  Route _createRouteCurrentBets() {
    return PageRouteBuilder(
      pageBuilder: (context, animation, secondaryAnimation) =>
          const CurrentBetsScreen(),
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        const begin = Offset(0.0, 1.0);
        const end = Offset.zero;
        const curve = Curves.ease;

        var tween =
            Tween(begin: begin, end: end).chain(CurveTween(curve: curve));

        return SlideTransition(
          position: animation.drive(tween),
          child: child,
        );
      },
    );
  }

  Route _createRouteChangePassword() {
    return PageRouteBuilder(
      pageBuilder: (context, animation, secondaryAnimation) =>
          const ChangePasswordScreen(),
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        const begin = Offset(0.0, 1.0);
        const end = Offset.zero;
        const curve = Curves.ease;

        var tween =
            Tween(begin: begin, end: end).chain(CurveTween(curve: curve));

        return SlideTransition(
          position: animation.drive(tween),
          child: child,
        );
      },
    );
  }
// --------------------- Game list Api ---------------------//

  Future getGameListDetails() async {
    var url = Apis.gameListApi;
    var body = {"gameType": "virtual"};
    var response = await GlobalFunction.apiPostRequestToken(url, body);
    var result = jsonDecode(response);
    if (result['status'] == true) {
      var list = result['data'] as List;
      setState(() {
        gameList.clear();
        var listdata = list.map((e) => GameListModel.fromJson(e)).toList();
        gameList.addAll(listdata);
      });
    }
  }

  Future getuserBalance() async {
    var url = Apis.profileAPI;
    var body = {};
    var response = await GlobalFunction.apiPostRequestToken(url, body);
    var result = jsonDecode(response);
    if (result['status'] == true) {
      setState(() {
        userBalance = result['data']['balance'];
        userName = result['data']['username'];
      });
    }
  }
}
