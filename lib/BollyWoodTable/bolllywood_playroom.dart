// ignore_for_file: use_build_context_synchronously

import 'dart:convert';
import 'package:blinking_text/blinking_text.dart';
import 'package:flip_card/flip_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:just_audio/just_audio.dart';
import 'package:lottie/lottie.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:virtual_casino/BollyWoodTable/animations/random_coin_left.dart';
import 'package:virtual_casino/BollyWoodTable/animations/random_coin_left_p.dart';
import 'package:virtual_casino/BollyWoodTable/animations/random_coin_right.dart';
import 'package:virtual_casino/BollyWoodTable/animations/random_coin_right_p.dart';
import 'package:virtual_casino/DragonTigerLion/buttons_model.dart';
import 'package:virtual_casino/Utils/toast.dart';
import 'package:http/http.dart' as http;
import '../User-Interface/change_passswod_screen.dart';
import '../User-Interface/current_user_bet.dart';
import '../User-Interface/my_account.dart';
import '../User-Interface/profile_screen.dart';
import '../User-Interface/signin_screen.dart';
import '../Utils/api_helper.dart';
import '../Utils/apis.dart';
import '../Widgets/customText.dart';
import '../constants/color_constants.dart';
import '../data/model/dragon_tiger_lion_model.dart';
import '../data/model/match_id_model.dart';

class BollyWoodTablePlayRoom extends StatefulWidget {
  final String matchID;
  final String gameCode;
  const BollyWoodTablePlayRoom(
      {super.key, required this.matchID, required this.gameCode});

  @override
  State<BollyWoodTablePlayRoom> createState() => _BollyWoodTablePlayRoomState();
}

