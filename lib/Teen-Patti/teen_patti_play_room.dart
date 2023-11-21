// ignore_for_file: use_build_context_synchronously

import 'dart:async';
import 'dart:convert';
import 'dart:math';
import 'package:blinking_text/blinking_text.dart';
import 'package:dart_ipify/dart_ipify.dart';
import 'package:flip_card/flip_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:just_audio/just_audio.dart';
import 'package:lottie/lottie.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:vibration/vibration.dart';
import 'package:virtual_casino/User-Interface/current_user_bet.dart';
import 'package:virtual_casino/Utils/api_helper.dart';
import 'package:virtual_casino/Utils/apis.dart';
import 'package:virtual_casino/Utils/toast.dart';
import 'package:virtual_casino/data/model/bet_list_model.dart';
import 'package:virtual_casino/data/model/result_model.dart';
import '../User-Interface/change_passswod_screen.dart';
import '../User-Interface/my_account.dart';
import '../User-Interface/profile_screen.dart';
import '../User-Interface/signin_screen.dart';
import '../Widgets/customText.dart';
import '../data/model/match_id_model.dart';
import 'Animation/coin_animation_left.dart';
import 'Animation/coin_animation_right.dart';
import 'Animation/portrait_random_animation.dart';

import 'package:http/http.dart' as http;

class TeenPattiPlayRoom extends StatefulWidget {
  final String matchID;
  final String gameCode;
  const TeenPattiPlayRoom(
      {super.key, required this.matchID, required this.gameCode});

  @override
  State<TeenPattiPlayRoom> createState() => _TeenPattiPlayRoomState();
}

