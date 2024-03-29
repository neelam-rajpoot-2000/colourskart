// ignore_for_file: use_build_context_synchronously

import 'dart:async';
import 'dart:convert';
import 'dart:math';
import 'package:blinking_text/blinking_text.dart';
import 'package:flip_card/flip_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:just_audio/just_audio.dart';
import 'package:lottie/lottie.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:vibration/vibration.dart';
import 'package:virtual_casino/DragonTigerLion/Animation/random_animation_left.dart';
import 'package:virtual_casino/DragonTigerLion/Animation/random_animation_left_p.dart';
import 'package:virtual_casino/DragonTigerLion/Animation/random_animation_right_p.dart';
import 'package:virtual_casino/DragonTigerLion/buttons_model.dart';
import 'package:virtual_casino/User-Interface/current_user_bet.dart';
import 'package:virtual_casino/Utils/toast.dart';
import 'package:http/http.dart' as http;
import '../User-Interface/change_passswod_screen.dart';
import '../User-Interface/my_account.dart';
import '../User-Interface/profile_screen.dart';
import '../User-Interface/signin_screen.dart';
import '../Utils/api_helper.dart';
import '../Utils/apis.dart';
import '../Widgets/customText.dart';
import '../constants/color_constants.dart';
import '../data/model/dragon_tiger_lion_model.dart';
import '../data/model/liablity_model.dart';
import '../data/model/match_id_model.dart';
import 'Animation/random_animation_right.dtl.dart';

class DragonTigerLionPlayRoom extends StatefulWidget {
  final String matchID;
  final String gameCode;
  const DragonTigerLionPlayRoom(
      {super.key, required this.matchID, required this.gameCode});

  @override
  State<DragonTigerLionPlayRoom> createState() =>
      _DragonTigerLionPlayRoomState();
}