class _BollyWoodTablePlayRoomState extends State<BollyWoodTablePlayRoom>
    with TickerProviderStateMixin, WidgetsBindingObserver {
  final GlobalKey<ScaffoldState> _globalKey = GlobalKey<ScaffoldState>();
  List<ButtonsModelBollyWood> buttonsList = [];
  double mainBalance = 0;
  final stopBettingmusic = AudioPlayer();
  final startBettingmusic = AudioPlayer();
  final onPressedmusic = AudioPlayer();
  late AnimationController _controller;
  late Animation<double> _animation;
  List<BollyWoodResultModel> cardResultList = [];
  final List<Widget> _coins = [];
  final List<Widget> _coinsRyt = [];
  final List<Widget> _coinsPort = [];
  final List<Widget> _coinsRytPort = [];
  List<MatchIdModel> matchIdList = [];
  late AnimationController controller1;
  double height = 0;
  double width = 0;
  bool redCoinAnimation = false;
  bool lightGreenCoinAnimation = false;
  bool blueCoinAnimation = false;
  bool greenCoinAnimation = false;
  bool lightBlueCoinAnimation = false;
  bool brownCoinAnimation = false;
  int stack1 = 0;
  int stack2 = 0;
  int stack3 = 0;
  int stack4 = 0;
  int stack5 = 0;
  int stack6 = 0;
  bool playBackgroundMusic = false;
  String userBalance = "";
  String liablity = "";
  int startTimes = 0;
  String winnerResult = "";
  String detail = "";
  String cardResult = "";
  String autoTime = "";
  String cardNameImage1 = "";
  String cardNameImage2 = "";
  String cardNameImage3 = "";
  String marketId = "";
  bool manualAmount = false;
  var stakeController = TextEditingController();
  String sid = "";
  String oddsRates = "";

  String donRate = "";
  String donLayRate = "";
  bool donButton = false;
  bool donLayButton = false;

  String amarakbarRate = "";
  String amarAkbarLayRate = "";
  bool amarAkbarutton = false;
  bool amarLayAkbarutton = false;

  String sahibRate = "";
  String sahibLayRate = "";
  bool sahibButton = false;
  bool sahibLayButton = false;

  String dharamRate = "";
  String dharamLayRate = "";
  bool dharamButton = false;
  bool dharamLayButton = false;

  String kiskisRate = "";
  String kiskisLayRate = "";
  bool kiskisButton = false;
  bool kiskisLayButton = false;

  String ghulamRate = "";
  String ghulamLayRate = "";
  bool ghulamButton = false;
  bool ghulamLayButton = false;

  String oddRate = "";
  String oddLayRate = "";
  bool oddButton = false;
  bool oddLayButton = false;

  String dulhaDulhanRate = "";
  bool dulhaButton = false;

  String baratiRate = "";
  bool baratiButton = false;
  String blackRate = "";
  bool blackButton = false;
  String redRate = "";
  bool redButton = false;
  double liablity1 = 0;
  double liablity2 = 0;
  double liablity3 = 0;
  double liablity4 = 0;
  double liablity5 = 0;
  double liablity6 = 0;
  double liablity7 = 0;
  double liablity8 = 0;
  double liablity9 = 0;
  double liablity10 = 0;
  double liablity11 = 0;
  double liablity12 = 0;
  double liablity13 = 0;
  double liablity14 = 0;
  double liablity15 = 0;

  bool showLiablity = false;
  Future<void> onPressedMusicForBet() async {
    onPressedmusic.playbackEventStream.listen((event) {},
        onError: (Object e, StackTrace stackTrace) {
      print('A stream error occurred: $e');
    });
    try {
      await onPressedmusic.setAudioSource(AudioSource.asset(
        "assets/lucky7/audio/coinsound.wav",
      ));
    } catch (e) {
      print("Error loading audio source: $e");
    }
    onPressedmusic.play();
  }

  Future<void> stopBettingMusic() async {
    stopBettingmusic.playbackEventStream.listen((event) {},
        onError: (Object e, StackTrace stackTrace) {
      print('A stream error occurred: $e');
    });
    try {
      await stopBettingmusic.setAudioSource(AudioSource.asset(
        "assets/Teen-patti/audio/stopbetting.mp3",
      ));
    } catch (e) {
      print("Error loading audio source: $e");
    }
    autoTime == "1" && playBackgroundMusic == false
        ? stopBettingmusic.play()
        : stopBettingmusic.stop();
    stopBettingmusic.setVolume(1);
  }

  Future<void> startBettingMusic() async {
    startBettingmusic.playbackEventStream.listen((event) {},
        onError: (Object e, StackTrace stackTrace) {
      print('A stream error occurred: $e');
    });
    try {
      await startBettingmusic.setAudioSource(AudioSource.asset(
        "assets/Teen-patti/audio/startbetting.mp3",
      ));
    } catch (e) {
      print("Error loading audio source: $e");
    }
    autoTime == "45" && playBackgroundMusic == false
        ? startBettingmusic.play()
        : startBettingmusic.stop();
    startBettingmusic.setVolume(1);
  }

  @override
  void initState() {
    getStakeDetails();
    controller1 = AnimationController(
      vsync: this,
      duration:
          Duration(milliseconds: 600), // Adjust the duration as neededp[c]
    );

    _controller = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 2000), // Adjust the duration as needed
    );

    _animation = CurvedAnimation(parent: _controller, curve: Curves.easeInOut);
    _controller.repeat(reverse: true);
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.landscapeLeft,
      DeviceOrientation.landscapeRight,
      DeviceOrientation.portraitUp
    ]);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    getResult();
    getuserBalance();
    getCardData();
    getMatchIdDetails();
    getUserDetails();

    height = MediaQuery.of(context).size.height;
    width = MediaQuery.of(context).size.width;
    autoTime == "0"
        ? setState(
            () {
              _coinsRytPort.reversed;
              _coinsRytPort.clear();
              _coinsPort.reversed;
              _coinsPort.clear();
              _coins.reversed;
              _coins.clear();
              _coinsRyt.reversed;
              _coinsRyt.clear();
            },
          )
        : null;

    return OrientationBuilder(builder: (context, oreintation) {
      if (oreintation == Orientation.landscape) {
        return landscapeWidget();
      } else {
        return protraitModeWidget();
      }
    });
  }

  Widget drawerWidget() {
    return Container(
      height: height,
      width: width * 0.4,
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
              margin: const EdgeInsets.symmetric(horizontal: 30, vertical: 10),
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
              margin: const EdgeInsets.symmetric(horizontal: 30, vertical: 10),
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
              margin: const EdgeInsets.symmetric(horizontal: 30, vertical: 10),
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
              margin: const EdgeInsets.symmetric(horizontal: 30, vertical: 10),
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
              margin: const EdgeInsets.symmetric(horizontal: 30, vertical: 10),
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
              margin: const EdgeInsets.symmetric(horizontal: 30, vertical: 10),
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
    );
  }

  Widget drawerWidgetPotrait() {
    return Container(
      height: height,
      width: width * 0.6,
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
              margin: const EdgeInsets.symmetric(horizontal: 30, vertical: 10),
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
              margin: const EdgeInsets.symmetric(horizontal: 30, vertical: 10),
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
              margin: const EdgeInsets.symmetric(horizontal: 30, vertical: 10),
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
              margin: const EdgeInsets.symmetric(horizontal: 30, vertical: 10),
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
              margin: const EdgeInsets.symmetric(horizontal: 30, vertical: 10),
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
              margin: const EdgeInsets.symmetric(horizontal: 30, vertical: 10),
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
    );
  }

  Future getVcLiablity() async {
    var url = Apis.vcLiablityApi;
    var body = {
      "roundId": marketId.toString(),
    };
    var response =
        await GlobalFunction.apiPostRequestTokenForUsers(url, body, context);
    var result = jsonDecode(response);

    if (result['status'] == true) {
      setState(() {
        showLiablity = true;
        liablity1 = result['data'][0]['liability'];
        liablity2 = result['data'][1]['liability'];
        liablity3 = result['data'][2]['liability'];
        liablity4 = result['data'][3]['liability'];
        liablity5 = result['data'][4]['liability'];
        liablity6 = result['data'][5]['liability'];
        liablity7 = result['data'][6]['liability'];
        liablity8 = result['data'][7]['liability'];
        liablity9 = result['data'][8]['liability'];
        liablity10 = result['data'][9]['liability'];
        liablity11 = result['data'][10]['liability'];
        liablity12 = result['data'][11]['liability'];
        liablity13 = result['data'][12]['liability'];
        liablity14 = result['data'][13]['liability'];
        liablity15 = result['data'][14]['liability'];

        print("liablity--->$liablity1");
      });
    }
  }

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
          CurrentUserBet(gameCode: widget.gameCode, matchId: widget.matchID),
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

  Widget landscapeWidget() {
    return Scaffold(
      drawerEnableOpenDragGesture: false,
      key: _globalKey,
      drawer: drawerWidget(),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
                height: height,
                decoration: BoxDecoration(
                    image: DecorationImage(
                        image: AssetImage(
                            "assets/bollywoodTable/background-image.png"),
                        fit: BoxFit.fill)),
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    Positioned(
                      top: height * 0.03,
                      left: width * 0.02,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              InkWell(
                                onTap: () {
                                  setState(() {});
                                  HapticFeedback.heavyImpact();
                                  _globalKey.currentState!.openDrawer();
                                },
                                child: Image.asset(
                                    'assets/bollywoodTable/menu-button.png',
                                    fit: BoxFit.fill,
                                    width: width * 0.05),
                              ),
                              SizedBox(
                                width: width * 0.03,
                              ),
                              Container(
                                alignment: Alignment.center,
                                width: width * 0.12,
                                height: height * 0.09,
                                decoration: BoxDecoration(
                                    image: DecorationImage(
                                        image: AssetImage(
                                            'assets/bollywoodTable/balance.png'),
                                        fit: BoxFit.fitWidth)),
                                child: Container(
                                  width: width * 0.15,
                                  margin: EdgeInsets.only(left: width * 0.05),
                                  child: Text(
                                    mainBalance.toStringAsFixed(2),
                                    style: TextStyle(
                                        color:
                                            Color.fromARGB(255, 248, 244, 204),
                                        fontSize: height * 0.03,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          InkWell(
                            onTap: () {
                              // HapticFeedback.vibrate();
                              Navigator.push(
                                  context, _createRouteCurrentBets());
                            },
                            child: Container(
                              alignment: Alignment.centerLeft,
                              height: height * 0.10,
                              width: width * 0.15,
                              decoration: BoxDecoration(
                                  image: DecorationImage(
                                      image: AssetImage(
                                          'assets/bollywoodTable/show-my-bet.png'),
                                      fit: BoxFit.cover)),
                              child: Padding(
                                padding: const EdgeInsets.only(left: 15.0),
                                child: Text(
                                  "MY-BET",
                                  style: TextStyle(color: Colors.white),
                                ),
                              ),
                            ),
                          ),
                          BlinkText(
                            "Round ID : $marketId",
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold),
                          ),
                          SizedBox(
                            height: 1,
                          ),
                        ],
                      ),
                    ),
                    Positioned(
                      top: height * 0.05,
                      child: Image.asset(
                        'assets/dragonTigerLion/tableImges/table-girl.png',
                        fit: BoxFit.cover,
                        height: height * 0.28,
                      ),
                    ),

                    Positioned(
                      top: height * 0.173,
                      left: width * 0.138,
                      child: CustomText(
                        text: matchIdList.length.toString(),
                        fontWeight: FontWeight.w500,
                        color: Color.fromARGB(255, 248, 244, 204),
                        fontSize: 13,
                        textAlign: TextAlign.center,
                      ),
                    ),

                    Positioned(
                      top: height * 0.02,
                      right: width * 0.05,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.end,
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              //---------------Game Timer------------//
                              startTimes >= 3
                                  ? Column(
                                      children: [
                                        CustomText(
                                          text: "Starting in $autoTime sec",
                                          fontWeight: FontWeight.w700,
                                          color: Colors.white,
                                          fontSize: 12.0,
                                          textAlign: TextAlign.center,
                                        ),
                                        SizedBox(
                                          height: 3,
                                          width: width * 0.20,
                                          child: LinearProgressIndicator(
                                            value: int.parse(autoTime) /
                                                45, // Calculate the progress
                                            backgroundColor: Colors.white,
                                            valueColor:
                                                AlwaysStoppedAnimation<Color>(
                                                    Color(0xaaCD7B01)),
                                          ),
                                        ),
                                        Text(
                                          "(Min: 100 Max: 25000)",
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontWeight: FontWeight.bold,
                                              fontSize: 10),
                                        )
                                      ],
                                    )
                                  : SizedBox(),
                              SizedBox(
                                width: width * 0.06,
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    Positioned(
                      top: height * 0.02,
                      right: width * 0.05,
                      child: playBackgroundMusic == false
                          ? InkWell(
                              onTap: () {
                                HapticFeedback.vibrate();

                                setState(() {
                                  playBackgroundMusic = true;
                                });
                              },
                              child: Image.asset(
                                  'assets/bollywoodTable/sound-on-button.png',
                                  fit: BoxFit.cover,
                                  width: width * 0.04),
                            )
                          : InkWell(
                              onTap: () {
                                HapticFeedback.vibrate();

                                setState(() {
                                  playBackgroundMusic = false;
                                });
                              },
                              child: Image.asset(
                                  'assets/dragonTigerLion/buttonsImage/mute-button.png',
                                  fit: BoxFit.cover,
                                  width: width * 0.04),
                            ),
                    ),

                    Positioned(
                      bottom: 1,
                      child: Image.asset(
                        'assets/bollywoodTable/bollywood-table.png',
                        fit: BoxFit.fill,
                        height: height * 0.67,
                      ),
                    ),
                    Positioned(
                      top: height * 0.37,
                      left: width * 0.17,
                      child: startTimes >= 3
                          ? AnimatedBuilder(
                              animation: _animation,
                              builder: (context, child) {
                                return Transform.translate(
                                  offset: Offset(0, -23 * _animation.value),
                                  child: Image.asset(
                                    'assets/lucky7/images/frame/logo.png',
                                    fit: BoxFit.cover,
                                    height: height * 0.10,
                                  ),
                                );
                              })
                          : Image.asset(
                              'assets/lucky7/images/frame/logo.png',
                              fit: BoxFit.cover,
                              height: height * 0.10,
                            ),
                    ),
                    Positioned(
                      top: height * 0.37,
                      right: width * 0.17,
                      child: startTimes >= 3
                          ? AnimatedBuilder(
                              animation: _animation,
                              builder: (context, child) {
                                return Transform.translate(
                                  offset: Offset(0, -23 * _animation.value),
                                  child: Image.asset(
                                    'assets/lucky7/images/frame/logo.png',
                                    fit: BoxFit.cover,
                                    height: height * 0.10,
                                  ),
                                );
                              })
                          : Image.asset(
                              'assets/lucky7/images/frame/logo.png',
                              fit: BoxFit.cover,
                              height: height * 0.10,
                            ),
                    ),
                    AnimatedSwitcher(
                      duration: Duration(milliseconds: 500),
                      child: Stack(
                        children: _coins,
                      ),
                    ),
                    AnimatedSwitcher(
                      duration: Duration(milliseconds: 500),
                      child: Stack(
                        children: _coinsRyt,
                      ),
                    ),
                    LandscapeRandomCoinLeftSideBollWood(
                        coinsSound: playBackgroundMusic),
                    RandomCoinThroughRightSideBollyWood(),
                    //------------------- RESULT IMAGE----------------//

                    autoTime == "45"
                        ? placeyourbetWidget(autoTime)
                        : autoTime == "3" || autoTime == "2" || autoTime == "1"
                            ? goWidget()
                            : autoTime == "0"
                                ? Positioned(
                                    top: height * 0.35,
                                    // right: width ,
                                    child: showCurrentCardLand())
                                : SizedBox(),

                    autoTime == "3" ? gameStopBetting(autoTime) : SizedBox(),

                    Positioned(
                      bottom: height * 0.01,
                      left: width * 0.29,
                      child: Row(
                        children: [
                          InkWell(
                            onTap: () {
                              setState(() {
                                redCoinAnimation = !redCoinAnimation;
                                lightGreenCoinAnimation = false;
                                blueCoinAnimation = false;
                                greenCoinAnimation = false;
                                lightBlueCoinAnimation = false;
                                brownCoinAnimation = false;
                              });
                            },
                            child: AnimatedContainer(
                              duration: Duration(milliseconds: 700),
                              alignment: Alignment.center,
                              height: redCoinAnimation == true
                                  ? height * 0.16
                                  : height * 0.11,
                              width: redCoinAnimation == true
                                  ? width * 0.08
                                  : width * 0.05,
                              decoration: BoxDecoration(
                                  image: DecorationImage(
                                image: AssetImage(
                                    "assets/dragonTigerLion/stakes/stake1.png"),
                                fit: BoxFit.cover,
                              )),
                              child: Text(
                                stack1.toString(),
                                style: TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 10),
                              ),
                            ),
                          ),
                          SizedBox(
                            width: width * 0.04,
                          ),
                          InkWell(
                            onTap: () {
                              setState(() {
                                lightGreenCoinAnimation =
                                    !lightBlueCoinAnimation;
                                redCoinAnimation = false;
                                blueCoinAnimation = false;
                                greenCoinAnimation = false;
                                lightBlueCoinAnimation = false;
                                brownCoinAnimation = false;
                              });
                            },
                            child: AnimatedContainer(
                              duration: Duration(milliseconds: 700),
                              alignment: Alignment.center,
                              height: lightGreenCoinAnimation == true
                                  ? height * 0.16
                                  : height * 0.11,
                              width: lightGreenCoinAnimation == true
                                  ? width * 0.08
                                  : width * 0.051,
                              decoration: BoxDecoration(
                                  image: DecorationImage(
                                image: AssetImage(
                                    "assets/dragonTigerLion/stakes/stake2.png"),
                                fit: BoxFit.cover,
                              )),
                              child: Text(
                                stack1 != 0 ? "1K" : stack1.toString(),
                                style: TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 10),
                              ),
                            ),
                          ),
                          SizedBox(
                            width: width * 0.04,
                          ),
                          InkWell(
                            onTap: () {
                              setState(() {
                                redCoinAnimation = false;
                                lightGreenCoinAnimation = false;
                                blueCoinAnimation = !blueCoinAnimation;
                                greenCoinAnimation = false;
                                lightBlueCoinAnimation = false;
                                brownCoinAnimation = false;
                              });
                            },
                            child: AnimatedContainer(
                              duration: Duration(milliseconds: 700),
                              alignment: Alignment.center,
                              height: blueCoinAnimation == true
                                  ? height * 0.16
                                  : height * 0.11,
                              width: blueCoinAnimation == true
                                  ? width * 0.08
                                  : width * 0.05,
                              decoration: BoxDecoration(
                                  image: DecorationImage(
                                image: AssetImage(
                                    "assets/dragonTigerLion/stakes/stake4.png"),
                                fit: BoxFit.cover,
                              )),
                              child: Text(
                                stack2 != 0 ? "2K" : stack3.toString(),
                                style: TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 10),
                              ),
                            ),
                          ),
                          SizedBox(
                            width: width * 0.04,
                          ),
                          InkWell(
                            onTap: () {
                              setState(() {
                                redCoinAnimation = false;
                                lightGreenCoinAnimation = false;
                                blueCoinAnimation = false;
                                greenCoinAnimation = !greenCoinAnimation;
                                lightBlueCoinAnimation = false;
                                brownCoinAnimation = false;
                              });
                            },
                            child: AnimatedContainer(
                              duration: Duration(milliseconds: 700),
                              alignment: Alignment.center,
                              height: greenCoinAnimation == true
                                  ? height * 0.16
                                  : height * 0.11,
                              width: greenCoinAnimation == true
                                  ? width * 0.08
                                  : width * 0.051,
                              decoration: BoxDecoration(
                                  image: DecorationImage(
                                image: AssetImage(
                                    "assets/dragonTigerLion/stakes/stake5.png"),
                                fit: BoxFit.cover,
                              )),
                              child: Text(
                                stack3 != 0 ? "5K" : stack4.toString(),
                                style: TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 10),
                              ),
                            ),
                          ),
                          SizedBox(
                            width: width * 0.04,
                          ),
                          InkWell(
                            onTap: () {
                              setState(() {
                                redCoinAnimation = false;
                                lightGreenCoinAnimation = false;
                                blueCoinAnimation = false;
                                greenCoinAnimation = false;
                                lightBlueCoinAnimation =
                                    !lightBlueCoinAnimation;
                                brownCoinAnimation = false;
                              });
                            },
                            child: AnimatedContainer(
                              duration: Duration(milliseconds: 700),
                              alignment: Alignment.center,
                              height: lightBlueCoinAnimation == true
                                  ? height * 0.16
                                  : height * 0.13,
                              width: lightBlueCoinAnimation == true
                                  ? width * 0.08
                                  : width * 0.06,
                              decoration: BoxDecoration(
                                  image: DecorationImage(
                                image: AssetImage(
                                    "assets/dragonTigerLion/stakes/stake3.png"),
                                fit: BoxFit.cover,
                              )),
                              child: Padding(
                                padding: const EdgeInsets.only(bottom: 3.0),
                                child: Text(
                                  stack4 != 0 ? "10K" : stack5.toString(),
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 10),
                                ),
                              ),
                            ),
                          ),
                          SizedBox(
                            width: width * 0.04,
                          ),
                          // InkWell(
                          //   onTap: () {
                          //     setState(() {
                          //       redCoinAnimation = false;
                          //       lightGreenCoinAnimation = false;
                          //       blueCoinAnimation = false;
                          //       greenCoinAnimation = false;
                          //       lightBlueCoinAnimation = false;
                          //       brownCoinAnimation = !brownCoinAnimation;
                          //     });
                          //   },
                          //   child: AnimatedContainer(
                          //     duration: Duration(milliseconds: 700),
                          //     alignment: Alignment.center,
                          //     height: brownCoinAnimation == true
                          //         ? height * 0.18
                          //         : height * 0.115,
                          //     width: brownCoinAnimation == true
                          //         ? width * 0.08
                          //         : width * 0.054,
                          //     decoration: BoxDecoration(
                          //         image: DecorationImage(
                          //       image: AssetImage(
                          //           "assets/dragonTigerLion/stakes/stake6.png"),
                          //       fit: BoxFit.cover,
                          //     )),
                          //     child: Text(
                          //       stack5 != 0 ? "20K" : stack6.toString(),
                          //       style: TextStyle(
                          //           fontWeight: FontWeight.bold, fontSize: 10),
                          //     ),
                          //   ),
                          // ),
                        ],
                      ),
                    ),

                    Positioned(
                      height: height * 0.82,
                      width: width * 0.04,
                      right: width * 0.05,
                      child: Container(
                        height: height * 0.08,
                        width: width * 0.3,
                        margin: EdgeInsets.only(top: 20),
                        padding: EdgeInsets.all(1),
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                            image: DecorationImage(
                          image: AssetImage(
                              "assets/bollywoodTable/past-result.png"),
                          fit: BoxFit.cover,
                        )),
                        child: ListView.builder(
                            physics: NeverScrollableScrollPhysics(),
                            itemCount: cardResultList.length,
                            scrollDirection: Axis.vertical,
                            itemBuilder: (context, index) {
                              var items = cardResultList[index];
                              return InkWell(
                                onTap: () {
                                  HapticFeedback.vibrate();
                                  DialogUtils.showResultBollyWood(context,
                                      items.c1, items.mid, items.detail);
                                },
                                child: Container(
                                  margin: EdgeInsets.all(2),
                                  padding: EdgeInsets.all(3),
                                  alignment: Alignment.center,
                                  decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: items.winner == "1" ||
                                              items.winner == "4"
                                          ? Color(0xaa028BA9)
                                          : items.winner == "2" ||
                                                  items.winner == "5"
                                              ? Color(0xaaA90270)
                                              : ColorConstants.lightGreenColor),
                                  child: Text(
                                    items.winner == "1"
                                        ? "1"
                                        : items.winner == "2"
                                            ? "2"
                                            : items.winner == "3"
                                                ? "3"
                                                : items.winner == "4"
                                                    ? "4"
                                                    : items.winner == "5"
                                                        ? "5"
                                                        : "6",
                                    style: TextStyle(
                                      fontWeight: FontWeight.w600,
                                      color: ColorConstants.whiteColor,
                                      fontSize: 12.0,
                                    ),
                                  ),
                                ),
                              );
                            }),
                      ),
                    ),
                    Positioned(
                      bottom: height * 0.05,
                      left: width * 0.05,
                      child: Row(
                        children: [
                          Container(
                            // padding: EdgeInsets.only(
                            //     left: width * 0.04, right: width * 0.02),
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                                image: DecorationImage(
                                    image: AssetImage(
                                        "assets/bollywoodTable/exposure-balance.png"))),
                            height: height * 0.1,
                            width: width * 0.15,
                            child: Text(
                              "EXP : $liablity",
                              style: TextStyle(
                                  color: Colors.yellow[50],
                                  fontWeight: FontWeight.bold,
                                  fontSize: 11),
                            ),
                          ),
                          SizedBox(
                            width: width * 0.57,
                          ),
                        ],
                      ),
                    ),
                  ],
                )),
            Container(
              decoration: BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage(
                          "assets/bollywoodTable/background-image.png"),
                      fit: BoxFit.cover)),
              height: height * 0.9,
              width: width,
              child: Column(
                children: [
                  bollywoodButtons(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget protraitModeWidget() {
    return Scaffold(
      key: _globalKey,
      drawer: drawerWidgetPotrait(),
      body: Container(
          height: height,
          width: width,
          decoration: BoxDecoration(
              image: DecorationImage(
            image: AssetImage(
              "assets/bollywoodTable/background-image-p.png",
            ),
            fit: BoxFit.fill,
          )),
          child: SingleChildScrollView(
            child: Column(children: [
              Padding(
                padding: EdgeInsets.only(
                    left: width * 0.02,
                    right: width * 0.02,
                    bottom: height * 0.02,
                    top: height * 0.02),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          width: width * 0.96,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Stack(
                                children: [
                                  Image.asset(
                                    'assets/bollywoodTable/balance.png',
                                    height: height * 0.04,
                                    width: width * 0.25,
                                    fit: BoxFit.contain,
                                  ),
                                  Positioned(
                                    top: height * 0.01,
                                    left: width * 0.1,
                                    child: CustomText(
                                      text: userBalance.toString(),
                                      fontWeight: FontWeight.w700,
                                      color: Colors.yellow[50],
                                      fontSize: width * 0.03,
                                      textAlign: TextAlign.center,
                                    ),
                                  ),
                                ],
                              ),
                              playBackgroundMusic == false
                                  ? Row(
                                      children: [
                                        InkWell(
                                          onTap: () {
                                            HapticFeedback.heavyImpact();
                                            _globalKey.currentState!
                                                .openDrawer();
                                          },
                                          child: Image.asset(
                                              'assets/bollywoodTable/menu-button.png',
                                              fit: BoxFit.cover,
                                              height: height * 0.05),
                                        ),
                                        SizedBox(
                                          width: 10,
                                        ),
                                        InkWell(
                                          onTap: () {
                                            HapticFeedback.vibrate();

                                            setState(() {
                                              playBackgroundMusic = true;
                                            });
                                          },
                                          child: Image.asset(
                                              'assets/bollywoodTable/sound-on-button.png',
                                              fit: BoxFit.cover,
                                              height: height * 0.05),
                                        ),
                                      ],
                                    )
                                  : InkWell(
                                      onTap: () {
                                        HapticFeedback.vibrate();

                                        setState(() {
                                          playBackgroundMusic = false;
                                        });
                                      },
                                      child: Image.asset(
                                          'assets/dragonTigerLion/buttonsImage/mute-button.png',
                                          fit: BoxFit.cover,
                                          height: height * 0.04),
                                    ),
                            ],
                          ),
                        ),
                        SizedBox(
                          width: width * 0.96,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              SizedBox(
                                child: Stack(
                                  children: [
                                    Container(
                                      alignment: Alignment.centerLeft,
                                      height: height * 0.04,
                                      width: width * 0.3,
                                      decoration: BoxDecoration(
                                          image: DecorationImage(
                                        image: AssetImage(
                                            "assets/bollywoodTable/exposure-balance.png"),
                                        fit: BoxFit.cover,
                                      )),
                                      child: Padding(
                                        padding:
                                            const EdgeInsets.only(left: 10.0),
                                        child: Text(
                                          "EXP : $liablity ",
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(
                                child: Stack(
                                  children: [
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        InkWell(
                                          onTap: () {
                                            // HapticFeedback.heavyImpact();
                                            Navigator.push(context,
                                                _createRouteCurrentBets());
                                          },
                                          child: Container(
                                            alignment: Alignment.centerLeft,
                                            height: height * 0.05,
                                            width: width * 0.3,
                                            decoration: BoxDecoration(
                                                image: DecorationImage(
                                              image: AssetImage(
                                                  "assets/bollywoodTable/show-my-bet.png"),
                                              fit: BoxFit.cover,
                                            )),
                                            child: Padding(
                                              padding: const EdgeInsets.only(
                                                  left: 10.0),
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  Text(
                                                    "MY BET",
                                                    style: TextStyle(
                                                        color: Colors.white),
                                                  ),
                                                  Container(
                                                      margin: const EdgeInsets
                                                              .symmetric(
                                                          horizontal: 12),
                                                      child: Text(
                                                        matchIdList.length
                                                            .toString(),
                                                        style: TextStyle(
                                                            color:
                                                                Colors.white),
                                                      ))
                                                ],
                                              ),
                                            ),
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
                      ],
                    ),
                  ],
                ),
              ),
              BlinkText(
                "Round Id : $marketId",
                style: TextStyle(color: Colors.white),
              ),
              Stack(
                children: [
                  Padding(
                    padding: EdgeInsets.only(
                        top: height * 0.0,
                        left: width * 0.02,
                        right: width * 0.02,
                        bottom: height * 0.028),
                    child: Container(
                      height: height * 0.04,
                      width: double.infinity - 2,
                      decoration: BoxDecoration(
                          image: DecorationImage(
                        image: AssetImage(
                            "assets/bollywoodTable/past-result-p.png"),
                        fit: BoxFit.fill,
                      )),
                      child: SizedBox(
                        height: height * 0.04,
                        child: ListView.builder(
                            shrinkWrap: true,
                            itemCount: cardResultList.length,
                            scrollDirection: Axis.horizontal,
                            itemBuilder: (context, index) {
                              var items = cardResultList[index];
                              return InkWell(
                                onTap: () {
                                  HapticFeedback.heavyImpact();
                                  DialogUtils.showResultBollyWoodPortrait(
                                      context,
                                      items.c1,
                                      items.mid,
                                      items.detail);
                                },
                                child: Container(
                                  margin: EdgeInsets.only(
                                    left: width * 0.025,
                                    right: width * 0.01,
                                  ),
                                  padding: EdgeInsets.all(7),
                                  alignment: Alignment.center,
                                  decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: items.winner == "1" ||
                                              items.winner == "4"
                                          ? Color(0xaa028BA9)
                                          : items.winner == "2" ||
                                                  items.winner == "5"
                                              ? Color(0xaaA90270)
                                              : ColorConstants.lightGreenColor),
                                  child: Text(
                                    items.winner == "1"
                                        ? "1"
                                        : items.winner == "2"
                                            ? "2"
                                            : items.winner == "3"
                                                ? "3"
                                                : items.winner == "4"
                                                    ? "4"
                                                    : items.winner == "5"
                                                        ? "5"
                                                        : "6",
                                    style: TextStyle(
                                      fontWeight: FontWeight.w600,
                                      color: ColorConstants.whiteColor,
                                      fontSize: 13.0,
                                    ),
                                  ),
                                ),
                              );
                            }),
                      ),
                    ),
                  ),
                ],
              ),
              Container(
                margin: EdgeInsets.symmetric(horizontal: 20),
                alignment: Alignment.centerRight,
                child: Text(
                  "(Min: 100 Max: 25000)",
                  style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 10),
                ),
              ),
              Image.asset(
                'assets/dragonTigerLion/tableImges/table-girl.png',
                fit: BoxFit.cover,
                height: height * 0.17,
              ),
              Stack(
                children: [
                  Image.asset(
                    'assets/bollywoodTable/table-p[.png',
                    fit: BoxFit.cover,
                    height: height * 0.38,
                    //width: width * 1.00,
                  ),
                  Positioned(
                    top: 13,
                    left: 30,
                    child: startTimes >= 3
                        ? AnimatedBuilder(
                            animation: _animation,
                            builder: (context, child) {
                              return Transform.translate(
                                offset: Offset(0, -25 * _animation.value),
                                child: Image.asset(
                                  'assets/lucky7/images/frame/logo.png',
                                  fit: BoxFit.cover,
                                  height: height * 0.05,
                                ),
                              );
                            })
                        : Image.asset(
                            'assets/lucky7/images/frame/logo.png',
                            fit: BoxFit.cover,
                            height: height * 0.05,
                          ),
                  ),
                  Positioned(
                      top: 13,
                      right: 15,
                      child: startTimes >= 3
                          ? AnimatedBuilder(
                              animation: _animation,
                              builder: (context, child) {
                                return Transform.translate(
                                  offset: Offset(0, -25 * _animation.value),
                                  child: Image.asset(
                                    'assets/lucky7/images/frame/logo.png',
                                    fit: BoxFit.cover,
                                    height: height * 0.05,
                                  ),
                                );
                              })
                          : Image.asset(
                              'assets/lucky7/images/frame/logo.png',
                              fit: BoxFit.cover,
                              height: height * 0.05,
                            )),
                  SizedBox(
                      height: height * 0.36,
                      child: PotraitRandomCoinLeftSideBollyWood(
                        coinsSound: playBackgroundMusic,
                      )),
                  SizedBox(
                    height: height * 0.36,
                    child: AnimatedSwitcher(
                      duration: Duration(milliseconds: 500),
                      child: Stack(
                        children: _coinsPort,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: height * 0.36,
                    child: AnimatedSwitcher(
                      duration: Duration(milliseconds: 500),
                      child: Stack(
                        children: _coinsRytPort,
                      ),
                    ),
                  ),
                  SizedBox(
                      height: height * 0.36,
                      child: PotraitRandomCoinRightSideBollywood()),
                  Positioned(
                    left: width * 0.30,
                    top: height * 0.02,
                    child: startTimes >= 3
                        ? Column(
                            children: [
                              CustomText(
                                text: "Starting in ${autoTime} sec",
                                fontWeight: FontWeight.w700,
                                color: Colors.white,
                                fontSize: 12.0,
                                textAlign: TextAlign.center,
                              ),
                              SizedBox(
                                height: 2,
                                width: width * 0.45,
                                child: LinearProgressIndicator(
                                  value: int.parse(autoTime) /
                                      45, // Calculate the progress
                                  backgroundColor: Colors.white,
                                  valueColor: AlwaysStoppedAnimation<Color>(
                                      Color(0xaaCD7B01)),
                                ),
                              ),
                            ],
                          )
                        : SizedBox(),
                  ),
                  autoTime == "45"
                      ? placeyourbetWidgetPortrait(autoTime)
                      : autoTime == "3" || autoTime == "2" || autoTime == "1"
                          ? goWidgetPort()
                          : autoTime == '0'
                              ? Positioned(
                                  top: height * 0.03,
                                  left: width * 0.18,
                                  child: showCurrentCardPort())
                              : SizedBox(),
                  autoTime == "3"
                      ? gameStopBettingPortrait(autoTime)
                      : SizedBox(),
                  Positioned(
                    bottom: height * 0.01,
                    left: width * 0.13,
                    child: Row(
                      children: [
                        InkWell(
                          onTap: () {
                            setState(() {
                              redCoinAnimation = !redCoinAnimation;
                              lightGreenCoinAnimation = false;
                              blueCoinAnimation = false;
                              greenCoinAnimation = false;
                              lightBlueCoinAnimation = false;
                              brownCoinAnimation = false;
                            });
                          },
                          child: AnimatedContainer(
                            duration: Duration(milliseconds: 700),
                            alignment: Alignment.center,
                            height: redCoinAnimation == true
                                ? height * 0.07
                                : height * 0.05,
                            width: redCoinAnimation == true
                                ? width * 0.15
                                : width * 0.11,
                            decoration: BoxDecoration(
                                image: DecorationImage(
                              image: AssetImage(
                                  "assets/lucky7/images/coins/red_coin.png"),
                              fit: BoxFit.fill,
                            )),
                            child: Text(
                              stack1.toString(),
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: height * 0.01),
                            ),
                          ),
                        ),
                        SizedBox(
                          width: width * 0.05,
                        ),
                        InkWell(
                          onTap: () {
                            setState(() {
                              redCoinAnimation = false;
                              lightGreenCoinAnimation =
                                  !lightGreenCoinAnimation;
                              blueCoinAnimation = false;
                              greenCoinAnimation = false;
                              lightBlueCoinAnimation = false;
                              brownCoinAnimation = false;
                            });
                          },
                          child: AnimatedContainer(
                            duration: Duration(milliseconds: 700),
                            alignment: Alignment.center,
                            height: lightGreenCoinAnimation == true
                                ? height * 0.07
                                : height * 0.05,
                            width: lightGreenCoinAnimation == true
                                ? width * 0.15
                                : width * 0.11,
                            decoration: BoxDecoration(
                                image: DecorationImage(
                              image: AssetImage(
                                  "assets/lucky7/images/coins/light_green_coin.png"),
                              fit: BoxFit.fill,
                            )),
                            child: Text(
                              stack2 != 0 ? "1K" : stack2.toString(),
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: height * 0.01),
                            ),
                          ),
                        ),
                        SizedBox(
                          width: width * 0.05,
                        ),
                        InkWell(
                          onTap: () {
                            setState(() {
                              redCoinAnimation = false;
                              lightGreenCoinAnimation = false;
                              blueCoinAnimation = false;
                              greenCoinAnimation = false;
                              lightBlueCoinAnimation = !lightBlueCoinAnimation;
                              brownCoinAnimation = false;
                            });
                          },
                          child: AnimatedContainer(
                            duration: Duration(milliseconds: 700),
                            alignment: Alignment.center,
                            height: lightBlueCoinAnimation == true
                                ? height * 0.07
                                : height * 0.05,
                            width: lightBlueCoinAnimation == true
                                ? width * 0.15
                                : width * 0.11,
                            decoration: BoxDecoration(
                                image: DecorationImage(
                              image: AssetImage(
                                  "assets/lucky7/images/coins/skyblue.png"),
                              fit: BoxFit.fill,
                            )),
                            child: Text(
                              stack3 != 0 ? "2K" : stack3.toString(),
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: height * 0.01),
                            ),
                          ),
                        ),
                        SizedBox(
                          width: width * 0.05,
                        ),
                        InkWell(
                          onTap: () {
                            setState(() {
                              redCoinAnimation = false;
                              lightGreenCoinAnimation = false;
                              blueCoinAnimation = false;
                              greenCoinAnimation = !greenCoinAnimation;
                              lightBlueCoinAnimation = false;
                              brownCoinAnimation = false;
                            });
                          },
                          child: AnimatedContainer(
                            duration: Duration(milliseconds: 700),
                            alignment: Alignment.center,
                            height: greenCoinAnimation == true
                                ? height * 0.07
                                : height * 0.05,
                            width: greenCoinAnimation == true
                                ? width * 0.15
                                : width * 0.11,
                            decoration: BoxDecoration(
                                image: DecorationImage(
                              image: AssetImage(
                                  "assets/lucky7/images/coins/green_coin.png"),
                              fit: BoxFit.fill,
                            )),
                            child: Text(
                              stack4 != 0 ? "5K" : stack4.toString(),
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: height * 0.01),
                            ),
                          ),
                        ),
                        SizedBox(
                          width: width * 0.05,
                        ),
                        InkWell(
                          onTap: () {
                            setState(() {
                              redCoinAnimation = false;
                              lightGreenCoinAnimation = false;
                              blueCoinAnimation = !blueCoinAnimation;
                              greenCoinAnimation = false;
                              lightBlueCoinAnimation = false;
                              brownCoinAnimation = false;
                            });
                          },
                          child: AnimatedContainer(
                            duration: Duration(milliseconds: 700),
                            alignment: Alignment.center,
                            height: blueCoinAnimation == true
                                ? height * 0.07
                                : height * 0.05,
                            width: blueCoinAnimation == true
                                ? width * 0.15
                                : width * 0.11,
                            decoration: BoxDecoration(
                                image: DecorationImage(
                              image: AssetImage(
                                  "assets/lucky7/images/coins/blue.png"),
                              fit: BoxFit.fill,
                            )),
                            child: Text(
                              stack5 != 0 ? "10K" : stack5.toString(),
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: height * 0.01),
                            ),
                          ),
                        ),
                        SizedBox(
                          width: width * 0.02,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 30,
              ),
              bollywoodButtonsPortrait(),
            ]),
          )),
    );
  }

  Widget bollywoodButtons() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                children: [
                  Container(
                    height: height * 0.12,
                    width: width * 0.3,
                    decoration: BoxDecoration(
                        border: Border.all(color: Colors.white, width: 2),
                        borderRadius: BorderRadius.circular(5)),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        InkWell(
                          onTap: () {
                            setState(() {
                              donButton = true;
                              donLayButton = false;
                              amarAkbarutton = false;
                              amarLayAkbarutton = false;
                              sahibButton = false;
                              sahibLayButton = false;
                              dharamButton = false;
                              dharamLayButton = false;
                              kiskisButton = false;
                              kiskisLayButton = false;
                              ghulamButton = false;
                              ghulamLayButton = false;
                              oddButton = false;
                              oddLayButton = false;
                              dulhaButton = false;
                              baratiButton = false;
                              redButton = false;
                              blackButton = false;
                              if (redCoinAnimation == true ||
                                  lightGreenCoinAnimation == true ||
                                  blueCoinAnimation == true ||
                                  greenCoinAnimation == true ||
                                  lightBlueCoinAnimation == true ||
                                  brownCoinAnimation == true) {
                                showMyDialogForBet(redCoinAnimation == true
                                    ? stack1
                                    : lightGreenCoinAnimation == true
                                        ? stack2
                                        : blueCoinAnimation == true
                                            ? stack3
                                            : greenCoinAnimation == true
                                                ? stack4
                                                : lightBlueCoinAnimation == true
                                                    ? stack5
                                                    : brownCoinAnimation == true
                                                        ? stack6
                                                        : 0);
                              }
                            });
                          },
                          child: Container(
                            alignment: Alignment.center,
                            height: height * 0.1,
                            width: width * 0.06,
                            decoration: BoxDecoration(
                                color: Color(0xaa72BBEF),
                                borderRadius: BorderRadius.circular(5)),
                            child: Text(
                              donRate,
                              style: TextStyle(fontWeight: FontWeight.w600),
                            ),
                          ),
                        ),
                        Text(
                          "Don",
                          style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.w600,
                              fontSize: 12),
                        ),
                        InkWell(
                          onTap: () {
                            setState(() {
                              donButton = false;
                              donLayButton = true;
                              amarAkbarutton = false;
                              amarLayAkbarutton = false;
                              sahibButton = false;
                              sahibLayButton = false;
                              dharamButton = false;
                              dharamLayButton = false;
                              kiskisButton = false;
                              kiskisLayButton = false;
                              ghulamButton = false;
                              ghulamLayButton = false;
                              oddButton = false;
                              oddLayButton = false;
                              dulhaButton = false;
                              baratiButton = false;
                              redButton = false;
                              blackButton = false;
                              if (redCoinAnimation == true ||
                                  lightGreenCoinAnimation == true ||
                                  blueCoinAnimation == true ||
                                  greenCoinAnimation == true ||
                                  lightBlueCoinAnimation == true ||
                                  brownCoinAnimation == true) {
                                showMyDialogForBet(redCoinAnimation == true
                                    ? stack1
                                    : lightGreenCoinAnimation == true
                                        ? stack2
                                        : blueCoinAnimation == true
                                            ? stack3
                                            : greenCoinAnimation == true
                                                ? stack4
                                                : lightBlueCoinAnimation == true
                                                    ? stack5
                                                    : brownCoinAnimation == true
                                                        ? stack6
                                                        : 0);
                              }
                            });
                          },
                          child: Container(
                            alignment: Alignment.center,
                            height: height * 0.1,
                            width: width * 0.06,
                            decoration: BoxDecoration(
                                color: Color(0xaaFAA9BA),
                                borderRadius: BorderRadius.circular(5)),
                            child: Text(
                              donLayRate,
                              style: TextStyle(fontWeight: FontWeight.w600),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  showLiablity == true
                      ? Text(
                          liablity5.toString(),
                          style: TextStyle(
                              color:
                                  liablity5 >= 0.0 ? Colors.green : Colors.red),
                        )
                      : Text(""),
                ],
              ),
              Column(
                children: [
                  Container(
                    height: height * 0.12,
                    width: width * 0.3,
                    decoration: BoxDecoration(
                        border: Border.all(color: Colors.white, width: 2),
                        borderRadius: BorderRadius.circular(5)),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        InkWell(
                          onTap: () {
                            setState(() {
                              donButton = false;
                              donLayButton = false;
                              amarAkbarutton = true;
                              amarLayAkbarutton = false;
                              sahibButton = false;
                              sahibLayButton = false;
                              dharamButton = false;
                              dharamLayButton = false;
                              kiskisButton = false;
                              kiskisLayButton = false;
                              ghulamButton = false;
                              ghulamLayButton = false;
                              oddButton = false;
                              oddLayButton = false;
                              dulhaButton = false;
                              baratiButton = false;
                              redButton = false;
                              blackButton = false;
                              if (redCoinAnimation == true ||
                                  lightGreenCoinAnimation == true ||
                                  blueCoinAnimation == true ||
                                  greenCoinAnimation == true ||
                                  lightBlueCoinAnimation == true ||
                                  brownCoinAnimation == true) {
                                showMyDialogForBet(redCoinAnimation == true
                                    ? stack1
                                    : lightGreenCoinAnimation == true
                                        ? stack2
                                        : blueCoinAnimation == true
                                            ? stack3
                                            : greenCoinAnimation == true
                                                ? stack4
                                                : lightBlueCoinAnimation == true
                                                    ? stack5
                                                    : brownCoinAnimation == true
                                                        ? stack6
                                                        : 0);
                              }
                            });
                          },
                          child: Container(
                            alignment: Alignment.center,
                            height: height * 0.1,
                            width: width * 0.06,
                            decoration: BoxDecoration(
                                color: Color(0xaa72BBEF),
                                borderRadius: BorderRadius.circular(5)),
                            child: Text(
                              amarakbarRate,
                              style: TextStyle(fontWeight: FontWeight.w600),
                            ),
                          ),
                        ),
                        Text(
                          "AMAR AKBAR ANTHONY",
                          style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.w600,
                              fontSize: 12),
                        ),
                        InkWell(
                          onTap: () {
                            setState(() {
                              donButton = false;
                              donLayButton = false;
                              amarAkbarutton = false;
                              amarLayAkbarutton = true;
                              sahibButton = false;
                              sahibLayButton = false;
                              dharamButton = false;
                              dharamLayButton = false;
                              kiskisButton = false;
                              kiskisLayButton = false;
                              ghulamButton = false;
                              ghulamLayButton = false;
                              oddButton = false;
                              oddLayButton = false;
                              dulhaButton = false;
                              baratiButton = false;
                              redButton = false;
                              blackButton = false;
                              if (redCoinAnimation == true ||
                                  lightGreenCoinAnimation == true ||
                                  blueCoinAnimation == true ||
                                  greenCoinAnimation == true ||
                                  lightBlueCoinAnimation == true ||
                                  brownCoinAnimation == true) {
                                showMyDialogForBet(redCoinAnimation == true
                                    ? stack1
                                    : lightGreenCoinAnimation == true
                                        ? stack2
                                        : blueCoinAnimation == true
                                            ? stack3
                                            : greenCoinAnimation == true
                                                ? stack4
                                                : lightBlueCoinAnimation == true
                                                    ? stack5
                                                    : brownCoinAnimation == true
                                                        ? stack6
                                                        : 0);
                              }
                            });
                          },
                          child: Container(
                            alignment: Alignment.center,
                            height: height * 0.1,
                            width: width * 0.06,
                            decoration: BoxDecoration(
                                color: Color(0xaaFAA9BA),
                                borderRadius: BorderRadius.circular(5)),
                            child: Text(
                              amarAkbarLayRate,
                              style: TextStyle(fontWeight: FontWeight.w600),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  showLiablity == true
                      ? Text(
                          liablity6.toString(),
                          style: TextStyle(
                              color:
                                  liablity6 >= 0.0 ? Colors.green : Colors.red),
                        )
                      : Text(""),
                ],
              ),
              Column(
                children: [
                  Container(
                    height: height * 0.12,
                    width: width * 0.3,
                    decoration: BoxDecoration(
                        border: Border.all(color: Colors.white, width: 2),
                        borderRadius: BorderRadius.circular(5)),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        InkWell(
                          onTap: () {
                            setState(() {
                              donButton = false;
                              donLayButton = false;
                              amarAkbarutton = false;
                              amarLayAkbarutton = false;
                              sahibButton = true;
                              sahibLayButton = false;
                              dharamButton = false;
                              dharamLayButton = false;
                              kiskisButton = false;
                              kiskisLayButton = false;
                              ghulamButton = false;
                              ghulamLayButton = false;
                              oddButton = false;
                              oddLayButton = false;
                              dulhaButton = false;
                              baratiButton = false;
                              redButton = false;
                              blackButton = false;
                              if (redCoinAnimation == true ||
                                  lightGreenCoinAnimation == true ||
                                  blueCoinAnimation == true ||
                                  greenCoinAnimation == true ||
                                  lightBlueCoinAnimation == true ||
                                  brownCoinAnimation == true) {
                                showMyDialogForBet(redCoinAnimation == true
                                    ? stack1
                                    : lightGreenCoinAnimation == true
                                        ? stack2
                                        : blueCoinAnimation == true
                                            ? stack3
                                            : greenCoinAnimation == true
                                                ? stack4
                                                : lightBlueCoinAnimation == true
                                                    ? stack5
                                                    : brownCoinAnimation == true
                                                        ? stack6
                                                        : 0);
                              }
                            });
                          },
                          child: Container(
                            alignment: Alignment.center,
                            height: height * 0.1,
                            width: width * 0.06,
                            decoration: BoxDecoration(
                                color: Color(0xaa72BBEF),
                                borderRadius: BorderRadius.circular(5)),
                            child: Text(
                              sahibRate,
                              style: TextStyle(fontWeight: FontWeight.w600),
                            ),
                          ),
                        ),
                        Text(
                          "SHAHIB BIWI GULAM",
                          style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.w600,
                              fontSize: 12),
                        ),
                        InkWell(
                          onTap: () {
                            setState(() {
                              donButton = false;
                              donLayButton = false;
                              amarAkbarutton = false;
                              amarLayAkbarutton = false;
                              sahibButton = false;
                              sahibLayButton = true;
                              dharamButton = false;
                              dharamLayButton = false;
                              kiskisButton = false;
                              kiskisLayButton = false;
                              ghulamButton = false;
                              ghulamLayButton = false;
                              oddButton = false;
                              oddLayButton = false;
                              dulhaButton = false;
                              baratiButton = false;
                              redButton = false;
                              blackButton = false;
                              if (redCoinAnimation == true ||
                                  lightGreenCoinAnimation == true ||
                                  blueCoinAnimation == true ||
                                  greenCoinAnimation == true ||
                                  lightBlueCoinAnimation == true ||
                                  brownCoinAnimation == true) {
                                showMyDialogForBet(redCoinAnimation == true
                                    ? stack1
                                    : lightGreenCoinAnimation == true
                                        ? stack2
                                        : blueCoinAnimation == true
                                            ? stack3
                                            : greenCoinAnimation == true
                                                ? stack4
                                                : lightBlueCoinAnimation == true
                                                    ? stack5
                                                    : brownCoinAnimation == true
                                                        ? stack6
                                                        : 0);
                              }
                            });
                          },
                          child: Container(
                            alignment: Alignment.center,
                            height: height * 0.1,
                            width: width * 0.06,
                            decoration: BoxDecoration(
                                color: Color(0xaaFAA9BA),
                                borderRadius: BorderRadius.circular(5)),
                            child: Text(
                              sahibLayRate,
                              style: TextStyle(fontWeight: FontWeight.w600),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  showLiablity == true
                      ? Text(
                          liablity7.toString(),
                          style: TextStyle(
                              color:
                                  liablity7 >= 0.0 ? Colors.green : Colors.red),
                        )
                      : Text(""),
                ],
              ),
            ],
          ),
          SizedBox(
            height: 10,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                children: [
                  Container(
                    height: height * 0.12,
                    width: width * 0.3,
                    decoration: BoxDecoration(
                        border: Border.all(color: Colors.white, width: 2),
                        borderRadius: BorderRadius.circular(5)),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        InkWell(
                          onTap: () {
                            setState(() {
                              donButton = false;
                              donLayButton = false;
                              amarAkbarutton = false;
                              amarLayAkbarutton = false;
                              sahibButton = false;
                              sahibLayButton = false;
                              dharamButton = true;
                              dharamLayButton = false;
                              kiskisButton = false;
                              kiskisLayButton = false;
                              ghulamButton = false;
                              ghulamLayButton = false;
                              oddButton = false;
                              oddLayButton = false;
                              dulhaButton = false;
                              baratiButton = false;
                              redButton = false;
                              blackButton = false;
                              if (redCoinAnimation == true ||
                                  lightGreenCoinAnimation == true ||
                                  blueCoinAnimation == true ||
                                  greenCoinAnimation == true ||
                                  lightBlueCoinAnimation == true ||
                                  brownCoinAnimation == true) {
                                showMyDialogForBet(redCoinAnimation == true
                                    ? stack1
                                    : lightGreenCoinAnimation == true
                                        ? stack2
                                        : blueCoinAnimation == true
                                            ? stack3
                                            : greenCoinAnimation == true
                                                ? stack4
                                                : lightBlueCoinAnimation == true
                                                    ? stack5
                                                    : brownCoinAnimation == true
                                                        ? stack6
                                                        : 0);
                              }
                            });
                          },
                          child: Container(
                            alignment: Alignment.center,
                            height: height * 0.1,
                            width: width * 0.06,
                            decoration: BoxDecoration(
                                color: Color(0xaa72BBEF),
                                borderRadius: BorderRadius.circular(5)),
                            child: Text(
                              dharamRate,
                              style: TextStyle(fontWeight: FontWeight.w600),
                            ),
                          ),
                        ),
                        Text(
                          "DHARAM VEER",
                          style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.w600,
                              fontSize: 12),
                        ),
                        InkWell(
                          onTap: () {
                            setState(() {
                              donButton = false;
                              donLayButton = false;
                              amarAkbarutton = false;
                              amarLayAkbarutton = false;
                              sahibButton = false;
                              sahibLayButton = false;
                              dharamButton = false;
                              dharamLayButton = true;
                              kiskisButton = false;
                              kiskisLayButton = false;
                              ghulamButton = false;
                              ghulamLayButton = false;
                              oddButton = false;
                              oddLayButton = false;
                              dulhaButton = false;
                              baratiButton = false;
                              redButton = false;
                              blackButton = false;
                              if (redCoinAnimation == true ||
                                  lightGreenCoinAnimation == true ||
                                  blueCoinAnimation == true ||
                                  greenCoinAnimation == true ||
                                  lightBlueCoinAnimation == true ||
                                  brownCoinAnimation == true) {
                                showMyDialogForBet(redCoinAnimation == true
                                    ? stack1
                                    : lightGreenCoinAnimation == true
                                        ? stack2
                                        : blueCoinAnimation == true
                                            ? stack3
                                            : greenCoinAnimation == true
                                                ? stack4
                                                : lightBlueCoinAnimation == true
                                                    ? stack5
                                                    : brownCoinAnimation == true
                                                        ? stack6
                                                        : 0);
                              }
                            });
                          },
                          child: Container(
                            alignment: Alignment.center,
                            height: height * 0.1,
                            width: width * 0.06,
                            decoration: BoxDecoration(
                                color: Color(0xaaFAA9BA),
                                borderRadius: BorderRadius.circular(5)),
                            child: Text(
                              dharamLayRate,
                              style: TextStyle(fontWeight: FontWeight.w600),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  showLiablity == true
                      ? Text(
                          liablity8.toString(),
                          style: TextStyle(
                              color:
                                  liablity8 >= 0.0 ? Colors.green : Colors.red),
                        )
                      : Text(""),
                ],
              ),
              Column(
                children: [
                  Container(
                    height: height * 0.12,
                    width: width * 0.3,
                    decoration: BoxDecoration(
                        border: Border.all(color: Colors.white, width: 2),
                        borderRadius: BorderRadius.circular(5)),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        InkWell(
                          onTap: () {
                            setState(() {
                              donButton = false;
                              donLayButton = false;
                              amarAkbarutton = false;
                              amarLayAkbarutton = false;
                              sahibButton = false;
                              sahibLayButton = false;
                              dharamButton = false;
                              dharamLayButton = false;
                              kiskisButton = true;
                              kiskisLayButton = false;
                              ghulamButton = false;
                              ghulamLayButton = false;
                              oddButton = false;
                              oddLayButton = false;
                              dulhaButton = false;
                              baratiButton = false;
                              redButton = false;
                              blackButton = false;
                              if (redCoinAnimation == true ||
                                  lightGreenCoinAnimation == true ||
                                  blueCoinAnimation == true ||
                                  greenCoinAnimation == true ||
                                  lightBlueCoinAnimation == true ||
                                  brownCoinAnimation == true) {
                                showMyDialogForBet(redCoinAnimation == true
                                    ? stack1
                                    : lightGreenCoinAnimation == true
                                        ? stack2
                                        : blueCoinAnimation == true
                                            ? stack3
                                            : greenCoinAnimation == true
                                                ? stack4
                                                : lightBlueCoinAnimation == true
                                                    ? stack5
                                                    : brownCoinAnimation == true
                                                        ? stack6
                                                        : 0);
                              }
                            });
                          },
                          child: Container(
                            alignment: Alignment.center,
                            height: height * 0.1,
                            width: width * 0.06,
                            decoration: BoxDecoration(
                                color: Color(0xaa72BBEF),
                                borderRadius: BorderRadius.circular(5)),
                            child: Text(
                              kiskisRate,
                              style: TextStyle(fontWeight: FontWeight.w600),
                            ),
                          ),
                        ),
                        Text(
                          "KIS KIS KO PYAR KAROON",
                          style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.w600,
                              fontSize: 12),
                        ),
                        InkWell(
                          onTap: () {
                            setState(() {
                              donButton = false;
                              donLayButton = false;
                              amarAkbarutton = false;
                              amarLayAkbarutton = false;
                              sahibButton = false;
                              sahibLayButton = false;
                              dharamButton = false;
                              dharamLayButton = false;
                              kiskisButton = false;
                              kiskisLayButton = true;
                              ghulamButton = false;
                              ghulamLayButton = false;
                              oddButton = false;
                              oddLayButton = false;
                              dulhaButton = false;
                              baratiButton = false;
                              redButton = false;
                              blackButton = false;
                              if (redCoinAnimation == true ||
                                  lightGreenCoinAnimation == true ||
                                  blueCoinAnimation == true ||
                                  greenCoinAnimation == true ||
                                  lightBlueCoinAnimation == true ||
                                  brownCoinAnimation == true) {
                                showMyDialogForBet(redCoinAnimation == true
                                    ? stack1
                                    : lightGreenCoinAnimation == true
                                        ? stack2
                                        : blueCoinAnimation == true
                                            ? stack3
                                            : greenCoinAnimation == true
                                                ? stack4
                                                : lightBlueCoinAnimation == true
                                                    ? stack5
                                                    : brownCoinAnimation == true
                                                        ? stack6
                                                        : 0);
                              }
                            });
                          },
                          child: Container(
                            alignment: Alignment.center,
                            height: height * 0.1,
                            width: width * 0.06,
                            decoration: BoxDecoration(
                                color: Color(0xaaFAA9BA),
                                borderRadius: BorderRadius.circular(5)),
                            child: Text(
                              kiskisLayRate,
                              style: TextStyle(fontWeight: FontWeight.w600),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  showLiablity == true
                      ? Text(
                          liablity9.toString(),
                          style: TextStyle(
                              color:
                                  liablity9 >= 0.0 ? Colors.green : Colors.red),
                        )
                      : Text(""),
                ],
              ),
              Column(
                children: [
                  Container(
                    height: height * 0.12,
                    width: width * 0.3,
                    decoration: BoxDecoration(
                        border: Border.all(color: Colors.white, width: 2),
                        borderRadius: BorderRadius.circular(5)),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        InkWell(
                          onTap: () {
                            setState(() {
                              donButton = false;
                              donLayButton = false;
                              amarAkbarutton = false;
                              amarLayAkbarutton = false;
                              sahibButton = false;
                              sahibLayButton = false;
                              dharamButton = false;
                              dharamLayButton = false;
                              kiskisButton = false;
                              kiskisLayButton = false;
                              ghulamButton = true;
                              ghulamLayButton = false;
                              oddButton = false;
                              oddLayButton = false;
                              dulhaButton = false;
                              baratiButton = false;
                              redButton = false;
                              blackButton = false;
                              if (redCoinAnimation == true ||
                                  lightGreenCoinAnimation == true ||
                                  blueCoinAnimation == true ||
                                  greenCoinAnimation == true ||
                                  lightBlueCoinAnimation == true ||
                                  brownCoinAnimation == true) {
                                showMyDialogForBet(redCoinAnimation == true
                                    ? stack1
                                    : lightGreenCoinAnimation == true
                                        ? stack2
                                        : blueCoinAnimation == true
                                            ? stack3
                                            : greenCoinAnimation == true
                                                ? stack4
                                                : lightBlueCoinAnimation == true
                                                    ? stack5
                                                    : brownCoinAnimation == true
                                                        ? stack6
                                                        : 0);
                              }
                            });
                          },
                          child: Container(
                            alignment: Alignment.center,
                            height: height * 0.1,
                            width: width * 0.06,
                            decoration: BoxDecoration(
                                color: Color(0xaa72BBEF),
                                borderRadius: BorderRadius.circular(5)),
                            child: Text(
                              ghulamRate,
                              style: TextStyle(fontWeight: FontWeight.w600),
                            ),
                          ),
                        ),
                        Text(
                          "GHULAM",
                          style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.w600,
                              fontSize: 12),
                        ),
                        InkWell(
                          onTap: () {
                            setState(() {
                              donButton = false;
                              donLayButton = false;
                              amarAkbarutton = false;
                              amarLayAkbarutton = false;
                              sahibButton = false;
                              sahibLayButton = false;
                              dharamButton = false;
                              dharamLayButton = false;
                              kiskisButton = false;
                              kiskisLayButton = false;
                              ghulamButton = false;
                              ghulamLayButton = true;
                              oddButton = false;
                              oddLayButton = false;
                              dulhaButton = false;
                              baratiButton = false;
                              redButton = false;
                              blackButton = false;
                              if (redCoinAnimation == true ||
                                  lightGreenCoinAnimation == true ||
                                  blueCoinAnimation == true ||
                                  greenCoinAnimation == true ||
                                  lightBlueCoinAnimation == true ||
                                  brownCoinAnimation == true) {
                                showMyDialogForBet(redCoinAnimation == true
                                    ? stack1
                                    : lightGreenCoinAnimation == true
                                        ? stack2
                                        : blueCoinAnimation == true
                                            ? stack3
                                            : greenCoinAnimation == true
                                                ? stack4
                                                : lightBlueCoinAnimation == true
                                                    ? stack5
                                                    : brownCoinAnimation == true
                                                        ? stack6
                                                        : 0);
                              }
                            });
                          },
                          child: Container(
                            alignment: Alignment.center,
                            height: height * 0.1,
                            width: width * 0.06,
                            decoration: BoxDecoration(
                                color: Color(0xaaFAA9BA),
                                borderRadius: BorderRadius.circular(5)),
                            child: Text(
                              ghulamLayRate,
                              style: TextStyle(fontWeight: FontWeight.w600),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  showLiablity == true
                      ? Text(
                          liablity10.toString(),
                          style: TextStyle(
                              color: liablity10 >= 0.0
                                  ? Colors.green
                                  : Colors.red),
                        )
                      : Text(""),
                ],
              ),
            ],
          ),
          SizedBox(
            height: 10,
          ),
          Container(
            height: 2,
            width: width,
            decoration: BoxDecoration(
                image: DecorationImage(
                    image: AssetImage("assets/bollywoodTable/Line 42 (3).png"),
                    fit: BoxFit.cover)),
          ),
          SizedBox(
            height: 10,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Column(
                children: [
                  Container(
                    height: height * 0.12,
                    width: width * 0.3,
                    decoration: BoxDecoration(
                        border: Border.all(color: Colors.white, width: 2),
                        borderRadius: BorderRadius.circular(5)),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        InkWell(
                          onTap: () {
                            setState(() {
                              donButton = false;
                              donLayButton = false;
                              amarAkbarutton = false;
                              amarLayAkbarutton = false;
                              sahibButton = false;
                              sahibLayButton = false;
                              dharamButton = false;
                              dharamLayButton = false;
                              kiskisButton = false;
                              kiskisLayButton = false;
                              ghulamButton = false;
                              ghulamLayButton = false;
                              oddButton = true;
                              oddLayButton = false;
                              dulhaButton = false;
                              baratiButton = false;
                              redButton = false;
                              blackButton = false;
                              if (redCoinAnimation == true ||
                                  lightGreenCoinAnimation == true ||
                                  blueCoinAnimation == true ||
                                  greenCoinAnimation == true ||
                                  lightBlueCoinAnimation == true ||
                                  brownCoinAnimation == true) {
                                showMyDialogForBet(redCoinAnimation == true
                                    ? stack1
                                    : lightGreenCoinAnimation == true
                                        ? stack2
                                        : blueCoinAnimation == true
                                            ? stack3
                                            : greenCoinAnimation == true
                                                ? stack4
                                                : lightBlueCoinAnimation == true
                                                    ? stack5
                                                    : brownCoinAnimation == true
                                                        ? stack6
                                                        : 0);
                              }
                            });
                          },
                          child: Container(
                            alignment: Alignment.center,
                            height: height * 0.1,
                            width: width * 0.06,
                            decoration: BoxDecoration(
                                color: Color(0xaa72BBEF),
                                borderRadius: BorderRadius.circular(5)),
                            child: Text(
                              oddRate,
                              style: TextStyle(fontWeight: FontWeight.w600),
                            ),
                          ),
                        ),
                        Text(
                          "ODD",
                          style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.w600,
                              fontSize: 12),
                        ),
                        InkWell(
                          onTap: () {
                            setState(() {
                              donButton = false;
                              donLayButton = false;
                              amarAkbarutton = false;
                              amarLayAkbarutton = false;
                              sahibButton = false;
                              sahibLayButton = false;
                              dharamButton = false;
                              dharamLayButton = false;
                              kiskisButton = false;
                              kiskisLayButton = false;
                              ghulamButton = false;
                              ghulamLayButton = false;
                              oddButton = false;
                              oddLayButton = true;
                              dulhaButton = false;
                              baratiButton = false;
                              redButton = false;
                              blackButton = false;
                              if (redCoinAnimation == true ||
                                  lightGreenCoinAnimation == true ||
                                  blueCoinAnimation == true ||
                                  greenCoinAnimation == true ||
                                  lightBlueCoinAnimation == true ||
                                  brownCoinAnimation == true) {
                                showMyDialogForBet(redCoinAnimation == true
                                    ? stack1
                                    : lightGreenCoinAnimation == true
                                        ? stack2
                                        : blueCoinAnimation == true
                                            ? stack3
                                            : greenCoinAnimation == true
                                                ? stack4
                                                : lightBlueCoinAnimation == true
                                                    ? stack5
                                                    : brownCoinAnimation == true
                                                        ? stack6
                                                        : 0);
                              }
                            });
                          },
                          child: Container(
                            alignment: Alignment.center,
                            height: height * 0.1,
                            width: width * 0.06,
                            decoration: BoxDecoration(
                                color: Color(0xaaFAA9BA),
                                borderRadius: BorderRadius.circular(5)),
                            child: Text(
                              oddLayRate,
                              style: TextStyle(fontWeight: FontWeight.w600),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  showLiablity == true
                      ? Text(
                          liablity11.toString(),
                          style: TextStyle(
                              color: liablity11 >= 0.0
                                  ? Colors.green
                                  : Colors.red),
                        )
                      : Text(""),
                ],
              ),
              SizedBox(
                width: 20,
              ),
              Container(
                height: height * 0.3,
                width: 1,
                decoration: BoxDecoration(
                    image: DecorationImage(
                        image:
                            AssetImage("assets/bollywoodTable/Line 42 (3).png"),
                        fit: BoxFit.cover)),
              ),
              SizedBox(
                width: 20,
              ),
              Column(
                children: [
                  Container(
                    height: height * 0.12,
                    width: width * 0.2,
                    decoration: BoxDecoration(
                        border: Border.all(color: Color(0xaa873800), width: 2),
                        borderRadius: BorderRadius.circular(5)),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        SizedBox(),
                        Text(
                          "DULHA DULHAN K-Q",
                          style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.w600,
                              fontSize: 10),
                        ),
                        InkWell(
                          onTap: () {
                            setState(() {
                              donButton = false;
                              donLayButton = false;
                              amarAkbarutton = false;
                              amarLayAkbarutton = false;
                              sahibButton = false;
                              sahibLayButton = false;
                              dharamButton = false;
                              dharamLayButton = false;
                              kiskisButton = false;
                              kiskisLayButton = false;
                              ghulamButton = false;
                              ghulamLayButton = false;
                              oddButton = false;
                              oddLayButton = false;
                              dulhaButton = true;
                              baratiButton = false;
                              redButton = false;
                              blackButton = false;
                              if (redCoinAnimation == true ||
                                  lightGreenCoinAnimation == true ||
                                  blueCoinAnimation == true ||
                                  greenCoinAnimation == true ||
                                  lightBlueCoinAnimation == true ||
                                  brownCoinAnimation == true) {
                                showMyDialogForBet(redCoinAnimation == true
                                    ? stack1
                                    : lightGreenCoinAnimation == true
                                        ? stack2
                                        : blueCoinAnimation == true
                                            ? stack3
                                            : greenCoinAnimation == true
                                                ? stack4
                                                : lightBlueCoinAnimation == true
                                                    ? stack5
                                                    : brownCoinAnimation == true
                                                        ? stack6
                                                        : 0);
                              }
                            });
                          },
                          child: Container(
                            alignment: Alignment.center,
                            height: height * 0.1,
                            width: width * 0.06,
                            decoration: BoxDecoration(
                                color: Color(0xaa0288A5),
                                borderRadius: BorderRadius.circular(5)),
                            child: Text(
                              dulhaDulhanRate,
                              style: TextStyle(fontWeight: FontWeight.w600),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  showLiablity == true
                      ? Text(
                          liablity3.toString(),
                          style: TextStyle(
                              color:
                                  liablity3 >= 0.0 ? Colors.green : Colors.red),
                        )
                      : Text(""),
                  SizedBox(
                    height: 10,
                  ),
                  Container(
                    height: height * 0.12,
                    width: width * 0.2,
                    decoration: BoxDecoration(
                        border: Border.all(color: Color(0xaa873800), width: 2),
                        borderRadius: BorderRadius.circular(5)),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        SizedBox(),
                        Container(
                          height: 35,
                          width: width * 0.1,
                          decoration: BoxDecoration(
                              image: DecorationImage(
                                  image: AssetImage(
                                      "assets/bollywoodTable/black-image.png"),
                                  fit: BoxFit.contain)),
                        ),
                        InkWell(
                          onTap: () {
                            setState(() {
                              donButton = false;
                              donLayButton = false;
                              amarAkbarutton = false;
                              amarLayAkbarutton = false;
                              sahibButton = false;
                              sahibLayButton = false;
                              dharamButton = false;
                              dharamLayButton = false;
                              kiskisButton = false;
                              kiskisLayButton = false;
                              ghulamButton = false;
                              ghulamLayButton = false;
                              oddButton = false;
                              oddLayButton = false;
                              dulhaButton = false;
                              baratiButton = false;
                              redButton = false;
                              blackButton = true;
                              if (redCoinAnimation == true ||
                                  lightGreenCoinAnimation == true ||
                                  blueCoinAnimation == true ||
                                  greenCoinAnimation == true ||
                                  lightBlueCoinAnimation == true ||
                                  brownCoinAnimation == true) {
                                // showMyDialog(redCoinAnimation == true
                                //     ? stack1
                                //     : lightGreenCoinAnimation == true
                                //         ? stack2
                                //         : blueCoinAnimation == true
                                //             ? stack3
                                //             : greenCoinAnimation == true
                                //                 ? stack4
                                //                 : lightBlueCoinAnimation == true
                                //                     ? stack5
                                //                     : brownCoinAnimation == true
                                //                         ? stack6
                                //                         : 0);
                              }
                            });
                          },
                          child: Container(
                            alignment: Alignment.center,
                            height: height * 0.1,
                            width: width * 0.06,
                            decoration: BoxDecoration(
                                color: Color(0xaa0288A5),
                                borderRadius: BorderRadius.circular(5)),
                            child: Text(
                              blackRate,
                              style: TextStyle(fontWeight: FontWeight.w600),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  showLiablity == true
                      ? Text(
                          liablity13.toString(),
                          style: TextStyle(
                              color: liablity13 >= 0.0
                                  ? Colors.green
                                  : Colors.red),
                        )
                      : Text(""),
                ],
              ),
              SizedBox(
                width: 20,
              ),
              Column(
                children: [
                  Container(
                    height: height * 0.12,
                    width: width * 0.2,
                    decoration: BoxDecoration(
                        border: Border.all(color: Color(0xaa873800), width: 2),
                        borderRadius: BorderRadius.circular(5)),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        SizedBox(),
                        Text(
                          "BARATI J-A",
                          style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.w600,
                              fontSize: 10),
                        ),
                        InkWell(
                          onTap: () {
                            setState(() {
                              donButton = false;
                              donLayButton = false;
                              amarAkbarutton = false;
                              amarLayAkbarutton = false;
                              sahibButton = false;
                              sahibLayButton = false;
                              dharamButton = false;
                              dharamLayButton = false;
                              kiskisButton = false;
                              kiskisLayButton = false;
                              ghulamButton = false;
                              ghulamLayButton = false;
                              oddButton = false;
                              oddLayButton = false;
                              dulhaButton = false;
                              baratiButton = true;
                              redButton = false;
                              blackButton = false;
                              if (redCoinAnimation == true ||
                                  lightGreenCoinAnimation == true ||
                                  blueCoinAnimation == true ||
                                  greenCoinAnimation == true ||
                                  lightBlueCoinAnimation == true ||
                                  brownCoinAnimation == true) {
                                showMyDialogForBet(redCoinAnimation == true
                                    ? stack1
                                    : lightGreenCoinAnimation == true
                                        ? stack2
                                        : blueCoinAnimation == true
                                            ? stack3
                                            : greenCoinAnimation == true
                                                ? stack4
                                                : lightBlueCoinAnimation == true
                                                    ? stack5
                                                    : brownCoinAnimation == true
                                                        ? stack6
                                                        : 0);
                              }
                            });
                          },
                          child: Container(
                            alignment: Alignment.center,
                            height: height * 0.1,
                            width: width * 0.06,
                            decoration: BoxDecoration(
                                color: Color(0xaa0288A5),
                                borderRadius: BorderRadius.circular(5)),
                            child: Text(
                              baratiRate,
                              style: TextStyle(fontWeight: FontWeight.w600),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  showLiablity == true
                      ? Text(
                          liablity4.toString(),
                          style: TextStyle(
                              color:
                                  liablity4 >= 0.0 ? Colors.green : Colors.red),
                        )
                      : Text(""),
                  SizedBox(
                    height: 10,
                  ),
                  Container(
                    height: height * 0.12,
                    width: width * 0.2,
                    decoration: BoxDecoration(
                        border: Border.all(color: Color(0xaa873800), width: 2),
                        borderRadius: BorderRadius.circular(5)),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        SizedBox(),
                        Container(
                          height: 35,
                          width: width * 0.1,
                          decoration: BoxDecoration(
                              image: DecorationImage(
                                  image: AssetImage(
                                      "assets/bollywoodTable/red-image.png"),
                                  fit: BoxFit.contain)),
                        ),
                        InkWell(
                          onTap: () {
                            setState(() {
                              donButton = false;
                              donLayButton = false;
                              amarAkbarutton = false;
                              amarLayAkbarutton = false;
                              sahibButton = false;
                              sahibLayButton = false;
                              dharamButton = false;
                              dharamLayButton = false;
                              kiskisButton = false;
                              kiskisLayButton = false;
                              ghulamButton = false;
                              ghulamLayButton = false;
                              oddButton = false;
                              oddLayButton = false;
                              dulhaButton = false;
                              baratiButton = false;
                              redButton = true;
                              blackButton = false;
                              if (redCoinAnimation == true ||
                                  lightGreenCoinAnimation == true ||
                                  blueCoinAnimation == true ||
                                  greenCoinAnimation == true ||
                                  lightBlueCoinAnimation == true ||
                                  brownCoinAnimation == true) {
                                showMyDialogForBet(redCoinAnimation == true
                                    ? stack1
                                    : lightGreenCoinAnimation == true
                                        ? stack2
                                        : blueCoinAnimation == true
                                            ? stack3
                                            : greenCoinAnimation == true
                                                ? stack4
                                                : lightBlueCoinAnimation == true
                                                    ? stack5
                                                    : brownCoinAnimation == true
                                                        ? stack6
                                                        : 0);
                              }
                            });
                          },
                          child: Container(
                            alignment: Alignment.center,
                            height: height * 0.1,
                            width: width * 0.06,
                            decoration: BoxDecoration(
                                color: Color(0xaa0288A5),
                                borderRadius: BorderRadius.circular(5)),
                            child: Text(
                              redRate,
                              style: TextStyle(fontWeight: FontWeight.w600),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  showLiablity == true
                      ? Text(
                          liablity12.toString(),
                          style: TextStyle(
                              color: liablity12 >= 0.0
                                  ? Colors.green
                                  : Colors.red),
                        )
                      : Text(""),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget bollywoodButtonsPortrait() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Container(
            height: height * 0.06,
            width: width * 0.9,
            decoration: BoxDecoration(
                border: Border.all(color: Colors.white, width: 2),
                borderRadius: BorderRadius.circular(5)),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                InkWell(
                  onTap: () {
                    setState(() {
                      donButton = true;
                      donLayButton = false;
                      amarAkbarutton = false;
                      amarLayAkbarutton = false;
                      sahibButton = false;
                      sahibLayButton = false;
                      dharamButton = false;
                      dharamLayButton = false;
                      kiskisButton = false;
                      kiskisLayButton = false;
                      ghulamButton = false;
                      ghulamLayButton = false;
                      oddButton = false;
                      oddLayButton = false;
                      dulhaButton = false;
                      baratiButton = false;
                      redButton = false;
                      blackButton = false;
                      if (redCoinAnimation == true ||
                          lightGreenCoinAnimation == true ||
                          blueCoinAnimation == true ||
                          greenCoinAnimation == true ||
                          lightBlueCoinAnimation == true ||
                          brownCoinAnimation == true) {
                        showMyDialogForBetPortrait(redCoinAnimation == true
                            ? stack1
                            : lightGreenCoinAnimation == true
                                ? stack2
                                : blueCoinAnimation == true
                                    ? stack3
                                    : greenCoinAnimation == true
                                        ? stack4
                                        : lightBlueCoinAnimation == true
                                            ? stack5
                                            : brownCoinAnimation == true
                                                ? stack6
                                                : 0);
                      }
                    });
                  },
                  child: Container(
                    alignment: Alignment.center,
                    height: height * 0.1,
                    width: width * 0.15,
                    decoration: BoxDecoration(
                        color: Color(0xaa72BBEF),
                        borderRadius: BorderRadius.circular(5)),
                    child: Text(
                      donRate,
                      style: TextStyle(fontWeight: FontWeight.w600),
                    ),
                  ),
                ),
                Text(
                  "Don",
                  style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w600,
                      fontSize: 12),
                ),
                InkWell(
                  onTap: () {
                    setState(() {
                      donButton = false;
                      donLayButton = true;
                      amarAkbarutton = false;
                      amarLayAkbarutton = false;
                      sahibButton = false;
                      sahibLayButton = false;
                      dharamButton = false;
                      dharamLayButton = false;
                      kiskisButton = false;
                      kiskisLayButton = false;
                      ghulamButton = false;
                      ghulamLayButton = false;
                      oddButton = false;
                      oddLayButton = false;
                      dulhaButton = false;
                      baratiButton = false;
                      redButton = false;
                      blackButton = false;
                      if (redCoinAnimation == true ||
                          lightGreenCoinAnimation == true ||
                          blueCoinAnimation == true ||
                          greenCoinAnimation == true ||
                          lightBlueCoinAnimation == true ||
                          brownCoinAnimation == true) {
                        showMyDialogForBetPortrait(redCoinAnimation == true
                            ? stack1
                            : lightGreenCoinAnimation == true
                                ? stack2
                                : blueCoinAnimation == true
                                    ? stack3
                                    : greenCoinAnimation == true
                                        ? stack4
                                        : lightBlueCoinAnimation == true
                                            ? stack5
                                            : brownCoinAnimation == true
                                                ? stack6
                                                : 0);
                      }
                    });
                  },
                  child: Container(
                    alignment: Alignment.center,
                    height: height * 0.1,
                    width: width * 0.15,
                    decoration: BoxDecoration(
                        color: Color(0xaaFAA9BA),
                        borderRadius: BorderRadius.circular(5)),
                    child: Text(
                      donLayRate,
                      style: TextStyle(fontWeight: FontWeight.w600),
                    ),
                  ),
                ),
              ],
            ),
          ),
          showLiablity == true
              ? Text(
                  liablity5.toString(),
                  style: TextStyle(
                      color: liablity5 >= 0.0 ? Colors.green : Colors.red),
                )
              : Text(""),
          SizedBox(
            height: 10,
          ),
          Container(
            height: height * 0.06,
            width: width * 0.9,
            decoration: BoxDecoration(
                border: Border.all(color: Colors.white, width: 2),
                borderRadius: BorderRadius.circular(5)),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                InkWell(
                  onTap: () {
                    setState(() {
                      donButton = false;
                      donLayButton = false;
                      amarAkbarutton = true;
                      amarLayAkbarutton = false;
                      sahibButton = false;
                      sahibLayButton = false;
                      dharamButton = false;
                      dharamLayButton = false;
                      kiskisButton = false;
                      kiskisLayButton = false;
                      ghulamButton = false;
                      ghulamLayButton = false;
                      oddButton = false;
                      oddLayButton = false;
                      dulhaButton = false;
                      baratiButton = false;
                      redButton = false;
                      blackButton = false;
                      if (redCoinAnimation == true ||
                          lightGreenCoinAnimation == true ||
                          blueCoinAnimation == true ||
                          greenCoinAnimation == true ||
                          lightBlueCoinAnimation == true ||
                          brownCoinAnimation == true) {
                        showMyDialogForBetPortrait(redCoinAnimation == true
                            ? stack1
                            : lightGreenCoinAnimation == true
                                ? stack2
                                : blueCoinAnimation == true
                                    ? stack3
                                    : greenCoinAnimation == true
                                        ? stack4
                                        : lightBlueCoinAnimation == true
                                            ? stack5
                                            : brownCoinAnimation == true
                                                ? stack6
                                                : 0);
                      }
                    });
                  },
                  child: Container(
                    alignment: Alignment.center,
                    height: height * 0.1,
                    width: width * 0.15,
                    decoration: BoxDecoration(
                        color: Color(0xaa72BBEF),
                        borderRadius: BorderRadius.circular(5)),
                    child: Text(
                      amarakbarRate,
                      style: TextStyle(fontWeight: FontWeight.w600),
                    ),
                  ),
                ),
                Text(
                  "AMAR AKBAR ANTHONY",
                  style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w600,
                      fontSize: 12),
                ),
                InkWell(
                  onTap: () {
                    setState(() {
                      donButton = false;
                      donLayButton = false;
                      amarAkbarutton = false;
                      amarLayAkbarutton = true;
                      sahibButton = false;
                      sahibLayButton = false;
                      dharamButton = false;
                      dharamLayButton = false;
                      kiskisButton = false;
                      kiskisLayButton = false;
                      ghulamButton = false;
                      ghulamLayButton = false;
                      oddButton = false;
                      oddLayButton = false;
                      dulhaButton = false;
                      baratiButton = false;
                      redButton = false;
                      blackButton = false;
                      if (redCoinAnimation == true ||
                          lightGreenCoinAnimation == true ||
                          blueCoinAnimation == true ||
                          greenCoinAnimation == true ||
                          lightBlueCoinAnimation == true ||
                          brownCoinAnimation == true) {
                        showMyDialogForBetPortrait(redCoinAnimation == true
                            ? stack1
                            : lightGreenCoinAnimation == true
                                ? stack2
                                : blueCoinAnimation == true
                                    ? stack3
                                    : greenCoinAnimation == true
                                        ? stack4
                                        : lightBlueCoinAnimation == true
                                            ? stack5
                                            : brownCoinAnimation == true
                                                ? stack6
                                                : 0);
                      }
                    });
                  },
                  child: Container(
                    alignment: Alignment.center,
                    height: height * 0.1,
                    width: width * 0.15,
                    decoration: BoxDecoration(
                        color: Color(0xaaFAA9BA),
                        borderRadius: BorderRadius.circular(5)),
                    child: Text(
                      amarAkbarLayRate,
                      style: TextStyle(fontWeight: FontWeight.w600),
                    ),
                  ),
                ),
              ],
            ),
          ),
          showLiablity == true
              ? Text(
                  liablity6.toString(),
                  style: TextStyle(
                      color: liablity6 >= 0.0 ? Colors.green : Colors.red),
                )
              : Text(""),
          SizedBox(
            height: 10,
          ),
          Column(
            children: [
              Container(
                height: height * 0.06,
                width: width * 0.9,
                decoration: BoxDecoration(
                    border: Border.all(color: Colors.white, width: 2),
                    borderRadius: BorderRadius.circular(5)),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    InkWell(
                      onTap: () {
                        setState(() {
                          donButton = false;
                          donLayButton = false;
                          amarAkbarutton = false;
                          amarLayAkbarutton = false;
                          sahibButton = true;
                          sahibLayButton = false;
                          dharamButton = false;
                          dharamLayButton = false;
                          kiskisButton = false;
                          kiskisLayButton = false;
                          ghulamButton = false;
                          ghulamLayButton = false;
                          oddButton = false;
                          oddLayButton = false;
                          dulhaButton = false;
                          baratiButton = false;
                          redButton = false;
                          blackButton = false;
                          if (redCoinAnimation == true ||
                              lightGreenCoinAnimation == true ||
                              blueCoinAnimation == true ||
                              greenCoinAnimation == true ||
                              lightBlueCoinAnimation == true ||
                              brownCoinAnimation == true) {
                            showMyDialogForBetPortrait(redCoinAnimation == true
                                ? stack1
                                : lightGreenCoinAnimation == true
                                    ? stack2
                                    : blueCoinAnimation == true
                                        ? stack3
                                        : greenCoinAnimation == true
                                            ? stack4
                                            : lightBlueCoinAnimation == true
                                                ? stack5
                                                : brownCoinAnimation == true
                                                    ? stack6
                                                    : 0);
                          }
                        });
                      },
                      child: Container(
                        alignment: Alignment.center,
                        height: height * 0.1,
                        width: width * 0.15,
                        decoration: BoxDecoration(
                            color: Color(0xaa72BBEF),
                            borderRadius: BorderRadius.circular(5)),
                        child: Text(
                          sahibRate,
                          style: TextStyle(fontWeight: FontWeight.w600),
                        ),
                      ),
                    ),
                    Text(
                      "SHAHIB BIWI GULAM",
                      style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w600,
                          fontSize: 12),
                    ),
                    InkWell(
                      onTap: () {
                        setState(() {
                          donButton = false;
                          donLayButton = false;
                          amarAkbarutton = false;
                          amarLayAkbarutton = false;
                          sahibButton = false;
                          sahibLayButton = true;
                          dharamButton = false;
                          dharamLayButton = false;
                          kiskisButton = false;
                          kiskisLayButton = false;
                          ghulamButton = false;
                          ghulamLayButton = false;
                          oddButton = false;
                          oddLayButton = false;
                          dulhaButton = false;
                          baratiButton = false;
                          redButton = false;
                          blackButton = false;
                          if (redCoinAnimation == true ||
                              lightGreenCoinAnimation == true ||
                              blueCoinAnimation == true ||
                              greenCoinAnimation == true ||
                              lightBlueCoinAnimation == true ||
                              brownCoinAnimation == true) {
                            showMyDialogForBetPortrait(redCoinAnimation == true
                                ? stack1
                                : lightGreenCoinAnimation == true
                                    ? stack2
                                    : blueCoinAnimation == true
                                        ? stack3
                                        : greenCoinAnimation == true
                                            ? stack4
                                            : lightBlueCoinAnimation == true
                                                ? stack5
                                                : brownCoinAnimation == true
                                                    ? stack6
                                                    : 0);
                          }
                        });
                      },
                      child: Container(
                        alignment: Alignment.center,
                        height: height * 0.1,
                        width: width * 0.15,
                        decoration: BoxDecoration(
                            color: Color(0xaaFAA9BA),
                            borderRadius: BorderRadius.circular(5)),
                        child: Text(
                          sahibLayRate,
                          style: TextStyle(fontWeight: FontWeight.w600),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              showLiablity == true
                  ? Text(
                      liablity7.toString(),
                      style: TextStyle(
                          color: liablity7 >= 0.0 ? Colors.green : Colors.red),
                    )
                  : Text(""),
            ],
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                height: height * 0.06,
                width: width * 0.9,
                decoration: BoxDecoration(
                    border: Border.all(color: Colors.white, width: 2),
                    borderRadius: BorderRadius.circular(5)),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    InkWell(
                      onTap: () {
                        setState(() {
                          donButton = false;
                          donLayButton = false;
                          amarAkbarutton = false;
                          amarLayAkbarutton = false;
                          sahibButton = false;
                          sahibLayButton = false;
                          dharamButton = true;
                          dharamLayButton = false;
                          kiskisButton = false;
                          kiskisLayButton = false;
                          ghulamButton = false;
                          ghulamLayButton = false;
                          oddButton = false;
                          oddLayButton = false;
                          dulhaButton = false;
                          baratiButton = false;
                          redButton = false;
                          blackButton = false;
                          if (redCoinAnimation == true ||
                              lightGreenCoinAnimation == true ||
                              blueCoinAnimation == true ||
                              greenCoinAnimation == true ||
                              lightBlueCoinAnimation == true ||
                              brownCoinAnimation == true) {
                            showMyDialogForBetPortrait(redCoinAnimation == true
                                ? stack1
                                : lightGreenCoinAnimation == true
                                    ? stack2
                                    : blueCoinAnimation == true
                                        ? stack3
                                        : greenCoinAnimation == true
                                            ? stack4
                                            : lightBlueCoinAnimation == true
                                                ? stack5
                                                : brownCoinAnimation == true
                                                    ? stack6
                                                    : 0);
                          }
                        });
                      },
                      child: Container(
                        alignment: Alignment.center,
                        height: height * 0.1,
                        width: width * 0.15,
                        decoration: BoxDecoration(
                            color: Color(0xaa72BBEF),
                            borderRadius: BorderRadius.circular(5)),
                        child: Text(
                          dharamRate,
                          style: TextStyle(fontWeight: FontWeight.w600),
                        ),
                      ),
                    ),
                    Text(
                      "DHARAM VEER",
                      style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w600,
                          fontSize: 12),
                    ),
                    InkWell(
                      onTap: () {
                        setState(() {
                          donButton = false;
                          donLayButton = false;
                          amarAkbarutton = false;
                          amarLayAkbarutton = false;
                          sahibButton = false;
                          sahibLayButton = false;
                          dharamButton = false;
                          dharamLayButton = true;
                          kiskisButton = false;
                          kiskisLayButton = false;
                          ghulamButton = false;
                          ghulamLayButton = false;
                          oddButton = false;
                          oddLayButton = false;
                          dulhaButton = false;
                          baratiButton = false;
                          redButton = false;
                          blackButton = false;
                          if (redCoinAnimation == true ||
                              lightGreenCoinAnimation == true ||
                              blueCoinAnimation == true ||
                              greenCoinAnimation == true ||
                              lightBlueCoinAnimation == true ||
                              brownCoinAnimation == true) {
                            showMyDialogForBetPortrait(redCoinAnimation == true
                                ? stack1
                                : lightGreenCoinAnimation == true
                                    ? stack2
                                    : blueCoinAnimation == true
                                        ? stack3
                                        : greenCoinAnimation == true
                                            ? stack4
                                            : lightBlueCoinAnimation == true
                                                ? stack5
                                                : brownCoinAnimation == true
                                                    ? stack6
                                                    : 0);
                          }
                        });
                      },
                      child: Container(
                        alignment: Alignment.center,
                        height: height * 0.1,
                        width: width * 0.15,
                        decoration: BoxDecoration(
                            color: Color(0xaaFAA9BA),
                            borderRadius: BorderRadius.circular(5)),
                        child: Text(
                          dharamLayRate,
                          style: TextStyle(fontWeight: FontWeight.w600),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              showLiablity == true
                  ? Text(
                      liablity8.toString(),
                      style: TextStyle(
                          color: liablity8 >= 0.0 ? Colors.green : Colors.red),
                    )
                  : Text(""),
              SizedBox(
                height: 10,
              ),
              Column(
                children: [
                  Container(
                    height: height * 0.06,
                    width: width * 0.9,
                    decoration: BoxDecoration(
                        border: Border.all(color: Colors.white, width: 2),
                        borderRadius: BorderRadius.circular(5)),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        InkWell(
                          onTap: () {
                            setState(() {
                              donButton = false;
                              donLayButton = false;
                              amarAkbarutton = false;
                              amarLayAkbarutton = false;
                              sahibButton = false;
                              sahibLayButton = false;
                              dharamButton = false;
                              dharamLayButton = false;
                              kiskisButton = true;
                              kiskisLayButton = false;
                              ghulamButton = false;
                              ghulamLayButton = false;
                              oddButton = false;
                              oddLayButton = false;
                              dulhaButton = false;
                              baratiButton = false;
                              redButton = false;
                              blackButton = false;
                              if (redCoinAnimation == true ||
                                  lightGreenCoinAnimation == true ||
                                  blueCoinAnimation == true ||
                                  greenCoinAnimation == true ||
                                  lightBlueCoinAnimation == true ||
                                  brownCoinAnimation == true) {
                                showMyDialogForBetPortrait(redCoinAnimation ==
                                        true
                                    ? stack1
                                    : lightGreenCoinAnimation == true
                                        ? stack2
                                        : blueCoinAnimation == true
                                            ? stack3
                                            : greenCoinAnimation == true
                                                ? stack4
                                                : lightBlueCoinAnimation == true
                                                    ? stack5
                                                    : brownCoinAnimation == true
                                                        ? stack6
                                                        : 0);
                              }
                            });
                          },
                          child: Container(
                            alignment: Alignment.center,
                            height: height * 0.1,
                            width: width * 0.15,
                            decoration: BoxDecoration(
                                color: Color(0xaa72BBEF),
                                borderRadius: BorderRadius.circular(5)),
                            child: Text(
                              kiskisRate,
                              style: TextStyle(fontWeight: FontWeight.w600),
                            ),
                          ),
                        ),
                        Text(
                          "KIS KIS KO PYAR KAROON",
                          style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.w600,
                              fontSize: 12),
                        ),
                        InkWell(
                          onTap: () {
                            setState(() {
                              donButton = false;
                              donLayButton = false;
                              amarAkbarutton = false;
                              amarLayAkbarutton = false;
                              sahibButton = false;
                              sahibLayButton = false;
                              dharamButton = false;
                              dharamLayButton = false;
                              kiskisButton = false;
                              kiskisLayButton = true;
                              ghulamButton = false;
                              ghulamLayButton = false;
                              oddButton = false;
                              oddLayButton = false;
                              dulhaButton = false;
                              baratiButton = false;
                              redButton = false;
                              blackButton = false;
                              if (redCoinAnimation == true ||
                                  lightGreenCoinAnimation == true ||
                                  blueCoinAnimation == true ||
                                  greenCoinAnimation == true ||
                                  lightBlueCoinAnimation == true ||
                                  brownCoinAnimation == true) {
                                showMyDialogForBetPortrait(redCoinAnimation ==
                                        true
                                    ? stack1
                                    : lightGreenCoinAnimation == true
                                        ? stack2
                                        : blueCoinAnimation == true
                                            ? stack3
                                            : greenCoinAnimation == true
                                                ? stack4
                                                : lightBlueCoinAnimation == true
                                                    ? stack5
                                                    : brownCoinAnimation == true
                                                        ? stack6
                                                        : 0);
                              }
                            });
                          },
                          child: Container(
                            alignment: Alignment.center,
                            height: height * 0.1,
                            width: width * 0.15,
                            decoration: BoxDecoration(
                                color: Color(0xaaFAA9BA),
                                borderRadius: BorderRadius.circular(5)),
                            child: Text(
                              kiskisLayRate,
                              style: TextStyle(fontWeight: FontWeight.w600),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  showLiablity == true
                      ? Text(
                          liablity9.toString(),
                          style: TextStyle(
                              color:
                                  liablity9 >= 0.0 ? Colors.green : Colors.red),
                        )
                      : Text(""),
                ],
              ),
              SizedBox(
                height: 20,
              ),
              Column(
                children: [
                  Container(
                    height: height * 0.06,
                    width: width * 0.9,
                    decoration: BoxDecoration(
                        border: Border.all(color: Colors.white, width: 2),
                        borderRadius: BorderRadius.circular(5)),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        InkWell(
                          onTap: () {
                            setState(() {
                              donButton = false;
                              donLayButton = false;
                              amarAkbarutton = false;
                              amarLayAkbarutton = false;
                              sahibButton = false;
                              sahibLayButton = false;
                              dharamButton = false;
                              dharamLayButton = false;
                              kiskisButton = false;
                              kiskisLayButton = false;
                              ghulamButton = true;
                              ghulamLayButton = false;
                              oddButton = false;
                              oddLayButton = false;
                              dulhaButton = false;
                              baratiButton = false;
                              redButton = false;
                              blackButton = false;
                              if (redCoinAnimation == true ||
                                  lightGreenCoinAnimation == true ||
                                  blueCoinAnimation == true ||
                                  greenCoinAnimation == true ||
                                  lightBlueCoinAnimation == true ||
                                  brownCoinAnimation == true) {
                                showMyDialogForBetPortrait(redCoinAnimation ==
                                        true
                                    ? stack1
                                    : lightGreenCoinAnimation == true
                                        ? stack2
                                        : blueCoinAnimation == true
                                            ? stack3
                                            : greenCoinAnimation == true
                                                ? stack4
                                                : lightBlueCoinAnimation == true
                                                    ? stack5
                                                    : brownCoinAnimation == true
                                                        ? stack6
                                                        : 0);
                              }
                            });
                          },
                          child: Container(
                            alignment: Alignment.center,
                            height: height * 0.1,
                            width: width * 0.15,
                            decoration: BoxDecoration(
                                color: Color(0xaa72BBEF),
                                borderRadius: BorderRadius.circular(5)),
                            child: Text(
                              ghulamRate,
                              style: TextStyle(fontWeight: FontWeight.w600),
                            ),
                          ),
                        ),
                        Text(
                          "GHULAM",
                          style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.w600,
                              fontSize: 12),
                        ),
                        InkWell(
                          onTap: () {
                            setState(() {
                              donButton = false;
                              donLayButton = false;
                              amarAkbarutton = false;
                              amarLayAkbarutton = false;
                              sahibButton = false;
                              sahibLayButton = false;
                              dharamButton = false;
                              dharamLayButton = false;
                              kiskisButton = false;
                              kiskisLayButton = false;
                              ghulamButton = false;
                              ghulamLayButton = true;
                              oddButton = false;
                              oddLayButton = false;
                              dulhaButton = false;
                              baratiButton = false;
                              redButton = false;
                              blackButton = false;
                              if (redCoinAnimation == true ||
                                  lightGreenCoinAnimation == true ||
                                  blueCoinAnimation == true ||
                                  greenCoinAnimation == true ||
                                  lightBlueCoinAnimation == true ||
                                  brownCoinAnimation == true) {
                                showMyDialogForBetPortrait(redCoinAnimation ==
                                        true
                                    ? stack1
                                    : lightGreenCoinAnimation == true
                                        ? stack2
                                        : blueCoinAnimation == true
                                            ? stack3
                                            : greenCoinAnimation == true
                                                ? stack4
                                                : lightBlueCoinAnimation == true
                                                    ? stack5
                                                    : brownCoinAnimation == true
                                                        ? stack6
                                                        : 0);
                              }
                            });
                          },
                          child: Container(
                            alignment: Alignment.center,
                            height: height * 0.1,
                            width: width * 0.15,
                            decoration: BoxDecoration(
                                color: Color(0xaaFAA9BA),
                                borderRadius: BorderRadius.circular(5)),
                            child: Text(
                              ghulamLayRate,
                              style: TextStyle(fontWeight: FontWeight.w600),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  showLiablity == true
                      ? Text(
                          liablity10.toString(),
                          style: TextStyle(
                              color: liablity10 >= 0.0
                                  ? Colors.green
                                  : Colors.red),
                        )
                      : Text(""),
                ],
              ),
              SizedBox(
                height: 10,
              ),
              SizedBox(
                height: 10,
              ),
              Container(
                height: 2,
                width: width,
                decoration: BoxDecoration(
                    image: DecorationImage(
                        image:
                            AssetImage("assets/bollywoodTable/Line 42 (3).png"),
                        fit: BoxFit.contain)),
              ),
              SizedBox(
                height: 10,
              ),
              SizedBox(
                height: 10,
              ),
              Column(
                children: [
                  Container(
                    height: height * 0.06,
                    width: width * 0.9,
                    decoration: BoxDecoration(
                        border: Border.all(color: Colors.white, width: 2),
                        borderRadius: BorderRadius.circular(5)),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        InkWell(
                          onTap: () {
                            setState(() {
                              donButton = false;
                              donLayButton = false;
                              amarAkbarutton = false;
                              amarLayAkbarutton = false;
                              sahibButton = false;
                              sahibLayButton = false;
                              dharamButton = false;
                              dharamLayButton = false;
                              kiskisButton = false;
                              kiskisLayButton = false;
                              ghulamButton = false;
                              ghulamLayButton = false;
                              oddButton = true;
                              oddLayButton = false;
                              dulhaButton = false;
                              baratiButton = false;
                              redButton = false;
                              blackButton = false;
                              if (redCoinAnimation == true ||
                                  lightGreenCoinAnimation == true ||
                                  blueCoinAnimation == true ||
                                  greenCoinAnimation == true ||
                                  lightBlueCoinAnimation == true ||
                                  brownCoinAnimation == true) {
                                showMyDialogForBetPortrait(redCoinAnimation ==
                                        true
                                    ? stack1
                                    : lightGreenCoinAnimation == true
                                        ? stack2
                                        : blueCoinAnimation == true
                                            ? stack3
                                            : greenCoinAnimation == true
                                                ? stack4
                                                : lightBlueCoinAnimation == true
                                                    ? stack5
                                                    : brownCoinAnimation == true
                                                        ? stack6
                                                        : 0);
                              }
                            });
                          },
                          child: Container(
                            alignment: Alignment.center,
                            height: height * 0.1,
                            width: width * 0.15,
                            decoration: BoxDecoration(
                                color: Color(0xaa72BBEF),
                                borderRadius: BorderRadius.circular(5)),
                            child: Text(
                              oddRate,
                              style: TextStyle(fontWeight: FontWeight.w600),
                            ),
                          ),
                        ),
                        Text(
                          "ODD",
                          style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.w600,
                              fontSize: 12),
                        ),
                        InkWell(
                          onTap: () {
                            setState(() {
                              donButton = false;
                              donLayButton = false;
                              amarAkbarutton = false;
                              amarLayAkbarutton = false;
                              sahibButton = false;
                              sahibLayButton = false;
                              dharamButton = false;
                              dharamLayButton = false;
                              kiskisButton = false;
                              kiskisLayButton = false;
                              ghulamButton = false;
                              ghulamLayButton = false;
                              oddButton = false;
                              oddLayButton = true;
                              dulhaButton = false;
                              baratiButton = false;
                              redButton = false;
                              blackButton = false;
                              if (redCoinAnimation == true ||
                                  lightGreenCoinAnimation == true ||
                                  blueCoinAnimation == true ||
                                  greenCoinAnimation == true ||
                                  lightBlueCoinAnimation == true ||
                                  brownCoinAnimation == true) {
                                showMyDialogForBetPortrait(redCoinAnimation ==
                                        true
                                    ? stack1
                                    : lightGreenCoinAnimation == true
                                        ? stack2
                                        : blueCoinAnimation == true
                                            ? stack3
                                            : greenCoinAnimation == true
                                                ? stack4
                                                : lightBlueCoinAnimation == true
                                                    ? stack5
                                                    : brownCoinAnimation == true
                                                        ? stack6
                                                        : 0);
                              }
                            });
                          },
                          child: Container(
                            alignment: Alignment.center,
                            height: height * 0.1,
                            width: width * 0.15,
                            decoration: BoxDecoration(
                                color: Color(0xaaFAA9BA),
                                borderRadius: BorderRadius.circular(5)),
                            child: Text(
                              oddLayRate,
                              style: TextStyle(fontWeight: FontWeight.w600),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  showLiablity == true
                      ? Text(
                          liablity11.toString(),
                          style: TextStyle(
                              color: liablity11 >= 0.0
                                  ? Colors.green
                                  : Colors.red),
                        )
                      : Text(""),
                ],
              ),
              SizedBox(
                height: 10,
              ),
              SizedBox(
                height: 10,
              ),
              Container(
                height: 2,
                width: width,
                decoration: BoxDecoration(
                    image: DecorationImage(
                        image:
                            AssetImage("assets/bollywoodTable/Line 42 (3).png"),
                        fit: BoxFit.contain)),
              ),
              SizedBox(
                height: 10,
              ),
              SizedBox(
                height: 10,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(children: [
                    Container(
                      height: height * 0.06,
                      width: width * 0.4,
                      decoration: BoxDecoration(
                          border:
                              Border.all(color: Color(0xaa873800), width: 2),
                          borderRadius: BorderRadius.circular(5)),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          SizedBox(),
                          Text(
                            "DULHA DULHAN K-Q",
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.w600,
                                fontSize: 10),
                          ),
                          InkWell(
                            onTap: () {
                              setState(() {
                                donButton = false;
                                donLayButton = false;
                                amarAkbarutton = false;
                                amarLayAkbarutton = false;
                                sahibButton = false;
                                sahibLayButton = false;
                                dharamButton = false;
                                dharamLayButton = false;
                                kiskisButton = false;
                                kiskisLayButton = false;
                                ghulamButton = false;
                                ghulamLayButton = false;
                                oddButton = false;
                                oddLayButton = false;
                                dulhaButton = true;
                                baratiButton = false;
                                redButton = false;
                                blackButton = false;
                                if (redCoinAnimation == true ||
                                    lightGreenCoinAnimation == true ||
                                    blueCoinAnimation == true ||
                                    greenCoinAnimation == true ||
                                    lightBlueCoinAnimation == true ||
                                    brownCoinAnimation == true) {
                                  showMyDialogForBetPortrait(redCoinAnimation ==
                                          true
                                      ? stack1
                                      : lightGreenCoinAnimation == true
                                          ? stack2
                                          : blueCoinAnimation == true
                                              ? stack3
                                              : greenCoinAnimation == true
                                                  ? stack4
                                                  : lightBlueCoinAnimation ==
                                                          true
                                                      ? stack5
                                                      : brownCoinAnimation ==
                                                              true
                                                          ? stack6
                                                          : 0);
                                }
                              });
                            },
                            child: Container(
                              alignment: Alignment.center,
                              height: height * 0.1,
                              width: width * 0.12,
                              decoration: BoxDecoration(
                                  color: Color(0xaa0288A5),
                                  borderRadius: BorderRadius.circular(5)),
                              child: Text(
                                dulhaDulhanRate,
                                style: TextStyle(fontWeight: FontWeight.w600),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    showLiablity == true
                        ? Text(
                            liablity3.toString(),
                            style: TextStyle(
                                color: liablity3 >= 0.0
                                    ? Colors.green
                                    : Colors.red),
                          )
                        : Text(""),
                  ]),
                  Column(
                    children: [
                      Container(
                        height: height * 0.06,
                        width: width * 0.4,
                        decoration: BoxDecoration(
                            border:
                                Border.all(color: Color(0xaa873800), width: 2),
                            borderRadius: BorderRadius.circular(5)),
                        child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              SizedBox(),
                              Text(
                                "BARATI J-A",
                                style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.w600,
                                    fontSize: 10),
                              ),
                              InkWell(
                                onTap: () {
                                  setState(() {
                                    donButton = false;
                                    donLayButton = false;
                                    amarAkbarutton = false;
                                    amarLayAkbarutton = false;
                                    sahibButton = false;
                                    sahibLayButton = false;
                                    dharamButton = false;
                                    dharamLayButton = false;
                                    kiskisButton = false;
                                    kiskisLayButton = false;
                                    ghulamButton = false;
                                    ghulamLayButton = false;
                                    oddButton = false;
                                    oddLayButton = false;
                                    dulhaButton = false;
                                    baratiButton = true;
                                    redButton = false;
                                    blackButton = false;
                                    if (redCoinAnimation == true ||
                                        lightGreenCoinAnimation == true ||
                                        blueCoinAnimation == true ||
                                        greenCoinAnimation == true ||
                                        lightBlueCoinAnimation == true ||
                                        brownCoinAnimation == true) {
                                      showMyDialogForBetPortrait(redCoinAnimation ==
                                              true
                                          ? stack1
                                          : lightGreenCoinAnimation == true
                                              ? stack2
                                              : blueCoinAnimation == true
                                                  ? stack3
                                                  : greenCoinAnimation == true
                                                      ? stack4
                                                      : lightBlueCoinAnimation ==
                                                              true
                                                          ? stack5
                                                          : brownCoinAnimation ==
                                                                  true
                                                              ? stack6
                                                              : 0);
                                    }
                                  });
                                },
                                child: Container(
                                  alignment: Alignment.center,
                                  height: height * 0.1,
                                  width: width * 0.12,
                                  decoration: BoxDecoration(
                                      color: Color(0xaa0288A5),
                                      borderRadius: BorderRadius.circular(5)),
                                  child: Text(
                                    baratiRate,
                                    style:
                                        TextStyle(fontWeight: FontWeight.w600),
                                  ),
                                ),
                              ),
                            ]),
                      ),
                      showLiablity == true
                          ? Text(
                              liablity4.toString(),
                              style: TextStyle(
                                  color: liablity4 >= 0.0
                                      ? Colors.green
                                      : Colors.red),
                            )
                          : Text(""),
                    ],
                  ),
                ],
              ),
              SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(children: [
                    Container(
                      height: height * 0.06,
                      width: width * 0.4,
                      decoration: BoxDecoration(
                          border:
                              Border.all(color: Color(0xaa873800), width: 2),
                          borderRadius: BorderRadius.circular(5)),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          SizedBox(),
                          Container(
                            height: 35,
                            width: width * 0.1,
                            decoration: BoxDecoration(
                                image: DecorationImage(
                                    image: AssetImage(
                                        "assets/bollywoodTable/black-image.png"),
                                    fit: BoxFit.contain)),
                          ),
                          InkWell(
                            onTap: () {
                              setState(() {
                                donButton = false;
                                donLayButton = false;
                                amarAkbarutton = false;
                                amarLayAkbarutton = false;
                                sahibButton = false;
                                sahibLayButton = false;
                                dharamButton = false;
                                dharamLayButton = false;
                                kiskisButton = false;
                                kiskisLayButton = false;
                                ghulamButton = false;
                                ghulamLayButton = false;
                                oddButton = false;
                                oddLayButton = false;
                                dulhaButton = false;
                                baratiButton = false;
                                redButton = false;
                                blackButton = true;
                                if (redCoinAnimation == true ||
                                    lightGreenCoinAnimation == true ||
                                    blueCoinAnimation == true ||
                                    greenCoinAnimation == true ||
                                    lightBlueCoinAnimation == true ||
                                    brownCoinAnimation == true) {
                                  showMyDialogForBetPortrait(redCoinAnimation ==
                                          true
                                      ? stack1
                                      : lightGreenCoinAnimation == true
                                          ? stack2
                                          : blueCoinAnimation == true
                                              ? stack3
                                              : greenCoinAnimation == true
                                                  ? stack4
                                                  : lightBlueCoinAnimation ==
                                                          true
                                                      ? stack5
                                                      : brownCoinAnimation ==
                                                              true
                                                          ? stack6
                                                          : 0);
                                }
                              });
                            },
                            child: Container(
                              alignment: Alignment.center,
                              height: height * 0.1,
                              width: width * 0.12,
                              decoration: BoxDecoration(
                                  color: Color(0xaa0288A5),
                                  borderRadius: BorderRadius.circular(5)),
                              child: Text(
                                blackRate,
                                style: TextStyle(fontWeight: FontWeight.w600),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    showLiablity == true
                        ? Text(
                            liablity12.toString(),
                            style: TextStyle(
                                color: liablity12 >= 0.0
                                    ? Colors.green
                                    : Colors.red),
                          )
                        : Text(""),
                  ]),
                  SizedBox(
                    height: 10,
                  ),
                  Column(
                    children: [
                      Container(
                        height: height * 0.06,
                        width: width * 0.4,
                        decoration: BoxDecoration(
                            border:
                                Border.all(color: Color(0xaa873800), width: 2),
                            borderRadius: BorderRadius.circular(5)),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            SizedBox(),
                            Container(
                              height: 35,
                              width: width * 0.1,
                              decoration: BoxDecoration(
                                  image: DecorationImage(
                                      image: AssetImage(
                                          "assets/bollywoodTable/red-image.png"),
                                      fit: BoxFit.contain)),
                            ),
                            InkWell(
                              onTap: () {
                                setState(() {
                                  donButton = false;
                                  donLayButton = false;
                                  amarAkbarutton = false;
                                  amarLayAkbarutton = false;
                                  sahibButton = false;
                                  sahibLayButton = false;
                                  dharamButton = false;
                                  dharamLayButton = false;
                                  kiskisButton = false;
                                  kiskisLayButton = false;
                                  ghulamButton = false;
                                  ghulamLayButton = false;
                                  oddButton = false;
                                  oddLayButton = false;
                                  dulhaButton = false;
                                  baratiButton = false;
                                  redButton = true;
                                  blackButton = false;
                                  if (redCoinAnimation == true ||
                                      lightGreenCoinAnimation == true ||
                                      blueCoinAnimation == true ||
                                      greenCoinAnimation == true ||
                                      lightBlueCoinAnimation == true ||
                                      brownCoinAnimation == true) {
                                    showMyDialogForBetPortrait(redCoinAnimation ==
                                            true
                                        ? stack1
                                        : lightGreenCoinAnimation == true
                                            ? stack2
                                            : blueCoinAnimation == true
                                                ? stack3
                                                : greenCoinAnimation == true
                                                    ? stack4
                                                    : lightBlueCoinAnimation ==
                                                            true
                                                        ? stack5
                                                        : brownCoinAnimation ==
                                                                true
                                                            ? stack6
                                                            : 0);
                                  }
                                });
                              },
                              child: Container(
                                alignment: Alignment.center,
                                height: height * 0.1,
                                width: width * 0.12,
                                decoration: BoxDecoration(
                                    color: Color(0xaa0288A5),
                                    borderRadius: BorderRadius.circular(5)),
                                child: Text(
                                  redRate,
                                  style: TextStyle(fontWeight: FontWeight.w600),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      showLiablity == true
                          ? Text(
                              liablity13.toString(),
                              style: TextStyle(
                                  color: liablity13 >= 0.0
                                      ? Colors.green
                                      : Colors.red),
                            )
                          : Text(""),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget placeyourbetWidget(String time) {
    return int.parse(autoTime) == 45
        ? Positioned(
            top: height * 0.4,
            child: TweenAnimationBuilder(
              duration: const Duration(seconds: 1),
              tween: Tween<double>(begin: 0, end: 1),
              builder: (BuildContext context, double opacity, Widget? child) {
                return Opacity(
                    opacity: opacity,
                    child: Padding(
                      padding: EdgeInsets.only(top: opacity * 20),
                      child: child,
                    ));
              },
              child: Image.asset(
                'assets/Teen-patti/images/place-your-bet.png',
                height: height * 0.2,
                width: width * 0.5,
                fit: BoxFit.fill,
              ),
            ))
        : SizedBox();
  }

  Widget gameStopBettingPortrait(String time) {
    return Positioned(
        top: height * 0.06,
        left: width * 0.2,
        child: TweenAnimationBuilder(
            duration: const Duration(milliseconds: 500),
            tween: Tween<double>(begin: 0, end: 1),
            builder: (BuildContext context, double opacity, Widget? child) {
              return Opacity(
                  opacity: opacity,
                  child: Padding(
                    padding: EdgeInsets.only(top: opacity * 10),
                    child: child,
                  ));
            },
            child: Image.asset(
              'assets/Teen-patti/images/stop-betting.png',
              height: height * 0.08,
              width: width * 0.6,
              fit: BoxFit.fill,
            )));
  }

  Widget gameStopBetting(String time) {
    return Positioned(
        top: height * 0.4,
        child: TweenAnimationBuilder(
            duration: const Duration(milliseconds: 500),
            tween: Tween<double>(begin: 0, end: 1),
            builder: (BuildContext context, double opacity, Widget? child) {
              return Opacity(
                  opacity: opacity,
                  child: Padding(
                    padding: EdgeInsets.only(top: opacity * 10),
                    child: child,
                  ));
            },
            child: Image.asset(
              'assets/Teen-patti/images/stop-betting.png',
              height: height * 0.2,
              width: width * 0.5,
              fit: BoxFit.fill,
            )));
  }

  goWidget() {
    return Visibility(
      visible: autoTime == "3" || autoTime == "2" || autoTime == "1",
      child: Lottie.asset("assets/Teen-patti/audio/countdown.json",
          height: height * 0.4, width: width),
    );
  }

  goWidgetPort() {
    return Visibility(
      visible: autoTime == "3" || autoTime == "2" || autoTime == "1",
      child: Lottie.asset("assets/Teen-patti/audio/countdown.json",
          height: height * 0.2, width: width),
    );
  }

  Widget showCurrentCardLand() {
    return Column(
      children: [
        Container(
          alignment: Alignment.center,
          height: height * 0.50,
          width: width * 0.4,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              image: DecorationImage(
                  image: AssetImage(
                    "assets/bollywoodTable/current-result-background.png",
                  ),
                  fit: BoxFit.cover)),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
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
              SizedBox(
                height: 20,
              ),
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 50),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    winnerResult != ""
                        ? buildImageLand(cardNameImage1)
                        : Image.asset(
                            'assets/lucky7/images/cardBg.png',
                            height: height * 0.19,
                            width: width * 0.06,
                            fit: BoxFit.fill,
                          ),
                  ],
                ),
              ),
              SizedBox(
                height: 30,
              ),
              Container(
                alignment: Alignment.center,
                margin: const EdgeInsets.symmetric(
                  horizontal: 20,
                ),
                height: 40,
                width: MediaQuery.of(context).size.width * 0.9,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(
                      color: Color(0xaa89560C),
                    )),
                child: Text(
                  mid == marketId ? resultOfBT.replaceAll('||', '|') : "",
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
    );
  }

  Widget buildImageLand(
    String cardImage,
  ) {
    return cardImage == "" || cardImage == "null"
        ? Image.asset(
            'assets/lucky7/images/cardBg.png',
            height: height * 0.19,
            width: width * 0.06,
            fit: BoxFit.fill,
          )
        : FlipCard(
            flipOnTouch: false,
            autoFlipDuration: Duration(seconds: 1),
            front: Image.asset(
              'assets/lucky7/images/cardBg.png',
              height: height * 0.19,
              width: width * 0.06,
              fit: BoxFit.fill,
            ),
            back: SizedBox(
                height: height * 0.19,
                width: width * 0.06,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(2.5),
                  child: Image.network(
                      'http://admin.kalyanexch.com/images/cards/$cardImage.png',
                      fit: BoxFit.cover),
                )));
  }

  Widget placeyourbetWidgetPortrait(String time) {
    return int.parse(autoTime) == 45
        ? Positioned(
            top: height * 0.06,
            left: width * 0.2,
            child: TweenAnimationBuilder(
              duration: const Duration(seconds: 1),
              tween: Tween<double>(begin: 0, end: 1),
              builder: (BuildContext context, double opacity, Widget? child) {
                return Opacity(
                    opacity: opacity,
                    child: Padding(
                      padding: EdgeInsets.only(top: opacity * 20),
                      child: child,
                    ));
              },
              child: Image.asset(
                'assets/Teen-patti/images/place-your-bet.png',
                height: height * 0.08,
                width: width * 0.6,
                fit: BoxFit.fill,
              ),
            ))
        : SizedBox();
  }

  Widget showCurrentCardPort() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        SizedBox(
          height: 30,
        ),
        Container(
          // margin: EdgeInsets.only(left: width * 2),
          alignment: Alignment.center,
          height: height * 0.18,
          width: width * 0.65,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              image: DecorationImage(
                  image: AssetImage(
                    "assets/bollywoodTable/current-result-background.png",
                  ),
                  fit: BoxFit.cover)),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    winnerResult != ""
                        ? buildImagePortrait(cardNameImage1)
                        : Image.asset(
                            'assets/lucky7/images/cardBg.png',
                            height: height * 0.19,
                            width: width * 0.06,
                            fit: BoxFit.fill,
                          ),
                  ],
                ),
              ),
              SizedBox(
                height: 10,
              ),
              SizedBox(
                height: 10,
              ),
              Container(
                alignment: Alignment.center,
                margin: const EdgeInsets.symmetric(
                  horizontal: 20,
                ),
                height: 40,
                width: MediaQuery.of(context).size.width * 0.9,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(
                      color: Color(0xaa89560C),
                    )),
                child: Text(
                  mid == marketId ? resultOfBT.replaceAll('||', '|') : "",
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 11,
                      fontWeight: FontWeight.bold),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget buildImagePortrait(String cardImage) {
    return cardImage == "" || cardImage == "null"
        ? Image.asset(
            'assets/User-interface/card-back.png',
            height: 55,
            width: 35,
            fit: BoxFit.fill,
          )
        : FlipCard(
            flipOnTouch: false,
            autoFlipDuration: Duration(seconds: 1),
            front: Image.asset(
              'assets/User-interface/card-back.png',
              height: 55,
              width: 35,
              fit: BoxFit.fill,
            ),
            back: SizedBox(
                height: 55,
                width: 35,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(2.5),
                  child: Image.network('${Apis.imagbaseLink}$cardImage.png',
                      fit: BoxFit.cover),
                )));
  }

  // --------------------xxxx API CALL xxxxxx------------------//
  String mid = "";
  String resultOfBT = "";
  Future getResult() async {
    var url = Apis.bollywoodResultApi;
    var response = await GlobalFunction.apiGetRequestae(url);
    var result = jsonDecode(response);

    var list = result as List;

    setState(() {
      cardResultList.clear();
      cardResultList =
          list.map((e) => BollyWoodResultModel.fromJson(e)).toList();
      winnerResult = result[0]['winner'].toString();
      mid = result[0]['mid'].toString();
      resultOfBT = result[0]['detail'].toString();

      // cardResultList.addAll(listdata);
    });
  }

  Future getCardData() async {
    var url = Apis.bollywoodCardApi;
    var response = await GlobalFunction.apiGetRequestae(url);
    var result = jsonDecode(response);

    if (result['status'] == true) {
      var list = result['data']['t2'] as List;
      setState(() {
        autoTime = result['data']['t1'][0]['autotime'].toString();
        marketId = result['data']['t1'][0]['mid'].toString();
        cardNameImage1 = result['data']['t1'][0]['C1'].toString();
        cardNameImage2 = result['data']['t1'][0]['C2'].toString();
        cardNameImage3 = result['data']['t1'][0]['C3'].toString();
        startTimes = int.parse(autoTime.toString());
        donRate = result['data']['t2'][0]['rate'].toString();
        donLayRate = result['data']['t2'][0]['layrate'].toString();
        amarakbarRate = result['data']['t2'][1]['rate'].toString();
        amarAkbarLayRate = result['data']['t2'][1]['layrate'].toString();
        sahibRate = result['data']['t2'][2]['rate'].toString();
        sahibLayRate = result['data']['t2'][2]['layrate'].toString();
        dharamRate = result['data']['t2'][3]['rate'].toString();
        dharamLayRate = result['data']['t2'][3]['layrate'].toString();
        kiskisRate = result['data']['t2'][4]['rate'].toString();
        kiskisLayRate = result['data']['t2'][4]['layrate'].toString();
        ghulamRate = result['data']['t2'][5]['rate'].toString();
        ghulamLayRate = result['data']['t2'][5]['layrate'].toString();
        oddRate = result['data']['t2'][6]['rate'].toString();
        oddLayRate = result['data']['t2'][6]['layrate'].toString();
        redRate = result['data']['t2'][7]['rate'].toString();
        blackRate = result['data']['t2'][8]['rate'].toString();
        dulhaDulhanRate = result['data']['t2'][13]['rate'].toString();
        baratiRate = result['data']['t2'][14]['rate'].toString();
      });
      autoTime == "0"
          ? setState(() {
              redCoinAnimation = false;
              lightGreenCoinAnimation = false;
              blueCoinAnimation = false;
              greenCoinAnimation = false;
              lightBlueCoinAnimation = false;
              brownCoinAnimation = false;
              showLiablity = false;
            })
          : SizedBox();
    }
  }

  Future getStakeDetails() async {
    var url = Apis.getStakeData;
    var body = {};
    var response = await GlobalFunction.apiPostRequestToken(url, body);

    var result = jsonDecode(response);
    if (result['status'] == true) {
      setState(() {
        stack1 = result['data']['stack1'];
        stack2 = result['data']['stack2'];
        stack3 = result['data']['stack3'];
        stack4 = result['data']['stack4'];
        stack5 = result['data']['stack5'];
        stack6 = result['data']['stack6'];
      });
    }
  }

  Future getuserBalance() async {
    var url = Apis.getuserBalanceApi;
    var body = {};
    var response =
        await GlobalFunction.apiPostRequestToken(url, jsonEncode(body));
    var result = jsonDecode(response);
    if (result['status'] == true) {
      setState(() {
        userBalance = result['data']['balance'];
        liablity = result['data']['libality'];
        mainBalance = double.parse(userBalance) - double.parse(liablity);
      });
    }
  }

  Future getUserDetails() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    var url = Apis.validateToken;
    var response = await http.post(Uri.parse(url), body: {}, headers: {
      "Authorization": "Bearer ${preferences.getString("token")}",
    });

    if (response.statusCode == 200) {
    } else {
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

  Future getMatchIdDetails() async {
    var url =
        "http://23.106.234.25:8192/admin-new-apis/enduser/bet-list-by-matchid";
    var body = {"matchId": widget.matchID.toString()};
    var response = await GlobalFunction.apiPostRequestToken(url, body);
    var result = jsonDecode(response);
    if (result['status'] == true) {
      var list = result['data'][widget.gameCode] as List;
      matchIdList.clear();
      var listdata = list.map((e) => MatchIdModel.fromJson(e)).toList();
      matchIdList.addAll(listdata);
    }
  }

  Future<void> showMyDialogForBet(int stake) async {
    return showDialog<void>(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            backgroundColor: Colors.transparent,
            content: SingleChildScrollView(
              child: Column(
                children: [
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.7,
                    width: MediaQuery.of(context).size.width * 0.6,
                    child: Stack(
                      alignment: Alignment.center,
                      children: [
                        Container(
                          margin: const EdgeInsets.symmetric(vertical: 22),
                          height: MediaQuery.of(context).size.height * 0.6,
                          width: MediaQuery.of(context).size.width * 0.4,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              image: DecorationImage(
                                  image: AssetImage(
                                      "assets/User-interface/amar-show-amount.png"),
                                  fit: BoxFit.fitHeight)),
                          child: Column(
                            children: [
                              Column(
                                children: const [
                                  SizedBox(
                                    height: 10,
                                  ),
                                  Text(
                                    "Amount",
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ],
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Container(
                                    margin: const EdgeInsets.symmetric(
                                        horizontal: 10),
                                    // alignment: Alignment.center,
                                    child: Image.asset(
                                      "assets/User-interface/minus-image.png",
                                      scale: 2,
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(top: 20.0),
                                    child: SizedBox(
                                      height: height * 0.18,
                                      width: width * 0.24,
                                      child: TextField(
                                        controller: stakeController,
                                        onChanged: (String value) async {
                                          manualAmount = true;
                                        },
                                        maxLength: 5,
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                            color: Colors.black,
                                            fontWeight: FontWeight.w600),
                                        keyboardType: TextInputType.number,
                                        decoration: InputDecoration(
                                          hintText: '$stake',
                                          hintStyle: TextStyle(
                                              fontSize: 16,
                                              color: Colors.black,
                                              fontWeight: FontWeight.w600),
                                          border: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(8),
                                            borderSide: BorderSide(
                                              width: 0,
                                              style: BorderStyle.none,
                                            ),
                                          ),
                                          filled: true,
                                          contentPadding: EdgeInsets.all(16),
                                          fillColor: Colors.white,
                                        ),
                                      ),
                                    ),
                                  ),
                                  Container(
                                    margin: const EdgeInsets.symmetric(
                                        horizontal: 10),
                                    // alignment: Alignment.center,
                                    child: Image.asset(
                                      "assets/User-interface/plus-image.png",
                                      scale: 2,
                                    ),
                                  ),
                                ],
                              ),
                              Text(
                                "Are you sure want to continue !!",
                                style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.w600),
                              ),
                              SizedBox(
                                height: 20,
                              ),
                              GestureDetector(
                                onTap: () {
                                  HapticFeedback.vibrate();
                                  // setState(() {
                                  //   _currentCoinIndex++;
                                  //   _startCoinAnimation();
                                  // });
                                  // _currentCoinIndex++;
                                  // _startCoinAnimation();
                                  // _currentCoinIndex++;
                                  // _startCoinAnimation();

                                  makeBet();
                                  Navigator.pop(context);
                                  onPressedMusicForBet();
                                },
                                child: Container(
                                  alignment: Alignment.center,
                                  height:
                                      MediaQuery.of(context).size.height * 0.1,
                                  width:
                                      MediaQuery.of(context).size.width * 0.7,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                      image: DecorationImage(
                                          image: AssetImage(
                                              "assets/User-interface/confirm-button.png"),
                                          fit: BoxFit.fitHeight)),
                                ),
                              )
                            ],
                          ),
                        ),
                        Positioned(
                          left: width * 0.48,
                          top: 15,
                          child: InkWell(
                            onTap: () {
                              Navigator.pop(context);
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
            ),
          );
        });
  }

  Future<void> showMyDialogForBetPortrait(int stake) {
    return showDialog(
        context: context,
        builder: (_) {
          return AlertDialog(
              backgroundColor: Colors.transparent,
              alignment: Alignment.center,
              content: SingleChildScrollView(
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    Container(
                      height: height * 0.3,
                      width: width * 99,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        image: DecorationImage(
                            image: AssetImage(
                                "assets/User-interface/amar-show-amount.png"),
                            fit: BoxFit.cover),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                            //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              CustomText(
                                text: "Amount",
                                color: Colors.white,
                                fontSize: 16,
                                fontWeight: FontWeight.w500,
                              ),
                              SizedBox(
                                height: height * 0.05,
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Container(
                                    margin: const EdgeInsets.only(right: 5),
                                    // alignment: Alignment.center,
                                    child: Image.asset(
                                      "assets/User-interface/minus-image.png",
                                      scale: 3,
                                    ),
                                  ),
                                  SizedBox(
                                    height: height * 0.05,
                                    width: width * 0.29,
                                    child: Center(
                                      child: TextField(
                                        textAlign: TextAlign.center,
                                        controller: stakeController,
                                        onChanged: (String value) async {
                                          manualAmount = true;
                                        },
                                        maxLength: 5,
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.w600,
                                        ),
                                        keyboardType: TextInputType.number,
                                        decoration: InputDecoration(
                                          counterText: "",
                                          hintText: '$stake',
                                          hintStyle: TextStyle(
                                              fontSize: 10,
                                              color: Colors.white,
                                              fontWeight: FontWeight.w600),
                                          border: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(1),
                                            borderSide: BorderSide(
                                              width: 0,
                                              style: BorderStyle.none,
                                            ),
                                          ),
                                          filled: true,
                                          // contentPadding:  EdgeInsets.only(top: height*0.1),
                                          fillColor: Colors.black,
                                        ),
                                      ),
                                    ),
                                  ),
                                  Container(
                                    margin: const EdgeInsets.only(left: 5),
                                    // alignment: Alignment.center,
                                    child: Image.asset(
                                      "assets/User-interface/plus-image.png",
                                      scale: 3,
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: height * 0.02,
                              ),
                              Text(
                                "Are you sure you want to continue?",
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 10,
                                    fontWeight: FontWeight.w500),
                              ),
                              SizedBox(
                                height: height * 0.05,
                              ),
                              manualAmount == true &&
                                      int.parse(stakeController.text) > 99 &&
                                      int.parse(stakeController.text) < 25000
                                  ? GestureDetector(
                                      onTap: () {
                                        HapticFeedback.vibrate();

                                        makeBetPortrait();
                                        Navigator.pop(context);
                                        onPressedMusicForBet();
                                      },
                                      child: Container(
                                        alignment: Alignment.center,
                                        height:
                                            MediaQuery.of(context).size.height *
                                                0.03,
                                        width:
                                            MediaQuery.of(context).size.width *
                                                0.3,
                                        decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(10),
                                            image: DecorationImage(
                                                image: AssetImage(
                                                    "assets/User-interface/confirm-button.png"),
                                                fit: BoxFit.fitHeight)),
                                      ),
                                    )
                                  : manualAmount == false
                                      ? GestureDetector(
                                          onTap: () {
                                            HapticFeedback.vibrate();

                                            makeBetPortrait();
                                            Navigator.pop(context);
                                            onPressedMusicForBet();
                                          },
                                          child: Container(
                                            alignment: Alignment.center,
                                            height: MediaQuery.of(context)
                                                    .size
                                                    .height *
                                                0.03,
                                            width: MediaQuery.of(context)
                                                    .size
                                                    .width *
                                                0.3,
                                            decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(10),
                                                image: DecorationImage(
                                                    image: AssetImage(
                                                        "assets/lucky7/images/button/comfirm.png"),
                                                    fit: BoxFit.fitHeight)),
                                          ),
                                        )
                                      : GestureDetector(
                                          onTap: () {
                                            Navigator.pop(context);
                                            setState(() {
                                              playBackgroundMusic == false
                                                  ? ''
                                                  : HapticFeedback.vibrate();
                                            });
                                            DialogUtils.showOneBtn(context,
                                                "Please Select Existing amount");
                                          },
                                          child: Container(
                                            alignment: Alignment.center,
                                            height: MediaQuery.of(context)
                                                    .size
                                                    .height *
                                                0.03,
                                            width: MediaQuery.of(context)
                                                    .size
                                                    .width *
                                                0.3,
                                            decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(10),
                                                image: DecorationImage(
                                                    image: AssetImage(
                                                        "assets/lucky7/images/button/comfirm.png"),
                                                    fit: BoxFit.fitHeight)),
                                          ),
                                        ),
                            ]),
                      ),
                    ),
                    Positioned(
                      right: width * 0.01,
                      top: 2,
                      child: InkWell(
                        onTap: () {
                          Navigator.pop(context);
                        },
                        child: Image.asset(
                          "assets/User-interface/close-button.png",
                          scale: 4,
                        ),
                      ),
                    ),
                  ],
                ),
              ));
        });
  }

  // Future<void> showMyDialogForBetPortrait(int stake) async {
  //   return showDialog<void>(
  //       context: context,
  //       builder: (BuildContext context) {
  //         return AlertDialog(
  //           backgroundColor: Colors.transparent,
  //           content: SingleChildScrollView(
  //             child: Column(
  //               children: [
  //                 SizedBox(
  //                   height: MediaQuery.of(context).size.height * 0.4,
  //                   width: MediaQuery.of(context).size.width,
  //                   child: Stack(
  //                     children: [
  //                       Container(
  //                         margin: const EdgeInsets.symmetric(vertical: 22),
  //                         height: MediaQuery.of(context).size.height * 0.35,
  //                         width: MediaQuery.of(context).size.width * 0.9,
  //                         decoration: BoxDecoration(
  //                             borderRadius: BorderRadius.circular(10),
  //                             image: DecorationImage(
  //                                 image: AssetImage(
  //                                     "assets/User-interface/amar-show-amount.png"),
  //                                 fit: BoxFit.fitHeight)),
  //                         child: Column(
  //                           children: [
  //                             Column(
  //                               children: const [
  //                                 SizedBox(
  //                                   height: 10,
  //                                 ),
  //                                 Text(
  //                                   "Amount",
  //                                   style: TextStyle(
  //                                       color: Colors.white,
  //                                       fontWeight: FontWeight.bold),
  //                                 ),
  //                               ],
  //                             ),
  //                             SizedBox(
  //                               height: 20,
  //                             ),
  //                             Row(
  //                               mainAxisAlignment:
  //                                   MainAxisAlignment.spaceBetween,
  //                               children: [
  //                                 Container(
  //                                   margin: const EdgeInsets.symmetric(
  //                                       horizontal: 10),
  //                                   // alignment: Alignment.center,
  //                                   child: Image.asset(
  //                                     "assets/User-interface/minus-image.png",
  //                                     scale: 2,
  //                                   ),
  //                                 ),
  //                                 Padding(
  //                                   padding: const EdgeInsets.only(top: 20.0),
  //                                   child: SizedBox(
  //                                     height: height * 0.08,
  //                                     width: width * 0.36,
  //                                     child: TextField(
  //                                       controller: stakeController,
  //                                       onChanged: (String value) async {
  //                                         manualAmount = true;
  //                                       },
  //                                       maxLength: 5,
  //                                       textAlign: TextAlign.center,
  //                                       style: TextStyle(
  //                                           color: Colors.black,
  //                                           fontWeight: FontWeight.w600),
  //                                       keyboardType: TextInputType.number,
  //                                       decoration: InputDecoration(
  //                                         hintText: '$stake',
  //                                         hintStyle: TextStyle(
  //                                             fontSize: 16,
  //                                             color: Colors.black,
  //                                             fontWeight: FontWeight.w600),
  //                                         border: OutlineInputBorder(
  //                                           borderRadius:
  //                                               BorderRadius.circular(8),
  //                                           borderSide: BorderSide(
  //                                             width: 0,
  //                                             style: BorderStyle.none,
  //                                           ),
  //                                         ),
  //                                         filled: true,
  //                                         contentPadding: EdgeInsets.all(16),
  //                                         fillColor: Colors.white,
  //                                       ),
  //                                     ),
  //                                   ),
  //                                 ),
  //                                 Container(
  //                                   margin: const EdgeInsets.symmetric(
  //                                       horizontal: 10),
  //                                   // alignment: Alignment.center,
  //                                   child: Image.asset(
  //                                     "assets/User-interface/plus-image.png",
  //                                     scale: 2,
  //                                   ),
  //                                 ),
  //                               ],
  //                             ),
  //                             Text(
  //                               "Are you sure want to continue !!",
  //                               style: TextStyle(
  //                                   color: Colors.white,
  //                                   fontWeight: FontWeight.w600),
  //                             ),
  //                             SizedBox(
  //                               height: 20,
  //                             ),
  //                             GestureDetector(
  //                               onTap: () {
  //                                 HapticFeedback.vibrate();

  //                                 makeBetPortrait();
  //                                 Navigator.pop(context);
  //                                 onPressedMusicForBet();
  //                               },
  //                               child: Container(
  //                                 alignment: Alignment.center,
  //                                 height:
  //                                     MediaQuery.of(context).size.height * 0.06,
  //                                 width:
  //                                     MediaQuery.of(context).size.width * 0.7,
  //                                 decoration: BoxDecoration(
  //                                     borderRadius: BorderRadius.circular(10),
  //                                     image: DecorationImage(
  //                                         image: AssetImage(
  //                                             "assets/User-interface/confirm-button.png"),
  //                                         fit: BoxFit.fitHeight)),
  //                               ),
  //                             )
  //                           ],
  //                         ),
  //                       ),
  //                       Positioned(
  //                         left: width * 0.61,
  //                         top: 15,
  //                         child: InkWell(
  //                           onTap: () {
  //                             Navigator.pop(context);
  //                           },
  //                           child: Image.asset(
  //                             "assets/User-interface/close-button.png",
  //                             scale: 4,
  //                           ),
  //                         ),
  //                       ),
  //                     ],
  //                   ),
  //                 ),
  //               ],
  //             ),
  //           ),
  //         );
  //       });
  // }

  Future makeBet() async {
    getUserDetails();
    DateTime currentTime = DateTime.now();
    var url = "http://13.250.53.81/VirtualCasinoBetPlacer/vc/place-bet";

    var body = {
      "casinoName": 1,
      "isBack": donLayButton == true
          ? false
          : amarLayAkbarutton == true
              ? false
              : sahibLayButton == true
                  ? false
                  : dharamLayButton == true
                      ? false
                      : kiskisLayButton == true
                          ? false
                          : ghulamLayButton == true
                              ? false
                              : oddLayButton == true
                                  ? false
                                  : true,
      "odds": dulhaButton == true
          ? dulhaDulhanRate
          : baratiButton == true
              ? baratiRate
              : redButton == true
                  ? redRate
                  : blackButton == true
                      ? blackRate
                      : donButton == true
                          ? donRate
                          : donLayButton == true
                              ? donLayRate
                              : amarAkbarutton == true
                                  ? amarakbarRate
                                  : amarLayAkbarutton == true
                                      ? amarAkbarLayRate
                                      : sahibButton == true
                                          ? sahibRate
                                          : sahibLayButton == true
                                              ? sahibLayRate
                                              : dharamButton == true
                                                  ? dharamRate
                                                  : dharamLayButton == true
                                                      ? dharamLayRate
                                                      : kiskisButton == true
                                                          ? kiskisRate
                                                          : kiskisLayButton ==
                                                                  true
                                                              ? kiskisLayRate
                                                              : ghulamButton ==
                                                                      true
                                                                  ? ghulamRate
                                                                  : ghulamLayButton ==
                                                                          true
                                                                      ? ghulamLayRate
                                                                      : "",
      "stake": manualAmount == true
          ? stakeController.text.toString()
          : redCoinAnimation == true && manualAmount == false
              ? stack1.toString()
              : lightGreenCoinAnimation == true && manualAmount == false
                  ? stack2.toString()
                  : blueCoinAnimation == true && manualAmount == false
                      ? stack3.toString()
                      : greenCoinAnimation == true && manualAmount == false
                          ? stack4.toString()
                          : brownCoinAnimation == true && manualAmount == false
                              ? stack5.toString()
                              : lightBlueCoinAnimation == true &&
                                      manualAmount == false
                                  ? stack6
                                  : "",
      "selectionId": donButton == true || donLayButton == true
          ? "1"
          : amarAkbarutton == true || amarLayAkbarutton == true
              ? "2"
              : sahibButton == true || sahibLayButton == true
                  ? "3"
                  : dharamButton == true || dharamLayButton == true
                      ? "4"
                      : kiskisButton == true || kiskisLayButton == true
                          ? "5"
                          : ghulamButton == true || ghulamLayButton == true
                              ? "6"
                              : oddButton == true || oddLayButton == true
                                  ? "7"
                                  : dulhaButton == true
                                      ? "14"
                                      : baratiButton == true
                                          ? "15"
                                          : redButton == true
                                              ? "8"
                                              : blackButton == true
                                                  ? "9"
                                                  : "",
      "placeTime": currentTime.toString(),
      "marketId": marketId.toString(),
      "matchId": 13,
      "userIp": "98.207.254.136".toString(),
      "deviceInfo": {
        "userAgent": "null",
        "browser": "null",
        "device": "Android",
        "deviceType": "mobile",
        "os": "Android",
        "os_version": "Android 13",
        "browser_version": "null",
        "orientation": "landscape"
      }
    };

    var response = await GlobalFunction.apiPostRequestTokenForBet(
      url,
      body,
      context,
      stakeController,
    );
    setState(() {
      manualAmount = false;
    });
    var result = jsonDecode(response);
    print("betBody--->$body");
    if (result['status'] == true) {
      getVcLiablity();
      print("response--->$result");
      DialogUtils.showOneBtn(context, result['message']);
      setState(() {
        manualAmount = false;
        stakeController.clear();
      });
      // getVcLiablity();
    } else {
      stakeController.clear();

      DialogUtils.showOneBtn(context, result['message']);
    }

    stakeController.clear();
    manualAmount = false;
  }

  Future makeBetPortrait() async {
    getUserDetails();
    DateTime currentTime = DateTime.now();
    var url = "http://13.250.53.81/VirtualCasinoBetPlacer/vc/place-bet";

    var body = {
      "casinoName": 1,
      "isBack": donLayButton == true
          ? false
          : amarLayAkbarutton == true
              ? false
              : sahibLayButton == true
                  ? false
                  : dharamLayButton == true
                      ? false
                      : kiskisLayButton == true
                          ? false
                          : ghulamLayButton == true
                              ? false
                              : oddLayButton == true
                                  ? false
                                  : true,
      "odds": dulhaButton == true
          ? dulhaDulhanRate
          : baratiButton == true
              ? baratiRate
              : redButton == true
                  ? redRate
                  : blackButton == true
                      ? blackRate
                      : donButton == true
                          ? donRate
                          : donLayButton == true
                              ? donLayRate
                              : amarAkbarutton == true
                                  ? amarakbarRate
                                  : amarLayAkbarutton == true
                                      ? amarAkbarLayRate
                                      : sahibButton == true
                                          ? sahibRate
                                          : sahibLayButton == true
                                              ? sahibLayRate
                                              : dharamButton == true
                                                  ? dharamRate
                                                  : dharamLayButton == true
                                                      ? dharamLayRate
                                                      : kiskisButton == true
                                                          ? kiskisRate
                                                          : kiskisLayButton ==
                                                                  true
                                                              ? kiskisLayRate
                                                              : ghulamButton ==
                                                                      true
                                                                  ? ghulamRate
                                                                  : ghulamLayButton ==
                                                                          true
                                                                      ? ghulamLayRate
                                                                      : "",
      "stake": manualAmount == true
          ? stakeController.text.toString()
          : redCoinAnimation == true && manualAmount == false
              ? stack1.toString()
              : lightGreenCoinAnimation == true && manualAmount == false
                  ? stack2.toString()
                  : blueCoinAnimation == true && manualAmount == false
                      ? stack3.toString()
                      : greenCoinAnimation == true && manualAmount == false
                          ? stack4.toString()
                          : brownCoinAnimation == true && manualAmount == false
                              ? stack5.toString()
                              : lightBlueCoinAnimation == true &&
                                      manualAmount == false
                                  ? stack6
                                  : "",
      "selectionId": donButton == true || donLayButton == true
          ? "1"
          : amarAkbarutton == true || amarLayAkbarutton == true
              ? "2"
              : sahibButton == true || sahibLayButton == true
                  ? "3"
                  : dharamButton == true || dharamLayButton == true
                      ? "4"
                      : kiskisButton == true || kiskisLayButton == true
                          ? "5"
                          : ghulamButton == true || ghulamLayButton == true
                              ? "6"
                              : oddButton == true || oddLayButton == true
                                  ? "7"
                                  : dulhaButton == true
                                      ? "14"
                                      : baratiButton == true
                                          ? "15"
                                          : redButton == true
                                              ? "8"
                                              : blackButton == true
                                                  ? "9"
                                                  : "",
      "placeTime": currentTime.toString(),
      "marketId": marketId.toString(),
      "matchId": 13,
      "userIp": "98.207.254.136".toString(),
      "deviceInfo": {
        "userAgent": "null",
        "browser": "null",
        "device": "Android",
        "deviceType": "mobile",
        "os": "Android",
        "os_version": "Android 13",
        "browser_version": "null",
        "orientation": "landscape"
      }
    };

    var response = await GlobalFunction.apiPostRequestTokenForBet(
      url,
      body,
      context,
      stakeController,
    );
    setState(() {
      manualAmount = false;
    });
    var result = jsonDecode(response);
    print("betBody--->$body");
    if (result['status'] == true) {
      getVcLiablity();
      print("response--->$result");
      DialogUtils.showOneBtnPortrait(context, result['message']);

      setState(() {
        manualAmount = false;
        stakeController.clear();
      });
    } else {
      manualAmount = false;
      stakeController.clear();

      DialogUtils.showOneBtnPortrait(context, result['message']);
    }

    stakeController.clear();
    manualAmount = false;
  }
}