class _TeenPattiPlayRoomState extends State<TeenPattiPlayRoom>
    with TickerProviderStateMixin, WidgetsBindingObserver {
  final GlobalKey<ScaffoldState> _globalKey = GlobalKey<ScaffoldState>();

  var stakeController = TextEditingController();
  bool manualAmount = false;
  bool showPopUp = false;
  double height = 0;
  double width = 0;
  String autoTime = "";
  String cardImage1 = "";
  String cardImage2 = "";
  String cardImage3 = "";
  String cardImage4 = "";
  String cardImage5 = "";
  String cardImage6 = "";
  bool confirmButton = false;
  List<ResultsModel> resultList = [];
  String userBalance = "";
  String liablity = "";
  bool menubar = false;
  final _player = AudioPlayer();
  late AnimationController _controller;
  final _cardPlayer = AudioPlayer();
  final stopBettingmusic = AudioPlayer();
  final startBettingmusic = AudioPlayer();
  final winnerBettingmusic = AudioPlayer();
  final onPressedmusic = AudioPlayer();
  List<BetListModel> betListResult = [];

  late AnimationController animationController;

  bool playBackgroundMusic = false;
  int stack1 = 0;
  int stack2 = 0;
  int stack3 = 0;
  int stack4 = 0;
  int stack5 = 0;
  int stack6 = 0;
  bool shakeWidget = false;

  bool selectPlayerA = false;
  bool selectPlayerB = false;
  bool teamBbutton = false;
  late Timer _clockTimer;
  var coin = 0;

  final List<Widget> _coinsRytPort = [];

  String cardNameImage6 = "";

  final Random _random = Random();

  bool redCoinAnimation = false;
  bool lightGreenCoinAnimation = false;
  bool greenCoinAnimation = false;
  bool lightBlueCoinAnimation = false;
  bool brownCoinAnimation = false;
  final List _redcoinImages = [
    'assets/Teen-patti/images/coins-image/Group 115.png',
  ];

  final List _lightGreencoinImages = [
    'assets/Teen-patti/images/coins-image/Group 654.png',
  ];
  final List _bluecoinImages = [
    'assets/Teen-patti/images/coins-image/Group 656.png',
  ];
  final List _greencoinImages = [
    'assets/Teen-patti/images/coins-image/Group 657 (1).png',
  ];
  final List _skybluecoinImages = [
    'assets/Teen-patti/images/coins-image/Group 677.png',
  ];
  final List _browncoinImages = [
    'assets/Teen-patti/images/coins-image/Group 678.png',
  ];

  final int _totalCoins = 7000;
  int _currentCoinIndex = 0;

  String playerASid = "";
  String playerBSid = "";
  String playerARate = "";
  String playerBRate = "";
  String playerA = "";
  String playerB = "";
  String iPAddress = "";
  String marketId = "";
  double liablity1 = 0;
  double liablity2 = 0;

  var gameSound = "assets/Teen-patti/audio/teen-patti-bgm.mp3";

  final List<Widget> _coins = [];
  final List<Widget> _coinsRyt = [];
  final List<Widget> _coinsPort = [];
  final double _minX = 260;
  final double _maxX = 630;
  final double _minY = 60;
  final double _maxY = 220;
  String playerStake = "";
  int startTimes = 0;

      int startTimeSmall=0;
  

  late Animation<double> _animation;

  @override
  void initState() {

      startTimeSmall=startTimes*100;
       Timer.periodic(const Duration(milliseconds: 10), (timer) {
        startTimeSmall =startTimeSmall-1;
       });

    showPopUp = true;
    getCardDetailsForBar();
    _controller = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 2000), // Adjust the duration as needed
    );
    _animation = CurvedAnimation(parent: _controller, curve: Curves.easeInOut);
    _controller.repeat(reverse: true);
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
    getDeviceIp();
    getStakeDetails();
    AudioPlayer.clearAssetCache();
    WidgetsBinding.instance.addObserver(this);
    bgMusic();
    winnerMusic();
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.landscapeLeft,
      DeviceOrientation.landscapeRight,
    ]);

    _clockTimer = Timer.periodic(Duration(seconds: 1), (timer) {});
    super.initState();
  }


  
  void _startCoinAnimation() {
    if (_currentCoinIndex >= _totalCoins) {
      return;
    }

    double _startX = _minX;
    double _startY = _minY;
    double _endX = _random.nextDouble() * (_maxX - _minX) + _minX;
    double _endY = _random.nextDouble() * (_maxY - _minY) + _minY;

    setState(() {
      autoTime != "0"
          ? _coins.add(TweenAnimationBuilder(
              tween: Tween<double>(begin: 0, end: 1),
              duration: const Duration(milliseconds: 600),
              builder: (BuildContext context, double value, Widget? child) {
                double currentX = _startX + (_endX - _startX) * value;
                double currentY = _startY + (_endY - _startY) * value;

                return Positioned(
                    right: currentX.clamp(_minX, _maxX),
                    bottom: currentY.clamp(_minY, _maxY),
                    child: autoTime != "0"
                        ? redCoinAnimation == true
                            ? Image.asset(
                                _redcoinImages[
                                    _currentCoinIndex % _redcoinImages.length],
                                height: 20,
                                width: 20,
                              )
                            : lightGreenCoinAnimation == true
                                ? Image.asset(
                                    _lightGreencoinImages[_currentCoinIndex %
                                        _lightGreencoinImages.length],
                                    height: 20,
                                    width: 20,
                                  )
                                : lightBlueCoinAnimation == true
                                    ? Image.asset(
                                        _bluecoinImages[_currentCoinIndex %
                                            _bluecoinImages.length],
                                        height: 20,
                                        width: 20,
                                      )
                                    : greenCoinAnimation == true
                                        ? Image.asset(
                                            _greencoinImages[_currentCoinIndex %
                                                _greencoinImages.length],
                                            height: 20,
                                            width: 20,
                                          )
                                        : brownCoinAnimation == true
                                            ? Image.asset(
                                                _skybluecoinImages[
                                                    _currentCoinIndex %
                                                        _skybluecoinImages
                                                            .length],
                                                height: 20,
                                                width: 20,
                                              )
                                            : SizedBox()
                        : SizedBox());
              },
            ))
          : _coins.clear();
    });

    autoTime != "0" && playBackgroundMusic == false
        ? onPressedMusicForBet()
        : null;
  }

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

  Future<void> winnerMusic() async {
    winnerBettingmusic.playbackEventStream.listen((event) {},
        onError: (Object e, StackTrace stackTrace) {
      print('A stream error occurred: $e');
    });
    try {
      await winnerBettingmusic.setAudioSource(AudioSource.asset(
        "assets/Teen-patti/audio/winsong.mp3",
      ));
    } catch (e) {
      print("Error loading audio source: $e");
    }
    cardImage6 != "" ? winnerBettingmusic.play() : winnerBettingmusic.stop();
    winnerBettingmusic.setVolume(1);
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
    setState(() {
      playBackgroundMusic == false ? null : onPressedmusic.play();
    });
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
    onPressedmusic.play();
  }

  List cardResultList = [];
  @override
  void dispose() {
    _controller.dispose();
    _clockTimer.cancel();
    _player.dispose();
    WidgetsBinding.instance.removeObserver(this);
    startBettingmusic.dispose();
    stopBettingmusic.dispose();
    _cardPlayer.dispose();
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.paused) {
      playBackgroundMusic = true;
      _player.pause();
    } else if (state == AppLifecycleState.resumed) {
      // _player.play();
    }
  }

  @override
  Widget build(BuildContext context) {
    getCardDetails();
    getReultsData();
    getUserDetails();
    getuserBalance();
    getMatchIdDetails();

    height = MediaQuery.of(context).size.height;
    width = MediaQuery.of(context).size.width;
    return WillPopScope(
      onWillPop: () {
        _player.stop();
        _clockTimer.cancel();
        setState(() {
          playBackgroundMusic = true;
        });
        return Future.value(true);
      },
      child: OrientationBuilder(builder: (context, oreintation) {
        if (oreintation == Orientation.landscape) {
          return landscapeWidget();
        } else {
          return potraitMode();
        }
      }),
    );
  }

  Widget landscapeWidget() {
    showPopUp = true;
    return Scaffold(
      key: _globalKey,
      backgroundColor: Colors.transparent,
      drawerEnableOpenDragGesture: false,
      drawer: SizedBox(width: width * 0.3, child: drawerWidget()),
      body: Container(
          height: height,
          decoration: BoxDecoration(
              image: DecorationImage(
                  image: AssetImage(
                      "assets/Teen-patti/images/backgroud-image.png"),
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
                                  setState(() {
                                    playBackgroundMusic == false
                                        ? onPressedMusic()
                                        : Vibration.vibrate();
                                  });
                                  _globalKey.currentState!.openDrawer();
                                },
                                child: Image.asset(  'assets/Teen-patti/images/menu-button.png',
                                    fit: BoxFit.fill, width: width * 0.045),
                              ),
                              SizedBox(
                                width: width * 0.01,
                              ),
                              Container(
                                  padding: EdgeInsets.symmetric(
                                      horizontal: width * 0.02,
                                      vertical: height * 0.015),
                                alignment: Alignment.center,
                                decoration: BoxDecoration(
                                    image: DecorationImage(
                                        image: AssetImage(
                                           'assets/Teen-patti/images/balance-frame.png'),
                                        fit: BoxFit.fill)),
                                child:  Row(
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
                        HapticFeedback.vibrate();
                        setState(() {
                          playBackgroundMusic == false ? onPressedMusic() : "";
                        });
                        Navigator.push(context, _createRouteCurrentBets());
                        // showBetHistory(context);
                      },
                      child:Container(
                              padding: EdgeInsets.only(
                                  left: width * 0.085, top: height * 0.001),
                              height: height * 0.09,
                              width: width * 0.13,
                              alignment: Alignment.center,
                              decoration: BoxDecoration(
                                  image: DecorationImage(
                                      image: AssetImage(
                                        'assets/Teen-patti/images/my-bet.png',
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
                    SizedBox(
                      height: 1,
                    ),
                    BlinkText(
                      "Round Id : $marketId",
                      style: TextStyle(
                          color: Colors.white, fontWeight: FontWeight.bold),
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

                    startTimes <= 1
                    ? Positioned(
                        top: height * 0.08,
                        child: Image.asset(
                          'assets/lucky7/images/tableGirl.png',
                          fit: BoxFit.cover,
                          height: height * 0.28,
                        ),
                      )
                    : SizedBox(),
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
                //     startTimes >= 1
                //             ?  Positioned(
                //           top: height * 0.02,
                // right: width * 0.14,
                //       child: CustomText(
                //                       text: "sec",
                //                       fontWeight: FontWeight.bold,
                //                       color: Colors.white,
                //                       fontSize: 09.0,
                //                       textAlign: TextAlign.end,
                //                     ),
                //     ):SizedBox(),
                Positioned(
                  top: height * 0.045,
                  right: width * 0.015,
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
                                      height: 5,
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
                                      ;
                                    });
                                    _player.stop();
                                    setState(() {
                                      playBackgroundMusic = true;
                                    });
                                  },
                                  child: Image.asset(
                                      'assets/Teen-patti/images/sound-unmute.png',
                                      fit: BoxFit.fill,
                                      width: width * 0.045),
                                )
                              : InkWell(
                                  onTap: () {
                                    setState(() {
                                      playBackgroundMusic == false
                                          ? onPressedMusic()
                                          : Vibration.vibrate();
                                      ;
                                    });
                                    _player.play();
                                    setState(() {
                                      playBackgroundMusic = false;
                                    });
                                  },
                                  child: Image.asset(
                                     'assets/Teen-patti/images/sound-button.png',
                                      fit: BoxFit.fill,
                                      width: width * 0.055),
                                ),
                        ],
                      ),
                    ],
                  ),
                ),

              
            
              Positioned(
                bottom: 1,
                child: Image.asset(
                  'assets/Teen-patti/images/table-image.png',
                  fit: BoxFit.fill,
                  height: height * 0.67,
                ),
              ),
              Positioned(
                top: height * 0.37,
                left: width * 0.2,
                child: Image.asset(
                  'assets/lucky7/images/frame/logo.png',
                  fit: BoxFit.cover,
                  height: height * 0.09,
                ),
              ),
              Positioned(
                  top: height * 0.37,
                  right: width * 0.2,
                  child: Image.asset(
                    'assets/lucky7/images/frame/logo.png',
                    fit: BoxFit.cover,
                    height: height * 0.09,
                  )),

              AnimatedSwitcher(
                duration: Duration(milliseconds: 500),
                child: Stack(
                  children: _coins,
                ),
              ),
              // ?
              //------------------- RESULT IMAGE----------------//
              Positioned(
                  top: height * 0.45,
                  right: width * 0.28,
                  child: Row(
                    children: [
                      InkWell(
                        onTap: () {
                          HapticFeedback.vibrate();
                          setState(() {
                            if (redCoinAnimation == true ||
                                lightGreenCoinAnimation == true ||
                                greenCoinAnimation == true ||
                                lightBlueCoinAnimation == true ||
                                brownCoinAnimation == true) {
                              selectPlayerA = !selectPlayerA;
                            }
                            if (selectPlayerA == true) {
                              selectPlayerB = false;
                              showMyDialog(
                                  context,
                                  height * 0.45,
                                  width * 0.33,
                                  height * 0.4,
                                  width * 0.7,
                                  height * 0.64,
                                  width * 0.55,
                                  redCoinAnimation == true
                                      ? stack1
                                      : lightGreenCoinAnimation == true
                                          ? stack2
                                          : lightBlueCoinAnimation == true
                                              ? stack3
                                              : greenCoinAnimation == true
                                                  ? stack4
                                                  : brownCoinAnimation == true
                                                      ? stack6
                                                      : 0);
                            }
                          });
                        },
                        child: AnimatedContainer(
                          height: selectPlayerA == true
                              ? height * 0.35
                              : height * 0.3,
                          width: selectPlayerA == true
                              ? width * 0.25
                              : width * 0.2,
                          duration: Duration(milliseconds: 300),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              border: Border.all(
                                  width: 3,
                                  color: selectPlayerA == true
                                      ? Colors.white
                                      : Color.fromRGBO(157, 50, 204, 2))),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Container(
                                alignment: Alignment.center,
                                height: 25,
                                width: width,
                                decoration: BoxDecoration(
                                    color: Colors.black,
                                    borderRadius: BorderRadius.only(
                                        topLeft: Radius.circular(10),
                                        topRight: Radius.circular(10))),
                                child: Container(
                                  margin:  EdgeInsets.symmetric(
                                      horizontal: 20),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Image.asset(
                                        "assets/User-interface/teen-patti-small-coin.png",
                                        scale: 1,
                                      ),
                                      Text(
                                        "Player A",
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontWeight: FontWeight.bold),
                                      ),
                                      Icon(
                                        Icons.person,
                                        color: Color.fromRGBO(157, 50, 204, 2),
                                      )
                                    ],
                                  ),
                                ),
                              ),
                              Column(
                                children: [
                                  Image.asset(
                                    "assets/User-interface/chips.png",
                                    scale: 1,
                                  ),
                                  Text(
                                    playerARate,
                                    style:
                                        TextStyle(fontWeight: FontWeight.bold),
                                  )
                                ],
                              ),
                              Container(
                                alignment: Alignment.center,
                                height: 25,
                                width: width,
                                decoration: BoxDecoration(
                                    color: Colors.black,
                                    borderRadius: BorderRadius.only(
                                        bottomRight: Radius.circular(10),
                                        bottomLeft: Radius.circular(10))),
                                child: Container(
                                  margin:  EdgeInsets.symmetric(
                                      horizontal: 20),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Image.asset(
                                        "assets/User-interface/teen-patti-small-coin.png",
                                        scale: 1,
                                      ),
                                      Text(
                                        "MY : $liablity1",
                                        style: TextStyle(
                                            color: liablity1 > 0
                                                ? Colors.green
                                                : Colors.white,
                                            fontWeight: FontWeight.bold),
                                      ),
                                      Text(
                                        "0",
                                        style: TextStyle(
                                            color: Colors.yellow,
                                            fontWeight: FontWeight.bold),
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 30,
                      ),
                      InkWell(
                        onTap: () {
                          HapticFeedback.vibrate();
                          setState(() {
                            if (redCoinAnimation == true ||
                                lightGreenCoinAnimation == true ||
                                greenCoinAnimation == true ||
                                lightBlueCoinAnimation == true ||
                                brownCoinAnimation == true) {
                              selectPlayerB = !selectPlayerB;
                            }
                            if (selectPlayerB == true) {
                              selectPlayerA = false;
                              showMyDialog(
                                  context,
                                  height * 0.45,
                                  width * 0.33,
                                  height * 0.4,
                                  width * 0.7,
                                  height * 0.64,
                                  width * 0.55,
                                  redCoinAnimation == true
                                      ? stack1
                                      : lightGreenCoinAnimation == true
                                          ? stack2
                                          : lightBlueCoinAnimation == true
                                              ? stack3
                                              : greenCoinAnimation == true
                                                  ? stack4
                                                  : brownCoinAnimation == true
                                                      ? stack6
                                                      : 0);
                            }
                          });
                        },
                        child: AnimatedContainer(
                          height: selectPlayerB == true
                              ? height * 0.35
                              : height * 0.3,
                          width: selectPlayerB == true
                              ? width * 0.25
                              : width * 0.2,
                          duration: Duration(milliseconds: 300),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              border: Border.all(
                                  width: 3,
                                  color: selectPlayerB == true
                                      ? Colors.white
                                      : Color.fromRGBO(157, 50, 204, 2))),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Container(
                                alignment: Alignment.center,
                                height: 25,
                                width: width,
                                decoration: BoxDecoration(
                                    color: Colors.black,
                                    borderRadius: BorderRadius.only(
                                        topLeft: Radius.circular(10),
                                        topRight: Radius.circular(10))),
                                child: Container(
                                  margin:  EdgeInsets.symmetric(
                                      horizontal: 20),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Image.asset(
                                        "assets/User-interface/teen-patti-small-coin.png",
                                        scale: 1,
                                      ),
                                      Text(
                                        "Player B",
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontWeight: FontWeight.bold),
                                      ),
                                      Icon(
                                        Icons.person,
                                        color: Color.fromRGBO(157, 50, 204, 2),
                                      )
                                    ],
                                  ),
                                ),
                              ),
                              Column(
                                children: [
                                  Image.asset(
                                    "assets/User-interface/chips.png",
                                    scale: 1,
                                  ),
                                  Text(
                                    playerBRate,
                                    style:
                                        TextStyle(fontWeight: FontWeight.bold),
                                  )
                                ],
                              ),
                              Container(
                                alignment: Alignment.center,
                                height: 25,
                                width: width,
                                decoration: BoxDecoration(
                                    color: Colors.black,
                                    borderRadius: BorderRadius.only(
                                        bottomRight: Radius.circular(10),
                                        bottomLeft: Radius.circular(10))),
                                child: Container(
                                  margin:  EdgeInsets.symmetric(
                                      horizontal: 20),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Image.asset(
                                        "assets/User-interface/teen-patti-small-coin.png",
                                        scale: 1,
                                      ),
                                      Text(
                                        "MY : $liablity2",
                                        style: TextStyle(
                                            color: liablity2 > 0
                                                ? Colors.green
                                                : Colors.white,
                                            fontWeight: FontWeight.bold),
                                      ),
                                      Text(
                                        "0",
                                        style: TextStyle(
                                            color: Colors.yellow,
                                            fontWeight: FontWeight.bold),
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  )),

              LandscapeRandomCoinLeftSide(coinsSound: playBackgroundMusic),
              RandomCoinThroughRightSide(),

              autoTime == "45"
                  ? placeyourbetWidget(autoTime)
                  : autoTime == "3" || autoTime == "2" || autoTime == "1"
                      ? goWidget()
                      : autoTime != "0"
                          ? SizedBox()
                          : Positioned(
                              top: height * 0.32,
                              right: width * 0.3,
                              child: Container(
                                alignment: Alignment.center,
                                height: height * 0.5,
                                width: width * 0.4,
                                decoration: BoxDecoration(
                                    image: DecorationImage(
                                        image: AssetImage(
                                          "assets/Teen-patti/images/Current Result.png",
                                        ),
                                        fit: BoxFit.cover)),
                                child: Container(
                                  margin:  EdgeInsets.symmetric(
                                      horizontal: 30),
                                  child: Row(
                                    children: [
                                      buildImage(cardImage1),
                                      SizedBox(
                                        width: 3,
                                      ),
                                      buildImage(cardImage2),
                                      SizedBox(
                                        width: 3,
                                      ),
                                      buildImage(cardImage3),
                                      SizedBox(
                                        width: 30,
                                      ),
                                      buildImage(cardImage4),
                                      SizedBox(
                                        width: 3,
                                      ),
                                      buildImage(cardImage5),
                                      SizedBox(
                                        width: 3,
                                      ),
                                      buildImage(cardImage6),
                                    ],
                                  ),
                                ),
                              ),
                            ),

// //Animated Coins : a
              startTimes <= 3 && autoTime != '0'
                  ? gameStopBetting(autoTime)
                  : SizedBox(),

              animatedCoinsSeletion(),
              Positioned(
                bottom: height * 0.05,
                left: width * 0.02,
                child: Row(
                  children: [
                    Container(
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                          image: DecorationImage(
                              image: AssetImage(
                                  "assets/Teen-patti/images/exp-image.png"),
                              fit: BoxFit.fitWidth)),
                      height: height * 0.09,
                      width: width * 0.15,
                      child: Text(
                        "EXP : $liablity",
                        style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 11),
                      ),
                    ),
                    SizedBox(
                      width: width * 0.57,
                    ),
                    // InkWell(
                    //   onTap: () {
                    //     _globalKey.currentState!.openDrawer();

                    //     HapticFeedback.vibrate();
                    //     onPressedMusic();
                    //     setState(() {
                    //       menubar = false;
                    //     });
                    //   },
                    //   child: Image.asset(
                    //     'assets/Teen-patti/images/bet-button.png',
                    //     height: height * 0.09,
                    //     fit: BoxFit.cover,
                    //   ),
                    // ),
                  ],
                ),
              ),

                 Positioned(
                  top: height * 0.18,
                  right: width * 0.02,
                  child: Container(
                    height: height * 0.75,
                    width: width * 0.04,
        
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                        image: DecorationImage(
                      image: AssetImage(
                          "assets/lucky7/images/coin_background.png"),
                      fit: BoxFit.cover,
                    )),
                    child:Padding(
                  padding:  EdgeInsets.only(top: 2.0),
                  child: ListView.builder(
                      physics: NeverScrollableScrollPhysics(),
                      scrollDirection: Axis.vertical,
                      itemCount: resultList.length,
                      itemBuilder: (context, index) {
                        var items = resultList[index];
                        return Column(
                          children: [
                            InkWell(
                              onTap: () {
                                playBackgroundMusic == false
                                    ? onPressedMusic()
                                    : "";
                                HapticFeedback.vibrate();
                                showPopUp == true
                                    ? DialogUtils.showResult(
                                        context,
                                        "",
                                        items.c1,
                                        items.c2,
                                        items.c3,
                                        items.c4,
                                        items.c5,
                                        items.c6,
                                        items.winner,
                                        items.mid,
                                        showPopUp,
                                        playBackgroundMusic)
                                    : "";
                              },
                              child: Container(
                                alignment: Alignment.center,
                                margin:  EdgeInsets.symmetric(vertical: 5),
                                height: 20,
                                width: 20,
                                decoration: BoxDecoration(
                                    color: items.winner == "1"
                                        ? Color(0xaa028BA9)
                                        : Color(0xaaA90270),
                                    borderRadius: BorderRadius.circular(100)),
                                child: Text(
                                  items.winner == "1" ? "A" : "B",
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                            ),
                          ],
                        );
                      }),
                ),)
              ),
            ],
          )),
    );
  }

  Widget potraitMode() {
    showPopUp = false;
    return Scaffold(
      drawerEnableOpenDragGesture: false,
      backgroundColor: Colors.transparent,
      key: _globalKey,
      drawer: SizedBox(width: width * 0.55, child: drawerWidget()),
      body: Container(
          height: height * 1.35,
          width: width,
          decoration: BoxDecoration(
              image: DecorationImage(
            image: AssetImage(
              "assets/Teen-patti/images/backgroud-image.png",
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
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                          image: DecorationImage(
                              image: AssetImage(
                                  'assets/Teen-patti/images/balance-frame.png'),
                              fit: BoxFit.fill)),
                      child: Container(
                        padding:
                            EdgeInsets.symmetric(horizontal: width * 0.016),
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
                      child: Image.asset( 'assets/Teen-patti/images/menu-button.png',
                          fit: BoxFit.cover, height: height * 0.05),
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
                                ;
                              });
                              _player.stop();
                              setState(() {
                                playBackgroundMusic = true;
                              });
                            },
                            child: Image.asset(
                                'assets/Teen-patti/images/sound-unmute.png',
                                fit: BoxFit.fill,
                                height: height * 0.045),
                          )
                        : InkWell(
                            onTap: () {
                              setState(() {
                                playBackgroundMusic == false
                                    ? onPressedMusic()
                                    : Vibration.vibrate();
                                ;
                              });
                              _player.play();
                              setState(() {
                                playBackgroundMusic = false;
                              });
                            },
                            child: Image.asset(
                                'assets/Teen-patti/images/sound-button.png',
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
                      height: height * 0.035,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                          image: DecorationImage(
                              image: AssetImage(
                                  'assets/Teen-patti/images/exp-image.png'),
                              fit: BoxFit.fill)),
                      child: CustomText(
                          text: "EXP: ${liablity.toString()}",
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

                      //  Navigator.push(context, _createRouteCurrentBetsList());
                      },
                      child: Container(
                        padding: EdgeInsets.only(
                            left: width * 0.165, top: height * 0.001),
                        height: height * 0.040,
                        width: width * 0.25,
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                            image: DecorationImage(
                                image: AssetImage(
                                  'assets/Teen-patti/images/my-bet-p.png',
                                ),
                                fit: BoxFit.fill)),
                        child: CustomText(
                          text: matchIdList.length.toString(),
                          fontWeight: FontWeight.w700,
                          color: Colors.white,
                          fontSize: width * 0.024,
                          textAlign: TextAlign.center,
                        ),
                      ),
                    )
                  ],
                ),
              ),
                BlinkText(
                "Round Id : $marketId",
                style:
                    TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
              ),
              SizedBox(
                height: 10,
              ),
              Container(
                padding:
                    EdgeInsets.only(left: width * 0.04, top: height * 0.01),
                margin:  EdgeInsets.symmetric(horizontal: 30, vertical: 0),
                alignment: Alignment.center,
                decoration: BoxDecoration(
                    image: DecorationImage(
                  image: AssetImage(
                    "assets/Teen-patti/images/small-result-p.png",
                  ),
                  fit: BoxFit.fill,
                )),
                height: height * 0.04,
                width: width,
                child: ListView.builder(
                    physics: NeverScrollableScrollPhysics(),
                    scrollDirection: Axis.horizontal,
                    itemCount: resultList.length,
                    itemBuilder: (context, index) {
                      var items = resultList[index];
                      return Column(
                        children: [
                          InkWell(
                            onTap: () {
                              playBackgroundMusic == false
                                  ? onPressedMusic()
                                  : "";
                              HapticFeedback.vibrate();
                              DialogUtils.showResultPortrait(
                                  context,
                                  "",
                                  items.c1,
                                  items.c2,
                                  items.c3,
                                  items.c4,
                                  items.c5,
                                  items.c6,
                                  items.winner,
                                  items.mid,
                                  playBackgroundMusic);
                            },
                            child: Container(
                              alignment: Alignment.center,
                              margin:  EdgeInsets.symmetric(horizontal: 5),
                              height: 20,
                              width: 20,
                              decoration: BoxDecoration(
                                  color: items.winner == "1"
                                      ? Color(0xaa028BA9)
                                      : Color(0xaaA90270),
                                  borderRadius: BorderRadius.circular(100)),
                              child: Text(
                                items.winner == "1" ? "A" : "B",
                                style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                          ),
                        ],
                      );
                    }),
              ),
              SizedBox(
                height: 10,
              ),
              Container(
                margin:  EdgeInsets.symmetric(horizontal: 30),
                alignment: Alignment.centerRight,
                child: Text(
                  "( Min:100 Max:25000 )",
                  style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 12),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Image.asset(
                'assets/dragonTigerLion/tableImges/table-girl.png',
                fit: BoxFit.cover,
                height: height * 0.13,
              ),
              Stack(
                children: [
                  Image.asset(
                    'assets/Teen-patti/images/table-p.png',
                    fit: BoxFit.fill,
                    height: height * 0.35,
                  ),
                  Positioned(
                    left: 30,
                    child:Image.asset(
                            'assets/lucky7/images/frame/logo.png',
                            fit: BoxFit.cover,
                            height: height * 0.04,
                          ),
                  ),
                  Positioned(
                    right: 30,
                    child: Image.asset(
                            'assets/lucky7/images/frame/logo.png',
                            fit: BoxFit.cover,
                            height: height * 0.04,
                          ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Image.asset(
                        'assets/Teen-patti/images/player-image.png',
                        fit: BoxFit.fitWidth,
                        height: height * 0.3,
                        width: width * 0.8,
                      ),
                    ],
                  ),
                  autoTime == "0"
                      ? SizedBox()
                      : Container(
                          width: width,
                          alignment: Alignment.center,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              SizedBox(
                                height: 20,
                              ),
                              Text(
                                "Starting in $autoTime Sec",
                                style: TextStyle(
                                    color: Colors.white, fontSize: 12),
                              ),
                              // SizedBox(
                              //   height: 16,
                              //   width: width * 0.25,
                              //   child: LinearPercentIndicator(
                              //     animation: autoTime == "0" ? false : true,
                              //     restartAnimation:
                              //         autoTime == "0" ? false : true,
                              //     lineHeight: 5.0,
                              //     animationDuration: 45000,
                              //     percent: 1.0,
                              //     progressColor: Color(0xaa9919D2),
                              //     barRadius: Radius.circular(20),
                              //   ),
                              // ),
                              SizedBox(
                                height: 2,
                                width: width * 0.25,
                                child: LinearProgressIndicator(
                                  value:
                                     startTimeSmall/4500, // Calculate the progress
                                  backgroundColor: Colors.grey,
                                  valueColor:
                                      AlwaysStoppedAnimation(Color(0xaa9919D2)),
                                  
                                ),
                              ),
                            ],
                          ),
                        ),
                  SizedBox(
                      height: 200,
                      child: PotraitRandomCoinLeftSide(
                        coinsSound: playBackgroundMusic,
                      )),
                  SizedBox(
                    height: height * 0.36,
                    child: AnimatedSwitcher(
                      duration: Duration(milliseconds: 900),
                      child: Stack(
                        children: _coinsRytPort,
                      ),
                    ),
                  ),
                  SizedBox(height: 200, child: PotraitRandomCoinRightSide()),
                  autoTime == "45"
                      ? placeyourbetWidget(autoTime)
                      : autoTime == "3" || autoTime == "2" || autoTime == "1"
                          ? goWidget()
                          : startTimes <= 3 && autoTime != '0'
                              ? gameStopBetting(autoTime)
                              : autoTime != "0"
                                  ? SizedBox()
                                  : Positioned(
                                      top: height * 0.0,
                                      left: 60,
                                      child: Container(
                                        alignment: Alignment.center,
                                        height: height * 0.3,
                                        width: width * 0.7,
                                        decoration: BoxDecoration(
                                            image: DecorationImage(
                                                image: AssetImage(
                                                  "assets/Teen-patti/images/Current Result.png",
                                                ),
                                                fit: BoxFit.contain)),
                                        child: Container(
                                          margin: 
                                           EdgeInsets.symmetric(
                                              horizontal: 30),
                                          child: Row(
                                            children: [
                                              buildImagePortrait(cardImage1),
                                              SizedBox(
                                                width: 3,
                                              ),
                                              buildImagePortrait(cardImage2),
                                              SizedBox(
                                                width: 3,
                                              ),
                                              buildImagePortrait(cardImage3),
                                              SizedBox(
                                                width: 30,
                                              ),
                                              buildImagePortrait(cardImage4),
                                              SizedBox(
                                                width: 3,
                                              ),
                                              buildImagePortrait(cardImage5),
                                              SizedBox(
                                                width: 3,
                                              ),
                                              buildImagePortrait(cardImage6),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                ],
              ),
              Stack(
                children: [
                  Image.asset(
                    'assets/Teen-patti/images/bottom-pic-p.png',
                    fit: BoxFit.cover,
                    width: width,
                    height: height * 0.08,
                  ),
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
              Container(
                margin:  EdgeInsets.symmetric(horizontal: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      children: [
                        InkWell(
                          onTap: () {
                            setState(() {
                              if (redCoinAnimation == true ||
                                  lightGreenCoinAnimation == true ||
                                  greenCoinAnimation == true ||
                                  lightBlueCoinAnimation == true ||
                                  brownCoinAnimation == true) {
                                selectPlayerB = !selectPlayerB;
                              }
                              if (selectPlayerB == true) {
                                selectPlayerA = false;
                                showMyDialogPortrait(
                                    context,
                                    height * 0.23,
                                    width,
                                    height * 0.4,
                                    width * 0.7,
                                    height * 0.26,
                                    width * 0.98,
                                    redCoinAnimation == true
                                        ? stack1
                                        : lightGreenCoinAnimation == true
                                            ? stack2
                                            : lightBlueCoinAnimation == true
                                                ? stack3
                                                : greenCoinAnimation == true
                                                    ? stack4
                                                    : brownCoinAnimation == true
                                                        ? stack6
                                                        : 0);
                              }
                            });
                          },
                          child: Image.asset(
                            'assets/Teen-patti/images/player-A.png',
                            height: height * 0.07,
                            fit: BoxFit.cover,
                          ),
                        ),
                        Text(
                          liablity1 != 0 ? "$liablity1" : "",
                          style: TextStyle(
                              color:
                                  liablity1 > 0 ? Colors.green : Colors.white),
                        ),
                      ],
                    ),
                    Column(
                      children: [
                        InkWell(
                          onTap: () {
                            setState(() {
                              if (redCoinAnimation == true ||
                                  lightGreenCoinAnimation == true ||
                                  greenCoinAnimation == true ||
                                  lightBlueCoinAnimation == true ||
                                  brownCoinAnimation == true) {
                                selectPlayerB = !selectPlayerB;
                              }
                              if (selectPlayerB == true) {
                                selectPlayerA = false;
                                showMyDialogPortrait(
                                    context,
                                    height * 0.23,
                                    width,
                                    height * 0.4,
                                    width * 0.7,
                                    height * 0.26,
                                    width * 0.98,
                                    redCoinAnimation == true
                                        ? stack1
                                        : lightGreenCoinAnimation == true
                                            ? stack2
                                            : lightBlueCoinAnimation == true
                                                ? stack3
                                                : greenCoinAnimation == true
                                                    ? stack4
                                                    : brownCoinAnimation == true
                                                        ? stack6
                                                        : 0);
                              }
                            });
                          },
                          child: Image.asset(
                            'assets/Teen-patti/images/player-B.png',
                            height: height * 0.07,
                            fit: BoxFit.cover,
                          ),
                        ),
                        Text(
                          liablity2 != 0 ? "$liablity2" : "",
                          style: TextStyle(
                            color: liablity2 > 0 ? Colors.green : Colors.white,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ]),
          )),
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
              HapticFeedback.vibrate();
            },
            child: Container(
              alignment: Alignment.centerRight,
              height: height * 0.09,
              width: width,
              decoration: BoxDecoration(color: Colors.black),
              child: Padding(
                padding:  EdgeInsets.only(right: 5),
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
              HapticFeedback.vibrate();
            },
            child: Container(
              margin:  EdgeInsets.symmetric(horizontal: 30, vertical: 10),
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
              HapticFeedback.vibrate();
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
              HapticFeedback.vibrate();
            },
            child: Container(
              margin:  EdgeInsets.symmetric(horizontal: 30, vertical: 10),
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
              HapticFeedback.vibrate();
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
              HapticFeedback.vibrate();
              Navigator.push(context, _createRouteChangePassword());
            },
            child: Container(
              margin:  EdgeInsets.symmetric(horizontal: 30, vertical: 10),
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
              HapticFeedback.vibrate();
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

  Widget animatedCoinsSeletion() {
    return Positioned(
      bottom: height * 0.01,
      left: width * 0.30,
      child: Row(
        children: [
          InkWell(
            onTap: () {
              setState(() {
                playBackgroundMusic == false ? '' : Vibration.vibrate();
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
                image: AssetImage("assets/lucky7/images/coins/red_coin.png"),
                fit: BoxFit.fill,
              )),
              child: Text(
                stack1.toString(),
                style: TextStyle(
                    fontWeight: FontWeight.bold, fontSize: height * 0.02),
              ),
            ),
          ),
          SizedBox(
            width: width * 0.03,
          ),
          InkWell(
            onTap: () {
              setState(() {
                playBackgroundMusic == false ? '' : Vibration.vibrate();
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
              height: lightGreenCoinAnimation == true && startTimes > 1
                  ? height * 0.15
                  : height * 0.11,
              width: lightGreenCoinAnimation == true && startTimes > 1
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
                    fontWeight: FontWeight.bold, fontSize: height * 0.02),
              ),
            ),
          ),
          SizedBox(
            width: width * 0.03,
          ),
          InkWell(
            onTap: () {
              setState(() {
                playBackgroundMusic == false ? '' : Vibration.vibrate();
                ;
              });
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
                height: lightBlueCoinAnimation == true && startTimes > 1
                    ? height * 0.15
                    : height * 0.11,
                width: lightBlueCoinAnimation == true && startTimes > 1
                    ? width * 0.07
                    : width * 0.05,
                decoration: BoxDecoration(
                    image: DecorationImage(
                  image: AssetImage("assets/lucky7/images/coins/skyblue.png"),
                  fit: BoxFit.fill,
                )),
                child: Text(
                  stack2 != 0 ? "2K" : stack3.toString(),
                  style: TextStyle(
                      fontWeight: FontWeight.bold, fontSize: height * 0.02),
                )),
          ),
          SizedBox(
            width: width * 0.03,
          ),
          InkWell(
            onTap: () {
              setState(() {
                playBackgroundMusic == false ? '' : Vibration.vibrate();
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
              height: greenCoinAnimation == true && startTimes > 1
                  ? height * 0.15
                  : height * 0.11,
              width: greenCoinAnimation == true && startTimes > 1
                  ? width * 0.07
                  : width * 0.05,
              decoration: BoxDecoration(
                  image: DecorationImage(
                image: AssetImage("assets/lucky7/images/coins/green_coin.png"),
                fit: BoxFit.fill,
              )),
              child: Text(
                stack3 != 0 ? "5K" : stack4.toString(),
                style: TextStyle(
                    fontWeight: FontWeight.bold, fontSize: height * 0.02),
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
                playBackgroundMusic == false ? '' : Vibration.vibrate();
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
              height: brownCoinAnimation == true && startTimes > 1
                  ? height * 0.17
                  : height * 0.13,
              width: brownCoinAnimation == true && startTimes > 1
                  ? width * 0.075
                  : width * 0.06,
              decoration: BoxDecoration(
                  image: DecorationImage(
                image: AssetImage("assets/lucky7/images/coins/brown.png"),
                fit: BoxFit.fill,
              )),
              child: Text(
                stack4 != 0 ? "20K" : stack6.toString(),
                style: TextStyle(
                    fontWeight: FontWeight.bold, fontSize: height * 0.02),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget buildImage(String cardImage) {
    return cardImage == "" || cardImage == "null"
        ? Image.asset(
            'assets/User-interface/card-back.png',
            height: 50,
            width: 35,
            fit: BoxFit.fill,
          )
        : FlipCard(
            flipOnTouch: false,
            autoFlipDuration: Duration(seconds: 1),
            front: Image.asset(
              'assets/User-interface/card-back.png',
              height: 50,
              width: 35,
              fit: BoxFit.fill,
            ),
            back: SizedBox(
                height: 50,
                width: 35,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(2.5),
                  child: Image.network(
                      'http://admin.kalyanexch.com/images/cards/$cardImage.png',
                      fit: BoxFit.cover),
                )));
  }

  Widget buildImagePortrait(String cardImage) {
    return cardImage == "" || cardImage == "null"
        ? Image.asset(
            'assets/User-interface/card-back.png',
            height: 40,
            width: 27,
            fit: BoxFit.fill,
          )
        : FlipCard(
            flipOnTouch: false,
            autoFlipDuration: Duration(seconds: 1),
            front: Image.asset(
              'assets/User-interface/card-back.png',
              height: 40,
              width: 27,
              fit: BoxFit.fill,
            ),
            back: SizedBox(
                height: 40,
                width: 27,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(2.5),
                  child: Image.network(
                      'http://admin.kalyanexch.com/images/cards/$cardImage.png',
                      fit: BoxFit.cover),
                )));
  }

  Widget goWidget() {
    return Visibility(
      visible: autoTime == "3" || autoTime == "2" || autoTime == "1",
      child: Lottie.asset("assets/Teen-patti/audio/countdown.json",
          height: height * 0.2, width: width),
    );
  }

  Widget placeyourbetWidget(String time) {
    return startTimes == 45
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

  //--------------API CALL----------------------//

  Future getCardDetails() async {
    var url = Apis.getCardDataTeenPatti;
    var response = await GlobalFunction.apiGetRequestae(url);
    var result = jsonDecode(response);
    if (result['status'] == true) {
     
        autoTime = result['data']['t1'][0]['autotime'].toString();
            if (startTimes != int.parse(autoTime.toString())) {
        startTimeSmall = startTimes * 100;
      }
        startTimes = int.parse(autoTime);
        cardImage1 = result['data']['t1'][0]['C1'].toString();
        cardImage2 = result['data']['t1'][0]['C2'].toString();
        cardImage3 = result['data']['t1'][0]['C3'].toString();
        cardImage4 = result['data']['t1'][0]['C4'].toString();
        cardImage5 = result['data']['t1'][0]['C5'].toString();
        cardImage6 = result['data']['t1'][0]['C6'].toString();
        marketId = result['data']['t1'][0]['mid'].toString();
        playerA = result['data']['t2'][0]['nat'].toString();
        playerB = result['data']['t2'][2]['nat'].toString();
        playerARate = result['data']['t2'][0]['rate'].toString();
        playerBRate = result['data']['t2'][2]['rate'].toString();
        playerASid = result['data']['t2'][0]['sid'].toString();
        playerBSid = result['data']['t2'][2]['sid'].toString();

      if (autoTime == "0") {
        setState(() {
          selectPlayerA = false;
          selectPlayerB = false;
          redCoinAnimation = false;
          lightGreenCoinAnimation = false;
          greenCoinAnimation = false;
          lightBlueCoinAnimation = false;
          brownCoinAnimation = false;
          confirmButton = false;
        });
      }
    }
  }

  String timerBar = "";
  int barTime = 0;
  Future getCardDetailsForBar() async {
    var url = Apis.getCardDataTeenPatti;
    var response = await GlobalFunction.apiGetRequestae(url);
    var result = jsonDecode(response);
    if (result['status'] == true) {
      setState(() {
        timerBar = result['data']['t1'][0]['autotime'].toString();
        barTime = int.parse(autoTime);
      });
    }
  }

  Future getReultsData() async {
    var url = Apis.getReusltsTeenPatti;
    var response = await GlobalFunction.apiGetRequestae(url);
    var result = jsonDecode(response);
    var list = result as List;
    setState(() {
      resultList.clear();
      var listdata = list.map((e) => ResultsModel.fromJson(e)).toList();
      resultList.addAll(listdata);
    });
  }

  double mainBalance = 0;

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

  Future getbetListDetails() async {
    var url = Apis.betListApi;
    var response = await GlobalFunction.apiGetRequestae(url);
    var result = jsonDecode(response);
    var list = result['data'] as List;
    if (result['status'] == true) {
      setState(() {
        betListResult.clear();
        var listdata = list.map((e) => ResultsModel.fromJson(e)).toList();
        // betListResult.addAll(listdata);
      });
    }
  }

  Future makeBet() async {
    getUserDetails();
    DateTime currentTime = DateTime.now();
    var url = "http://13.250.53.81/VirtualCasinoBetPlacer/vc/place-bet";
    var body = {
      "casinoName": 1,
      "isBack": true,
      "odds": selectPlayerA == true
          ? playerARate
          : selectPlayerB == true
              ? playerBRate
              : "",
      "stake": manualAmount == true
          ? stakeController.text.toString()
          : redCoinAnimation == true && manualAmount == false
              ? stack1.toString()
              : lightGreenCoinAnimation == true && manualAmount == false
                  ? stack2.toString()
                  : lightBlueCoinAnimation == true && manualAmount == false
                      ? stack3.toString()
                      : greenCoinAnimation == true && manualAmount == false
                          ? stack4.toString()
                           : brownCoinAnimation == true &&
                                      manualAmount == false
                                  ? stack6
                                  : "",
      "selectionId":
          selectPlayerA == true ? playerASid.toString() : playerASid.toString(),
      "placeTime": currentTime.toString(),
      "marketId": marketId.toString(),
      "matchId": 15,
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
        result['message'],
      );
      setState(() {
        selectPlayerA = false;
        selectPlayerB = false;
        manualAmount = false;
        stakeController.clear();
      });
    } else {
      manualAmount = false;
      stakeController.clear();

      DialogUtils.showOneBtn(
        context,
        result['message'],
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
      "odds": selectPlayerA == true
          ? playerARate
          : selectPlayerB == true
              ? playerBRate
              : "",
      "stake": manualAmount == true
          ? stakeController.text.toString()
          : redCoinAnimation == true && manualAmount == false
              ? stack1.toString()
              : lightGreenCoinAnimation == true && manualAmount == false
                  ? stack2.toString()
                  : lightBlueCoinAnimation == true && manualAmount == false
                      ? stack3.toString()
                      : greenCoinAnimation == true && manualAmount == false
                          ? stack4.toString()
                           : brownCoinAnimation == true &&
                                      manualAmount == false
                                  ? stack6
                                  : "",
      "selectionId":
          selectPlayerA == true ? playerASid.toString() : playerASid.toString(),
      "placeTime": currentTime.toString(),
      "marketId": marketId.toString(),
      "matchId": 15,
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
    var response = await GlobalFunction.apiPostRequestTokenForBetPortrait(
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
        result['message'],
      );
      setState(() {
        selectPlayerA = false;
        selectPlayerB = false;
        manualAmount = false;
        stakeController.clear();
      });
      getVcLiablity();
    } else {
      manualAmount = false;
      stakeController.clear();

      DialogUtils.showOneBtnPortrait(
        context,
        result['message'],
      );
    }

    stakeController.clear();
    manualAmount = false;
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

  showMyDialog(
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
                                "assets/User-interface/pop-background-amount.png"),
                            fit: BoxFit.cover),
                      ),
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
                                    scale: 3,
                                  ),
                                ),
                                SizedBox(
                                  height: height * 0.26,
                                  width: width * 0.22,
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
                                    scale: 3,
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
                                      if (selectPlayerA == true ||
                                          selectPlayerB == true) {
                                        makeBet();
                                        Navigator.pop(context);

                                        selectPlayerA = false;
                                        selectPlayerB = false;
                                        setState(() {
                                          confirmButton = true;
                                        });
                                      }
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

                                          if (selectPlayerA == true ||
                                              selectPlayerB == true) {
                                            makeBet();
                                            Navigator.pop(context);

                                            selectPlayerA = false;
                                            selectPlayerB = false;
                                            setState(() {
                                              confirmButton = true;
                                            });
                                          }
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
                                            "Please Select Existing amount",
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

  showMyDialogPortrait(
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
                                "assets/User-interface/pop-background-amount.png"),
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
                                      scale: 3,
                                    ),
                                  ),
                                  SizedBox(
                                    height: height * 0.125,
                                    width: width * 0.45,
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
                                      scale: 3,
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

                                        if (selectPlayerA == true ||
                                            selectPlayerB == true) {
                                          makeBetPortrait();
                                          Navigator.pop(context);

                                          selectPlayerA = false;
                                          selectPlayerB = false;
                                          setState(() {
                                            confirmButton = true;
                                          });
                                        }
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

                                            if (selectPlayerA == true ||
                                                selectPlayerB == true) {
                                              makeBetPortrait();
                                              Navigator.pop(context);

                                              selectPlayerA = false;
                                              selectPlayerB = false;
                                              setState(() {
                                                confirmButton = true;
                                              });
                                            }
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
                                              "Please Select Existing amount",
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

  List<MatchIdModel> matchIdList = [];
  Future getMatchIdDetails() async {
    var url = Apis.matchId;
    var body = {"matchId": "15"};
    var response = await GlobalFunction.apiPostRequestToken(url, body);
    var result = jsonDecode(response);
    if (result['status'] == true) {
      var list = result['data']['VT20'] as List;
      matchIdList.clear();
      var listdata = list.map((e) => MatchIdModel.fromJson(e)).toList();
      matchIdList.addAll(listdata);
    }
  }

  showBetHistory(BuildContext context) {
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
                                      MediaQuery.of(context).size.width * 0.9,
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
                                      SizedBox(
                                        height: height * 0.3,
                                        width: width * 0.9,
                                        child: ListView.builder(
                                            shrinkWrap: true,
                                            scrollDirection: Axis.vertical,
                                            itemCount: matchIdList.length,
                                            itemBuilder: (context, index) {
                                              var items = matchIdList[index];
                                              return Column(
                                                children: [
                                                  Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceBetween,
                                                      children: [
                                                        CustomText(
                                                          text: items.nation
                                                              .toString(),
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          color: Colors.white,
                                                          fontSize: 12.0,
                                                          textAlign:
                                                              TextAlign.center,
                                                        ),
                                                        Text(
                                                          items.rate.toString(),
                                                          style: TextStyle(
                                                            fontWeight:
                                                                FontWeight.bold,
                                                            color: Colors.white,
                                                            fontSize: 12.0,
                                                          ),
                                                        ),
                                                        CustomText(
                                                          text: items.amount
                                                              .toString(),
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          color: Colors.white,
                                                          fontSize: 12.0,
                                                          textAlign:
                                                              TextAlign.center,
                                                        ),
                                                      ]),
                                                ],
                                              );
                                            }),
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
                InkWell(
                  onTap: () {
                    Navigator.pop(context);
                    HapticFeedback.heavyImpact();
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

  showBetHistoryPotrait(BuildContext context) {
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
                                        color:
                                            Color.fromARGB(170, 232, 175, 17),
                                      )),
                                  child: Column(
                                    children: [
                                      Container(
                                        color:
                                            Color.fromARGB(170, 206, 154, 22),
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
                                      SizedBox(
                                        height: height * 0.2,
                                        width: width * 0.7,
                                        child: ListView.builder(
                                            shrinkWrap: true,
                                            scrollDirection: Axis.vertical,
                                            itemCount: matchIdList.length,
                                            itemBuilder: (context, index) {
                                              var items = matchIdList[index];
                                              return Column(
                                                children: [
                                                  Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceBetween,
                                                      children: [
                                                        CustomText(
                                                          text: items.nation
                                                              .toString(),
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          color: Colors.white,
                                                          fontSize: 12.0,
                                                          textAlign:
                                                              TextAlign.center,
                                                        ),
                                                        Text(
                                                          items.rate.toString(),
                                                          style: TextStyle(
                                                            fontWeight:
                                                                FontWeight.bold,
                                                            color: Colors.white,
                                                            fontSize: 12.0,
                                                          ),
                                                        ),
                                                        CustomText(
                                                          text: items.amount
                                                              .toString(),
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          color: Colors.white,
                                                          fontSize: 12.0,
                                                          textAlign:
                                                              TextAlign.center,
                                                        ),
                                                      ]),
                                                ],
                                              );
                                            }),
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
                InkWell(
                  onTap: () {
                    Navigator.pop(context);
                    HapticFeedback.heavyImpact();
                  },
                  child: Container(
                    alignment: Alignment.topRight,
                    height: MediaQuery.of(context).size.height * 0.6,
                    width: MediaQuery.of(context).size.width * 0.42,
                    margin: const EdgeInsets.only(left: 160, top: 10),
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
        liablity1 = result['data'][0]['liability'];
        liablity2 = result['data'][2]['liability'];
      });
    }
  }

  Route _createRouteCurrentBets() {
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

  void getDeviceIp() async {
    final ipv4 = await Ipify.ipv4();
    print(ipv4); // 98.207.254.136

    final ipv6 = await Ipify.ipv64();
    iPAddress = ipv6.toString();
    print(
        "Ip Address --->$iPAddress"); // 98.207.254.136 or 2a00:1450:400f:80d::200e

    final ipv4json = await Ipify.ipv64(format: Format.JSON);
    print(
        ipv4json); //{"ip":"98.207.254.136"} or {"ip":"2a00:1450:400f:80d::200e"}

    // The response type can be text, json or jsonp
  }
}