class _DragonTigerLionPlayRoomState extends State<DragonTigerLionPlayRoom>
    with TickerProviderStateMixin, WidgetsBindingObserver {
  final GlobalKey<ScaffoldState> _globalKey = GlobalKey<ScaffoldState>();
  List<LiablityModel> liablityList = [];
  double mainBalance = 0;
  final stopBettingmusic = AudioPlayer();
  final startBettingmusic = AudioPlayer();
  final onPressedmusic = AudioPlayer();
  late AnimationController _controller;
  List<DragonTigerLionResult> cardResultList = [];
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
  bool confirmButton = false;
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
  List<ButtonsModelDTL> buttonsList = [];
  bool dragonButton = false;
  bool tigerButton = false;
  bool lionButton = false;
  bool manualAmount = false;
  var stakeController = TextEditingController();
  String sid = "";
  String oddsRates = "";
  String winnerDRate = "";
  bool winnerDbutton = false;
  String blackDRate = "";
  bool blackDbutton = false;
  String redDRate = "";
  bool redDbutton = false;
  
  final _player = AudioPlayer();
  final _cardPlayer = AudioPlayer();
  List<Color> chipColors = List.generate(200, (index) => Colors.blue); // Generate 100 blue chips
 List<Offset> chipPositions = List.generate(
   200,
   (index) => Offset(
     Random().nextDouble(), // Random horizontal position
     Random().nextDouble(), // Random vertical position
   ),
 );
 int currentChipIndex = 0;


 Offset targetBox = Offset(150, 100); // Target box position


  var gameSound = "assets/lucky7/audio/bgm.mp3";

int startTimeSmall = 0;

  void bgMusic() async {
    await _player.setAsset(gameSound);
    playSound();
  }

  void playSound() async {
    await _player.setVolume(0.05);
    await _player.play();
    await _player.setLoopMode(LoopMode.one);
  }

  Future<void> cardPlay() async {
    _player.playbackEventStream.listen((event) {},
        onError: (Object e, StackTrace stackTrace) {
      print('A stream error occurred: $e');
    });
    try {
      await _cardPlayer.setAudioSource(AudioSource.asset(
        "assets/Teen-patti/audio/flipcard.mp3",
      ));
    } catch (e) {
      print("Error loading audio source: $e");
    }
    _player.play();
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
    autoTime == '3' &&
            autoTime != '2' &&
            autoTime != '1' &&
            autoTime != '0' &&
            playBackgroundMusic == false
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

  
  Future<void> onPressedMusic() async {
    onPressedmusic.playbackEventStream.listen((event) {},
        onError: (Object e, StackTrace stackTrace) {
      print('A stream error occurred: $e');
    });
    try {
      await onPressedmusic.setAudioSource(AudioSource.asset(
        "assets/Teen-patti/audio/flipcard.mp3",
      ));
    } catch (e) {
      print("Error loading audio source: $e");
    }
    autoTime == "45" && playBackgroundMusic == false
        ? onPressedmusic.play()
        : onPressedmusic.stop();
  }

  Future<void> onPressedMusicForBet() async {
    onPressedmusic.playbackEventStream.listen((event) {},
        onError: (Object e, StackTrace stackTrace) {
      print('A stream error occurred: $e');
    });
    try {
      await onPressedmusic.setAudioSource(AudioSource.asset(
        "assets/Teen-patti/audio/coinsound.wav",
      ));
    } catch (e) {
      print("Error loading audio source: $e");
    }
    startTimes > 3 && playBackgroundMusic == false
        ? onPressedmusic.play()
        : onPressedmusic.stop();
  }

  @override
  void initState() {
    bgMusic();
        AudioPlayer.clearAssetCache();
    WidgetsBinding.instance.addObserver(this);
    startTimeSmall = startTimes * 100;
    Timer.periodic(const Duration(milliseconds: 10), (timer) {
      startTimeSmall = startTimeSmall - 1;
    });
    dragonButton = true;
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

    _controller.repeat(reverse: true);
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.landscapeLeft,
      DeviceOrientation.landscapeRight,
      DeviceOrientation.portraitUp
    ]);
    super.initState();
  }

 
  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.paused) {
      playBackgroundMusic = true;
      _player.pause();
    } else if (state == AppLifecycleState.resumed) {
      //  _player.play();
    }
  }

  void dispose() {
    _controller.dispose();
  _player.dispose();
    WidgetsBinding.instance.removeObserver(this);
    startBettingmusic.dispose();
    stopBettingmusic.dispose();

    _cardPlayer.dispose();

    super.dispose();
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

  Widget protraitModeWidget() {
    return Scaffold(
      key: _globalKey,
      backgroundColor: Colors.transparent,
      drawer: Drawer(width: width * 0.55, child: drawerWidget()),
      body: Container(
          height: height,
          width: width,
          decoration: BoxDecoration(
              image: DecorationImage(
            image: AssetImage(
              "assets/dragonTigerLion/tableImges/bakcgroung-image-p.png",
            ),
            fit: BoxFit.fill,
          )),
          child: SingleChildScrollView(
            child: Column(children: [
              Padding(
                padding: EdgeInsets.only(
                    left: width * 0.02,
                    right: width * 0.02,
                    bottom: height * 0.01,
                    top: height * 0.02),
                child: Row(
                  children: [
                    Container(
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                          image: DecorationImage(
                              image: AssetImage(
                                'assets/dragonTigerLion/buttonsImage/balance-frma.png',
                              ),
                              fit: BoxFit.fill)),
                      child: Container(
                        padding: EdgeInsets.symmetric(
                            horizontal: width * 0.02, vertical: height * 0.001),
                        child: Row(
                          children: [
                            Image.asset(
                              'assets/lucky7/images/Group 658.png',
                              height: height * 0.04,
                              width: width * 0.045,
                            ),
                            Text(
                              "  ${mainBalance.toStringAsFixed(2)}",
                              style: TextStyle(
                                  color: Color(0xffFFEFC1),
                                  fontSize: height * 0.015,
                                  fontWeight: FontWeight.w500),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Expanded(
                      child: SizedBox(),
                    ),
                    InkWell(
                      onTap: () {
                        setState(() {
                          playBackgroundMusic == false
                              ? onPressedMusic()
                              : Vibration.vibrate();
                        });
                        _globalKey.currentState!.openDrawer();
                      },
                      child: Image.asset(
                          'assets/dragonTigerLion/buttonsImage/menu-button.png',
                          fit: BoxFit.cover,
                          height: height * 0.05),
                    ),
                    SizedBox(
                      width: width * 0.001,
                    ),
                    playBackgroundMusic == false
                        ? InkWell(
                            onTap: () {
                              setState(() {
                                playBackgroundMusic == false
                                    ? onPressedMusic()
                                    : Vibration.vibrate();
                              });
                              _player.stop();

                              setState(() {
                                playBackgroundMusic = true;
                              });
                            },
                            child: Image.asset(
                                'assets/dragonTigerLion/buttonsImage/sound-button.png',
                                fit: BoxFit.fill,
                                height: height * 0.045),
                          )
                        : InkWell(
                            onTap: () {
                              setState(() {
                                playBackgroundMusic == false
                                    ? onPressedMusic()
                                    : Vibration.vibrate();
                              });
                              _player.play();

                              setState(() {
                                playBackgroundMusic = false;
                              });
                            },
                            child: Image.asset(
                                'assets/dragonTigerLion/buttonsImage/mute-button.png',
                                fit: BoxFit.fill,
                                height: height * 0.045),
                          ),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: width * 0.01,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      padding: EdgeInsets.only(
                          left: width * 0.02,
                          right: width * 0.015,
                          top: height * 0.001),
                      height: height * 0.04,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                          image: DecorationImage(
                              image: AssetImage(
                                "assets/dragonTigerLion/buttonsImage/exp-button.png",
                              ),
                              fit: BoxFit.fill)),
                      child: CustomText(
                          text: "EXP : $liablity ",
                          color: Color(0xffFFEFC1),
                          fontSize: height * 0.0125,
                          fontWeight: FontWeight.w500),
                    ),
                    InkWell(
                      onTap: () {
                        setState(() {
                          playBackgroundMusic == false
                              ? onPressedMusic()
                              : Vibration.vibrate();
                        });
                         Navigator.push(context, _createRouteCurrentBetsList());
                      },
                      child: Container(
                        padding: EdgeInsets.only(
                            left: width * 0.165, top: height * 0.001),
                        height: height * 0.04,
                        width: width * 0.25,
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                            image: DecorationImage(
                                image: AssetImage(
                                  "assets/dragonTigerLion/buttonsImage/my-bet-image.png",
                                ),
                                fit: BoxFit.fill)),
                        child: CustomText(
                          text: matchIdList.length.toString(),
                          fontWeight: FontWeight.w700,
                          color: Colors.white,
                          fontSize: width * 0.023,
                          textAlign: TextAlign.center,
                        ),
                      ),
                    )
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
                        top: height * 0.02,
                        left: width * 0.02,
                        right: width * 0.02,
                        bottom: height * 0.01),
                    child: Container(
                      height: height * 0.04,
                      width: double.infinity,
                      decoration: BoxDecoration(
                          image: DecorationImage(
                        image: AssetImage(
                            "assets/dragonTigerLion/tableImges/small-result-p.png"),
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
                                  DialogUtils.showResultDTLPortrait(
                                    context,
                                    items.winner == "1"
                                        ? items.dragonDetail
                                        : items.winner == "2"
                                            ? items.tigerDetail
                                            : items.lionDetail,
                                    items.card1,
                                    items.card2,
                                    items.card3,
                                    items.winnerDetail,
                                    items.mid,
                                    items.tigerDetail,
                                    items.lionDetail,
                                    playBackgroundMusic,
                                    height * 0.3,
                                    width,
                                    height * 0.1,
                                    width,
                                   width*0.1,
                                    width * 0.2,
                                    width * 0.2,
                                    width * 0.2,
                                  );
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
                                      color: items.winner == "1"
                                          ? Color(0xaa028BA9)
                                          : items.winner == "2"
                                              ? Color(0xaaA90270)
                                              : ColorConstants.lightGreenColor),
                                  child: Text(
                                    items.winner == "1"
                                        ? "D"
                                        : items.winner == "2"
                                            ? "T"
                                            : "L",
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
                alignment: Alignment.centerRight,
                margin: EdgeInsets.symmetric(horizontal: 20),
                child: Text(
                  "( Min:100 Max: 25000 )",
                  style: TextStyle(color: Colors.white, fontSize: 12),
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
                    'assets/dragonTigerLion/tableImges/table-image-p.png',
                    fit: BoxFit.cover,
                    height: height * 0.38,
                    //width: width * 1.00,
                  ),
                  Positioned(
                    top: 13,
                    left: 30,
                    child: Image.asset(
                      'assets/lucky7/images/frame/logo.png',
                      fit: BoxFit.cover,
                      height: height * 0.05,
                    ),
                  ),
                  Positioned(
                      top: 13,
                      right: 15,
                      child: Image.asset(
                        'assets/lucky7/images/frame/logo.png',
                        fit: BoxFit.cover,
                        height: height * 0.05,
                      )),
                  SizedBox(
                      height: height * 0.36,
                      child: PotraitRandomCoinLeftSideLDTL(
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
                      child: PotraitRandomCoinRightSideDTL()),
                         startTimes >= 1
                      ? Positioned(
                          left: width * 0.40,
                          top: height * 0.012,
                          child: CustomText(
                            text: "Starting in ",
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                            fontSize: 09.0,
                            textAlign: TextAlign.end,
                          ),
                        )
                      : SizedBox(),

                  startTimes >= 1
                      ? Positioned(
                          left: width * 0.54,
                          top: height * 0.012,
                          child: SizedBox(
                            width: width * 0.055,
                            child: Center(
                              child: CustomText(
                                text: "$autoTime s",
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                                fontSize: 09.0,
                                textAlign: TextAlign.start,
                              ),
                            ),
                          ),
                        )
                      : SizedBox(),
                  Positioned(
                    left: width * 0.37,
                    top: height * 0.05,
                    child: startTimes >= 3
                        ? SizedBox(
                          height: 5,
                          width: width * 0.25,
                          child: LinearProgressIndicator(
                            value: startTimeSmall /
                                4500, // Calculate the progress
                            backgroundColor: Colors.grey,
                            valueColor:
                                AlwaysStoppedAnimation(Color(0xaa9919D2)),
                          ),
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
                  startTimes <= 3 && autoTime != '0'
                      ? gameStopBettingPortrait(autoTime)
                      : SizedBox(),
                  Positioned(
                    bottom: height * 0.01,
                    left: width * 0.155,
                    child: Row(
                      children: [
                        InkWell(
                          onTap: () {
                            setState(() {
                              playBackgroundMusic == false
                                  ? ''
                                  : Vibration.vibrate();
                              ;
                            });

                            setState(() {
                              redCoinAnimation = !redCoinAnimation;
                              lightGreenCoinAnimation = false;

                              greenCoinAnimation = false;
                              lightBlueCoinAnimation = false;
                              brownCoinAnimation = false;
                            });
                          },
                          child: AnimatedContainer(
                            duration: Duration(milliseconds: 700),
                            alignment: Alignment.center,
                            height: redCoinAnimation == true && startTimes > 1
                                ? height * 0.07
                                : height * 0.05,
                            width: redCoinAnimation == true && startTimes > 1
                                ? width * 0.15
                                : width * 0.105,
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
                          width: width * 0.045,
                        ),
                        InkWell(
                          onTap: () {
                            setState(() {
                              playBackgroundMusic == false
                                  ? ''
                                  : Vibration.vibrate();
                              ;
                            });

                            setState(() {
                              redCoinAnimation = false;
                              lightGreenCoinAnimation =
                                  !lightGreenCoinAnimation;

                              greenCoinAnimation = false;
                              lightBlueCoinAnimation = false;
                              brownCoinAnimation = false;
                            });
                          },
                          child: AnimatedContainer(
                            duration: Duration(milliseconds: 700),
                            alignment: Alignment.center,
                            height: lightGreenCoinAnimation == true &&
                                    startTimes > 1
                                ? height * 0.07
                                : height * 0.05,
                            width: lightGreenCoinAnimation == true &&
                                    startTimes > 1
                                ? width * 0.15
                                : width * 0.105,
                            decoration: BoxDecoration(
                                image: DecorationImage(
                              image: AssetImage(
                                  "assets/lucky7/images/coins/light_green_coin.png"),
                              fit: BoxFit.fill,
                            )),
                            child: Text(
                              stack1 != 0 ? "1K" : stack2.toString(),
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: height * 0.01),
                            ),
                          ),
                        ),
                        SizedBox(
                          width: width * 0.045,
                        ),
                        InkWell(
                          onTap: () {
                            playBackgroundMusic == false
                                ? ''
                                : Vibration.vibrate();
                            setState(() {
                              redCoinAnimation = false;
                              lightGreenCoinAnimation = false;

                              greenCoinAnimation = false;
                              lightBlueCoinAnimation = !lightBlueCoinAnimation;
                              brownCoinAnimation = false;
                            });
                          },
                          child: AnimatedContainer(
                            duration: Duration(milliseconds: 700),
                            alignment: Alignment.center,
                            height:
                                lightBlueCoinAnimation == true && startTimes > 1
                                    ? height * 0.07
                                    : height * 0.05,
                            width:
                                lightBlueCoinAnimation == true && startTimes > 1
                                    ? width * 0.15
                                    : width * 0.105,
                            decoration: BoxDecoration(
                                image: DecorationImage(
                              image: AssetImage(
                                  "assets/lucky7/images/coins/skyblue.png"),
                              fit: BoxFit.fill,
                            )),
                            child: Text(
                              stack2 != 0 ? "2K" : stack3.toString(),
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: height * 0.01),
                            ),
                          ),
                        ),
                        SizedBox(
                          width: width * 0.045,
                        ),
                        InkWell(
                          onTap: () {
                            setState(() {
                              playBackgroundMusic == false
                                  ? ''
                                  : Vibration.vibrate();
                              ;
                            });
                            setState(() {
                              redCoinAnimation = false;
                              lightGreenCoinAnimation = false;

                              greenCoinAnimation = !greenCoinAnimation;
                              lightBlueCoinAnimation = false;
                              brownCoinAnimation = false;
                            });
                          },
                          child: AnimatedContainer(
                            duration: Duration(milliseconds: 700),
                            alignment: Alignment.center,
                            height: greenCoinAnimation == true && startTimes > 1
                                ? height * 0.07
                                : height * 0.05,
                            width: greenCoinAnimation == true && startTimes > 1
                                ? width * 0.15
                                : width * 0.105,
                            decoration: BoxDecoration(
                                image: DecorationImage(
                              image: AssetImage(
                                  "assets/lucky7/images/coins/green_coin.png"),
                              fit: BoxFit.fill,
                            )),
                            child: Text(
                              stack3 != 0 ? "5K" : stack4.toString(),
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: height * 0.01),
                            ),
                          ),
                        ),
                        SizedBox(
                          width: width * 0.045,
                        ),
                        InkWell(
                          onTap: () {
                            setState(() {
                              playBackgroundMusic == false
                                  ? ''
                                  : Vibration.vibrate();
                              ;
                            });

                            setState(() {
                              redCoinAnimation = false;
                              lightGreenCoinAnimation = false;

                              greenCoinAnimation = false;
                              lightBlueCoinAnimation = false;
                              brownCoinAnimation = !brownCoinAnimation;
                            });
                          },
                          child: AnimatedContainer(
                            duration: Duration(milliseconds: 700),
                            alignment: Alignment.center,
                            height: brownCoinAnimation == true && startTimes > 1
                                ? height * 0.08
                                : height * 0.06,
                            width: brownCoinAnimation == true && startTimes > 1
                                ? width * 0.17
                                : width * 0.13,
                            decoration: BoxDecoration(
                                image: DecorationImage(
                              image: AssetImage(
                                  "assets/lucky7/images/coins/brown.png"),
                              fit: BoxFit.fill,
                            )),
                            child: Text(
                              stack4 != 0 ? "20K" : stack6.toString(),
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: height * 0.01),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 30,
              ),
              SizedBox(
                height: height * 0.1,
                width: width * 0.9,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    InkWell(
                      onTap: () {
                        setState(() {
                          tigerButton = false;
                          lionButton = false;
                          dragonButton = true;
                        });
                      },
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "DRAGON",
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 18,
                                fontWeight: FontWeight.bold),
                          ),
                          dragonButton == true
                              ? Container(
                                  height: 2,
                                  width: width * 0.2,
                                  decoration:
                                      BoxDecoration(color: Color(0xaa19ACEC)),
                                )
                              : SizedBox(
                                  height: 2,
                                  width: width * 0.2,
                                ),
                        ],
                      ),
                    ),
                    Container(
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                          image: DecorationImage(
                              image: AssetImage(
                                  "assets/dragonTigerLion/buttonsImage/Line 39.png"))),
                      height: height * 0.05,
                      width: width * 0.15,
                    ),
                    InkWell(
                      onTap: () {
                        setState(() {
                          tigerButton = true;
                          lionButton = false;
                          dragonButton = false;
                        });
                      },
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "TIGER",
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 18,
                                fontWeight: FontWeight.bold),
                          ),
                          tigerButton == true
                              ? Container(
                                  height: 2,
                                  width: width * 0.2,
                                  decoration:
                                      BoxDecoration(color: Color(0xaa19ACEC)),
                                )
                              : SizedBox(
                                  height: 2,
                                  width: width * 0.2,
                                ),
                        ],
                      ),
                    ),
                    Container(
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                          image: DecorationImage(
                              image: AssetImage(
                                  "assets/dragonTigerLion/buttonsImage/Line 39.png"))),
                      height: height * 0.05,
                      width: width * 0.15,
                    ),
                    InkWell(
                      onTap: () {
                        setState(() {
                          tigerButton = false;
                          lionButton = true;
                          dragonButton = false;
                        });
                      },
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "LION",
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 18,
                                fontWeight: FontWeight.bold),
                          ),
                          lionButton == true
                              ? Container(
                                  height: 2,
                                  width: width * 0.2,
                                  decoration:
                                      BoxDecoration(color: Color(0xaa19ACEC)),
                                )
                              : SizedBox(
                                  height: 2,
                                  width: width * 0.2,
                                ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 10,
              ),
              dragonButton == true
                  ? SizedBox(
                      height: height * 0.5,
                      width: width * 0.9,
                      child: GridView.builder(
                          shrinkWrap: true,
                          physics: BouncingScrollPhysics(),
                          gridDelegate:
                              SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 2, mainAxisExtent: 60),
                          itemCount: dragonList.length,
                          itemBuilder: (context, index) {
                            var items = dragonList[index];
                            return Container(
                              margin: const EdgeInsets.symmetric(
                                  horizontal: 10, vertical: 10),
                              height: height * 0.05,
                              width: width * 0.4,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  border: Border.all(
                                      color: Color(0xaa40A3CC), width: 2)),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Container(
                                    margin: const EdgeInsets.symmetric(
                                        horizontal: 10),
                                    child: Text(
                                      items['nat'],
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                  InkWell(
                                    onTap: () {
                                      setState(() {
                                        sid = items['sid'];
                                        oddsRates = items['rate'];
                                      });
                                      if (autoTime != "0") {
                                        showMyDialogForBetPortrait(
                                            context,
                                            height * 0.23,
                                            width,
                                            height * 0.4,
                                            width * 0.7,
                                            height * 0.26,
                                            width * 0.98,
                                            redCoinAnimation == true
                                                ? stack1
                                                : greenCoinAnimation == true
                                                    ? stack2
                                                    : lightGreenCoinAnimation ==
                                                            true
                                                        ? stack3
                                                        : blueCoinAnimation ==
                                                                true
                                                            ? stack4
                                                            : brownCoinAnimation ==
                                                                    true
                                                                ? stack5
                                                                : lightBlueCoinAnimation ==
                                                                        true
                                                                    ? stack6
                                                                    : 0);
                                      }
                                    },
                                    child: Container(
                                      alignment: Alignment.center,
                                      margin: const EdgeInsets.symmetric(
                                          horizontal: 3),
                                      height: height * 0.08,
                                      width: width * 0.1,
                                      decoration: BoxDecoration(
                                          color: Color(0xaa0288A5),
                                          borderRadius:
                                              BorderRadius.circular(5)),
                                      child: Text(
                                        items['rate'],
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            );
                          }))
                  : tigerButton == true
                      ? SizedBox(
                          height: height * 0.5,
                          width: width * 0.9,
                          child: GridView.builder(
                              shrinkWrap: true,
                              physics: BouncingScrollPhysics(),
                              gridDelegate:
                                  SliverGridDelegateWithFixedCrossAxisCount(
                                      crossAxisCount: 2, mainAxisExtent: 60),
                              itemCount: tigerList.length,
                              itemBuilder: (context, index) {
                                var items = tigerList[index];

                                return Container(
                                  margin: const EdgeInsets.symmetric(
                                      horizontal: 10, vertical: 10),
                                  height: height * 0.05,
                                  width: width * 0.4,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                      border: Border.all(
                                          color: Color(0xaa40A3CC), width: 2)),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Container(
                                        margin: const EdgeInsets.symmetric(
                                            horizontal: 10),
                                        child: Text(
                                          items['nat'],
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ),
                                      InkWell(
                                        onTap: () {
                                          setState(() {
                                            sid = items['sid'];
                                            oddsRates = items['rate'];
                                          });
                                          if (autoTime != "0") {
                                            showMyDialogForBetPortrait(
                                                context,
                                                height * 0.23,
                                                width,
                                                height * 0.4,
                                                width * 0.7,
                                                height * 0.26,
                                                width * 0.98,
                                                redCoinAnimation == true
                                                    ? stack1
                                                    : greenCoinAnimation == true
                                                        ? stack2
                                                        : lightGreenCoinAnimation ==
                                                                true
                                                            ? stack3
                                                            : blueCoinAnimation ==
                                                                    true
                                                                ? stack4
                                                                : brownCoinAnimation ==
                                                                        true
                                                                    ? stack5
                                                                    : lightBlueCoinAnimation ==
                                                                            true
                                                                        ? stack6
                                                                        : 0);
                                          }
                                        },
                                        child: Container(
                                          alignment: Alignment.center,
                                          margin: const EdgeInsets.symmetric(
                                              horizontal: 3),
                                          height: height * 0.08,
                                          width: width * 0.1,
                                          decoration: BoxDecoration(
                                              color: Color(0xaa0288A5),
                                              borderRadius:
                                                  BorderRadius.circular(5)),
                                          child: Text(
                                            items['rate'],
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontWeight: FontWeight.bold),
                                          ),
                                        ),
                                      )
                                    ],
                                  ),
                                );
                              }))
                      : lionButton == true
                          ? SizedBox(
                              height: height * 0.5,
                              width: width * 0.9,
                              child: GridView.builder(
                                shrinkWrap: true,
                                physics: BouncingScrollPhysics(),
                                gridDelegate:
                                    SliverGridDelegateWithFixedCrossAxisCount(
                                        crossAxisCount: 2, mainAxisExtent: 60),
                                itemCount: lionList.length,
                                itemBuilder: (context, index) {
                                  var items = lionList[index];

                                  return Container(
                                    margin: const EdgeInsets.symmetric(
                                        horizontal: 10, vertical: 10),
                                    height: height * 0.05,
                                    width: width * 0.4,
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(10),
                                        border: Border.all(
                                            color: Color(0xaa40A3CC),
                                            width: 2)),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Container(
                                          margin: const EdgeInsets.symmetric(
                                              horizontal: 10),
                                          child: Text(
                                            items['nat'],
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontWeight: FontWeight.bold),
                                          ),
                                        ),
                                        InkWell(
                                          onTap: () {
                                            setState(() {
                                              sid = items['sid'];
                                              oddsRates = items['rate'];
                                            });
                                            if (autoTime != "0") {
                                              showMyDialogForBetPortrait(
                                                  context,
                                                  height * 0.23,
                                                  width,
                                                  height * 0.4,
                                                  width * 0.7,
                                                  height * 0.26,
                                                  width * 0.98,
                                                  redCoinAnimation == true
                                                      ? stack1
                                                      : greenCoinAnimation ==
                                                              true
                                                          ? stack2
                                                          : lightGreenCoinAnimation ==
                                                                  true
                                                              ? stack3
                                                              : blueCoinAnimation ==
                                                                      true
                                                                  ? stack4
                                                                  : brownCoinAnimation ==
                                                                          true
                                                                      ? stack5
                                                                      : lightBlueCoinAnimation ==
                                                                              true
                                                                          ? stack6
                                                                          : 0);
                                            }
                                          },
                                          child: Container(
                                            alignment: Alignment.center,
                                            margin: const EdgeInsets.symmetric(
                                                horizontal: 3),
                                            height: height * 0.08,
                                            width: width * 0.1,
                                            decoration: BoxDecoration(
                                                color: Color(0xaa0288A5),
                                                borderRadius:
                                                    BorderRadius.circular(5)),
                                            child: Text(
                                              items['rate'],
                                              style: TextStyle(
                                                  color: Colors.white,
                                                  fontWeight: FontWeight.bold),
                                            ),
                                          ),
                                        )
                                      ],
                                    ),
                                  );
                                },
                              ))
                          : SizedBox(),
              SizedBox(
                height: 10,
              ),
            ]),
          )),
    );
  }

  Widget landscapeWidget() {
    return Scaffold(
      drawerEnableOpenDragGesture: false,
      backgroundColor: Colors.transparent,
      key: _globalKey,
      drawer:
          SizedBox(width: width * 0.3, child: Drawer(child: drawerWidget())),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
                height: height,
                decoration: BoxDecoration(
                    image: DecorationImage(
                        image: AssetImage(
                            "assets/dragonTigerLion/tableImges/background-image.png"),
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
                                    'assets/dragonTigerLion/buttonsImage/menu-button.png',
                                    fit: BoxFit.fill,
                                    width: width * 0.045),
                              ),
                              SizedBox(
                                width: width * 0.03,
                              ),
                              Container(
                                padding: EdgeInsets.symmetric(
                                    horizontal: width * 0.02,
                                    vertical: height * 0.015),
                                alignment: Alignment.center,
                                decoration: BoxDecoration(
                                    image: DecorationImage(
                                        image: AssetImage(
                                            'assets/dragonTigerLion/buttonsImage/balance-frma.png'),
                                        fit: BoxFit.fill)),
                                child: Row(
                                  children: [
                                    Image.asset(
                                      'assets/lucky7/images/Group 658.png',
                                      height: height * 0.05,
                                      width: width * 0.03,
                                    ),
                                    Text(
                                      "  ${mainBalance.toStringAsFixed(2)}",
                                      style: TextStyle(
                                          color: Color(0xffFFEFC1),
                                          fontSize: height * 0.03,
                                          fontWeight: FontWeight.w500),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                          InkWell(
                            onTap: () {
                              setState(() {
                                playBackgroundMusic == false
                                    ? onPressedMusic()
                                    : Vibration.vibrate();
                              });
                                  Navigator.push(context, _createRouteCurrentBetsList());
                            },
                            child: Container(
                              padding: EdgeInsets.only(
                                  left: width * 0.085, top: height * 0.001),
                              height: height * 0.09,
                              width: width * 0.13,
                              alignment: Alignment.center,
                              decoration: BoxDecoration(
                                  image: DecorationImage(
                                      image: AssetImage(
                                        'assets/dragonTigerLion/buttonsImage/my-bet-image.png',
                                      ),
                                      fit: BoxFit.fill)),
                              child: CustomText(
                                text: matchIdList.length.toString(),
                                fontWeight: FontWeight.w500,
                                color: Colors.yellow[50],
                                fontSize: width * 0.014,
                                textAlign: TextAlign.center,
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
                      top: height * 0.1,
                      child: Image.asset(
                        'assets/dragonTigerLion/tableImges/table-girl.png',
                        fit: BoxFit.cover,
                        height: height * 0.28,
                      ),
                    ),
                    startTimes >= 1
                        ? Positioned(
                            top: height * 0.02,
                            right: width * 0.18,
                            child: CustomText(
                              text: "Starting in ",
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                              fontSize: 09.0,
                              textAlign: TextAlign.end,
                            ),
                          )
                        : SizedBox(),
                    startTimes >= 1
                        ? Positioned(
                            top: height * 0.02,
                            right: width * 0.148,
                            child: SizedBox(
                              width: width * 0.03,
                              child: Center(
                                child: CustomText(
                                  text: "$autoTime  s",
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                  fontSize: 09.0,
                                  textAlign: TextAlign.start,
                                ),
                              ),
                            ),
                          )
                        : SizedBox(),
                    Positioned(
                      top: height * 0.05,
                      right: width * 0.02,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.end,
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              //---------------Game Timer------------//
                              startTimes >= 1
                                  ? Column(
                                      children: [
                                        SizedBox(
                                          height: 4,
                                          width: width * 0.15,
                                          child: LinearProgressIndicator(
                                            value: startTimeSmall /
                                                4500, // Calculate the progress
                                            backgroundColor: Colors.grey,
                                            valueColor: AlwaysStoppedAnimation(
                                                Color(0xaa9919D2)),
                                          ),
                                        ),
                                        SizedBox(
                                          height: 4,
                                        ),
                                        Text(
                                          "Min:100 Max: 250000",
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontWeight: FontWeight.bold,
                                              fontSize: 10),
                                        )
                                      ],
                                    )
                                  : SizedBox(),
                              SizedBox(
                                width: width * 0.05,
                              ),
                              playBackgroundMusic == false
                                  ? InkWell(
                                      onTap: () {
                                        setState(() {
                                          playBackgroundMusic == false
                                              ? onPressedMusic()
                                              : Vibration.vibrate();
                                        });
                                        _player.stop();
                                        setState(() {
                                          playBackgroundMusic = true;
                                        });
                                      },
                                      child: Image.asset(
                                          "assets/dragonTigerLion/buttonsImage/sound-button.png",
                                          fit: BoxFit.fill,
                                          width: width * 0.045),
                                    )
                                  : InkWell(
                                      onTap: () {
                                        setState(() {
                                          playBackgroundMusic == false
                                              ? onPressedMusic()
                                              : Vibration.vibrate();
                                        });
                                        _player.play();
                                        setState(() {
                                          playBackgroundMusic = false;
                                        });
                                      },
                                      child: Image.asset(
                                          'assets/dragonTigerLion/buttonsImage/mute-button.png',
                                          fit: BoxFit.fill,
                                          width: width * 0.045),
                                    ),
                            ],
                          ),
                        ],
                      ),
                    ),

                    ///

                    Positioned(
                      bottom: 1,
                      child: Image.asset(
                        'assets/dragonTigerLion/tableImges/table-Image.png',
                        fit: BoxFit.fill,
                        height: height * 0.67,
                      ),
                    ),
                    Positioned(
                      top: height * 0.37,
                      left: width * 0.17,
                      child: Image.asset(
                        'assets/lucky7/images/frame/logo.png',
                        fit: BoxFit.cover,
                        height: height * 0.10,
                      ),
                    ),
                    Positioned(
                      top: height * 0.37,
                      right: width * 0.17,
                      child: Image.asset(
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
                    LandscapeRandomCoinLeftSideDTL(
                        coinsSound: playBackgroundMusic),
                    RandomCoinThroughRightSideDTL(),
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

                    startTimes <= 3 && autoTime != '0'
                        ? gameStopBetting(autoTime)
                        : SizedBox(),

                    Positioned(
                      bottom: height * 0.01,
                      left: width * 0.30,
                      child: Row(
                        children: [
                          InkWell(
                            onTap: () {
                              setState(() {
                                playBackgroundMusic == false
                                    ? ''
                                    : Vibration.vibrate();
                                ;
                              });
                              setState(() {
                                redCoinAnimation = true;
                                lightGreenCoinAnimation = false;

                                greenCoinAnimation = false;
                                lightBlueCoinAnimation = false;
                                brownCoinAnimation = false;
                              });
                            },
                            child: AnimatedContainer(
                              duration: Duration(milliseconds: 700),
                              alignment: Alignment.center,
                              height: redCoinAnimation == true && startTimes > 1
                                  ? height * 0.15
                                  : height * 0.11,
                              width: redCoinAnimation == true && startTimes > 1
                                  ? width * 0.07
                                  : width * 0.05,
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
                                    fontSize: height * 0.02),
                              ),
                            ),
                          ),
                          SizedBox(
                            width: width * 0.03,
                          ),
                          InkWell(
                            onTap: () {
                              setState(() {
                                playBackgroundMusic == false
                                    ? ''
                                    : Vibration.vibrate();
                                ;
                              });
                              setState(() {
                                lightGreenCoinAnimation = true;
                                redCoinAnimation = false;

                                greenCoinAnimation = false;
                                lightBlueCoinAnimation = false;
                                brownCoinAnimation = false;
                              });
                            },
                            child: AnimatedContainer(
                              duration: Duration(milliseconds: 700),
                              alignment: Alignment.center,
                              height: lightGreenCoinAnimation == true &&
                                      startTimes > 1
                                  ? height * 0.15
                                  : height * 0.11,
                              width: lightGreenCoinAnimation == true &&
                                      startTimes > 1
                                  ? width * 0.07
                                  : width * 0.05,
                              decoration: BoxDecoration(
                                  image: DecorationImage(
                                image: AssetImage(
                                    "assets/lucky7/images/coins/light_green_coin.png"),
                                fit: BoxFit.fill,
                              )),
                              child: Text(
                                stack1 != 0 ? "1K" : stack1.toString(),
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: height * 0.02),
                              ),
                            ),
                          ),
                          SizedBox(
                            width: width * 0.03,
                          ),
                          InkWell(
                            onTap: () {
                              setState(() {
                                playBackgroundMusic == false
                                    ? ''
                                    : Vibration.vibrate();
                                ;
                              });
                              setState(() {
                                redCoinAnimation = false;
                                lightGreenCoinAnimation = false;

                                greenCoinAnimation = false;
                                lightBlueCoinAnimation =
                                    !lightBlueCoinAnimation;
                                brownCoinAnimation = false;
                              });
                            },
                            child: AnimatedContainer(
                                duration: Duration(milliseconds: 700),
                                alignment: Alignment.center,
                                height: lightBlueCoinAnimation == true &&
                                        startTimes > 1
                                    ? height * 0.15
                                    : height * 0.11,
                                width: lightBlueCoinAnimation == true &&
                                        startTimes > 1
                                    ? width * 0.07
                                    : width * 0.05,
                                decoration: BoxDecoration(
                                    image: DecorationImage(
                                  image: AssetImage(
                                      "assets/lucky7/images/coins/skyblue.png"),
                                  fit: BoxFit.fill,
                                )),
                                child: Text(
                                  stack2 != 0 ? "2K" : stack3.toString(),
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: height * 0.02),
                                )),
                          ),
                          SizedBox(
                            width: width * 0.03,
                          ),
                          InkWell(
                            onTap: () {
                              setState(() {
                                playBackgroundMusic == false
                                    ? ''
                                    : Vibration.vibrate();
                                ;
                              });
                              setState(() {
                                redCoinAnimation = false;
                                lightGreenCoinAnimation = false;

                                greenCoinAnimation = true;
                                lightBlueCoinAnimation = false;
                                brownCoinAnimation = false;
                              });
                            },
                            child: AnimatedContainer(
                              duration: Duration(milliseconds: 700),
                              alignment: Alignment.center,
                              height:
                                  greenCoinAnimation == true && startTimes > 1
                                      ? height * 0.15
                                      : height * 0.11,
                              width:
                                  greenCoinAnimation == true && startTimes > 1
                                      ? width * 0.07
                                      : width * 0.05,
                              decoration: BoxDecoration(
                                  image: DecorationImage(
                                image: AssetImage(
                                    "assets/lucky7/images/coins/green_coin.png"),
                                fit: BoxFit.fill,
                              )),
                              child: Text(
                                stack3 != 0 ? "5K" : stack4.toString(),
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: height * 0.02),
                              ),
                            ),
                          ),
                          //               SizedBox(
                          //                 width: width * 0.02,
                          //               ),
                          //               InkWell(
                          //                 onTap: () {
                          //                 setState(() {
                          //   playBackgroundMusic == false
                          //       ? onPressedMusic()
                          //       :                  Vibration.vibrate();;
                          // });
                          //                   setState(() {
                          //                     redCoinAnimation = false;
                          //                     lightGreenCoinAnimation = false;
                          //                     blueCoinAnimation = false;
                          //                     greenCoinAnimation = false;
                          //                     lightBlueCoinAnimation = true;
                          //                     brownCoinAnimation = false;
                          //                   });
                          //                 },
                          //                 child: AnimatedContainer(
                          //                   duration: Duration(milliseconds: 700),
                          //                   alignment: Alignment.center,
                          //                   height:
                          //                       lightBlueCoinAnimation == true && startTimes > 1
                          //                           ? height * 0.15
                          //                           : height * 0.11,
                          //                   width:
                          //                       lightBlueCoinAnimation == true && startTimes > 1
                          //                           ? width * 0.07
                          //                       : width * 0.05,
                          //                   decoration: BoxDecoration(
                          //                       image: DecorationImage(
                          //                     image: AssetImage(
                          //                         "assets/lucky7/images/coins/blue.png"),
                          //                     fit: BoxFit.fill,
                          //                   )),
                          //                   child: Text(
                          //                     stack4 != 0 ? "10K" : stack5.toString(),
                          //                     style: TextStyle(
                          //                         fontWeight: FontWeight.bold, fontSize:height * 0.02),
                          //                   ),
                          //                 ),
                          //               ),

                          SizedBox(
                            width: width * 0.03,
                          ),
                          InkWell(
                            onTap: () {
                              setState(() {
                                playBackgroundMusic == false
                                    ? ''
                                    : Vibration.vibrate();
                                ;
                              });
                              setState(() {
                                redCoinAnimation = false;
                                lightGreenCoinAnimation = false;

                                greenCoinAnimation = false;
                                lightBlueCoinAnimation = false;
                                brownCoinAnimation = true;
                              });
                            },
                            child: AnimatedContainer(
                              duration: Duration(milliseconds: 700),
                              alignment: Alignment.center,
                              height:
                                  brownCoinAnimation == true && startTimes > 1
                                      ? height * 0.17
                                      : height * 0.13,
                              width:
                                  brownCoinAnimation == true && startTimes > 1
                                      ? width * 0.075
                                      : width * 0.06,
                              decoration: BoxDecoration(
                                  image: DecorationImage(
                                image: AssetImage(
                                    "assets/lucky7/images/coins/brown.png"),
                                fit: BoxFit.fill,
                              )),
                              child: Text(
                                stack4 != 0 ? "20K" : stack6.toString(),
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: height * 0.02),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),

                    Positioned(
                      top: height * 0.17,
                      right: width * 0.018,
                      child: Container(
                        height: height * 0.75,
                        width: width * 0.05,
                        padding: EdgeInsets.symmetric(vertical: 10),
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5),
                            image: DecorationImage(
                              image: AssetImage(
                                  "assets/dragonTigerLion/tableImges/small-result.png"),
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
                                  HapticFeedback.heavyImpact();
                                  DialogUtils.showResultDTLPortrait(
                                    context,
                                    items.winner == "1"
                                        ? items.dragonDetail
                                        : items.winner == "2"
                                            ? items.tigerDetail
                                            : items.lionDetail,
                                    items.card1,
                                    items.card2,
                                    items.card3,
                                    items.winnerDetail,
                                    items.mid,
                                    items.tigerDetail,
                                    items.lionDetail,
                                    playBackgroundMusic,
                                    height * 0.55,
                                    width * 0.5,
                                    height * 0.12,
                                    width * 0.4,
                                    width * 0.07,
                                    width * 0.1,
                                    width * 0.1,
                                    width * 0.1,
                                  );
                                },
                                child: Container(
                                  margin: EdgeInsets.all(2),
                                  padding: EdgeInsets.all(3),
                                  alignment: Alignment.center,
                                  decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: items.winner == "1"
                                          ? Color(0xaa028BA9)
                                          : items.winner == "2"
                                              ? Color(0xaaA90270)
                                              : ColorConstants.lightGreenColor),
                                  child: Text(
                                    items.winner == "1"
                                        ? "D"
                                        : items.winner == "2"
                                            ? "T"
                                            : "L",
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
                                        "assets/dragonTigerLion/buttonsImage/exp-button.png"))),
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
                          "assets/dragonTigerLion/tableImges/background-image.png"),
                      fit: BoxFit.cover)),
              height: height * 0.7,
              width: width,
              child: Column(
                children: [
                  SizedBox(
                    height: 10,
                  ),
                  SizedBox(
                    height: height * 0.1,
                    width: width * 0.9,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        InkWell(
                          onTap: () {
                            setState(() {
                              tigerButton = false;
                              lionButton = false;
                              dragonButton = true;
                            });
                          },
                          child: Column(
                            children: [
                              Text(
                                "DRAGON",
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold),
                              ),
                              dragonButton == true
                                  ? Container(
                                      height: 2,
                                      width: width * 0.2,
                                      decoration: BoxDecoration(
                                          color: Color(0xaa19ACEC)),
                                    )
                                  : SizedBox(
                                      height: 2,
                                      width: width * 0.2,
                                    ),
                            ],
                          ),
                        ),
                        Container(
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                              image: DecorationImage(
                                  image: AssetImage(
                                      "assets/dragonTigerLion/buttonsImage/Line 39.png"))),
                          height: height * 0.1,
                          width: width * 0.15,
                        ),
                        InkWell(
                          onTap: () {
                            setState(() {
                              tigerButton = true;
                              lionButton = false;
                              dragonButton = false;
                            });
                          },
                          child: Column(
                            children: [
                              Text(
                                "TIGER",
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold),
                              ),
                              tigerButton == true
                                  ? Container(
                                      height: 2,
                                      width: width * 0.2,
                                      decoration: BoxDecoration(
                                          color: Color(0xaa19ACEC)),
                                    )
                                  : SizedBox(
                                      height: 2,
                                      width: width * 0.2,
                                    ),
                            ],
                          ),
                        ),
                        Container(
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                              image: DecorationImage(
                                  image: AssetImage(
                                      "assets/dragonTigerLion/buttonsImage/Line 39.png"))),
                          height: height * 0.1,
                          width: width * 0.15,
                        ),
                        InkWell(
                          onTap: () {
                            setState(() {
                              tigerButton = false;
                              lionButton = true;
                              dragonButton = false;
                            });
                          },
                          child: Column(
                            children: [
                              Text(
                                "LION",
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold),
                              ),
                              lionButton == true
                                  ? Container(
                                      height: 2,
                                      width: width * 0.2,
                                      decoration: BoxDecoration(
                                          color: Color(0xaa19ACEC)),
                                    )
                                  : SizedBox(
                                      height: 2,
                                      width: width * 0.2,
                                    ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  dragonButton == true
                      ? SizedBox(
                          height: height * 0.5,
                          width: width * 0.9,
                          child: MediaQuery.removePadding(
                            context: context,
                            removeBottom: true,
                            removeTop: true,
                            child: SafeArea(
                              top: false,
                              bottom: false,
                              child: GridView.builder(
                                  padding: EdgeInsets.zero,
                                  physics: BouncingScrollPhysics(),
                                  gridDelegate:
                                      SliverGridDelegateWithFixedCrossAxisCount(
                                          mainAxisSpacing: 1,
                                          crossAxisSpacing: 0,
                                          crossAxisCount: 4,
                                          mainAxisExtent: 90),
                                  itemCount: dragonList.length,
                                  itemBuilder: (context, index) {
                                    var items = dragonList[index];

                                    return Column(children: [
                                      Container(
                                        height: height * 0.12,
                                        width: width * 0.2,
                                        decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(10),
                                            border: Border.all(
                                                color: Color(0xaa40A3CC),
                                                width: 2)),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Container(
                                              margin:
                                                  const EdgeInsets.symmetric(
                                                      horizontal: 10),
                                              child: Text(
                                                items['nat'],
                                                style: TextStyle(
                                                    color: Colors.white,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                            ),
                                            InkWell(
                                              onTap: () {
                                                setState(() {
                                                  sid = items['sid'];
                                                  oddsRates = items['rate'];
                                                });
                                                if (autoTime != "0") {
                                                  showMyDialogForBet(
                                                      context,
                                                      height * 0.45,
                                                      width * 0.33,
                                                      height * 0.4,
                                                      width * 0.7,
                                                      height * 0.64,
                                                      width * 0.55,
                                                      redCoinAnimation == true
                                                          ? stack1
                                                          : greenCoinAnimation ==
                                                                  true
                                                              ? stack2
                                                              : lightGreenCoinAnimation ==
                                                                      true
                                                                  ? stack3
                                                                  : blueCoinAnimation ==
                                                                          true
                                                                      ? stack4
                                                                      : brownCoinAnimation ==
                                                                              true
                                                                          ? stack5
                                                                          : lightBlueCoinAnimation == true
                                                                              ? stack6
                                                                              : 0);
                                                }
                                              },
                                              child: Container(
                                                alignment: Alignment.center,
                                                margin:
                                                    const EdgeInsets.symmetric(
                                                        horizontal: 3),
                                                height: height * 0.1,
                                                width: width * 0.05,
                                                decoration: BoxDecoration(
                                                    color: Color(0xaa0288A5),
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            5)),
                                                child: Text(
                                                  items['rate'],
                                                  style: TextStyle(
                                                      color: Colors.white,
                                                      fontWeight:
                                                          FontWeight.bold),
                                                ),
                                              ),
                                            )
                                          ],
                                        ),
                                      ),
                                      SizedBox(
                                        height: 20,
                                        width: 100,
                                        child: ListView.builder(
                                            physics:
                                                NeverScrollableScrollPhysics(),
                                            shrinkWrap: true,
                                            itemCount: liablityList.length,
                                            itemBuilder: (context, index) {
                                              var item = liablityList[index];

                                              return Text(
                                                item.liability.toString(),
                                                style: TextStyle(
                                                    color: item.liability >= 0
                                                        ? Colors.green
                                                        : Colors.red),
                                              );
                                            }),
                                      ),
                                    ]);
                                  }),
                            ),
                          ),
                        )
                      : tigerButton == true
                          ? SizedBox(
                              height: height * 0.5,
                              width: width * 0.9,
                              child: MediaQuery.removePadding(
                                context: context,
                                removeBottom: true,
                                removeTop: true,
                                child: SafeArea(
                                  top: false,
                                  bottom: false,
                                  child: GridView.builder(
                                      padding: EdgeInsets.zero,
                                      physics: BouncingScrollPhysics(),
                                      gridDelegate:
                                          SliverGridDelegateWithFixedCrossAxisCount(
                                              mainAxisSpacing: 1,
                                              crossAxisSpacing: 0,
                                              crossAxisCount: 4,
                                              mainAxisExtent: 90),
                                      itemCount: tigerList.length,
                                      itemBuilder: (context, index) {
                                        var items = tigerList[index];
                                        return Column(children: [
                                          Container(
                                            height: height * 0.12,
                                            width: width * 0.2,
                                            decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(10),
                                                border: Border.all(
                                                    color: Color(0xaa40A3CC),
                                                    width: 2)),
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Container(
                                                  margin: const EdgeInsets
                                                          .symmetric(
                                                      horizontal: 10),
                                                  child: Text(
                                                    items['nat'],
                                                    style: TextStyle(
                                                        color: Colors.white,
                                                        fontWeight:
                                                            FontWeight.bold),
                                                  ),
                                                ),
                                                InkWell(
                                                  onTap: () {
                                                    setState(() {
                                                      sid = items['sid'];
                                                      oddsRates = items['rate'];
                                                    });
                                                    if (autoTime != "0") {
                                                      showMyDialogForBet(
                                                          context,
                                                          height * 0.45,
                                                          width * 0.33,
                                                          height * 0.4,
                                                          width * 0.7,
                                                          height * 0.64,
                                                          width * 0.55,
                                                          redCoinAnimation ==
                                                                  true
                                                              ? stack1
                                                              : greenCoinAnimation ==
                                                                      true
                                                                  ? stack2
                                                                  : lightGreenCoinAnimation ==
                                                                          true
                                                                      ? stack3
                                                                      : blueCoinAnimation ==
                                                                              true
                                                                          ? stack4
                                                                          : brownCoinAnimation == true
                                                                              ? stack5
                                                                              : lightBlueCoinAnimation == true
                                                                                  ? stack6
                                                                                  : 0);
                                                    }
                                                  },
                                                  child: Container(
                                                    alignment: Alignment.center,
                                                    margin: const EdgeInsets
                                                            .symmetric(
                                                        horizontal: 3),
                                                    height: height * 0.1,
                                                    width: width * 0.05,
                                                    decoration: BoxDecoration(
                                                        color:
                                                            Color(0xaa0288A5),
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(5)),
                                                    child: Text(
                                                      items['rate'],
                                                      style: TextStyle(
                                                          color: Colors.white,
                                                          fontWeight:
                                                              FontWeight.bold),
                                                    ),
                                                  ),
                                                )
                                              ],
                                            ),
                                          ),
                                          SizedBox(
                                            height: 20,
                                            width: 100,
                                            child: ListView.builder(
                                                physics:
                                                    NeverScrollableScrollPhysics(),
                                                shrinkWrap: true,
                                                itemCount: liablityList.length,
                                                itemBuilder: (context, index) {
                                                  var item =
                                                      liablityList[index];

                                                  return Text(
                                                    item.liability.toString(),
                                                    style: TextStyle(
                                                        color:
                                                            item.liability >= 0
                                                                ? Colors.green
                                                                : Colors.red),
                                                  );
                                                }),
                                          ),
                                        ]);
                                      }),
                                ),
                              ),
                            )
                          : lionButton == true
                              ? SizedBox(
                                  height: height * 0.5,
                                  width: width * 0.9,
                                  child: MediaQuery.removePadding(
                                    context: context,
                                    removeBottom: true,
                                    removeTop: true,
                                    child: SafeArea(
                                      top: false,
                                      bottom: false,
                                      child: GridView.builder(
                                          padding: EdgeInsets.zero,
                                          physics: BouncingScrollPhysics(),
                                          gridDelegate:
                                              SliverGridDelegateWithFixedCrossAxisCount(
                                                  mainAxisSpacing: 1,
                                                  crossAxisSpacing: 0,
                                                  crossAxisCount: 4,
                                                  mainAxisExtent: 90),
                                          itemCount: lionList.length,
                                          itemBuilder: (context, index) {
                                            var items = lionList[index];
                                            return Column(children: [
                                              Container(
                                                height: height * 0.12,
                                                width: width * 0.2,
                                                decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            10),
                                                    border: Border.all(
                                                        color:
                                                            Color(0xaa40A3CC),
                                                        width: 2)),
                                                child: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: [
                                                    Container(
                                                      margin: const EdgeInsets
                                                              .symmetric(
                                                          horizontal: 10),
                                                      child: Text(
                                                        items['nat'],
                                                        style: TextStyle(
                                                            color: Colors.white,
                                                            fontWeight:
                                                                FontWeight
                                                                    .bold),
                                                      ),
                                                    ),
                                                    InkWell(
                                                      onTap: () {
                                                        setState(() {
                                                          sid = items['sid'];
                                                          oddsRates =
                                                              items['rate'];
                                                        });
                                                        if (autoTime != "0") {
                                                          showMyDialogForBet(
                                                              context,
                                                              height * 0.45,
                                                              width * 0.33,
                                                              height * 0.4,
                                                              width * 0.7,
                                                              height * 0.64,
                                                              width * 0.55,
                                                              redCoinAnimation ==
                                                                      true
                                                                  ? stack1
                                                                  : greenCoinAnimation ==
                                                                          true
                                                                      ? stack2
                                                                      : lightGreenCoinAnimation ==
                                                                              true
                                                                          ? stack3
                                                                          : blueCoinAnimation == true
                                                                              ? stack4
                                                                              : brownCoinAnimation == true
                                                                                  ? stack5
                                                                                  : lightBlueCoinAnimation == true
                                                                                      ? stack6
                                                                                      : 0);
                                                        }
                                                      },
                                                      child: Container(
                                                        alignment:
                                                            Alignment.center,
                                                        margin: const EdgeInsets
                                                                .symmetric(
                                                            horizontal: 3),
                                                        height: height * 0.1,
                                                        width: width * 0.05,
                                                        decoration: BoxDecoration(
                                                            color: Color(
                                                                0xaa0288A5),
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        5)),
                                                        child: Text(
                                                          items['rate'],
                                                          style: TextStyle(
                                                              color:
                                                                  Colors.white,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold),
                                                        ),
                                                      ),
                                                    )
                                                  ],
                                                ),
                                              ),
                                              SizedBox(
                                                height: 20,
                                                width: 100,
                                                child: ListView.builder(
                                                    physics:
                                                        NeverScrollableScrollPhysics(),
                                                    shrinkWrap: true,
                                                    itemCount:
                                                        liablityList.length,
                                                    itemBuilder:
                                                        (context, index) {
                                                      var item =
                                                          liablityList[index];

                                                      return Text(
                                                        item.liability
                                                            .toString(),
                                                        style: TextStyle(
                                                            color:
                                                                item.liability >= 0
                                                                    ? Colors
                                                                        .green
                                                                    : Colors
                                                                        .red),
                                                      );
                                                    }),
                                              ),
                                            ]);
                                          }),
                                    ),
                                  ),
                                )
                              : SizedBox(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

    Route _createRouteCurrentBetsList() {
    return PageRouteBuilder(
      pageBuilder: (context, animation, secondaryAnimation) => CurrentUserBet(
        matchId: widget.matchID,
        gameCode: widget.gameCode,
        playBackgroundMusic: playBackgroundMusic,
      ),
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
              setState(() {
                playBackgroundMusic == false ? '' : Vibration.vibrate();
                ;
              });
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
              setState(() {
                playBackgroundMusic == false ? '' : Vibration.vibrate();
                ;
              });
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
              setState(() {
                playBackgroundMusic == false ? '' : Vibration.vibrate();
                ;
              });
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
              setState(() {
                playBackgroundMusic == false ? '' : Vibration.vibrate();
                ;
              });
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
            onTap: () async {
              setState(() {
                playBackgroundMusic == false ? '' : Vibration.vibrate();
                ;
              });
            },
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
              setState(() {
                playBackgroundMusic == false ? '' : Vibration.vibrate();
                ;
              });
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
              setState(() {
                playBackgroundMusic == false ? '' : Vibration.vibrate();
                ;
              });
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

  Route _createRoute() {
    return PageRouteBuilder(
      pageBuilder: (context, animation, secondaryAnimation) => MyAccountPage(
        playBackgroundMusic: playBackgroundMusic,
      ),
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
      pageBuilder: (context, animation, secondaryAnimation) => ProfileScreen(
        playBackgroundMusic: playBackgroundMusic,
      ),
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
      pageBuilder: (context, animation, secondaryAnimation) => CurrentUserBet(
        gameCode: widget.gameCode,
        matchId: widget.matchID,
        playBackgroundMusic: playBackgroundMusic,
      ),
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
          ChangePasswordScreen(
        playBackgroundMusic: playBackgroundMusic,
      ),
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

  Widget buttonsWidgetDragonPortrait(ButtonsModelDTL items, index) {
    return Column(
      children: [
        dragonButton == true
            ? Container(
                height: height * 0.05,
                width: width * 0.4,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(color: Color(0xaa40A3CC), width: 2)),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      margin: const EdgeInsets.symmetric(horizontal: 10),
                      child: Text(
                        items.nat,
                        style: TextStyle(
                            color: Colors.white, fontWeight: FontWeight.bold),
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        setState(() {
                          sid = items.sid;
                          oddsRates = items.rate;
                        });
                        if (autoTime != "0") {
                          showMyDialogForBetPortrait(
                              context,
                              height * 0.23,
                              width,
                              height * 0.4,
                              width * 0.7,
                              height * 0.26,
                              width * 0.98,
                              redCoinAnimation == true
                                  ? stack1
                                  : greenCoinAnimation == true
                                      ? stack2
                                      : lightGreenCoinAnimation == true
                                          ? stack3
                                          : blueCoinAnimation == true
                                              ? stack4
                                              : brownCoinAnimation == true
                                                  ? stack5
                                                  : lightBlueCoinAnimation ==
                                                          true
                                                      ? stack6
                                                      : 0);
                        }
                      },
                      child: Container(
                        alignment: Alignment.center,
                        margin: const EdgeInsets.symmetric(horizontal: 3),
                        height: height * 0.08,
                        width: width * 0.1,
                        decoration: BoxDecoration(
                            color: Color(0xaa0288A5),
                            borderRadius: BorderRadius.circular(5)),
                        child: Text(
                          items.rate,
                          style: TextStyle(
                              color: Colors.white, fontWeight: FontWeight.bold),
                        ),
                      ),
                    )
                  ],
                ),
              )
            : tigerButton == true
                ? Container(
                    height: height * 0.05,
                    width: width * 0.4,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(color: Color(0xaa40A3CC), width: 2)),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          margin: const EdgeInsets.symmetric(horizontal: 10),
                          child: Text(
                            items.nat,
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                        InkWell(
                          onTap: () {
                            setState(() {
                              sid = items.sid;
                              oddsRates = items.rate;
                            });
                            if (autoTime != "0") {
                              showMyDialogForBetPortrait(
                                  context,
                                  height * 0.23,
                                  width,
                                  height * 0.4,
                                  width * 0.7,
                                  height * 0.26,
                                  width * 0.98,
                                  redCoinAnimation == true
                                      ? stack1
                                      : greenCoinAnimation == true
                                          ? stack2
                                          : lightGreenCoinAnimation == true
                                              ? stack3
                                              : blueCoinAnimation == true
                                                  ? stack4
                                                  : brownCoinAnimation == true
                                                      ? stack5
                                                      : lightBlueCoinAnimation ==
                                                              true
                                                          ? stack6
                                                          : 0);
                            }
                          },
                          child: Container(
                            alignment: Alignment.center,
                            margin: const EdgeInsets.symmetric(horizontal: 3),
                            height: height * 0.1,
                            width: width * 0.1,
                            decoration: BoxDecoration(
                                color: Color(0xaa0288A5),
                                borderRadius: BorderRadius.circular(5)),
                            child: Text(
                              items.rate,
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                        )
                      ],
                    ),
                  )
                : lionButton == true
                    ? Container(
                        height: height * 0.05,
                        width: width * 0.4,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            border:
                                Border.all(color: Color(0xaa40A3CC), width: 2)),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                              margin:
                                  const EdgeInsets.symmetric(horizontal: 10),
                              child: Text(
                                items.nat,
                                style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                            InkWell(
                              onTap: () {
                                setState(() {
                                  sid = items.sid;
                                  oddsRates = items.rate;
                                });
                                if (autoTime != "0") {
                                  showMyDialogForBetPortrait(
                                      context,
                                      height * 0.23,
                                      width,
                                      height * 0.4,
                                      width * 0.7,
                                      height * 0.26,
                                      width * 0.98,
                                      redCoinAnimation == true
                                          ? stack1
                                          : greenCoinAnimation == true
                                              ? stack2
                                              : lightGreenCoinAnimation == true
                                                  ? stack3
                                                  : blueCoinAnimation == true
                                                      ? stack4
                                                      : brownCoinAnimation ==
                                                              true
                                                          ? stack5
                                                          : lightBlueCoinAnimation ==
                                                                  true
                                                              ? stack6
                                                              : 0);
                                }
                              },
                              child: Container(
                                alignment: Alignment.center,
                                margin:
                                    const EdgeInsets.symmetric(horizontal: 3),
                                height: height * 0.1,
                                width: width * 0.1,
                                decoration: BoxDecoration(
                                    color: Color(0xaa0288A5),
                                    borderRadius: BorderRadius.circular(5)),
                                child: Text(
                                  items.rate,
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                            )
                          ],
                        ),
                      )
                    : SizedBox(),
        SizedBox(
          height: 5,
        ),
      ],
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
    return startTimes <= 3 && autoTime != '0'
        ? Positioned(
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
                )))
        : SizedBox();
  }

  Widget gameStopBetting(String time) {
    return startTimes <= 3 && autoTime != '0'
        ? Positioned(
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
                )))
        : SizedBox();
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
          // margin: EdgeInsets.only(left: width * 2),
          alignment: Alignment.center,
          height: height * 0.50,
          width: width * 0.5,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              image: DecorationImage(
                  image: AssetImage(
                    "assets/dragonTigerLion/tableImges/result-backgroud.png",
                  ),
                  fit: BoxFit.cover)),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                "RESULT",
                style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 20),
              ),
              SizedBox(
                height: 10,
              ),
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 50),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    winnerResult != ""
                        ? buildImageLand(cardNameImage1)
                        : Image.asset(
                            'assets/lucky7/images/cardBg.png',
                            height: height * 0.19,
                            width: width * 0.06,
                            fit: BoxFit.fill,
                          ),
                    winnerResult != ""
                        ? buildImageLand(cardNameImage2)
                        : Image.asset(
                            'assets/lucky7/images/cardBg.png',
                            height: height * 0.19,
                            width: width * 0.06,
                            fit: BoxFit.fill,
                          ),
                    winnerResult != ""
                        ? buildImageLand(cardNameImage3)
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
                      color: Color(0xaa45B8E8),
                    )),
                child: Text(
                  "DRAGON    |       TIGER       |       LION",
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
                    "assets/dragonTigerLion/tableImges/small-result-p.png",
                  ),
                  fit: BoxFit.cover)),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    winnerResult != ""
                        ? buildImagePortrait(cardNameImage1)
                        : Image.asset(
                            'assets/lucky7/images/cardBg.png',
                            height: height * 0.19,
                            width: width * 0.06,
                            fit: BoxFit.fill,
                          ),
                    winnerResult != ""
                        ? buildImagePortrait(cardNameImage2)
                        : Image.asset(
                            'assets/lucky7/images/cardBg.png',
                            height: height * 0.19,
                            width: width * 0.06,
                            fit: BoxFit.fill,
                          ),
                    winnerResult != ""
                        ? buildImagePortrait(cardNameImage3)
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
                      color: Color(0xaa45B8E8),
                    )),
                child: Text(
                  "DRAGON    |       TIGER       |       LION",
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

  Future getResult() async {
    var url = Apis.dragonTigerLionResult;
    var response = await GlobalFunction.apiGetRequestae(url);
    var result = jsonDecode(response);

    var list = result as List;

    setState(() {
      cardResultList.clear();
      cardResultList =
          list.map((e) => DragonTigerLionResult.fromJson(e)).toList();
      winnerResult = result[0]['winner'].toString();

      // cardResultList.addAll(listdata);
    });
  }

  List lionList = [
    {
      "mid": "3.928696",
      "nat": "Winner L",
      "rate": "2.94",
      "min": "100",
      "max": "25000",
      "gstatus": "0",
      "sid": "41"
    },
    {
      "mid": "3.928696",
      "nat": "Black L",
      "rate": "1.97",
      "min": "100",
      "max": "25000",
      "gstatus": "0",
      "sid": "42"
    },
    {
      "mid": "3.928696",
      "nat": "Red L",
      "rate": "1.97",
      "min": "100",
      "max": "25000",
      "gstatus": "0",
      "sid": "43"
    },
    {
      "mid": "3.928696",
      "nat": "Odd L",
      "rate": "1.83",
      "min": "100",
      "max": "25000",
      "gstatus": "0",
      "sid": "44"
    },
    {
      "mid": "3.928696",
      "nat": "Even L",
      "rate": "2.12",
      "min": "100",
      "max": "25000",
      "gstatus": "0",
      "sid": "45"
    },
    {
      "mid": "3.928696",
      "nat": "Lion A",
      "rate": "12.00",
      "min": "100",
      "max": "25000",
      "gstatus": "0",
      "sid": "46"
    },
    {
      "mid": "3.928696",
      "nat": "Lion 2",
      "rate": "12.00",
      "min": "100",
      "max": "25000",
      "gstatus": "0",
      "sid": "47"
    },
    {
      "mid": "3.928696",
      "nat": "Lion 3",
      "rate": "12.00",
      "min": "100",
      "max": "25000",
      "gstatus": "0",
      "sid": "48"
    },
    {
      "mid": "3.928696",
      "nat": "Lion 4",
      "rate": "12.00",
      "min": "100",
      "max": "25000",
      "gstatus": "0",
      "sid": "49"
    },
    {
      "mid": "3.928696",
      "nat": "Lion 5",
      "rate": "12.00",
      "min": "100",
      "max": "25000",
      "gstatus": "0",
      "sid": "50"
    },
    {
      "mid": "3.928696",
      "nat": "Lion 6",
      "rate": "12.00",
      "min": "100",
      "max": "25000",
      "gstatus": "0",
      "sid": "51"
    },
    {
      "mid": "3.928696",
      "nat": "Lion 7",
      "rate": "12.00",
      "min": "100",
      "max": "25000",
      "gstatus": "0",
      "sid": "52"
    },
    {
      "mid": "3.928696",
      "nat": "Lion 8",
      "rate": "12.00",
      "min": "100",
      "max": "25000",
      "gstatus": "0",
      "sid": "53"
    },
    {
      "mid": "3.928696",
      "nat": "Lion 9",
      "rate": "12.00",
      "min": "100",
      "max": "25000",
      "gstatus": "0",
      "sid": "54"
    },
    {
      "mid": "3.928696",
      "nat": "Lion 10",
      "rate": "12.00",
      "min": "100",
      "max": "25000",
      "gstatus": "0",
      "sid": "55"
    },
    {
      "mid": "3.928696",
      "nat": "Lion J",
      "rate": "12.00",
      "min": "100",
      "max": "25000",
      "gstatus": "0",
      "sid": "56"
    },
    {
      "mid": "3.928696",
      "nat": "Lion Q",
      "rate": "12.00",
      "min": "100",
      "max": "25000",
      "gstatus": "0",
      "sid": "57"
    },
    {
      "mid": "3.928696",
      "nat": "Lion K",
      "rate": "12.00",
      "min": "100",
      "max": "25000",
      "gstatus": "0",
      "sid": "58"
    }
  ];
  List tigerList = [
    {
      "mid": "3.928696",
      "nat": "Winner T",
      "rate": "2.94",
      "min": "100",
      "max": "25000",
      "gstatus": "0",
      "sid": "21"
    },
    {
      "mid": "3.928696",
      "nat": "Black T",
      "rate": "1.97",
      "min": "100",
      "max": "25000",
      "gstatus": "0",
      "sid": "22"
    },
    {
      "mid": "3.928696",
      "nat": "Red T",
      "rate": "1.97",
      "min": "100",
      "max": "25000",
      "gstatus": "0",
      "sid": "23"
    },
    {
      "mid": "3.928696",
      "nat": "Odd T",
      "rate": "1.83",
      "min": "100",
      "max": "25000",
      "gstatus": "0",
      "sid": "24"
    },
    {
      "mid": "3.928696",
      "nat": "Even T",
      "rate": "2.12",
      "min": "100",
      "max": "25000",
      "gstatus": "0",
      "sid": "25"
    },
    {
      "mid": "3.928696",
      "nat": "Tiger A",
      "rate": "12.00",
      "min": "100",
      "max": "25000",
      "gstatus": "0",
      "sid": "26"
    },
    {
      "mid": "3.928696",
      "nat": "Tiger 2",
      "rate": "12.00",
      "min": "100",
      "max": "25000",
      "gstatus": "0",
      "sid": "27"
    },
    {
      "mid": "3.928696",
      "nat": "Tiger 3",
      "rate": "12.00",
      "min": "100",
      "max": "25000",
      "gstatus": "0",
      "sid": "28"
    },
    {
      "mid": "3.928696",
      "nat": "Tiger 4",
      "rate": "12.00",
      "min": "100",
      "max": "25000",
      "gstatus": "0",
      "sid": "29"
    },
    {
      "mid": "3.928696",
      "nat": "Tiger 5",
      "rate": "12.00",
      "min": "100",
      "max": "25000",
      "gstatus": "0",
      "sid": "30"
    },
    {
      "mid": "3.928696",
      "nat": "Tiger 6",
      "rate": "12.00",
      "min": "100",
      "max": "25000",
      "gstatus": "0",
      "sid": "31"
    },
    {
      "mid": "3.928696",
      "nat": "Tiger 7",
      "rate": "12.00",
      "min": "100",
      "max": "25000",
      "gstatus": "0",
      "sid": "32"
    },
    {
      "mid": "3.928696",
      "nat": "Tiger 8",
      "rate": "12.00",
      "min": "100",
      "max": "25000",
      "gstatus": "0",
      "sid": "33"
    },
    {
      "mid": "3.928696",
      "nat": "Tiger 9",
      "rate": "12.00",
      "min": "100",
      "max": "25000",
      "gstatus": "0",
      "sid": "34"
    },
    {
      "mid": "3.928696",
      "nat": "Tiger 10",
      "rate": "12.00",
      "min": "100",
      "max": "25000",
      "gstatus": "0",
      "sid": "35"
    },
    {
      "mid": "3.928696",
      "nat": "Tiger J",
      "rate": "12.00",
      "min": "100",
      "max": "25000",
      "gstatus": "0",
      "sid": "36"
    },
    {
      "mid": "3.928696",
      "nat": "Tiger Q",
      "rate": "12.00",
      "min": "100",
      "max": "25000",
      "gstatus": "0",
      "sid": "37"
    },
    {
      "mid": "3.928696",
      "nat": "Tiger K",
      "rate": "12.00",
      "min": "100",
      "max": "25000",
      "gstatus": "0",
      "sid": "38"
    },
  ];
  List dragonList = [
    {
      "mid": "3.928696",
      "nat": "Winner D",
      "rate": "2.94",
      "min": "100",
      "max": "25000",
      "gstatus": "0",
      "sid": "1"
    },
    {
      "mid": "3.928696",
      "nat": "Black D",
      "rate": "1.97",
      "min": "100",
      "max": "25000",
      "gstatus": "0",
      "sid": "2"
    },
    {
      "mid": "3.928696",
      "nat": "Red D",
      "rate": "1.97",
      "min": "100",
      "max": "25000",
      "gstatus": "0",
      "sid": "3"
    },
    {
      "mid": "3.928696",
      "nat": "Odd D",
      "rate": "1.83",
      "min": "100",
      "max": "25000",
      "gstatus": "0",
      "sid": "4"
    },
    {
      "mid": "3.928696",
      "nat": "Even D",
      "rate": "2.12",
      "min": "100",
      "max": "25000",
      "gstatus": "0",
      "sid": "5"
    },
    {
      "mid": "3.928696",
      "nat": "Dragon A",
      "rate": "12.00",
      "min": "100",
      "max": "25000",
      "gstatus": "0",
      "sid": "6"
    },
    {
      "mid": "3.928696",
      "nat": "Dragon 2",
      "rate": "12.00",
      "min": "100",
      "max": "25000",
      "gstatus": "0",
      "sid": "7"
    },
    {
      "mid": "3.928696",
      "nat": "Dragon 3",
      "rate": "12.00",
      "min": "100",
      "max": "25000",
      "gstatus": "0",
      "sid": "8"
    },
    {
      "mid": "3.928696",
      "nat": "Dragon 4",
      "rate": "12.00",
      "min": "100",
      "max": "25000",
      "gstatus": "0",
      "sid": "9"
    },
    {
      "mid": "3.928696",
      "nat": "Dragon 5",
      "rate": "12.00",
      "min": "100",
      "max": "25000",
      "gstatus": "0",
      "sid": "10"
    },
    {
      "mid": "3.928696",
      "nat": "Dragon 6",
      "rate": "12.00",
      "min": "100",
      "max": "25000",
      "gstatus": "0",
      "sid": "11"
    },
    {
      "mid": "3.928696",
      "nat": "Dragon 7",
      "rate": "12.00",
      "min": "100",
      "max": "25000",
      "gstatus": "0",
      "sid": "12"
    },
    {
      "mid": "3.928696",
      "nat": "Dragon 8",
      "rate": "12.00",
      "min": "100",
      "max": "25000",
      "gstatus": "0",
      "sid": "13"
    },
    {
      "mid": "3.928696",
      "nat": "Dragon 9",
      "rate": "12.00",
      "min": "100",
      "max": "25000",
      "gstatus": "0",
      "sid": "14"
    },
    {
      "mid": "3.928696",
      "nat": "Dragon 10",
      "rate": "12.00",
      "min": "100",
      "max": "25000",
      "gstatus": "0",
      "sid": "15"
    },
    {
      "mid": "3.928696",
      "nat": "Dragon J",
      "rate": "12.00",
      "min": "100",
      "max": "25000",
      "gstatus": "0",
      "sid": "16"
    },
    {
      "mid": "3.928696",
      "nat": "Dragon Q",
      "rate": "12.00",
      "min": "100",
      "max": "25000",
      "gstatus": "0",
      "sid": "17"
    },
    {
      "mid": "3.928696",
      "nat": "Dragon K",
      "rate": "12.00",
      "min": "100",
      "max": "25000",
      "gstatus": "0",
      "sid": "18"
    },
  ];
  // void getAllList() {
  //   for (int i = 0; i < buttonsList.length; i++) {
  //     if (buttonsList.contains((e) => e['nat'].toString() == "Lion")) {
  //       lion.add(buttonsList[i]);
  //     } else if (buttonsList.contains((e) => e['nat'].toString() == " L")) {
  //       lion.add(buttonsList[i]);
  //     }
  //   }
  //   for (int i = 0; i < buttonsList.length; i++) {
  //     if (buttonsList.contains((e) => e['nat'].toString() == "Tiger")) {
  //       tiger.add(buttonsList[i]);
  //     } else if (buttonsList.contains((e) => e['nat'].toString() == " T")) {
  //       tiger.add(buttonsList[i]);
  //     }
  //   }
  //   for (int i = 0; i < buttonsList.length; i++) {
  //     if (buttonsList.contains((e) => e['nat'].toString() == "Dragon")) {
  //       dragon.add(buttonsList[i]);
  //     } else if (buttonsList.contains((e) => e['nat'].toString() == " D")) {
  //       dragon.add(buttonsList[i]);
  //     }
  //   }

  //   print("Lion ${lion.length}");
  //   print("Tiger ${tiger.length}");
  //   print("Dragon ${dragon.length}");
  // }

  Future getCardData() async {
    var url = Apis.dragonTigerLionCardAPi;
    var response = await GlobalFunction.apiGetRequestae(url);
    var result = jsonDecode(response);

    if (result['status'] == true) {
      setState(() {
        autoTime = result['data']['t1'][0]['autotime'].toString();
        if (startTimes != int.parse(autoTime.toString())) {
          startTimeSmall = startTimes * 100;
        }
        marketId = result['data']['t1'][0]['mid'].toString();
        cardNameImage1 = result['data']['t1'][0]['C1'].toString();
        cardNameImage2 = result['data']['t1'][0]['C2'].toString();
        cardNameImage3 = result['data']['t1'][0]['C3'].toString();
        startTimes = int.parse(autoTime.toString());
      });
      autoTime == "0"
          ? setState(() {
              redCoinAnimation = false;
              lightGreenCoinAnimation = false;
              blueCoinAnimation = false;
              greenCoinAnimation = false;
              lightBlueCoinAnimation = false;
              brownCoinAnimation = false;
            })
          : SizedBox();
    }
  }

  // Route _createRouteCurrentBets() {
  //   return PageRouteBuilder(
  //     pageBuilder: (context, animation, secondaryAnimation) =>
  //         CurrentUserBet(matchId: widget.matchID, gameCode: widget.gameCode),
  //     transitionsBuilder: (context, animation, secondaryAnimation, child) {
  //       const begin = Offset(0.0, 1.0);
  //       const end = Offset.zero;
  //       const curve = Curves.ease;

  //       var tween =
  //           Tween(begin: begin, end: end).chain(CurveTween(curve: curve));

  //       return SlideTransition(
  //         position: animation.drive(tween),
  //         child: child,
  //       );
  //     },
  //   );
  // }

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
    var url = Apis.matchId;
    var body = {"matchId": widget.matchID};
    var response = await GlobalFunction.apiPostRequestToken(url, body);
    var result = jsonDecode(response);
    if (result['status'] == true) {
      var list = result['data']['VDragon Tiger Lion'] as List;
      matchIdList.clear();
      var listdata = list.map((e) => MatchIdModel.fromJson(e)).toList();
      matchIdList.addAll(listdata);
    }
  }

  showMyDialogForBet(
      BuildContext context,
      double heightImage,
      double widthImage,
      double height,
      double width,
      double heightClick,
      double widthClick,
      int stake) {
    showDialog(
        context: context,
        builder: (_) {
          return AlertDialog(
            backgroundColor: Colors.transparent,
            content: SingleChildScrollView(
              child: SizedBox(
                height: heightImage,
                width: widthImage,
                child: Stack(
                  children: [
                    Container(
                      height: heightImage,
                      width: widthImage,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          image: DecorationImage(
                              image: AssetImage(
                                  "assets/User-interface/place-bet-bg.png"),
                              fit: BoxFit.fitHeight)),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          children: [
                            CustomText(
                              text: "Amount",
                              color: Colors.white,
                              fontSize: 16,
                              fontWeight: FontWeight.w700,
                            ),
                            SizedBox(
                              height: height * 0.09,
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
                                    scale: 2.3,
                                  ),
                                ),
                                SizedBox(
                                  height: height * 0.26,
                                  width: width * 0.22,
                                  child: Center(
                                    child: TextField(
                                        textAlignVertical: TextAlignVertical.center,
                                      textAlign: TextAlign.center,
                                      controller: stakeController,
                                      onChanged: (String value) async {
                                        manualAmount = true;
                                      },
                                      maxLength: 5,
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.w600,
                                        fontSize: 10,
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
                                                BorderRadius.circular(2),
                                            borderSide: BorderSide(
                                              color: Color(0xff4E4E4E),
                                              width: 3,
                                            )),
                                        filled: true,
                                        // contentPadding:  EdgeInsets.only(top: height*0.1),
                                        fillColor: Colors.black,
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
                                    scale: 2.3,
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: height * 0.08,
                            ),
                            Text(
                              "Are you sure you want to continue?",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 11,
                                  fontWeight: FontWeight.bold),
                            ),
                            SizedBox(
                              height: height * 0.07,
                            ),
                            manualAmount == true &&
                                    int.parse(stakeController.text) > 99 &&
                                    int.parse(stakeController.text) < 25000
                                ? InkWell(
                                    onTap: () {
                                      setState(() {
                                        playBackgroundMusic == false
                                            ? onPressedMusicForBet()
                                            : Vibration.vibrate();
                                      });

                                      makeBet();
                                      Navigator.pop(context);

                                      setState(() {
                                        confirmButton = true;
                                      });
                                    },
                                    child: Container(
                                        height: height * 0.22,
                                        width: width * 0.23,
                                        decoration: BoxDecoration(
                                            image: DecorationImage(
                                                image: AssetImage(
                                                    "assets/lucky7/images/button/comfirm.png")))),
                                  )
                                : manualAmount == false
                                    ? InkWell(
                                        onTap: () {
                                          setState(() {
                                            playBackgroundMusic == false
                                                ? onPressedMusicForBet()
                                                : Vibration.vibrate();
                                          });

                                          makeBet();
                                          Navigator.pop(context);

                                          setState(() {
                                            confirmButton = true;
                                          });
                                        },
                                        child: Container(
                                            height: height * 0.22,
                                            width: width * 0.23,
                                            decoration: BoxDecoration(
                                                image: DecorationImage(
                                                    image: AssetImage(
                                                        "assets/lucky7/images/button/comfirm.png")))),
                                      )
                                    : GestureDetector(
                                        onTap: () {
                                          Navigator.pop(context);
                                          setState(() {
                                            playBackgroundMusic == false
                                                ? ''
                                                : Vibration.vibrate();
                                            ;
                                          });
                                          DialogUtils.showOneBtn(
                                            context,
                                            "Please Select Existing amount",playBackgroundMusic
                                          );
                                        },
                                        child: Container(
                                          alignment: Alignment.center,
                                          height: height * 0.22,
                                          width: width * 0.23,
                                          decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                              image: DecorationImage(
                                                image: AssetImage(
                                                    "assets/lucky7/images/button/comfirm.png"),
                                              )),
                                        ),
                                      ),
                          ],
                        ),
                      ),
                    ),
                    Positioned(
                      right: width * 0.01,
                      top: 2,
                      child: InkWell(
                        onTap: () {
                          playBackgroundMusic == false
                              ? onPressedMusic()
                              : Vibration.vibrate();

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
            ),
          );
        });
  }

  showMyDialogForBetPortrait(
      BuildContext context,
      double heightImage,
      double widthImage,
      double height,
      double width,
      double heightClick,
      double widthClick,
      int stake) {
    showDialog(
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
                      height: heightImage,
                      width: widthImage,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          image: DecorationImage(
                              image: AssetImage(
                                  "assets/User-interface/place-bet-bg.png"),
                              fit: BoxFit.fitHeight)),
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
                                height: height * 0.07,
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Container(
                                    margin: const EdgeInsets.only(right: 5),
                                    // alignment: Alignment.center,
                                    child: Image.asset(
                                      "assets/User-interface/minus-image.png",
                                      scale: 2.3,
                                    ),
                                  ),
                                  SizedBox(
                                    height: height * 0.125,
                                    width: width * 0.45,
                                    child: Center(
                                      child: TextField(
                                          textAlignVertical: TextAlignVertical.center,
                                        textAlign: TextAlign.center,
                                        controller: stakeController,
                                        onChanged: (String value) async {
                                          manualAmount = true;
                                        },
                                        maxLength: 5,
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.w600,
                                          fontSize: 10,
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
                                      scale: 2.3,
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: height * 0.04,
                              ),
                              Text(
                                "Are you sure you want to continue?",
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 08,
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
                                        setState(() {
                                          playBackgroundMusic == false
                                              ? onPressedMusicForBet()
                                              : Vibration.vibrate();
                                        });

                                        makeBetPortrait();
                                        Navigator.pop(context);

                                        setState(() {
                                          confirmButton = true;
                                        });
                                      },
                                      child: Container(
                                        alignment: Alignment.center,
                                        height:
                                            MediaQuery.of(context).size.height *
                                                0.04,
                                        width:
                                            MediaQuery.of(context).size.width *
                                                0.4,
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
                                            playBackgroundMusic == false
                                                ? onPressedMusicForBet()
                                                : Vibration.vibrate();

                                            makeBetPortrait();
                                            Navigator.pop(context);
                                          },
                                          child: Container(
                                            alignment: Alignment.center,
                                            height: MediaQuery.of(context)
                                                    .size
                                                    .height *
                                                0.04,
                                            width: MediaQuery.of(context)
                                                    .size
                                                    .width *
                                                0.4,
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
                                                  ? ""
                                                  : Vibration.vibrate();
                                            });
                                            DialogUtils.showOneBtn(
                                              context,
                                              "Please Select Existing amount",playBackgroundMusic
                                            );
                                          },
                                          child: Container(
                                            alignment: Alignment.center,
                                            height: MediaQuery.of(context)
                                                    .size
                                                    .height *
                                                0.04,
                                            width: MediaQuery.of(context)
                                                    .size
                                                    .width *
                                                0.4,
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
                          playBackgroundMusic == false
                              ? onPressedMusic()
                              : Vibration.vibrate();
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

  Future makeBet() async {
    getUserDetails();
    DateTime currentTime = DateTime.now();
    var url = "http://13.250.53.81/VirtualCasinoBetPlacer/vc/place-bet";
    var body = {
      "casinoName": 1,
      "isBack": true,
      "odds": oddsRates,
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
      "selectionId": sid,
      "placeTime": currentTime.toString(),
      "marketId": marketId.toString(),
      "matchId": 31,
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
      DialogUtils.showOneBtn(
        context,
        result['message'],playBackgroundMusic
      );
      setState(() {
        manualAmount = false;
        stakeController.clear();
      });
    } else {
      stakeController.clear();

      DialogUtils.showOneBtn(
        context,
        result['message'],playBackgroundMusic
      );
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
      "isBack": true,
      "odds": oddsRates,
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
      "selectionId": sid,
      "placeTime": currentTime.toString(),
      "marketId": marketId.toString(),
      "matchId": 31,
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
      print("response--->$result");
      DialogUtils.showOneBtnPortrait(
        context,
        result['message'],playBackgroundMusic
      );

      setState(() {
        manualAmount = false;
        stakeController.clear();
      });
      // getVcLiablity();
    } else {
      manualAmount = false;
      stakeController.clear();

      DialogUtils.showOneBtnPortrait(
        context,
        result['message'],playBackgroundMusic
      );
    }

    stakeController.clear();
    manualAmount = false;
  }

  String myliablity = "";
  Future getVcLiablity() async {
    var url = Apis.vcLiablityApi;
    var body = {
      "roundId": marketId.toString(),
    };
    var response =
        await GlobalFunction.apiPostRequestTokenForUsers(url, body, context);
    var result = jsonDecode(response);
    print("res--->$response");

    if (result['status'] == true) {
      var list = result['data'] as List;
      setState(() {
        liablityList.clear();
        liablityList = list.map((e) => LiablityModel.fromJson(e)).toList();
        print("lib list---->${liablityList.length}");
      });
    }
  }
}
