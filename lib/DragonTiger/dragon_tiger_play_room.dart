import 'dart:async';
import 'dart:convert';
import 'dart:math';

import 'package:blinking_text/blinking_text.dart';
import 'package:connectivity/connectivity.dart';
import 'package:dart_ipify/dart_ipify.dart';
import 'package:flip_card/flip_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:just_audio/just_audio.dart';
import 'package:lottie/lottie.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:vibration/vibration.dart';
import 'package:virtual_casino/Utils/toast.dart';
import 'package:virtual_casino/Widgets/customButton.dart';
import '../Lucky7/Modal/matchIdModelLucky.dart';
import '../User-Interface/change_passswod_screen.dart';
import '../User-Interface/current_bets_screen.dart';
import '../User-Interface/current_user_bet.dart';
import '../User-Interface/my_account.dart';
import '../User-Interface/profile_screen.dart';
import '../User-Interface/signin_screen.dart';
import '../Utils/api_helper.dart';
import '../Utils/apis.dart';
import '../Widgets/customText.dart';
import '../Widgets/custom_image.dart';
import '../constants/color_constants.dart';
import 'Constants/images_constant_dt.dart';
import 'Model/winner_result_model.dart';

class DragonTigerPlayRoom extends StatefulWidget {
  final String matchId;
  final String gameCode;
  const DragonTigerPlayRoom(
      {super.key, required this.matchId, required this.gameCode});

  @override
  State<DragonTigerPlayRoom> createState() => _DragonTigerPlayRoomState();
}

class _DragonTigerPlayRoomState extends State<DragonTigerPlayRoom>
    with TickerProviderStateMixin, WidgetsBindingObserver {
  final GlobalKey<ScaffoldState> _globalKey = GlobalKey<ScaffoldState>();
  double height = 0;
  double width = 0;
  late Timer _clockTimer;
  String winnerResult = "";
  bool selectCard = false;

  int cardIndex = 0;
  int stack1 = 0;
  int stack2 = 0;
  int stack3 = 0;
  int stack4 = 0;
  int stack5 = 0;
  int stack6 = 0;
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
  double liablity16 = 0;
  double liablity17 = 0;
  double liablity18 = 0;
  double liablity19 = 0;
  bool redCoinAnimation = false;

  double _minXRytPort = 0;
  double _maxXRytPort = 0;
  double _minYRytPort = 0;
  double _maxYRytPort = 0;
  int _currentCoinIndex = 0;

  double _minX = 0;
  double _maxX = 0;
  double _minY = 0;
  double _maxY = 0;
  var stakeController = TextEditingController();
  bool manualAmount = false;

  final List _redcoinImages = [
    'assets/lucky7/images/coins/one.png',
  ];

  final List _lightGreencoinImages = [
    'assets/lucky7/images/coins/five.png',
  ];
  final List _bluecoinImages = [
    'assets/lucky7/images/coins/hundred.png',
  ];
  final List _greencoinImages = [
    'assets/lucky7/images/coins/hundred1.png',
  ];
  final List _skybluecoinImages = [
    'assets/lucky7/images/coins/fifty.png',
  ];
  final List _browncoinImages = [
    'assets/lucky7/images/coins/ten.png',
  ];
  final Random _random = Random();

  final int _totalCoins = 7000;
  int _currentCoinIndexRytPort = 0;
  bool lightGreenCoinAnimation = false;
  bool blueCoinAnimation = false;
  bool greenCoinAnimation = false;
  bool lightBlueCoinAnimation = false;
  bool brownCoinAnimation = false;
  bool dragonButton = false;
  bool tieButton = false;
  bool tigerButton = false;
  bool pairButton = false;
  bool evenDragonButton = false;
  bool oddDragonButton = false;
  bool blackDragonButton = false;
  bool redDragonButton = false;
  bool evenTigerButton = false;
  bool oddTigerButton = false;
  bool blackTigerButton = false;
  bool redTigerButton = false;
  bool confirmButton = false;
  bool dragon = true;
  bool tiger = false;
  String dragonRate = " ";
  String tieRate = " ";
  String tigerRate = " ";
  String pairRate = " ";
  String evenDragonRate = " ";
  String oddDragonRate = " ";
  String blackDragonRate = " ";
  String redDragonRate = " ";
  String cardADragonRate = "";
  String card2DragonRate = "";
  String card3DragonRate = "";
  String card4DragonRate = "";
  String card5DragonRate = "";
  String card6DragonRate = "";
  String card7DragonRate = "";
  String card8DragonRate = "";
  String card9DragonRate = "";
  String card10DragonRate = "";
  String cardJDragonRate = "";
  String cardQDragonRate = "";
  String cardKDragonRate = "";
  String evenTigerRate = " ";
  String oddTigerRate = " ";
  String blackTigerRate = " ";
  String redTigerRate = " ";
  String cardATigerRate = "";
  String card2TigerRate = "";
  String card3TigerRate = "";
  String card4TigerRate = "";
  String card5TigerRate = "";
  String card6TigerRate = "";
  String card7TigerRate = "";
  String card8TigerRate = "";
  String card9TigerRate = "";
  String card10TigerRate = "";
  String cardJTigerRate = "";
  String cardQTigerRate = "";
  String cardKTigerRate = "";
  String dragonSid = " ";
  String tieSid = " ";
  String tigerSid = " ";
  String pairSid = " ";
  String evenSid = " ";
  String oddSid = " ";
  String blackSid = " ";
  String redSid = " ";
  String cardASid = "";
  String card2Sid = "";
  String card3Sid = "";
  String card4Sid = "";
  String card5Sid = "";
  String card6Sid = "";
  String card7Sid = "";
  String card8Sid = "";
  String card9Sid = "";
  String card10Sid = "";
  String cardJSid = "";
  String cardQSid = "";
  String cardKSid = "";
  String evenSidDragon = " ";
  String oddSidDragon = " ";
  String blackSidDragon = " ";
  String redSidDragon = " ";
  String cardASiDragon = "";
  String card2SidDragon = "";
  String card3SidDragon = "";
  String card4SidDragon = "";
  String card5SidDragon = "";
  String card6SidDragon = "";
  String card7SidDragon = "";
  String card8SidDragon = "";
  String card9SidDragon = "";
  late Timer _musicTimer;

  String card10SidDragon = "";
  String cardJSidDragon = "";
  String cardQSidDragon = "";
  String cardKSidDragon = "";
  String autoTime = "";
  String cardNameImage1 = "";
  String cardNameImage2 = "";
  String marketId = "";
  int startTimes = 0;
  String userBalance = "";
  String liablity = "";
  bool playBackgroundMusic = false;
  String iPAddress = "";
  List<DTResultModel> cardResultList = [];
  List<String> roundIdList = [];
  late AnimationController _controller1;
  late AnimationController _controller;
  late AnimationController _animationController;
  late Animation<double> _animation;
  final _player = AudioPlayer();
  final _cardPlayer = AudioPlayer();
  final stopBettingmusic = AudioPlayer();
  final startBettingmusic = AudioPlayer();
  final winnerBettingmusic = AudioPlayer();
  final onPressedmusic = AudioPlayer();
  var gameSound = "assets/lucky7/audio/bgm.mp3";
  final List _coinImagesRyt = [
    'assets/lucky7/images/coins/hundred.png',
    'assets/lucky7/images/coins/hundred1.png',
    'assets/lucky7/images/coins/ten.png',
    'assets/lucky7/images/coins/one.png',
    'assets/lucky7/images/coins/hundred.png',
    'assets/lucky7/images/coins/fifty.png',
    'assets/lucky7/images/coins/hundred1.png',
    'assets/lucky7/images/coins/ten.png',
    'assets/lucky7/images/coins/one.png',
    'assets/lucky7/images/coins/hundred.png',
    'assets/lucky7/images/coins/fifty.png',
    'assets/lucky7/images/coins/hundred1.png',
  ];

  final List _coinImages = [
    'assets/lucky7/images/coins/one.png',
    'assets/lucky7/images/coins/ten.png',
    'assets/lucky7/images/coins/one.png',
    'assets/lucky7/images/coins/hundred.png',
    'assets/lucky7/images/coins/fifty.png',
    'assets/lucky7/images/coins/hundred.png',
    'assets/lucky7/images/coins/hundred1.png',
    'assets/lucky7/images/coins/hundred.png',
    'assets/lucky7/images/coins/hundred1.png',

    // Add more image paths for each chip
  ];
  final List<Widget> _coinsRytPort = [];
  final List<Widget> _coinsRytLand = [];

  final List<Widget> _coinsLeftLandRand = [];
  final List<Widget> _coinsRytLandRand = [];
  final List<Widget> _coinsRytPortRand = [];
  final List<Widget> _coinsLeftPortRand = [];

  double _minXLeftLandRand = 0;
  double _maxXLeftLandRand = 0;
  double _minYLeftLandRand = 0;
  double _maxYLeftLandRand = 0;

  double _minXRytPortRand = 0;
  double _maxXRytPortRand = 0;
  double _minYRytPortRand = 0;
  double _maxYRytPortRand = 0;

  double _minXLeftPortRand = 0;
  double _maxXLeftPortRand = 0;
  double _minYLeftPortRand = 0;
  double _maxYLeftPortRand = 0;

  double _minXRytLandRand = 0;
  double _maxXRytLandRand = 0;
  double _minYRytLandRand = 0;
  double _maxYRytLandRand = 0;
       int startTimeSmall=0;

  @override
  void initState() {
      startTimeSmall=startTimes*100;
       Timer.periodic(const Duration(milliseconds: 10), (timer) {
        startTimeSmall =startTimeSmall-1;
       });
    AudioPlayer.clearAssetCache();
    WidgetsBinding.instance.addObserver(this);
    bgMusic();
    getuserBalance();
    getuserBalance();
    getStakeDetails();
    getDeviceIp();
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.landscapeLeft,
      DeviceOrientation.landscapeRight,
      DeviceOrientation.portraitUp
    ]);
    AudioPlayer.clearAssetCache();
    WidgetsBinding.instance.addObserver(this);
    setState(() {
      checkInternet();
    });
    _clockTimer = Timer.periodic(const Duration(seconds: 1), (timer) {
      getResult().then((value) => getCardData());
      stopBettingMusic();
      startBettingMusic();
      getMatchIdDetails();
    });
    _controller1 = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 2000), // Adjust the duration as needed
    );

    _animation = CurvedAnimation(parent: _controller1, curve: Curves.easeInOut);
    _controller1.repeat(reverse: true);

    _controller = AnimationController(
      duration: const Duration(seconds: 1),
      vsync: this,
    );

    super.initState();
  }

  Future<void> checkInternet() async {
    var connectivityResult = await Connectivity().checkConnectivity();
    if (connectivityResult == ConnectivityResult.none) {
      // No internet connection
      // Handle this situation as needed
      print('No internet connection');
    } else {
      // Internet connection is available
      _startCoinAnimationRytPortRand();
      _startCoinAnimationLeftPortRand();
      _startCoinAnimationLeftLandRand();
      _startCoinAnimationRytLandRand();
    }
  }

  ///left land random
  // void _startCoinAnimationLeftLandRand() {
  //   if (_currentCoinIndex >= _totalCoins) {
  //     return;
  //   }

  //   double radius = 200; // Radius of the circular path
  //   double angle = _currentCoinIndex * (pi / _totalCoins);

  //   double _startX = _minXLeftLandRand;
  //   double _startY = _minYLeftLandRand;
  //   double _endX =
  //       _random.nextDouble() * (_maxXLeftLandRand - _minXLeftLandRand) +
  //           _minXLeftLandRand;
  //   double _endY =
  //       _random.nextDouble() * (_maxYLeftLandRand - _minYLeftLandRand) +
  //           _minYLeftLandRand;

  //   // coin = int.parse(widget.autotime.toString());
  //   //   print("====>$coin");
  //   cardNameImage2 == ''
  //       ? _coinsLeftLandRand.add(TweenAnimationBuilder(
  //           tween: Tween<double>(begin: 0, end: 1),
  //           duration: const Duration(milliseconds: 600),
  //           builder: (BuildContext context, double value, Widget? child) {
  //             double currentX = _startX + (_endX - _startX) * value;
  //             double currentY = _startY + (_endY - _startY) * value;

  //             return Positioned(
  //                 left: currentX.clamp(_minXLeftLandRand, _maxXLeftLandRand),
  //                 top: currentY.clamp(_minYLeftLandRand, _maxYLeftLandRand),
  //                 child: startTimes > 1
  //                     ? Image.asset(
  //                         _coinImages[_currentCoinIndex % _coinImages.length],
  //                         height: 20,
  //                         width: 20,
  //                       )
  //                     : SizedBox());
  //           },
  //         ))
  //       : cardNameImage2 == ''
  //           ? _coinsLeftLandRand.clear()
  //           : "";
  //   _currentCoinIndex++;
  //   if (startTimes > 15) {
  //     Timer(Duration(seconds: 2), _startCoinAnimationLeftLandRand);
  //   } else {
  //     Timer(Duration(seconds: 3), _startCoinAnimationLeftLandRand);
  //   }

  //   autoTime != "0" && playBackgroundMusic == false ? onPressedMusic() : null;
  //   //  cardNameImage2 == ''
  //   //     ?_coinsLeftLandRand.clear() : null;
  // }

  ///ryt land random
  // void _startCoinAnimationRytPortRand() {
  //   if (_currentCoinIndex >= _totalCoins) {
  //     return;
  //   }

  //   double _startX = _minXRytPortRand;
  //   double _startY = _minYRytPortRand;
  //   double _endX =
  //       _random.nextDouble() * (_maxXRytPortRand - _minXRytPortRand) +
  //           _minXRytPortRand;
  //   double _endY =
  //       _random.nextDouble() * (_maxYRytPortRand - _minYRytPortRand) +
  //           _minYRytPortRand;

  //   cardNameImage2 == ""
  //       ? _coinsRytPortRand.add(TweenAnimationBuilder(

  //          tween: Tween(
  //           begin: Offset(0, 1),end:  Offset(_endX - _startX, _endY - _startY)),
  //           duration: const Duration(seconds: 2),
  //           builder: (BuildContext context, Offset value, Widget? child) {
  //             double currentX = _startX + (_endX - _startX) * value.dx;
  //             double currentY = _startY + (_endY - _startY) * value.dy;

  //             return Positioned(
  //                 right:_startX+ value.dx-10,
  //                 top:_startY+ value.dy-10,
  //                 child: startTimes > 3
  //                     ? Image.asset(
  //                         _coinImages[_currentCoinIndex % _coinImages.length],
  //                         height: 20,
  //                         width: 20,
  //                       )
  //                     : SizedBox());
  //           },
  //         ))

  //       :  _coinsRytPortRand.clear()
  //         ;

  //   _currentCoinIndex++;

  //   if (startTimes > 15) {
  //     Timer(Duration(seconds: 2), _startCoinAnimationRytPortRand);
  //   } else {
  //     Timer(Duration(seconds: 3), _startCoinAnimationRytPortRand);
  //   }

  //   autoTime != "0" && playBackgroundMusic == false ? onPressedMusic() : null;
  //   // cardNameImage2 == ''
  //   //     ?_coinsRytPortRand.clear() : null;
  // }

  void _startCoinAnimationRytPortRand() {
    if (_currentCoinIndex >= _totalCoins) {
      return;
    }
    double _endX =
        _random.nextDouble() * (_maxXRytPortRand - _minXRytPortRand) +
            _minXRytPortRand;
    double _endY =
        _random.nextDouble() * (_maxYRytPortRand - _minYRytPortRand) +
            _minYRytPortRand;
    _maxXRytPortRand = width - 900;
    _maxYRytPortRand = width - 850;

    cardNameImage2 == ""
        ? _coinsRytPortRand.add(
            TweenAnimationBuilder(
              duration: Duration(milliseconds: 900),
              tween: Tween(
                begin: Offset(0, 0),
                end: Offset(_endX - 40,
                    _endY - 108), // Adjust for the fixed starting point
              ),
              builder: (BuildContext context, Offset value, Widget? child) {
                return Positioned(
                  right: width * 0.1 + value.dx,
                  top: height * 0.1 + value.dy,
                  child: child!,
                );
              },
              child: startTimes > 3
                  ? Image.asset(
                      _coinImages[_currentCoinIndex % _coinImages.length],
                      height: 15,
                      width: 15,
                    )
                  : SizedBox(),
            ),
          )
        : _coinsRytPortRand.clear();
    _currentCoinIndex++;

    if (startTimes > 15) {
      Timer(Duration(seconds: 2), _startCoinAnimationRytPortRand);
    } else {
      Timer(Duration(seconds: 3), _startCoinAnimationRytPortRand);
    }

    startTimes > 3 && playBackgroundMusic == false
        ? onPressedMusicForBet()
        : null;
  }

  void _startCoinAnimationLeftPortRand() {
    if (_currentCoinIndex >= _totalCoins) {
      return;
    }

    double _endX =
        _random.nextDouble() * (_maxXLeftPortRand - _minXLeftPortRand) +
            _minXLeftPortRand;
    double _endY =
        _random.nextDouble() * (_maxYLeftPortRand - _minYLeftPortRand) +
            _minYLeftPortRand;
    _maxXLeftPortRand = width - 300;

    _maxYLeftPortRand = height - 870;

    cardNameImage2 == ""
        ? _coinsLeftPortRand.add(
            TweenAnimationBuilder(
              duration: Duration(milliseconds: 900),
              tween: Tween(
                begin: Offset(0, 0),
                end: Offset(_endX + 40,
                    _endY - 30), // Adjust for the fixed starting point
              ),
              builder: (BuildContext context, Offset value, Widget? child) {
                return Positioned(
                  left: width * 0.15 + value.dx,
                  bottom: height * 0.25 + value.dy,
                  child: child!,
                );
              },
              child: startTimes > 3
                  ? Image.asset(
                      _coinImages[_currentCoinIndex % _coinImages.length],
                      height: 15,
                      width: 15,
                    )
                  : SizedBox(),
            ),
          )
        : _coinsLeftPortRand.clear();
    _currentCoinIndex++;

    if (startTimes > 15) {
      Timer(Duration(seconds: 1), _startCoinAnimationLeftPortRand);
    } else {
      Timer(Duration(seconds: 2), _startCoinAnimationLeftPortRand);
    }
  }

  ///left port random
  // void _startCoinAnimationLeftPortRand() {
  //   if (_currentCoinIndex >= _totalCoins) {
  //     return;
  //   }

  //   double radius = 200; // Radius of the circular path
  //   double angle = _currentCoinIndex * (pi / _totalCoins);

  //   double _startX = _minXLeftPortRand;
  //   double _startY = _minYLeftPortRand;
  //   double _endX =
  //       _random.nextDouble() * (_maxXLeftPortRand - _minXLeftPortRand) +
  //           _minXLeftPortRand;
  //   double _endY =
  //       _random.nextDouble() * (_maxYLeftPortRand - _minYLeftPortRand) +
  //           _minYLeftPortRand;

  //   cardNameImage2 == ""
  //       ? _coinsLeftPortRand.add(TweenAnimationBuilder(
  //           tween: Tween<double>(begin: 0, end: 1),
  //           duration: const Duration(milliseconds: 900),
  //           builder: (BuildContext context, double value, Widget? child) {
  //             double currentX = _startX + (_endX - _startX) * value;
  //             double currentY = _startY + (_endY - _startY) * value;

  //             return Positioned(
  //                 left: currentX.clamp(_minXLeftPortRand, _maxXLeftPortRand),
  //                 top: currentY.clamp(_minYLeftPortRand, _maxYLeftPortRand),
  //                 child: startTimes > 1
  //                     ? Image.asset(
  //                         _coinImages[_currentCoinIndex % _coinImages.length],
  //                         height: 20,
  //                         width: 20,
  //                       )
  //                     : SizedBox());
  //           },
  //         ))
  //       : _coinsLeftPortRand.clear()
  //         ;

  //   _currentCoinIndex++;

  //   if (startTimes > 15) {
  //     Timer(Duration(seconds: 3), _startCoinAnimationLeftPortRand);
  //   } else {
  //     Timer(Duration(seconds: 1), _startCoinAnimationLeftPortRand);
  //   }
  // }

  void _startCoinAnimationRytLandRand() {
    if (_currentCoinIndex >= _totalCoins) {
      return;
    }

    double _endX =
        _random.nextDouble() * (_maxXRytLandRand - _minXRytLandRand) +
            _minXRytLandRand;
    double _endY =
        _random.nextDouble() * (_maxYRytLandRand - _minYRytLandRand) +
            _minYRytLandRand;
    _maxXRytLandRand = MediaQuery.of(context).size.width - 740;

    _maxYRytLandRand = MediaQuery.of(context).size.width - 890;

    cardNameImage2 == ""
        ? _coinsRytLandRand.add(
            TweenAnimationBuilder(
              duration: Duration(milliseconds: 900),
              tween: Tween(
                begin: Offset(0, 0),
                end: Offset(_endX + 60,
                    _endY - 60), // Adjust for the fixed starting point
              ),
              builder: (BuildContext context, Offset value, Widget? child) {
                return Positioned(
                  right: width * 0.3 + value.dx,
                  bottom: height * 0.55 + value.dy,
                  child: child!,
                );
              },
              child: startTimes > 3
                  ? Image.asset(
                      _coinImagesRyt[_currentCoinIndex % _coinImagesRyt.length],
                      height: 15,
                      width: 15,
                    )
                  : SizedBox(),
            ),
          )
        : _coinsRytLandRand.clear();
    _currentCoinIndex++;

    if (startTimes > 15) {
      Timer(Duration(seconds: 3), _startCoinAnimationRytLandRand);
    } else {
      Timer(Duration(seconds: 1), _startCoinAnimationRytLandRand);
    }

    startTimes > 3 && playBackgroundMusic == false
        ? onPressedMusicForBet()
        : null;
  }

  void _startCoinAnimationLeftLandRand() {
    if (_currentCoinIndex >= _totalCoins) {
      return;
    }

    double _endX =
        _random.nextDouble() * (_maxXLeftLandRand - _minXLeftLandRand) +
            _minXLeftLandRand;
    double _endY =
        _random.nextDouble() * (_maxYLeftLandRand - _minYLeftLandRand) +
            _minYLeftLandRand;
    _maxXLeftLandRand = MediaQuery.of(context).size.width - 740;

    _maxYLeftLandRand = MediaQuery.of(context).size.width - 890;

    cardNameImage2 == ""
        ? _coinsLeftLandRand.add(
            TweenAnimationBuilder(
              duration: Duration(milliseconds: 900),
              tween: Tween(
                begin: Offset(0, 0),
                end: Offset(_endX + 60,
                    _endY - 45), // Adjust for the fixed starting point
              ),
              builder: (BuildContext context, Offset value, Widget? child) {
                return Positioned(
                  left: width * 0.3 + value.dx,
                  bottom: height * 0.55 + value.dy,
                  child: child!,
                );
              },
              child: startTimes > 3
                  ? Image.asset(
                      _coinImages[_currentCoinIndex % _coinImages.length],
                      height: 15,
                      width: 15,
                    )
                  : SizedBox(),
            ),
          )
        : _coinsLeftLandRand.clear();
    _currentCoinIndex++;

    if (startTimes > 15) {
      Timer(Duration(seconds: 2), _startCoinAnimationLeftLandRand);
    } else {
      Timer(Duration(seconds: 3), _startCoinAnimationLeftLandRand);
    }
  }

  ///ryt port random
  // void _startCoinAnimationRytLandRand() {
  //   if (_currentCoinIndex >= _totalCoins) {
  //     return;
  //   }

  //   double radius = 100; // Radius of the circular path
  //   double angle = _currentCoinIndex * (pi / _totalCoins);

  //   double _startX = _minXRytLandRand;
  //   double _startY = _minYRytLandRand;
  //   double _endX =
  //       _random.nextDouble() * (_maxXRytLandRand - _minXRytLandRand) +
  //           _minXRytLandRand;
  //   double _endY =
  //       _random.nextDouble() * (_maxYRytLandRand - _minYRytLandRand) +
  //           _minYRytLandRand;

  //   cardNameImage2 == ""
  //       ? _coinsRytLandRand.add(TweenAnimationBuilder(
  //           tween: Tween<double>(begin: 0, end: 1),
  //           duration: const Duration(milliseconds: 600),
  //           builder: (BuildContext context, double value, Widget? child) {
  //             double currentX = _startX + (_endX - _startX) * value;
  //             double currentY = _startY + (_endY - _startY) * value;

  //             return Positioned(
  //                 right: currentX.clamp(_minXRytLandRand, _maxXRytLandRand),
  //                 top: currentY.clamp(_minYRytLandRand, _maxYRytLandRand),
  //                 child: startTimes > 1
  //                     ? Image.asset(
  //                         _coinImagesRyt[
  //                             _currentCoinIndex % _coinImagesRyt.length],
  //                         height: 20,
  //                         width: 20,
  //                       )
  //                     : SizedBox());
  //           },
  //         ))
  //       : cardNameImage2 == ''
  //           ? _coinsRytLandRand.clear()
  //           : "";

  //   _currentCoinIndex++;

  //   if (startTimes > 15) {
  //     Timer(Duration(seconds: 3), _startCoinAnimationRytLandRand);
  //   } else {
  //     Timer(Duration(seconds: 1), _startCoinAnimationRytLandRand);
  //   }
  // }

  void _startCoinAnimationRightPort() {
    if (_currentCoinIndexRytPort >= _totalCoins) {
      return;
    }

    double _startX = _minYRytPort;
    double _startY = _minXRytPort;
    double _endX =
        _random.nextDouble() * (_maxXRytPort - _minXRytPort) + _minXRytPort;
    double _endY =
        _random.nextDouble() * (_maxYRytPort - _minYRytPort) + _minYRytPort;

    startTimes > 3
        ? _coinsRytPort.add(TweenAnimationBuilder(
            tween: Tween<double>(begin: 0, end: 1),
            duration: const Duration(milliseconds: 600),
            builder: (BuildContext context, double value, Widget? child) {
              double currentX = _startX + (_endX - _startX) * value;
              double currentY = _startY + (_endY - _startY) * value;

              return Positioned(
                  right: currentX.clamp(_minXRytPort, _maxXRytPort),
                  bottom: currentY.clamp(_minYRytPort, _maxYRytPort),
                  child: startTimes > 3
                      ? redCoinAnimation == true
                          ? Image.asset(
                              _redcoinImages[_currentCoinIndexRytPort %
                                  _redcoinImages.length],
                              height: 15,
                              width: 15,
                            )
                          : lightGreenCoinAnimation == true
                              ? Image.asset(
                                  _lightGreencoinImages[
                                      _currentCoinIndexRytPort %
                                          _lightGreencoinImages.length],
                                  height: 15,
                                  width: 15,
                                )
                              : blueCoinAnimation == true
                                  ? Image.asset(
                                      _bluecoinImages[_currentCoinIndexRytPort %
                                          _bluecoinImages.length],
                                      height: 15,
                                      width: 15,
                                    )
                                  : greenCoinAnimation == true
                                      ? Image.asset(
                                          _greencoinImages[
                                              _currentCoinIndexRytPort %
                                                  _greencoinImages.length],
                                          height: 15,
                                          width: 15,
                                        )
                                      : lightBlueCoinAnimation == true
                                          ? Image.asset(
                                              _skybluecoinImages[
                                                  _currentCoinIndexRytPort %
                                                      _skybluecoinImages
                                                          .length],
                                              height: 15,
                                              width: 15,
                                            )
                                          : brownCoinAnimation == true
                                              ? Image.asset(
                                                  _browncoinImages[
                                                      _currentCoinIndexRytPort %
                                                          _browncoinImages
                                                              .length],
                                                  height: 15,
                                                  width: 15,
                                                )
                                              : SizedBox()
                      : SizedBox());
            },
          ))
        : cardNameImage2 == ''
            ? _coinsRytPort.reversed
            : "";

    startTimes > 3 && playBackgroundMusic == false
        ? onPressedMusicForBet()
        : null;
  }

  void _startCoinAnimation() {
    if (_currentCoinIndex >= _totalCoins) {
      return;
    }

    double _startX = _minX;
    double _startY = _minY;
    double _endX = _random.nextDouble() * (_maxX - _minX) + _minX;
    double _endY = _random.nextDouble() * (_maxY - _minY) + _minY;

    startTimes > 3
        ? _coinsRytLand.add(TweenAnimationBuilder(
            tween: Tween<double>(begin: 0, end: 1),
            duration: const Duration(milliseconds: 600),
            builder: (BuildContext context, double value, Widget? child) {
              double currentX = _startX + (_endX - _startX) * value;
              double currentY = _startY + (_endY - _startY) * value;

              return Positioned(
                  right: currentX.clamp(_minX, _maxX),
                  bottom: currentY.clamp(_minY, _maxY),
                  child: startTimes > 3
                      ? redCoinAnimation == true
                          ? Image.asset(
                              _redcoinImages[
                                  _currentCoinIndex % _redcoinImages.length],
                              height: 15,
                              width: 15,
                            )
                          : lightGreenCoinAnimation == true
                              ? Image.asset(
                                  _lightGreencoinImages[_currentCoinIndex %
                                      _lightGreencoinImages.length],
                                  height: 15,
                                  width: 15,
                                )
                              : blueCoinAnimation == true
                                  ? Image.asset(
                                      _bluecoinImages[_currentCoinIndex %
                                          _bluecoinImages.length],
                                      height: 15,
                                      width: 15,
                                    )
                                  : greenCoinAnimation == true
                                      ? Image.asset(
                                          _greencoinImages[_currentCoinIndex %
                                              _greencoinImages.length],
                                          height: 15,
                                          width: 15,
                                        )
                                      : lightBlueCoinAnimation == true
                                          ? Image.asset(
                                              _skybluecoinImages[
                                                  _currentCoinIndex %
                                                      _skybluecoinImages
                                                          .length],
                                              height: 15,
                                              width: 15,
                                            )
                                          : brownCoinAnimation == true
                                              ? Image.asset(
                                                  _browncoinImages[
                                                      _currentCoinIndex %
                                                          _browncoinImages
                                                              .length],
                                                  height: 15,
                                                  width: 15,
                                                )
                                              : SizedBox()
                      : SizedBox());
            },
          ))
        : cardNameImage2 == ''
            ? _coinsRytLand.clear()
            : "";

    startTimes > 3 && playBackgroundMusic == false
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
    cardNameImage1 != ""
        ? winnerBettingmusic.play()
        : winnerBettingmusic.stop();
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
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.paused) {
      playBackgroundMusic = true;
      _player.pause();
    } else if (state == AppLifecycleState.resumed) {
      //  _player.play();
    }
  }

  @override
  void dispose() {
    _clockTimer.cancel();
    _player.dispose();
    WidgetsBinding.instance.removeObserver(this);
    startBettingmusic.dispose();
    stopBettingmusic.dispose();
    _musicTimer.cancel();
    _cardPlayer.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final oreintation = MediaQuery.of(context).orientation;
    height = MediaQuery.of(context).size.height;
    width = MediaQuery.of(context).size.width;
    // _minXRytLandRand = 270;
    // _maxXRytLandRand = width - 405;
    //  _minYRytLandRand = 200;
    // _maxYRytLandRand = height - 100;
    //   _minXLeftLandRand = 270;
    // _maxXLeftLandRand = width - 405;
    // _minYLeftLandRand = 200;
    // _maxYLeftLandRand = height - 100;
    // _minXLeftPortRand = 80;
    // _maxXLeftPortRand = width - 190;
    // _minYLeftPortRand = 90;
    // _maxYLeftPortRand = height - 610;
    _minXRytPortRand = 60;
    _maxXRytPortRand = width - 210;
    _minYRytPortRand = 90;
    _maxYRytPortRand = height - 610;

    _minXRytPort = 80;
    _maxXRytPort = width - 200;
    _minYRytPort = 85;
    _maxYRytPort = height - 580;
    _minX = 300;
    _maxX = width - 450;
    _minY = 160;
    _maxY = height - 240;
    return WillPopScope(
      onWillPop: () {
        return Future.value(true);
      },
      child: OrientationBuilder(builder: (context, orientation) {
        print(orientation);

        if (orientation == Orientation.landscape) {
          return landscapeWidget();
        } else {
          return protraitModeWidget();
        }
      }),
    );
  }

  Widget landscapeWidget() {
    return Scaffold(
      key: _globalKey,
      backgroundColor: Colors.transparent,
      drawerEnableOpenDragGesture: false,
      drawer: SizedBox(
        width: width * 0.3,
        child: Drawer(
          child: drawerWidget(),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
                height: height,
                decoration: BoxDecoration(
                    image: DecorationImage(
                        image: AssetImage(DragonTigerImages.landBg),
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
                                child: Image.asset(DragonTigerImages.menu,
                                    fit: BoxFit.fill, width: width * 0.05),
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
                                            DragonTigerImages.amountBg),
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
                              setState(() {
                                playBackgroundMusic == false
                                    ? onPressedMusic()
                                    : Vibration.vibrate();
                              });

                              Navigator.push(
                                  context, _createRouteCurrentBetsList());
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
                                        DragonTigerImages.mybet,
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
                            height: 3,
                          ),
                          BlinkText(
                            "Round ID : $marketId",
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                    ),
                    Positioned(
                      top: height * 0.1,
                      child: Image.asset(
                        DragonTigerImages.girl,
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
                                          height: 6,
                                          width: width * 0.15,
                                          child: LinearProgressIndicator(
                                  value:
                                     startTimeSmall/4500, // Calculate the progress
                                  backgroundColor: Colors.grey,
                                  valueColor:
                                      AlwaysStoppedAnimation(Color(0xaa9919D2)),
                                  
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
                                          DragonTigerImages.musicOn,
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
                                          DragonTigerImages.musicOff,
                                          fit: BoxFit.fill,
                                          width: width * 0.045),
                                    ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    Positioned(
                      bottom: height * 0.00,
                      child: Image.asset(
                        DragonTigerImages.tableLand,
                        fit: BoxFit.fill,
                        height: height * 0.61,
                      ),
                    ),
                    Positioned(
                      top: height * 0.38,
                      left: width * 0.28,
                      child:  Image.asset(
                              'assets/lucky7/images/frame/logo.png',
                              fit: BoxFit.cover,
                              height: height * 0.10,
                            ),
                    ),
                    Positioned(
                      top: height * 0.38,
                      right: width * 0.28,
                      child: Image.asset(
                              'assets/lucky7/images/frame/logo.png',
                              fit: BoxFit.cover,
                              height: height * 0.10,
                            ),
                    ),
                    AnimatedSwitcher(
                      duration: Duration(milliseconds: 500),
                      child: Stack(
                        children: _coinsRytLand,
                      ),
                    ),
                    AnimatedSwitcher(
                      duration: Duration(milliseconds: 500),
                      child: Stack(
                        children: _coinsLeftLandRand,
                      ),
                    ),
                    AnimatedSwitcher(
                      duration: Duration(milliseconds: 500),
                      child: Stack(
                        children: _coinsRytLandRand,
                      ),
                    ),
                    autoTime == "45"
                        ? placeyourbetWidget(autoTime)
                        : autoTime == "3" || autoTime == "2" || autoTime == "1"
                            ? goWidget()
                            : autoTime != "0"
                                ? SizedBox()
                                : Positioned(
                                    top: height * 0.36,
                                    right: width * 0.35,
                                    child: showCurrentCardLand()),
                    startTimes <= 3 && autoTime != '0'
                        ? gameStopBetting(autoTime)
                        : SizedBox(),
                    Positioned(
                      bottom: height * 0.01,
                      left: width * 0.31,
                      child: Row(
                        children: [
                          InkWell(
                            onTap: () {
                              setState(() {
                                playBackgroundMusic == false
                                    ? ''
                                    : Vibration.vibrate();
                              });
                              setState(() {
                                redCoinAnimation = true;
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
                              });
                              setState(() {
                                lightGreenCoinAnimation = true;
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
                              });
                              setState(() {
                                redCoinAnimation = false;
                                lightGreenCoinAnimation = false;
                                blueCoinAnimation = true;
                                greenCoinAnimation = false;
                                lightBlueCoinAnimation = false;
                                brownCoinAnimation = false;
                              });
                            },
                            child: AnimatedContainer(
                              duration: Duration(milliseconds: 700),
                              alignment: Alignment.center,
                              height:
                                  blueCoinAnimation == true && startTimes > 1
                                      ? height * 0.15
                                      : height * 0.11,
                              width: blueCoinAnimation == true && startTimes > 1
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
                              });
                              setState(() {
                                redCoinAnimation = false;
                                lightGreenCoinAnimation = false;
                                blueCoinAnimation = false;
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
                                    fontWeight: FontWeight.bold, fontSize: 10),
                              ),
                            ),
                          ),
                          //                   SizedBox(
                          //                     width: width * 0.02,
                          //                   ),
                          //                   InkWell(
                          //                     onTap: () {
                          //
                          //  Vibration.vibrate();
                          //                       setState(() {
                          //                         redCoinAnimation = false;
                          //                         lightGreenCoinAnimation = false;
                          //                         blueCoinAnimation = false;
                          //                         greenCoinAnimation = false;
                          //                         lightBlueCoinAnimation = true;
                          //                         brownCoinAnimation = false;
                          //                       });
                          //                     },
                          //                     child: AnimatedContainer(
                          //                       duration: Duration(milliseconds: 700),
                          //                       alignment: Alignment.center,
                          //                       height: lightBlueCoinAnimation == true &&
                          //                               startTimes > 1
                          //                           ? height * 0.15
                          //                           : height * 0.11,
                          //                       width: lightBlueCoinAnimation == true &&
                          //                               startTimes > 1
                          //                           ? width * 0.08
                          //                           : width * 0.06,
                          //                       decoration: BoxDecoration(
                          //                           image: DecorationImage(
                          //                         image: AssetImage(
                          //                             "assets/lucky7/images/coins/blue.png"),
                          //                         fit: BoxFit.fill,
                          //                       )),
                          //                       child: Text(
                          //                         stack4 != 0 ? "10K" : stack5.toString(),
                          //                         style: TextStyle(
                          //                             fontWeight: FontWeight.bold, fontSize: 10),
                          //                       ),
                          //                     ),
                          //                   ),

                          SizedBox(
                            width: width * 0.03,
                          ),
                          InkWell(
                            onTap: () {
                              setState(() {
                                setState(() {
                                  playBackgroundMusic == false
                                      ? ''
                                      : Vibration.vibrate();
                                });
                                redCoinAnimation = false;
                                lightGreenCoinAnimation = false;
                                blueCoinAnimation = false;
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
                                stack5 != 0 ? "20K" : stack6.toString(),
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
                      top: height * 0.16,
                      right: width * 0.02,
                      child: Container(
                        height: height * 0.65,
                        width: width * 0.04,
                        padding: EdgeInsets.all(1),
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                            image: DecorationImage(
                          image: AssetImage(DragonTigerImages.buttonBgLand),
                          fit: BoxFit.cover,
                        )),
                        child: ListView.builder(
                            shrinkWrap: true,
                            physics: BouncingScrollPhysics(),
                            itemCount: cardResultList.length,
                            scrollDirection: Axis.vertical,
                            itemBuilder: (context, index) {
                              var item = cardResultList[index];

                              return InkWell(
                                onTap: () {
                                  setState(() {
                                    playBackgroundMusic == false
                                        ? onPressedMusic()
                                        : Vibration.vibrate();
                                  });
                                  showResultDTLand(
                                      context,
                                      item.c1,
                                      item.c2,
                                      item.winnerDetail,
                                      item.dragonDetail,
                                      item.tigerDetail,
                                      item.mid);
                                },
                                child: Container(
                                  margin: EdgeInsets.all(1),
                                  padding: EdgeInsets.all(2),
                                  alignment: Alignment.center,
                                  decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: item.winner == "1"
                                          ? ColorConstants.skyBlueColor
                                          : item.winner == "2"
                                              ? ColorConstants.pinkColor
                                              : ColorConstants.lightGreenColor),
                                  child: Text(
                                    item.winner == "1"
                                        ? "D"
                                        : item.winner == "2"
                                            ? "T"
                                            : "T",
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
                      bottom: height * 0.16,
                      left: width * 0.08,
                      child: Row(
                        children: [
                          Container(
                            padding: EdgeInsets.only(
                                left: width * 0.045, right: width * 0.02),
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                                image: DecorationImage(
                                    image: AssetImage(DragonTigerImages.exp))),
                            height: height * 0.09,
                            //    width: width * 0.1,
                            child: CustomText(
                                text: liablity.toString(),
                                color: Color(0xffFFEFC1),
                                fontSize: height * 0.025,
                                fontWeight: FontWeight.w500),
                          ),
                        ],
                      ),
                    ),
                  ],
                )),
            Container(
              padding: EdgeInsets.symmetric(
                  horizontal: width * 0.02, vertical: height * 0.03),
              decoration: BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage(DragonTigerImages.buttonBg),
                      fit: BoxFit.cover)),
              height: height * 0.6,
              width: width,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    // crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: height * 0.03),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Column(
                            children: [
                              InkWell(
                                onTap: () {
                                  setState(() {
                                    playBackgroundMusic == false
                                        ? ''
                                        : Vibration.vibrate();
                                  });
                                  dragonButton = true;
                                  tieButton = false;
                                  tigerButton = false;
                                  pairButton = false;
                                  evenDragonButton = false;
                                  oddDragonButton = false;
                                  blackDragonButton = false;
                                  redDragonButton = false;
                                  evenTigerButton = false;
                                  oddTigerButton = false;
                                  blackTigerButton = false;
                                  redTigerButton = false;
                                  if ((redCoinAnimation == true ||
                                          lightGreenCoinAnimation == true ||
                                          blueCoinAnimation == true ||
                                          greenCoinAnimation == true ||
                                          lightBlueCoinAnimation == true ||
                                          brownCoinAnimation == true) &&
                                      startTimes > 1) {
                                    showMyDialog(
                                      context,
                              height * 0.45,
                              width * 0.33,
                              height * 0.4,
                              width * 0.7,
                              height * 0.64,
                              width * 0.55,redCoinAnimation == true
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
                                },
                                child: CustomImage(
                                  color: Color(0xff913DDC),
                                  text: dragonRate,
                                  image: 'DRAGON',
                                  sizedWidth: width * 0.04,
                                ),
                              ),
                              SizedBox(
                                height: height * 0.005,
                              ),
                              Text(
                                  confirmButton == true && startTimes > 1
                                      ? liablity1.toString()
                                      : "",
                                  style: liablity1 > 0.0
                                      ? TextStyle(
                                          color: Color(
                                            0xff24BC0B,
                                          ),
                                          fontSize: 12,
                                          fontWeight: FontWeight.w500)
                                      : TextStyle(
                                          color: Color(0xffFE2121),
                                          fontSize: 12,
                                          fontWeight: FontWeight.w500)),
                            ],
                          ),
                          SizedBox(
                            width: width * 0.01,
                          ),
                          Column(
                            children: [
                              InkWell(
                                onTap: () {
                                  setState(() {
                                    playBackgroundMusic == false
                                        ? ''
                                        : Vibration.vibrate();
                                  });
                                  dragonButton = false;
                                  tieButton = true;
                                  tigerButton = false;
                                  pairButton = false;
                                  evenDragonButton = false;
                                  oddDragonButton = false;
                                  blackDragonButton = false;
                                  redDragonButton = false;
                                  evenTigerButton = false;
                                  oddTigerButton = false;
                                  blackTigerButton = false;
                                  redTigerButton = false;
                                  if ((redCoinAnimation == true ||
                                          lightGreenCoinAnimation == true ||
                                          blueCoinAnimation == true ||
                                          greenCoinAnimation == true ||
                                          lightBlueCoinAnimation == true ||
                                          brownCoinAnimation == true) &&
                                      startTimes > 1) {
                                    showMyDialog(context,
                              height * 0.45,
                              width * 0.33,
                              height * 0.4,
                              width * 0.7,
                              height * 0.64,
                              width * 0.55,redCoinAnimation == true
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
                                },
                                child: CustomImage(
                                    color: Color(0xff913DDC),
                                    text: tieRate,
                                    image: 'TIE',
                                    sizedWidth: width * 0.02),
                              ),
                              SizedBox(
                                height: height * 0.005,
                              ),
                              Text(
                                  confirmButton == true && startTimes > 1
                                      ? liablity2.toString()
                                      : "",
                                  style: liablity2 > 0.0
                                      ? TextStyle(
                                          color: Color(
                                            0xff24BC0B,
                                          ),
                                          fontSize: 12,
                                          fontWeight: FontWeight.w500)
                                      : TextStyle(
                                          color: Color(0xffFE2121),
                                          fontSize: 12,
                                          fontWeight: FontWeight.w500)),
                            ],
                          ),
                          SizedBox(
                            width: width * 0.008,
                          ),
                          Container(
                            height: height * 0.1,
                            width: width * 0.02,
                            decoration: BoxDecoration(
                                image: DecorationImage(
                                    image: AssetImage(
                                        DragonTigerImages.dividerLand))),
                          ),
                          SizedBox(
                            width: width * 0.008,
                          ),
                          Column(
                            children: [
                              InkWell(
                                onTap: () {
                                  setState(() {
                                    playBackgroundMusic == false
                                        ? ''
                                        : Vibration.vibrate();
                                  });
                                  dragonButton = false;
                                  tieButton = false;
                                  tigerButton = true;
                                  pairButton = false;
                                  evenDragonButton = false;
                                  oddDragonButton = false;
                                  blackDragonButton = false;
                                  redDragonButton = false;
                                  evenTigerButton = false;
                                  oddTigerButton = false;
                                  blackTigerButton = false;
                                  redTigerButton = false;
                                  if ((redCoinAnimation == true ||
                                          lightGreenCoinAnimation == true ||
                                          blueCoinAnimation == true ||
                                          greenCoinAnimation == true ||
                                          lightBlueCoinAnimation == true ||
                                          brownCoinAnimation == true) &&
                                      startTimes > 1) {
                                    showMyDialog(context,
                              height * 0.45,
                              width * 0.33,
                              height * 0.4,
                              width * 0.7,
                              height * 0.64,
                              width * 0.55,redCoinAnimation == true
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
                                },
                                child: CustomImage(
                                  color: Color(0xff913DDC),
                                  text: tigerRate,
                                  image: 'TIGER',
                                  sizedWidth: width * 0.04,
                                ),
                              ),
                              SizedBox(
                                height: height * 0.005,
                              ),
                              Text(
                                  confirmButton == true && startTimes > 1
                                      ? liablity3.toString()
                                      : "",
                                  style: liablity3 > 0.0
                                      ? TextStyle(
                                          color: Color(
                                            0xff24BC0B,
                                          ),
                                          fontSize: 12,
                                          fontWeight: FontWeight.w500)
                                      : TextStyle(
                                          color: Color(0xffFE2121),
                                          fontSize: 12,
                                          fontWeight: FontWeight.w500)),
                            ],
                          ),
                          SizedBox(
                            width: width * 0.01,
                          ),
                          Column(
                            children: [
                              InkWell(
                                onTap: () {
                                  setState(() {
                                    playBackgroundMusic == false
                                        ? ''
                                        : Vibration.vibrate();
                                  });
                                  dragonButton = false;
                                  tieButton = false;
                                  tigerButton = false;
                                  pairButton = true;
                                  evenDragonButton = false;
                                  oddDragonButton = false;
                                  blackDragonButton = false;
                                  redDragonButton = false;
                                  evenTigerButton = false;
                                  oddTigerButton = false;
                                  blackTigerButton = false;
                                  redTigerButton = false;
                                  if ((redCoinAnimation == true ||
                                          lightGreenCoinAnimation == true ||
                                          blueCoinAnimation == true ||
                                          greenCoinAnimation == true ||
                                          lightBlueCoinAnimation == true ||
                                          brownCoinAnimation == true) &&
                                      startTimes > 1) {
                                    showMyDialog(context,
                              height * 0.45,
                              width * 0.33,
                              height * 0.4,
                              width * 0.7,
                              height * 0.64,
                              width * 0.55,redCoinAnimation == true
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
                                },
                                child: CustomImage(
                                    color: Color(0xff913DDC),
                                    text: pairRate,
                                    image: 'PAIR',
                                    sizedWidth: width * 0.02),
                              ),
                              SizedBox(
                                height: height * 0.005,
                              ),
                              Text(
                                  confirmButton == true && startTimes > 1
                                      ? liablity4.toString()
                                      : "",
                                  style: liablity4 > 0.0
                                      ? TextStyle(
                                          color: Color(
                                            0xff24BC0B,
                                          ),
                                          fontSize: 12,
                                          fontWeight: FontWeight.w500)
                                      : TextStyle(
                                          color: Color(0xffFE2121),
                                          fontSize: 12,
                                          fontWeight: FontWeight.w500)),
                            ],
                          ),
                        ],
                      ),
                      Container(
                        height: height * 0.1,
                        width: width * 0.5,
                        decoration: BoxDecoration(
                            image: DecorationImage(
                                image: AssetImage(DragonTigerImages.divider))),
                      ),
                      // Center(
                      //   child: Text(
                      //     "Cards 12.00",
                      //     style: TextStyle(color: Colors.white),
                      //   ),
                      // ),
                      // Container(
                      //     alignment: Alignment.center,
                      //     height: height * 0.2,
                      //     width: width * 0.5,
                      //     child: ListView.builder(
                      //         physics: NeverScrollableScrollPhysics(),
                      //         scrollDirection: Axis.horizontal,
                      //         itemCount: 13,
                      //         itemBuilder: (context, index) {
                      //           return InkWell(
                      //             onTap: () {
                      //                Vibration.vibrate();
                      //               setState(() {
                      //                 cardIndex = index;
                      //                 selectCard = true;
                      //               });
                      //               if (redCoinAnimation == true ||
                      //                   lightGreenCoinAnimation == true ||
                      //                   blueCoinAnimation == true ||
                      //                   greenCoinAnimation == true ||
                      //                   lightBlueCoinAnimation == true ||
                      //                   brownCoinAnimation == true) {
                      //                 showMyDialog(redCoinAnimation == true
                      //                     ? stack1
                      //                     : lightGreenCoinAnimation == true
                      //                         ? stack2
                      //                         : blueCoinAnimation == true
                      //                             ? stack3
                      //                             : greenCoinAnimation == true
                      //                                 ? stack4
                      //                                 : lightBlueCoinAnimation ==
                      //                                         true
                      //                                     ? stack5
                      //                                     : brownCoinAnimation ==
                      //                                             true
                      //                                         ? stack6
                      //                                         : 0);
                      //               }
                      //             },
                      //             child: Container(
                      //               height: height * 0.12,
                      //               width: width * 0.05,
                      //               decoration: BoxDecoration(
                      //                   image: DecorationImage(
                      //                       image: AssetImage(
                      //                           "assets/AmarAkhbarAnthony/Images/card-image.png"))),
                      //             ),
                      //           );
                      //         }))
                    ],
                  ),
                  Container(
                    margin: EdgeInsets.symmetric(horizontal: width * 0.01),
                    height: height * 0.5,
                    width: width * 0.01,
                    decoration: BoxDecoration(
                        image: DecorationImage(
                            image: AssetImage(DragonTigerImages.dividerLand))),
                  ),
                  Column(
                    children: [
                      SizedBox(
                        height: height * 0.03,
                      ),
                      Row(
                        children: [
                          InkWell(
                            onTap: () {
                              setState(() {
                                playBackgroundMusic == false
                                    ? ''
                                    : Vibration.vibrate();
                              });
                              setState(() {
                                dragon = true;
                                tiger = false;
                              });
                            },
                            child: Column(
                              children: [
                                CustomText(
                                  text: 'DRAGON',
                                  color: tiger == true
                                      ? Colors.white
                                      : Color.fromARGB(255, 222, 194, 241),
                                  fontSize: 14,
                                  fontWeight: FontWeight.w700,
                                ),
                                tiger == true
                                    ? SizedBox()
                                    : Container(
                                        height: height * 0.005,
                                        width: width * 0.09,
                                        decoration: BoxDecoration(
                                            color: Color(0xff6910A2)),
                                      ),
                              ],
                            ),
                          ),
                          SizedBox(
                            width: width * 0.02,
                          ),
                          InkWell(
                            onTap: () {
                              setState(() {
                                playBackgroundMusic == false
                                    ? ''
                                    : Vibration.vibrate();
                              });

                              setState(() {
                                dragon = true;
                                tiger = true;
                              });
                            },
                            child: Column(
                              children: [
                                CustomText(
                                  text: 'TIGER',
                                  color: tiger == true
                                      ? Color.fromARGB(255, 222, 194, 241)
                                      : Colors.white,
                                  fontSize: 14,
                                  fontWeight: FontWeight.w700,
                                ),
                                tiger == true
                                    ? Container(
                                        height: height * 0.005,
                                        width: width * 0.06,
                                        decoration: BoxDecoration(
                                            color: Color(0xff6910A2)),
                                      )
                                    : SizedBox()
                              ],
                            ),
                          )
                        ],
                      ),
                      SizedBox(
                        height: height * 0.06,
                      ),
                      Row(
                        children: [
                          Column(
                            children: [
                              InkWell(
                                onTap: () {
                                  setState(() {
                                    playBackgroundMusic == false
                                        ? ''
                                        : Vibration.vibrate();
                                  });
                                  dragonButton = false;
                                  tieButton = false;
                                  tigerButton = false;
                                  pairButton = false;
                                  tiger == true
                                      ? evenTigerButton = true
                                      : evenDragonButton = true;
                                  oddDragonButton = false;
                                  blackDragonButton = false;
                                  redDragonButton = false;

                                  oddTigerButton = false;
                                  blackTigerButton = false;
                                  redTigerButton = false;
                                  if ((redCoinAnimation == true ||
                                          lightGreenCoinAnimation == true ||
                                          blueCoinAnimation == true ||
                                          greenCoinAnimation == true ||
                                          lightBlueCoinAnimation == true ||
                                          brownCoinAnimation == true) &&
                                      startTimes > 1) {
                                    showMyDialog(context,
                              height * 0.45,
                              width * 0.33,
                              height * 0.4,
                              width * 0.7,
                              height * 0.64,
                              width * 0.55,redCoinAnimation == true
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
                                },
                                child: CustomImage(
                                    color: Color(0xff913DDC),
                                    text: tiger == true
                                        ? evenTigerRate
                                        : evenDragonRate,
                                    image: 'EVEN',
                                    sizedWidth: width * 0.07),
                              ),
                              SizedBox(
                                height: height * 0.005,
                              ),
                              tiger == true
                                  ? Text(
                                      confirmButton == true && startTimes > 1
                                          ? liablity9.toString()
                                          : "",
                                      style: liablity9 > 0.0
                                          ? TextStyle(
                                              color: Color(
                                                0xff24BC0B,
                                              ),
                                              fontSize: 12,
                                              fontWeight: FontWeight.w500)
                                          : TextStyle(
                                              color: Color(0xffFE2121),
                                              fontSize: 12,
                                              fontWeight: FontWeight.w500))
                                  : Text(
                                      confirmButton == true && startTimes > 1
                                          ? liablity5.toString()
                                          : "",
                                      style: liablity5 > 0.0
                                          ? TextStyle(
                                              color: Color(
                                                0xff24BC0B,
                                              ),
                                              fontSize: 12,
                                              fontWeight: FontWeight.w500)
                                          : TextStyle(
                                              color: Color(0xffFE2121),
                                              fontSize: 12,
                                              fontWeight: FontWeight.w500)),
                            ],
                          ),
                          SizedBox(
                            width: width * 0.02,
                          ),
                          Column(
                            children: [
                              InkWell(
                                onTap: () {
                                  setState(() {
                                    playBackgroundMusic == false
                                        ? ''
                                        : Vibration.vibrate();
                                  });
                                  dragonButton = false;
                                  tieButton = false;
                                  tigerButton = false;
                                  pairButton = false;
                                  evenDragonButton = false;
                                  tiger == true
                                      ? oddTigerButton = true
                                      : oddDragonButton = true;
                                  blackDragonButton = false;
                                  redDragonButton = false;
                                  evenTigerButton = false;

                                  blackTigerButton = false;
                                  redTigerButton = false;
                                  if ((redCoinAnimation == true ||
                                          lightGreenCoinAnimation == true ||
                                          blueCoinAnimation == true ||
                                          greenCoinAnimation == true ||
                                          lightBlueCoinAnimation == true ||
                                          brownCoinAnimation == true) &&
                                      startTimes > 1) {
                                    showMyDialog(context,
                              height * 0.45,
                              width * 0.33,
                              height * 0.4,
                              width * 0.7,
                              height * 0.64,
                              width * 0.55,redCoinAnimation == true
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
                                },
                                child: CustomImage(
                                    color: Color(0xff913DDC),
                                    text: tiger == true
                                        ? oddTigerRate
                                        : oddDragonRate,
                                    image: 'ODD',
                                    sizedWidth: width * 0.07),
                              ),
                              SizedBox(
                                height: height * 0.005,
                              ),
                              tiger == true
                                  ? Text(
                                      confirmButton == true && startTimes > 1
                                          ? liablity10.toString()
                                          : "",
                                      style: liablity10 > 0.0
                                          ? TextStyle(
                                              color: Color(
                                                0xff24BC0B,
                                              ),
                                              fontSize: 12,
                                              fontWeight: FontWeight.w500)
                                          : TextStyle(
                                              color: Color(0xffFE2121),
                                              fontSize: 12,
                                              fontWeight: FontWeight.w500))
                                  : Text(
                                      confirmButton == true && startTimes > 1
                                          ? liablity6.toString()
                                          : "",
                                      style: liablity6 > 0.0
                                          ? TextStyle(
                                              color: Color(
                                                0xff24BC0B,
                                              ),
                                              fontSize: 12,
                                              fontWeight: FontWeight.w500)
                                          : TextStyle(
                                              color: Color(0xffFE2121),
                                              fontSize: 12,
                                              fontWeight: FontWeight.w500)),
                            ],
                          ),
                        ],
                      ),
                      SizedBox(
                        height: height * 0.02,
                      ),
                      Row(
                        children: [
                          Column(
                            children: [
                              InkWell(
                                onTap: () {
                                  setState(() {
                                    playBackgroundMusic == false
                                        ? ''
                                        : Vibration.vibrate();
                                  });
                                  dragonButton = false;
                                  tieButton = false;
                                  tigerButton = false;
                                  pairButton = false;
                                  evenDragonButton = false;
                                  oddDragonButton = false;
                                  blackDragonButton = false;
                                  tiger == true
                                      ? redTigerButton = true
                                      : redDragonButton = true;
                                  evenTigerButton = false;
                                  oddTigerButton = false;
                                  blackTigerButton = false;

                                  if ((redCoinAnimation == true ||
                                          lightGreenCoinAnimation == true ||
                                          blueCoinAnimation == true ||
                                          greenCoinAnimation == true ||
                                          lightBlueCoinAnimation == true ||
                                          brownCoinAnimation == true) &&
                                      startTimes > 1) {
                                    showMyDialog(context,
                              height * 0.45,
                              width * 0.33,
                              height * 0.4,
                              width * 0.7,
                              height * 0.64,
                              width * 0.55,redCoinAnimation == true
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
                                },
                                child: CustomButton(
                                  color: Color(0xff913DDC),
                                  text: tiger == true
                                      ? redTigerRate
                                      : redDragonRate,
                                  image: DragonTigerImages.redCard,
                                  heightImage: height * 0.03,
                                  sizedWidth: width * 0.077,
                                ),
                              ),
                              SizedBox(
                                height: height * 0.005,
                              ),
                              tiger == true
                                  ? Text(
                                      confirmButton == true && startTimes > 1
                                          ? liablity11.toString()
                                          : "",
                                      style: liablity11 > 0.0
                                          ? TextStyle(
                                              color: Color(
                                                0xff24BC0B,
                                              ),
                                              fontSize: 12,
                                              fontWeight: FontWeight.w500)
                                          : TextStyle(
                                              color: Color(0xffFE2121),
                                              fontSize: 12,
                                              fontWeight: FontWeight.w500))
                                  : Text(
                                      confirmButton == true && startTimes > 1
                                          ? liablity7.toString()
                                          : "",
                                      style: liablity7 > 0.0
                                          ? TextStyle(
                                              color: Color(
                                                0xff24BC0B,
                                              ),
                                              fontSize: 12,
                                              fontWeight: FontWeight.w500)
                                          : TextStyle(
                                              color: Color(0xffFE2121),
                                              fontSize: 12,
                                              fontWeight: FontWeight.w500)),
                            ],
                          ),
                          SizedBox(
                            width: width * 0.02,
                          ),
                          Column(
                            children: [
                              InkWell(
                                onTap: () {
                                  setState(() {
                                    playBackgroundMusic == false
                                        ? ''
                                        : Vibration.vibrate();
                                  });
                                  dragonButton = false;
                                  tieButton = false;
                                  tigerButton = false;
                                  pairButton = false;
                                  evenDragonButton = false;
                                  oddDragonButton = false;

                                  tiger == true
                                      ? blackTigerButton = true
                                      : blackDragonButton = true;
                                  redDragonButton = false;
                                  evenTigerButton = false;
                                  oddTigerButton = false;
                                  redTigerButton = false;
                                  if (redCoinAnimation == true ||
                                      lightGreenCoinAnimation == true ||
                                      blueCoinAnimation == true ||
                                      greenCoinAnimation == true ||
                                      lightBlueCoinAnimation == true ||
                                      brownCoinAnimation == true) {
                                    showMyDialog(context,
                              height * 0.45,
                              width * 0.33,
                              height * 0.4,
                              width * 0.7,
                              height * 0.64,
                              width * 0.55,redCoinAnimation == true
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
                                },
                                child: CustomButton(
                                  color: Color(0xff913DDC),
                                  text: tiger == true
                                      ? blackTigerRate
                                      : blackDragonRate,
                                  image: DragonTigerImages.blackCard,
                                  heightImage: height * 0.03,
                                  sizedWidth: width * 0.077,
                                ),
                              ),
                              SizedBox(
                                height: height * 0.005,
                              ),
                              tiger == true
                                  ? Text(
                                      confirmButton == true && startTimes > 1
                                          ? liablity12.toString()
                                          : "",
                                      style: liablity12 > 0.0
                                          ? TextStyle(
                                              color: Color(
                                                0xff24BC0B,
                                              ),
                                              fontSize: 12,
                                              fontWeight: FontWeight.w500)
                                          : TextStyle(
                                              color: Color(0xffFE2121),
                                              fontSize: 12,
                                              fontWeight: FontWeight.w500))
                                  : Text(
                                      confirmButton == true && startTimes > 1
                                          ? liablity8.toString()
                                          : "",
                                      style: liablity8 > 0.0
                                          ? TextStyle(
                                              color: Color(
                                                0xff24BC0B,
                                              ),
                                              fontSize: 12,
                                              fontWeight: FontWeight.w500)
                                          : TextStyle(
                                              color: Color(0xffFE2121),
                                              fontSize: 12,
                                              fontWeight: FontWeight.w500)),
                            ],
                          ),
                        ],
                      )
                    ],
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }


   Widget protraitModeWidget() {
    return Scaffold(
      key: _globalKey,
      backgroundColor: Colors.transparent,
      drawerEnableOpenDragGesture: false,
      drawer: SizedBox(
        width: width * 0.55,
        child: Drawer(
          child: drawerWidget(),
        ),
      ),
      body: Container(
        height: height,
        width: width,
        decoration: BoxDecoration(
            image: DecorationImage(
          image: AssetImage(
            DragonTigerImages.bg,
          ),
          fit: BoxFit.fill,
        )),
        child: SingleChildScrollView(
          child: Column(
            children: [
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
                                DragonTigerImages.amountBg,
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
                      child: Image.asset(DragonTigerImages.menu,
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
                              });
                              _player.stop();

                              setState(() {
                                playBackgroundMusic = true;
                              });
                            },
                            child: Image.asset(DragonTigerImages.musicOn,
                                fit: BoxFit.fill, height: height * 0.055),
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
                            child: Image.asset(DragonTigerImages.musicOff,
                                fit: BoxFit.fill, height: height * 0.055),
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
                          left: width * 0.08,
                          right: width * 0.015,
                          top: height * 0.001),
                      height: height * 0.04,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                          image: DecorationImage(
                              image: AssetImage(
                                DragonTigerImages.exp,
                              ),
                              fit: BoxFit.fill)),
                      child: CustomText(
                          text: liablity.toString(),
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
                                  DragonTigerImages.mybet,
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
              Stack(
                children: [
                  Padding(
                    padding: EdgeInsets.only(
                        top: height * 0.02,
                        left: width * 0.02,
                        right: width * 0.02,
                        bottom: height * 0.01),
                    child: Image.asset(
                      DragonTigerImages.pastResultBg,
                      fit: BoxFit.fill,
                      height: height * 0.04,
                      width: double.infinity,
                    ),
                  ),
                  Positioned(
                    left: width * 0.05,
                    top: height * 0.02,
                    child: Container(
                      height: height * 0.04,
                      child: ListView.builder(
                          shrinkWrap: true,
                          itemCount: cardResultList.length,
                          scrollDirection: Axis.horizontal,
                          itemBuilder: (context, index) {
                            var item = cardResultList[index];

                            return InkWell(
                              onTap: () {
                                setState(() {
                                  playBackgroundMusic == false
                                      ? onPressedMusic()
                                      : Vibration.vibrate();
                                });
                                showResultDT(
                                    context,
                                    item.c1,
                                    item.c2,
                                    item.winnerDetail,
                                    item.dragonDetail,
                                    item.tigerDetail,
                                    item.mid);
                              },
                              child: Container(
                                margin: EdgeInsets.only(
                                  left: width * 0.02,
                                  right: width * 0.01,
                                ),
                                padding: EdgeInsets.all(7),
                                alignment: Alignment.center,
                                decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: item.winner == "1"
                                        ? ColorConstants.skyBlueColor
                                        : item.winner == "2"
                                            ? ColorConstants.pinkColor
                                            : ColorConstants.lightGreenColor),
                                child: Text(
                                  item.winner == "1"
                                      ? "T"
                                      : item.winner == "2"
                                          ? "D"
                                          : "T",
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
                ],
              ),
              Padding(
                padding: EdgeInsets.only(
                    right: width * 0.04, bottom: height * 0.005),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: const [
                    Text(
                      "(Min:100 Max: 250000)",
                      style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 12),
                    ),
                  ],
                ),
              ),
              BlinkText(
                "Round ID : $marketId",
                style:
                    TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
              ),
              SizedBox(
                height: height * 0.02,
              ),
              Image.asset(
                DragonTigerImages.girl,
                fit: BoxFit.cover,
                height: height * 0.15,
              ),
              Stack(
                children: [
                  Image.asset(
                    DragonTigerImages.tableBg,
                    fit: BoxFit.cover,
                    height: height * 0.38,
                    //width: width * 1.00,
                  ),
                  Positioned(
                    top: height * 0.07,
                    left: width * 0.13,
                    child:  Image.asset(
                            'assets/lucky7/images/frame/logo.png',
                            fit: BoxFit.cover,
                            height: height * 0.05,
                          ),
                  ),
                  Positioned(
                      top: height * 0.07,
                      right: width * 0.05,
                      child:  Image.asset(
                              'assets/lucky7/images/frame/logo.png',
                              fit: BoxFit.cover,
                              height: height * 0.05,
                            )),
                  SizedBox(
                      height: height * 0.36,
                      child: AnimatedSwitcher(
                        duration: Duration(milliseconds: 900),
                        child: Stack(
                          children: _coinsRytPortRand,
                        ),
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
                  SizedBox(
                      height: height * 0.36,
                      child: AnimatedSwitcher(
                        duration: Duration(milliseconds: 900),
                        child: Stack(
                          children: _coinsLeftPortRand,
                        ),
                      )),
                  startTimes >= 1
                      ? Positioned(
                          left: width * 0.35,
                          top: height * 0.02,
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
                          left: width * 0.49,
                          top: height * 0.02,
                          child: SizedBox(
                            width: width * 0.05,
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
                    left: width * 0.33,
                    top: height * 0.04,
                    child: startTimes >= 1
                        ? Column(
                            children: [
                              SizedBox(
                                height: 5,
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
                          )
                        : SizedBox(),
                  ),
                  autoTime == "45"
                      ? placeyourbetWidget(autoTime)
                      : autoTime == "3" || autoTime == "2" || autoTime == "1"
                          ? goWidgetPort()
                          : autoTime != '0'
                              ? SizedBox()
                              : Positioned(
                                  top: height * 0.03,
                                  left: width * 0.18,
                                  child: showCurrentCardPort()),
                  startTimes <= 3 && autoTime != '0'
                      ? gameStopBettingPortrait(autoTime)
                      : SizedBox(),
                  Positioned(
                    bottom: height * 0.01,
                    left: width * 0.14,
                    child: Row(
                      children: [
                        InkWell(
                          onTap: () {
                            setState(() {
                              playBackgroundMusic == false
                                  ? ''
                                  : Vibration.vibrate();
                            });
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
                            height: redCoinAnimation == true && startTimes > 1
                                ? height * 0.07
                                : height * 0.05,
                            width: redCoinAnimation == true && startTimes > 1
                                ? width * 0.15
                                : width * 0.105,
                            decoration: BoxDecoration(
                                image: DecorationImage(
                              image: AssetImage(DragonTigerImages.redCoin),
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
                              playBackgroundMusic == false
                                  ? ''
                                  : Vibration.vibrate();
                            });
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
                              image:
                                  AssetImage(DragonTigerImages.lightGreenCoin),
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
                              playBackgroundMusic == false
                                  ? ''
                                  : Vibration.vibrate();
                            });
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
                              image: AssetImage(DragonTigerImages.blueCoin),
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
                              playBackgroundMusic == false
                                  ? ''
                                  : Vibration.vibrate();
                            });

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
                            height: greenCoinAnimation == true && startTimes > 1
                                ? height * 0.07
                                : height * 0.05,
                            width: greenCoinAnimation == true && startTimes > 1
                                ? width * 0.15
                                : width * 0.105,
                            decoration: BoxDecoration(
                                image: DecorationImage(
                              image: AssetImage(DragonTigerImages.greenCoin),
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
                              playBackgroundMusic == false
                                  ? ''
                                  : Vibration.vibrate();
                            });

                            setState(() {
                              redCoinAnimation = false;
                              lightGreenCoinAnimation = false;
                              blueCoinAnimation = false;
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
                              image: AssetImage(DragonTigerImages.brownCoin),
                              fit: BoxFit.fill,
                            )),
                            child: Text(
                              stack6 != 0 ? "20K" : stack6.toString(),
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
              Stack(
                children: [dragonTigerTiePair()],
              )
            ],
          ),
        ),
      ),
    );
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
                        gradient: LinearGradient(
                          colors: const <Color>[
                            Color(0xff110020),
                            Color(0xff250443),
                          ],
                        ),
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
                                   
                                        if (evenDragonButton == true ||
                                            oddDragonButton == true ||
                                            blackDragonButton == true ||
                                            redDragonButton == true ||
                                            evenTigerButton == true ||
                                            oddTigerButton == true ||
                                            blackTigerButton == true ||
                                            redTigerButton == true ||
                                            dragonButton == true ||
                                            pairButton == true ||
                                            tieButton == true ||
                                            tigerButton == true ||
                                            selectCard == true) {
                                          makeBet();
                                          Navigator.pop(context);

                                          evenDragonButton = false;
                                          oddDragonButton = false;
                                          blackDragonButton = false;
                                          redDragonButton = false;
                                          evenTigerButton = false;
                                          oddTigerButton = false;
                                          blackTigerButton = false;
                                          redTigerButton = false;
                                          dragonButton = false;
                                          pairButton = false;
                                          tieButton = false;
                                          tigerButton = false;
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

                                         
                                        if (evenDragonButton == true ||
                                            oddDragonButton == true ||
                                            blackDragonButton == true ||
                                            redDragonButton == true ||
                                            evenTigerButton == true ||
                                            oddTigerButton == true ||
                                            blackTigerButton == true ||
                                            redTigerButton == true ||
                                            dragonButton == true ||
                                            pairButton == true ||
                                            tieButton == true ||
                                            tigerButton == true ||
                                            selectCard == true) {
                                          makeBet();
                                          Navigator.pop(context);

                                          evenDragonButton = false;
                                          oddDragonButton = false;
                                          blackDragonButton = false;
                                          redDragonButton = false;
                                          evenTigerButton = false;
                                          oddTigerButton = false;
                                          blackTigerButton = false;
                                          redTigerButton = false;
                                          dragonButton = false;
                                          pairButton = false;
                                          tieButton = false;
                                          tigerButton = false;
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
                        gradient: LinearGradient(
                          colors: const <Color>[
                            Color(0xff110020),
                            Color(0xff250443),
                          ],
                        ),
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

                                        if (evenDragonButton == true ||
                                            oddDragonButton == true ||
                                            blackDragonButton == true ||
                                            redDragonButton == true ||
                                            evenTigerButton == true ||
                                            oddTigerButton == true ||
                                            blackTigerButton == true ||
                                            redTigerButton == true ||
                                            dragonButton == true ||
                                            pairButton == true ||
                                            tieButton == true ||
                                            tigerButton == true ||
                                            selectCard == true) {
                                          makeBetPortrait();
                                          Navigator.pop(context);

                                          evenDragonButton = false;
                                          oddDragonButton = false;
                                          blackDragonButton = false;
                                          redDragonButton = false;
                                          evenTigerButton = false;
                                          oddTigerButton = false;
                                          blackTigerButton = false;
                                          redTigerButton = false;
                                          dragonButton = false;
                                          pairButton = false;
                                          tieButton = false;
                                          tigerButton = false;
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

                                            if (evenDragonButton == true ||
                                                oddDragonButton == true ||
                                                blackDragonButton == true ||
                                                redDragonButton == true ||
                                                evenTigerButton == true ||
                                                oddTigerButton == true ||
                                                blackTigerButton == true ||
                                                redTigerButton == true ||
                                                dragonButton == true ||
                                                pairButton == true ||
                                                tieButton == true ||
                                                tigerButton == true ||
                                                selectCard == true) {
                                              makeBetPortrait();
                                              Navigator.pop(context);

                                              evenDragonButton = false;
                                              oddDragonButton = false;
                                              blackDragonButton = false;
                                              redDragonButton = false;
                                              evenTigerButton = false;
                                              oddTigerButton = false;
                                              blackTigerButton = false;
                                              redTigerButton = false;
                                              dragonButton = false;
                                              pairButton = false;
                                              tieButton = false;
                                              tigerButton = false;
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

  Widget drawerWidget() {
    return Container(
      height: height,
      width: width * 0.55,
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

  Route _createRouteCurrentBetsList() {
    return PageRouteBuilder(
      pageBuilder: (context, animation, secondaryAnimation) => CurrentUserBet(
        matchId: widget.matchId,
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
      pageBuilder: (context, animation, secondaryAnimation) =>
          CurrentBetsScreen(
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

  Widget dragonTigerTiePair() {
    return Column(
      children: [
        Container(
            padding: EdgeInsets.symmetric(
                vertical: height * 0.02, horizontal: width * 0.01),
            height: height * 0.7,
            width: width,
            decoration: BoxDecoration(
                image: DecorationImage(
                    image: AssetImage(DragonTigerImages.buttonBg),
                    fit: BoxFit.fitWidth)),
            child: Column(
              children: [
                Row(
                  children: [
                    Expanded(
                        child: Column(
                      children: [
                        InkWell(
                            onTap: () {
                              setState(() {
                                playBackgroundMusic == false
                                    ? ''
                                    : Vibration.vibrate();
                              });
                              dragonButton = true;
                              tieButton = false;
                              tigerButton = false;
                              pairButton = false;
                              evenDragonButton = false;
                              oddDragonButton = false;
                              blackDragonButton = false;
                              redDragonButton = false;
                              evenTigerButton = false;
                              oddTigerButton = false;
                              blackTigerButton = false;
                              redTigerButton = false;
                              if ((redCoinAnimation == true ||
                                      lightGreenCoinAnimation == true ||
                                      blueCoinAnimation == true ||
                                      greenCoinAnimation == true ||
                                      lightBlueCoinAnimation == true ||
                                      brownCoinAnimation == true) &&
                                  startTimes > 1) {
                                showMyDialogPortrait(    context,
                            height * 0.23,
                            width,
                            height * 0.4,
                            width * 0.7,
                            height * 0.26,
                            width * 0.98,redCoinAnimation == true
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
                            },
                            child: CustomImage(
                              color: Color(0xff913DDC),
                              text: dragonRate,
                              image: 'DRAGON',
                              sizedWidth: width * 0.01,
                            )),
                        SizedBox(
                          height: height * 0.005,
                        ),
                        Text(
                            confirmButton == true && startTimes > 1
                                ? liablity1.toString()
                                : "",
                            style: liablity1 > 0.0
                                ? TextStyle(
                                    color: Color(
                                      0xff24BC0B,
                                    ),
                                    fontSize: 12,
                                    fontWeight: FontWeight.w500)
                                : TextStyle(
                                    color: Color(0xffFE2121),
                                    fontSize: 12,
                                    fontWeight: FontWeight.w500)),
                      ],
                    )),
                    SizedBox(
                      width: width * 0.1,
                    ),
                    Column(
                      children: [
                        InkWell(
                            onTap: () {
                              setState(() {
                                playBackgroundMusic == false
                                    ? ''
                                    : Vibration.vibrate();
                              });
                              dragonButton = false;
                              tieButton = true;
                              tigerButton = false;
                              pairButton = false;
                              evenDragonButton = false;
                              oddDragonButton = false;
                              blackDragonButton = false;
                              redDragonButton = false;
                              evenTigerButton = false;
                              oddTigerButton = false;
                              blackTigerButton = false;
                              redTigerButton = false;
                              if ((redCoinAnimation == true ||
                                      lightGreenCoinAnimation == true ||
                                      blueCoinAnimation == true ||
                                      greenCoinAnimation == true ||
                                      lightBlueCoinAnimation == true ||
                                      brownCoinAnimation == true) &&
                                  startTimes > 1) {
                                showMyDialogPortrait(    context,
                            height * 0.23,
                            width,
                            height * 0.4,
                            width * 0.7,
                            height * 0.26,
                            width * 0.98,redCoinAnimation == true
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
                            },
                            child: CustomImage(
                                color: Color(0xff913DDC),
                                text: tieRate,
                                image: 'TIE',
                                sizedWidth: width * 0.12)),
                        SizedBox(
                          height: height * 0.005,
                        ),
                        Text(
                            confirmButton == true && startTimes > 1
                                ? liablity2.toString()
                                : "",
                            style: liablity2 > 0.0
                                ? TextStyle(
                                    color: Color(
                                      0xff24BC0B,
                                    ),
                                    fontSize: 12,
                                    fontWeight: FontWeight.w500)
                                : TextStyle(
                                    color: Color(0xffFE2121),
                                    fontSize: 12,
                                    fontWeight: FontWeight.w500)),
                      ],
                    ),
                  ],
                ),
                SizedBox(
                  height: height * 0.01,
                ),
                Row(
                  children: [
                    Expanded(
                        child: Column(
                      children: [
                        InkWell(
                            onTap: () {
                              setState(() {
                                playBackgroundMusic == false
                                    ? ''
                                    : Vibration.vibrate();
                              });
                              dragonButton = false;
                              tieButton = false;
                              tigerButton = true;
                              pairButton = false;
                              evenDragonButton = false;
                              oddDragonButton = false;
                              blackDragonButton = false;
                              redDragonButton = false;
                              evenTigerButton = false;
                              oddTigerButton = false;
                              blackTigerButton = false;
                              redTigerButton = false;
                              if ((redCoinAnimation == true ||
                                      lightGreenCoinAnimation == true ||
                                      blueCoinAnimation == true ||
                                      greenCoinAnimation == true ||
                                      lightBlueCoinAnimation == true ||
                                      brownCoinAnimation == true) &&
                                  startTimes > 1) {
                                showMyDialogPortrait(    context,
                            height * 0.23,
                            width,
                            height * 0.4,
                            width * 0.7,
                            height * 0.26,
                            width * 0.98,redCoinAnimation == true
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
                            },
                            child: CustomImage(
                              color: Color(0xff913DDC),
                              text: tigerRate,
                              image: 'TIGER',
                              sizedWidth: width * 0.01,
                            )),
                        SizedBox(
                          height: height * 0.005,
                        ),
                        Text(
                            confirmButton == true && startTimes > 1
                                ? liablity3.toString()
                                : "",
                            style: liablity3 > 0.0
                                ? TextStyle(
                                    color: Color(
                                      0xff24BC0B,
                                    ),
                                    fontSize: 12,
                                    fontWeight: FontWeight.w500)
                                : TextStyle(
                                    color: Color(0xffFE2121),
                                    fontSize: 12,
                                    fontWeight: FontWeight.w500)),
                      ],
                    )),
                    SizedBox(
                      width: width * 0.1,
                    ),
                    Column(
                      children: [
                        InkWell(
                            onTap: () {
                              setState(() {
                                playBackgroundMusic == false
                                    ? ''
                                    : Vibration.vibrate();
                              });
                              dragonButton = false;
                              tieButton = false;
                              tigerButton = false;
                              pairButton = true;
                              evenDragonButton = false;
                              oddDragonButton = false;
                              blackDragonButton = false;
                              redDragonButton = false;
                              evenTigerButton = false;
                              oddTigerButton = false;
                              blackTigerButton = false;
                              redTigerButton = false;
                              if ((redCoinAnimation == true ||
                                      lightGreenCoinAnimation == true ||
                                      blueCoinAnimation == true ||
                                      greenCoinAnimation == true ||
                                      lightBlueCoinAnimation == true ||
                                      brownCoinAnimation == true) &&
                                  startTimes > 1) {
                                showMyDialogPortrait(    context,
                            height * 0.23,
                            width,
                            height * 0.4,
                            width * 0.7,
                            height * 0.26,
                            width * 0.98,redCoinAnimation == true
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
                            },
                            child: CustomImage(
                                color: Color(0xff913DDC),
                                text: pairRate,
                                image: 'PAIR',
                                sizedWidth: width * 0.11)),
                        SizedBox(
                          height: height * 0.005,
                        ),
                        Text(
                            confirmButton == true && startTimes > 1
                                ? liablity4.toString()
                                : "",
                            style: liablity4 > 0.0
                                ? TextStyle(
                                    color: Color(
                                      0xff24BC0B,
                                    ),
                                    fontSize: 12,
                                    fontWeight: FontWeight.w500)
                                : TextStyle(
                                    color: Color(0xffFE2121),
                                    fontSize: 12,
                                    fontWeight: FontWeight.w500)),
                      ],
                    ),
                  ],
                ),
                SizedBox(
                  height: height * 0.02,
                ),
                Row(
                  children: [
                    InkWell(
                      onTap: () {
                        setState(() {
                          playBackgroundMusic == false
                              ? ''
                              : Vibration.vibrate();
                        });

                        setState(() {
                          dragon = true;
                          tiger = false;
                        });
                      },
                      child: Column(
                        children: [
                          CustomText(
                            text: 'DRAGON',
                            fontWeight: FontWeight.w700,
                            color: tiger == true
                                ? Colors.white
                                : Color.fromARGB(255, 222, 194, 241),
                            fontSize: 14.0,
                            textAlign: TextAlign.start,
                          ),
                          tiger == true
                              ? SizedBox()
                              : Container(
                                  height: height * 0.003,
                                  width: width * 0.15,
                                  decoration:
                                      BoxDecoration(color: Color(0xff6910A2)),
                                ),
                        ],
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
                        });

                        setState(() {
                          dragon = false;
                          tiger = true;
                        });
                      },
                      child: Column(
                        children: [
                          CustomText(
                            text: 'TIGER',
                            fontWeight: FontWeight.w700,
                            color: tiger == true
                                ? Color.fromARGB(255, 222, 194, 241)
                                : Colors.white,
                            fontSize: 14.0,
                            textAlign: TextAlign.start,
                          ),
                          tiger == true
                              ? Container(
                                  height: height * 0.003,
                                  width: width * 0.09,
                                  decoration:
                                      BoxDecoration(color: Color(0xff6910A2)),
                                )
                              : SizedBox()
                        ],
                      ),
                    ),
                  ],
                ),

                SizedBox(
                  height: height * 0.02,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      children: [
                        InkWell(
                            onTap: () {
                              setState(() {
                                playBackgroundMusic == false
                                    ? ''
                                    : Vibration.vibrate();
                              });
                              dragonButton = false;
                              tieButton = false;
                              tigerButton = false;
                              pairButton = false;
                              tiger == true
                                  ? evenTigerButton = true
                                  : evenDragonButton = true;
                              oddDragonButton = false;
                              blackDragonButton = false;
                              redDragonButton = false;

                              oddTigerButton = false;
                              blackTigerButton = false;
                              redTigerButton = false;
                              if ((redCoinAnimation == true ||
                                      lightGreenCoinAnimation == true ||
                                      blueCoinAnimation == true ||
                                      greenCoinAnimation == true ||
                                      lightBlueCoinAnimation == true ||
                                      brownCoinAnimation == true) &&
                                  startTimes > 1) {
                                showMyDialogPortrait(    context,
                            height * 0.23,
                            width,
                            height * 0.4,
                            width * 0.7,
                            height * 0.26,
                            width * 0.98,redCoinAnimation == true
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
                            },
                            child: CustomImage(
                                color: Color(0xff913DDC),
                                text: tiger == true
                                    ? evenTigerRate
                                    : evenDragonRate,
                                image: 'EVEN',
                                sizedWidth: width * 0.27)),
                        SizedBox(
                          height: height * 0.005,
                        ),
                        tiger == true
                            ? Text(
                                confirmButton == true && startTimes > 1
                                    ? liablity9.toString()
                                    : "",
                                style: liablity9 > 0.0
                                    ? TextStyle(
                                        color: Color(
                                          0xff24BC0B,
                                        ),
                                        fontSize: 12,
                                        fontWeight: FontWeight.w500)
                                    : TextStyle(
                                        color: Color(0xffFE2121),
                                        fontSize: 12,
                                        fontWeight: FontWeight.w500))
                            : Text(
                                confirmButton == true && startTimes > 1
                                    ? liablity5.toString()
                                    : "",
                                style: liablity5 > 0.0
                                    ? TextStyle(
                                        color: Color(
                                          0xff24BC0B,
                                        ),
                                        fontSize: 12,
                                        fontWeight: FontWeight.w500)
                                    : TextStyle(
                                        color: Color(0xffFE2121),
                                        fontSize: 12,
                                        fontWeight: FontWeight.w500)),
                      ],
                    ),
                    Column(
                      children: [
                        InkWell(
                            onTap: () {
                              setState(() {
                                playBackgroundMusic == false
                                    ? ''
                                    : Vibration.vibrate();
                              });
                              dragonButton = false;
                              tieButton = false;
                              tigerButton = false;
                              pairButton = false;
                              evenDragonButton = false;
                              tiger == true
                                  ? oddTigerButton = true
                                  : oddDragonButton = true;
                              blackDragonButton = false;
                              redDragonButton = false;
                              evenTigerButton = false;

                              blackTigerButton = false;
                              redTigerButton = false;
                              if ((redCoinAnimation == true ||
                                      lightGreenCoinAnimation == true ||
                                      blueCoinAnimation == true ||
                                      greenCoinAnimation == true ||
                                      lightBlueCoinAnimation == true ||
                                      brownCoinAnimation == true) &&
                                  startTimes > 1) {
                                showMyDialogPortrait(    context,
                            height * 0.23,
                            width,
                            height * 0.4,
                            width * 0.7,
                            height * 0.26,
                            width * 0.98,redCoinAnimation == true
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
                            },
                            child: CustomImage(
                              color: Color(0xff913DDC),
                              text:
                                  tiger == true ? oddTigerRate : oddDragonRate,
                              image: 'ODD',
                              sizedWidth: width * 0.27,
                            )),
                        SizedBox(
                          height: height * 0.005,
                        ),
                        tiger == true
                            ? Text(
                                confirmButton == true && startTimes > 1
                                    ? liablity10.toString()
                                    : "",
                                style: liablity10 > 0.0
                                    ? TextStyle(
                                        color: Color(
                                          0xff24BC0B,
                                        ),
                                        fontSize: 12,
                                        fontWeight: FontWeight.w500)
                                    : TextStyle(
                                        color: Color(0xffFE2121),
                                        fontSize: 12,
                                        fontWeight: FontWeight.w500))
                            : Text(
                                confirmButton == true && startTimes > 1
                                    ? liablity6.toString()
                                    : "",
                                style: liablity6 > 0.0
                                    ? TextStyle(
                                        color: Color(
                                          0xff24BC0B,
                                        ),
                                        fontSize: 12,
                                        fontWeight: FontWeight.w500)
                                    : TextStyle(
                                        color: Color(0xffFE2121),
                                        fontSize: 12,
                                        fontWeight: FontWeight.w500)),
                      ],
                    ),
                  ],
                ),
                SizedBox(
                  height: height * 0.01,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      children: [
                        InkWell(
                            onTap: () {
                              setState(() {
                                playBackgroundMusic == false
                                    ? ''
                                    : Vibration.vibrate();
                              });
                              dragonButton = false;
                              tieButton = false;
                              tigerButton = false;
                              pairButton = false;
                              evenDragonButton = false;
                              oddDragonButton = false;

                              tiger == true
                                  ? blackTigerButton = true
                                  : blackDragonButton = true;
                              redDragonButton = false;
                              evenTigerButton = false;
                              oddTigerButton = false;
                              redTigerButton = false;
                              if ((redCoinAnimation == true ||
                                      lightGreenCoinAnimation == true ||
                                      blueCoinAnimation == true ||
                                      greenCoinAnimation == true ||
                                      lightBlueCoinAnimation == true ||
                                      brownCoinAnimation == true) &&
                                  startTimes > 1) {
                                showMyDialogPortrait(    context,
                            height * 0.23,
                            width,
                            height * 0.4,
                            width * 0.7,
                            height * 0.26,
                            width * 0.98,redCoinAnimation == true
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
                            },
                            child: CustomButton(
                              color: Color(0xff913DDC),
                              text: tiger == true
                                  ? blackTigerRate
                                  : blackDragonRate,
                              image: DragonTigerImages.blackCard,
                              heightImage: height * 0.03,
                              sizedWidth: width * 0.25,
                            )),
                        SizedBox(
                          height: height * 0.005,
                        ),
                        tiger == true
                            ? Text(
                                confirmButton == true && startTimes > 1
                                    ? liablity11.toString()
                                    : "",
                                style: liablity11 > 0.0
                                    ? TextStyle(
                                        color: Color(
                                          0xff24BC0B,
                                        ),
                                        fontSize: 12,
                                        fontWeight: FontWeight.w500)
                                    : TextStyle(
                                        color: Color(0xffFE2121),
                                        fontSize: 12,
                                        fontWeight: FontWeight.w500))
                            : Text(
                                confirmButton == true && startTimes > 1
                                    ? liablity7.toString()
                                    : "",
                                style: liablity7 > 0.0
                                    ? TextStyle(
                                        color: Color(
                                          0xff24BC0B,
                                        ),
                                        fontSize: 12,
                                        fontWeight: FontWeight.w500)
                                    : TextStyle(
                                        color: Color(0xffFE2121),
                                        fontSize: 12,
                                        fontWeight: FontWeight.w500)),
                      ],
                    ),
                    Column(
                      children: [
                        InkWell(
                            onTap: () {
                              setState(() {
                                playBackgroundMusic == false
                                    ? ''
                                    : Vibration.vibrate();
                              });
                              dragonButton = false;
                              tieButton = false;
                              tigerButton = false;
                              pairButton = false;
                              evenDragonButton = false;
                              oddDragonButton = false;
                              blackDragonButton = false;
                              tiger == true
                                  ? redTigerButton = true
                                  : redDragonButton = true;
                              evenTigerButton = false;
                              oddTigerButton = false;
                              blackTigerButton = false;
                              if ((redCoinAnimation == true ||
                                      lightGreenCoinAnimation == true ||
                                      blueCoinAnimation == true ||
                                      greenCoinAnimation == true ||
                                      lightBlueCoinAnimation == true ||
                                      brownCoinAnimation == true) &&
                                  startTimes > 1) {
                                showMyDialogPortrait(    context,
                            height * 0.23,
                            width,
                            height * 0.4,
                            width * 0.7,
                            height * 0.26,
                            width * 0.98,redCoinAnimation == true
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
                            },
                            child: CustomButton(
                              color: Color(0xff913DDC),
                              text:
                                  tiger == true ? redTigerRate : redDragonRate,
                              image: DragonTigerImages.redCard,
                              heightImage: height * 0.03,
                              sizedWidth: width * 0.23,
                            )),
                        SizedBox(
                          height: height * 0.005,
                        ),
                        tiger == true
                            ? Text(
                                confirmButton == true && startTimes > 1
                                    ? liablity12.toString()
                                    : "",
                                style: liablity12 > 0.0
                                    ? TextStyle(
                                        color: Color(
                                          0xff24BC0B,
                                        ),
                                        fontSize: 12,
                                        fontWeight: FontWeight.w500)
                                    : TextStyle(
                                        color: Color(0xffFE2121),
                                        fontSize: 12,
                                        fontWeight: FontWeight.w500))
                            : Text(
                                confirmButton == true && startTimes > 1
                                    ? liablity8.toString()
                                    : "",
                                style: liablity8 > 0.0
                                    ? TextStyle(
                                        color: Color(
                                          0xff24BC0B,
                                        ),
                                        fontSize: 12,
                                        fontWeight: FontWeight.w500)
                                    : TextStyle(
                                        color: Color(0xffFE2121),
                                        fontSize: 12,
                                        fontWeight: FontWeight.w500)),
                      ],
                    ),
                  ],
                ),
              ],
            )),
      ],
    );
  }

  goWidgetPort() {
    return Visibility(
      visible: autoTime == "3" || autoTime == "2" || autoTime == "1",
      child: Lottie.asset("assets/lucky7/audio/countdown.json",
          height: height * 0.2, width: width),
    );
  }

  goWidget() {
    return Visibility(
      visible: autoTime == "3" || autoTime == "2" || autoTime == "1",
      child: Lottie.asset("assets/lucky7/audio/countdown.json",
          height: height * 0.4, width: width),
    );
  }

  Widget placeyourbetWidget(String time) {
    return autoTime == '45'
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
                'assets/lucky7/images/Place Your Bet.png',
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
                  'assets/lucky7/images/Stop Betting.png',
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
                  'assets/lucky7/images/Stop Betting.png',
                  height: height * 0.2,
                  width: width * 0.5,
                  fit: BoxFit.fill,
                )))
        : SizedBox();
  }

  Future getCardData() async {
    var url = Apis.getCardDT;
    var response = await GlobalFunction.apiGetRequestae(url);
    var result = jsonDecode(response);
    if (result['status'] == true) {
 
        autoTime = result['data']['t1'][0]['autotime'].toString();
          if (startTimes != int.parse(autoTime.toString())) {
        startTimeSmall = startTimes * 100;
      }
        cardNameImage1 = result['data']['t1'][0]['C1'].toString();
        cardNameImage2 = result['data']['t1'][0]['C2'].toString();
        dragonRate = result['data']['t2'][0]['rate'];
        tigerRate = result['data']['t2'][1]['rate'];
        tieRate = result['data']['t2'][2]['rate'];
        pairRate = result['data']['t2'][3]['rate'];
        evenDragonRate = result['data']['t2'][4]['rate'];
        oddDragonRate = result['data']['t2'][5]['rate'];
        redDragonRate = result['data']['t2'][6]['rate'];
        blackDragonRate = result['data']['t2'][7]['rate'];
        cardADragonRate = result['data']['t2'][8]['rate'];
        card2DragonRate = result['data']['t2'][9]['rate'];
        card3DragonRate = result['data']['t2'][10]['rate'];
        card4DragonRate = result['data']['t2'][11]['rate'];
        card5DragonRate = result['data']['t2'][12]['rate'];
        card6DragonRate = result['data']['t2'][13]['rate'];
        card7DragonRate = result['data']['t2'][14]['rate'];
        card8DragonRate = result['data']['t2'][15]['rate'];
        card9DragonRate = result['data']['t2'][16]['rate'];
        card10DragonRate = result['data']['t2'][17]['rate'];
        cardJDragonRate = result['data']['t2'][18]['rate'];
        cardQDragonRate = result['data']['t2'][19]['rate'];
        cardKDragonRate = result['data']['t2'][20]['rate'];
        evenTigerRate = result['data']['t2'][21]['rate'];
        oddTigerRate = result['data']['t2'][22]['rate'];
        redTigerRate = result['data']['t2'][21]['rate'];
        blackTigerRate = result['data']['t2'][21]['rate'];
        cardATigerRate = result['data']['t2'][21]['rate'];
        card2TigerRate = result['data']['t2'][22]['rate'];
        card3TigerRate = result['data']['t2'][23]['rate'];
        card4TigerRate = result['data']['t2'][24]['rate'];
        card5TigerRate = result['data']['t2'][25]['rate'];
        card6TigerRate = result['data']['t2'][26]['rate'];
        card7TigerRate = result['data']['t2'][27]['rate'];
        card8TigerRate = result['data']['t2'][28]['rate'];
        card9TigerRate = result['data']['t2'][29]['rate'];
        card10TigerRate = result['data']['t2'][30]['rate'];
        cardJTigerRate = result['data']['t2'][31]['rate'];
        cardQTigerRate = result['data']['t2'][32]['rate'];
        cardKTigerRate = result['data']['t2'][33]['rate'];
        startTimes = int.parse(autoTime.toString());
        print("====>$startTimes");
        marketId = result['data']['t1'][0]['mid'].toString();

      autoTime == "0"
          ? setState(() {
              redCoinAnimation = false;
              lightGreenCoinAnimation = false;
              blueCoinAnimation = false;
              greenCoinAnimation = false;
              lightBlueCoinAnimation = false;
              brownCoinAnimation = false;
              confirmButton = false;
            })
          : SizedBox();
    }
  }

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
      setState(() {
        liablity1 = result['data'][27]['liability']; //dragon sid-1 index-27
        liablity2 = result['data'][28]['liability']; //tiger sid-2 index-28
        liablity3 = result['data'][29]['liability']; //tie   index-29
        liablity4 = result['data'][30]['liability']; //pair index-30
        liablity5 = result['data'][31]['liability']; //dragon even index-31
        liablity6 = result['data'][32]['liability']; //dragon odd index-32
        liablity7 = result['data'][33]['liability']; //dragon red index-33
        liablity8 =
            result['data'][34]['liability']; //dragon black sid-8 index-34
        liablity9 = result['data'][0]['liability']; //tiger  even sid-22 index-0
        liablity10 = result['data'][1]['liability']; //tiger odd sid-23 index-1
        liablity11 = result['data'][2]['liability']; //tiger red sid-24 index-2
        liablity12 = result['data'][3]['liability']; //tiger black sid-25index-3
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
        print("mainBalance=====>$userBalance");

        liablity = result['data']['libality'];
        mainBalance = double.parse(userBalance) - double.parse(liablity);
        print("mainBalance=====>$mainBalance");
      });
    }
  }

  void getDeviceIp() async {
    final ipv4 = await Ipify.ipv4();
    print(ipv4); // 98.207.254.136

    final ipv6 = await Ipify.ipv64();
    iPAddress = ipv6.toString();
    print(iPAddress); // 98.207.254.136 or 2a00:1450:400f:80d::200e

    final ipv4json = await Ipify.ipv64(format: Format.JSON);
    print(
        ipv4json); //{"ip":"98.207.254.136"} or {"ip":"2a00:1450:400f:80d::200e"}

    // The response type can be text, json or jsonp
  }

  Widget buildImageLand(String cardImage) {
    return cardImage == "" || cardImage == "null" || cardImage == null
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

  ///upload card image
  Widget buildImage(String cardImage) {
    return cardImage == "" || cardImage == "null" || cardImage == null
        ? Image.asset(
            'assets/lucky7/images/cardBg.png',
            height: height * 0.09,
            width: width * 0.12,
            fit: BoxFit.fill,
          )
        : FlipCard(
            flipOnTouch: false,
            autoFlipDuration: Duration(seconds: 1),
            front: Image.asset(
              'assets/lucky7/images/cardBg.png',
              height: height * 0.09,
              width: width * 0.12,
              fit: BoxFit.fill,
            ),
            back: SizedBox(
                height: height * 0.09,
                width: width * 0.12,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(2.5),
                  child: Image.network(
                      'http://admin.kalyanexch.com/images/cards/$cardImage.png',
                      fit: BoxFit.cover),
                )));
  }

  showResultDT(BuildContext context, cardImage1, cardImage2, cardDetail,
      cardDetail2, cardDetail3, roundIdList) {
    showDialog(
        context: context,
        builder: (_) {
          var height = MediaQuery.of(context).size.height;
          var width = MediaQuery.of(context).size.width;
          return AlertDialog(
            backgroundColor: Colors.transparent,
            content: Stack(
              children: [
                Container(
                  // padding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                  height: height * 0.26,
                  width: width * 0.9,

                  // width: width * 0.4,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      image: DecorationImage(
                          image: AssetImage(DragonTigerImages.pastResult),
                          fit: BoxFit.fill)),
                  child: Padding(
                    padding: EdgeInsets.only(top: height * 0.04),
                    child: Column(
                      children: [
                        Padding(
                          padding: EdgeInsets.only(
                              left: width * 0.25, top: height * 0.015),
                          child: Row(
                            children: [
                              Image.network(
                                "http://admin.kalyanexch.com/images/cards/$cardImage1.png",
                                height: height * 0.09,
                                width: width * 0.12,
                              ),
                              SizedBox(
                                width: width * 0.1,
                              ),
                              Image.network(
                                "http://admin.kalyanexch.com/images/cards/$cardImage2.png",
                                height: height * 0.09,
                                width: width * 0.12,
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: height * 0.0,
                        ),
                        CustomText(
                            text: 'Round ID: ${roundIdList}',
                            fontSize: 12,
                            color: Colors.white,
                            fontWeight: FontWeight.bold),
                        Padding(
                          padding: EdgeInsets.only(
                              left: width * 0.07, top: height * 0.04),
                          child: Row(
                            children: [
                              CustomText(
                                text: "$cardDetail".replaceAll("||", "|"),
                                fontWeight: FontWeight.w700,
                                color: Colors.white60,
                                fontSize: 6.0,
                                textAlign: TextAlign.center,
                              ),
                              SizedBox(
                                width: width * 0.05,
                              ),
                              CustomText(
                                text: "$cardDetail2".replaceAll("||", "|"),
                                fontWeight: FontWeight.w700,
                                color: Colors.white60,
                                fontSize: 6.0,
                                textAlign: TextAlign.center,
                              ),
                              SizedBox(
                                width: width * 0.05,
                              ),
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
                      Vibration.vibrate();
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

  showResultDTLand(BuildContext context, cardImage1, cardImage2, cardDetail,
      cardDetail2, cardDetail3, roundIdList) {
    showDialog(
        context: context,
        builder: (_) {
          var height = MediaQuery.of(context).size.height;
          var width = MediaQuery.of(context).size.width;
          return AlertDialog(
            backgroundColor: Colors.transparent,
            content: Stack(
              children: [
                Container(
                  padding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                  height: height * 0.54,
                  width: width * 0.40,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      image: DecorationImage(
                          image: AssetImage(DragonTigerImages.pastResult),
                          fit: BoxFit.fill)),
                  child: Padding(
                    padding: EdgeInsets.only(top: height * 0.05),
                    child: Column(
                      children: [
                        Padding(
                          padding: EdgeInsets.only(
                              left: width * 0.15, top: height * 0.04),
                          child: Row(
                            children: [
                              Image.network(
                                "http://admin.kalyanexch.com/images/cards/$cardImage1.png",
                                height: height * 0.14,
                                // width: width * 0.19,
                              ),
                              SizedBox(
                                width: width * 0.07,
                              ),
                              Image.network(
                                "http://admin.kalyanexch.com/images/cards/$cardImage2.png",
                                height: height * 0.14,
                                //  width: width * 0.14,
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: height * 0.03,
                        ),
                        CustomText(
                            text: 'Round ID: ${roundIdList}',
                            fontSize: 12,
                            color: Colors.white,
                            fontWeight: FontWeight.bold),
                        Padding(
                          padding: EdgeInsets.only(
                              left: width * 0.03, top: height * 0.11),
                          child: Row(
                            children: [
                              CustomText(
                                text: "$cardDetail".replaceAll("||", "|"),
                                fontWeight: FontWeight.w700,
                                color: Colors.white60,
                                fontSize: 6.0,
                                textAlign: TextAlign.center,
                              ),
                              SizedBox(
                                width: width * 0.06,
                              ),
                              CustomText(
                                text: "$cardDetail2".replaceAll("||", "|"),
                                fontWeight: FontWeight.w700,
                                color: Colors.white60,
                                fontSize: 6.0,
                                textAlign: TextAlign.center,
                              ),
                              SizedBox(
                                width: width * 0.065,
                              ),
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
                      Vibration.vibrate();
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

  Widget showCurrentCardPort() {
    return Container(
      alignment: Alignment.center,
      height: height * 0.26,
      width: width * 0.7,
      decoration: BoxDecoration(
          image: DecorationImage(
              image: AssetImage(
                DragonTigerImages.currentResult,
              ),
              fit: BoxFit.contain)),
      child: Padding(
        padding: EdgeInsets.only(top: height * 0.05),
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.only(left: width * 0.15, top: height * 0.0),
              child: Row(
                children: [
                  cardNameImage1 != ""
                      ? buildImage(cardNameImage1)
                      : Image.asset(
                          'assets/lucky7/images/cardBg.png',
                          height: height * 0.09,
                          width: width * 0.12,
                          fit: BoxFit.fill,
                        ),
                  SizedBox(
                    width: width * 0.18,
                  ),
                  cardNameImage1 != ""
                      ? buildImage(cardNameImage2)
                      : Image.asset(
                          'assets/lucky7/images/cardBg.png',
                          height: height * 0.09,
                          width: width * 0.12,
                          fit: BoxFit.fill,
                        ),
                ],
              ),
            ),
            SizedBox(
              height: height * 0.01,
            ),
            CustomText(
                text: 'Round ID: ${marketId.toString()}',
                fontSize: 12,
                color: Colors.white,
                fontWeight: FontWeight.bold),
          ],
        ),
      ),
    );
  }

  Widget showCurrentCardLand() {
    return Container(
      alignment: Alignment.center,
      height: height * 0.5,
      width: width * 0.3,
      decoration: BoxDecoration(
          image: DecorationImage(
              image: AssetImage(
                DragonTigerImages.currentResult,
              ),
              fit: BoxFit.fill)),
      child: Padding(
        padding: EdgeInsets.only(top: height * 0.08),
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.only(left: width * 0.05, top: height * 0.01),
              child: Row(
                children: [
                  cardNameImage1 != ""
                      ? buildImageLand(cardNameImage1)
                      : Image.asset(
                          'assets/lucky7/images/cardBg.png',
                          height: height * 0.19,
                          width: width * 0.06,
                          fit: BoxFit.fill,
                        ),
                  SizedBox(
                    width: width * 0.08,
                  ),
                  cardNameImage1 != ""
                      ? buildImageLand(cardNameImage2)
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
              height: height * 0.01,
            ),
            CustomText(
                text: 'Round ID: ${marketId.toString()}',
                fontSize: 12,
                color: Colors.white,
                fontWeight: FontWeight.bold),
          ],
        ),
      ),
    );
  }

  Future getResult() async {
    var url = Apis.getResultDT;
    var response = await GlobalFunction.apiGetRequestae(url);
    var result = jsonDecode(response);

    var list = result as List;

    setState(() {
      cardResultList.clear();
      var listdata = list.map((e) => DTResultModel.fromJson(e)).toList();
      cardResultList.addAll(listdata);

      winnerResult = result[0]['winner'].toString();
    });
  }

  List<MatchIdModeLL7> matchIdList = [];
  Future getMatchIdDetails() async {
    var url = Apis.matchId;
    var body = {"matchId": "14"};
    var response = await GlobalFunction.apiPostRequestToken(url, body);
    var result = jsonDecode(response);
    print("----------result match id ---------$result");
    if (result['status'] == true) {
      var list = result['data']['VDragon Tiger'] as List;
      matchIdList.clear();
      var listdata = list.map((e) => MatchIdModeLL7.fromJson(e)).toList();
      matchIdList.addAll(listdata);
    }
  }

  Future makeBet() async {
    DateTime currentTime = DateTime.now();
    var url = "http://13.250.53.81/VirtualCasinoBetPlacer/vc/place-bet";
    var body = {
      "casinoName": 1,
      "isBack": true,
      "odds": cardIndex == 0 && selectCard == true
          ? tiger == true
              ? cardATigerRate
              : cardADragonRate
          : cardIndex == 1 && selectCard == true
              ? tiger == true
                  ? card2TigerRate
                  : card2DragonRate
              : cardIndex == 2 && selectCard == true
                  ? tiger == true
                      ? card3TigerRate
                      : card3DragonRate
                  : cardIndex == 3 && selectCard == true
                      ? tiger == true
                          ? card4TigerRate
                          : card4DragonRate
                      : cardIndex == 4 && selectCard == true
                          ? tiger == true
                              ? card5TigerRate
                              : card5DragonRate
                          : cardIndex == 5 && selectCard == true
                              ? tiger == true
                                  ? card6TigerRate
                                  : card6DragonRate
                              : cardIndex == 6 && selectCard == true
                                  ? tiger == true
                                      ? card7TigerRate
                                      : card7DragonRate
                                  : cardIndex == 7 && selectCard == true
                                      ? tiger == true
                                          ? card8TigerRate
                                          : card8DragonRate
                                      : cardIndex == 8 && selectCard == true
                                          ? tiger == true
                                              ? card9TigerRate
                                              : card9DragonRate
                                          : cardIndex == 9 && selectCard == true
                                              ? tiger == true
                                                  ? card10TigerRate
                                                  : card10DragonRate
                                              : cardIndex == 10 &&
                                                      selectCard == true
                                                  ? tiger == true
                                                      ? cardJTigerRate
                                                      : cardJDragonRate
                                                  : cardIndex == 11 &&
                                                          selectCard == true
                                                      ? tiger == true
                                                          ? cardQTigerRate
                                                          : cardQDragonRate
                                                      : cardIndex == 12 &&
                                                              selectCard == true
                                                          ? tiger == true
                                                              ? cardKTigerRate
                                                              : cardKDragonRate
                                                          : dragonButton == true
                                                              ? dragonRate
                                                              : tieButton ==
                                                                      true
                                                                  ? tieRate
                                                                  : tigerButton ==
                                                                          true
                                                                      ? tigerRate
                                                                      : pairButton ==
                                                                              true
                                                                          ? pairRate
                                                                          : evenDragonButton == true
                                                                              ? evenDragonRate
                                                                              : oddDragonButton == true
                                                                                  ? oddDragonRate
                                                                                  : redDragonButton == true
                                                                                      ? redDragonRate
                                                                                      : blackDragonButton == true
                                                                                          ? blackDragonRate
                                                                                          : evenTigerButton == true
                                                                                              ? evenTigerRate
                                                                                              : oddTigerButton == true
                                                                                                  ? oddTigerRate
                                                                                                  : redTigerButton == true
                                                                                                      ? redTigerRate
                                                                                                      : blackTigerButton == true
                                                                                                          ? blackTigerRate
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
                          : lightBlueCoinAnimation == true &&
                                  manualAmount == false
                              ? stack5.toString()
                              : brownCoinAnimation == true &&
                                      manualAmount == false
                                  ? stack6
                                  : "",
      "selectionId": cardIndex == 0 && selectCard == true
          ? tiger == true
              ? '26'
              : '9'
          : cardIndex == 1 && selectCard == true
              ? tiger == true
                  ? '27'
                  : '10'
              : cardIndex == 2 && selectCard == true
                  ? tiger == true
                      ? '28'
                      : '11'
                  : cardIndex == 3 && selectCard == true
                      ? tiger == true
                          ? '29'
                          : '12'
                      : cardIndex == 4 && selectCard == true
                          ? tiger == true
                              ? '30'
                              : '13'
                          : cardIndex == 5 && selectCard == true
                              ? tiger == true
                                  ? '31'
                                  : '14'
                              : cardIndex == 6 && selectCard == true
                                  ? tiger == true
                                      ? '32'
                                      : '15'
                                  : cardIndex == 7 && selectCard == true
                                      ? tiger == true
                                          ? '33'
                                          : '16'
                                      : cardIndex == 8 && selectCard == true
                                          ? tiger == true
                                              ? '34'
                                              : '17'
                                          : cardIndex == 9 && selectCard == true
                                              ? tiger == true
                                                  ? '35'
                                                  : '18'
                                              : cardIndex == 10 &&
                                                      selectCard == true
                                                  ? tiger == true
                                                      ? '36'
                                                      : '19'
                                                  : cardIndex == 11 &&
                                                          selectCard == true
                                                      ? tiger == true
                                                          ? '37'
                                                          : '20'
                                                      : cardIndex == 12 &&
                                                              selectCard == true
                                                          ? tiger == true
                                                              ? '38'
                                                              : '21'
                                                          : dragonButton == true
                                                              ? '1'
                                                              : tieButton ==
                                                                      true
                                                                  ? '2'
                                                                  : tigerButton ==
                                                                          true
                                                                      ? '3'
                                                                      : pairButton ==
                                                                              true
                                                                          ? '4'
                                                                          : evenDragonButton == true
                                                                              ? '5'
                                                                              : oddDragonButton == true
                                                                                  ? '6'
                                                                                  : redDragonButton == true
                                                                                      ? '7'
                                                                                      : blackDragonButton == true
                                                                                          ? '8'
                                                                                          : evenTigerButton == true
                                                                                              ? '22'
                                                                                              : oddTigerButton == true
                                                                                                  ? '23'
                                                                                                  : redTigerButton == true
                                                                                                      ? '24'
                                                                                                      : blackTigerButton == true
                                                                                                          ? '25'
                                                                                                          : SizedBox(),
      "placeTime": currentTime.toString(),
      "marketId": marketId.toString(),
      "matchId": 14,
      "userIp": iPAddress.toString(),
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
    selectCard = false;
    manualAmount = false;
    var result = jsonDecode(response);

    print("betBody--->$body");
    if (result['status'] == true) {
      print("response--->$result");
      DialogUtils.showOneBtn(
        context,
        result['message'],
      );
      setState(() {
        evenDragonButton = false;
        oddDragonButton = false;
        blackDragonButton = false;
        redDragonButton = false;
        evenTigerButton = false;
        oddTigerButton = false;
        blackTigerButton = false;
        redTigerButton = false;
        dragonButton = false;
        pairButton = false;
        tieButton = false;
        tigerButton = false;
      });
      getuserBalance();
      getVcLiablity();
    } else {
      DialogUtils.showOneBtn(
        context,
        result['message'],
      );
    }
  }

  Future makeBetPortrait() async {
    DateTime currentTime = DateTime.now();
    var url = "http://13.250.53.81/VirtualCasinoBetPlacer/vc/place-bet";
    var body = {
      "casinoName": 1,
      "isBack": true,
      "odds": cardIndex == 0 && selectCard == true
          ? tiger == true
              ? cardATigerRate
              : cardADragonRate
          : cardIndex == 1 && selectCard == true
              ? tiger == true
                  ? card2TigerRate
                  : card2DragonRate
              : cardIndex == 2 && selectCard == true
                  ? tiger == true
                      ? card3TigerRate
                      : card3DragonRate
                  : cardIndex == 3 && selectCard == true
                      ? tiger == true
                          ? card4TigerRate
                          : card4DragonRate
                      : cardIndex == 4 && selectCard == true
                          ? tiger == true
                              ? card5TigerRate
                              : card5DragonRate
                          : cardIndex == 5 && selectCard == true
                              ? tiger == true
                                  ? card6TigerRate
                                  : card6DragonRate
                              : cardIndex == 6 && selectCard == true
                                  ? tiger == true
                                      ? card7TigerRate
                                      : card7DragonRate
                                  : cardIndex == 7 && selectCard == true
                                      ? tiger == true
                                          ? card8TigerRate
                                          : card8DragonRate
                                      : cardIndex == 8 && selectCard == true
                                          ? tiger == true
                                              ? card9TigerRate
                                              : card9DragonRate
                                          : cardIndex == 9 && selectCard == true
                                              ? tiger == true
                                                  ? card10TigerRate
                                                  : card10DragonRate
                                              : cardIndex == 10 &&
                                                      selectCard == true
                                                  ? tiger == true
                                                      ? cardJTigerRate
                                                      : cardJDragonRate
                                                  : cardIndex == 11 &&
                                                          selectCard == true
                                                      ? tiger == true
                                                          ? cardQTigerRate
                                                          : cardQDragonRate
                                                      : cardIndex == 12 &&
                                                              selectCard == true
                                                          ? tiger == true
                                                              ? cardKTigerRate
                                                              : cardKDragonRate
                                                          : dragonButton == true
                                                              ? dragonRate
                                                              : tieButton ==
                                                                      true
                                                                  ? tieRate
                                                                  : tigerButton ==
                                                                          true
                                                                      ? tigerRate
                                                                      : pairButton ==
                                                                              true
                                                                          ? pairRate
                                                                          : evenDragonButton == true
                                                                              ? evenDragonRate
                                                                              : oddDragonButton == true
                                                                                  ? oddDragonRate
                                                                                  : redDragonButton == true
                                                                                      ? redDragonRate
                                                                                      : blackDragonButton == true
                                                                                          ? blackDragonRate
                                                                                          : evenTigerButton == true
                                                                                              ? evenTigerRate
                                                                                              : oddTigerButton == true
                                                                                                  ? oddTigerRate
                                                                                                  : redTigerButton == true
                                                                                                      ? redTigerRate
                                                                                                      : blackTigerButton == true
                                                                                                          ? blackTigerRate
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
                          : lightBlueCoinAnimation == true &&
                                  manualAmount == false
                              ? stack5.toString()
                              : brownCoinAnimation == true &&
                                      manualAmount == false
                                  ? stack6
                                  : "",
      "selectionId": cardIndex == 0 && selectCard == true
          ? tiger == true
              ? '26'
              : '9'
          : cardIndex == 1 && selectCard == true
              ? tiger == true
                  ? '27'
                  : '10'
              : cardIndex == 2 && selectCard == true
                  ? tiger == true
                      ? '28'
                      : '11'
                  : cardIndex == 3 && selectCard == true
                      ? tiger == true
                          ? '29'
                          : '12'
                      : cardIndex == 4 && selectCard == true
                          ? tiger == true
                              ? '30'
                              : '13'
                          : cardIndex == 5 && selectCard == true
                              ? tiger == true
                                  ? '31'
                                  : '14'
                              : cardIndex == 6 && selectCard == true
                                  ? tiger == true
                                      ? '32'
                                      : '15'
                                  : cardIndex == 7 && selectCard == true
                                      ? tiger == true
                                          ? '33'
                                          : '16'
                                      : cardIndex == 8 && selectCard == true
                                          ? tiger == true
                                              ? '34'
                                              : '17'
                                          : cardIndex == 9 && selectCard == true
                                              ? tiger == true
                                                  ? '35'
                                                  : '18'
                                              : cardIndex == 10 &&
                                                      selectCard == true
                                                  ? tiger == true
                                                      ? '36'
                                                      : '19'
                                                  : cardIndex == 11 &&
                                                          selectCard == true
                                                      ? tiger == true
                                                          ? '37'
                                                          : '20'
                                                      : cardIndex == 12 &&
                                                              selectCard == true
                                                          ? tiger == true
                                                              ? '38'
                                                              : '21'
                                                          : dragonButton == true
                                                              ? '1'
                                                              : tieButton ==
                                                                      true
                                                                  ? '2'
                                                                  : tigerButton ==
                                                                          true
                                                                      ? '3'
                                                                      : pairButton ==
                                                                              true
                                                                          ? '4'
                                                                          : evenDragonButton == true
                                                                              ? '5'
                                                                              : oddDragonButton == true
                                                                                  ? '6'
                                                                                  : redDragonButton == true
                                                                                      ? '7'
                                                                                      : blackDragonButton == true
                                                                                          ? '8'
                                                                                          : evenTigerButton == true
                                                                                              ? '22'
                                                                                              : oddTigerButton == true
                                                                                                  ? '23'
                                                                                                  : redTigerButton == true
                                                                                                      ? '24'
                                                                                                      : blackTigerButton == true
                                                                                                          ? '25'
                                                                                                          : SizedBox(),
      "placeTime": currentTime.toString(),
      "marketId": marketId.toString(),
      "matchId": 14,
      "userIp": iPAddress.toString(),
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
    selectCard = false;
    manualAmount = false;
    var result = jsonDecode(response);

    print("betBody--->$body");
    if (result['status'] == true) {
      print("response--->$result");
      print("betBody--->$response");
      DialogUtils.showOneBtnPortrait(
        context,
        result['message'],
      );
      setState(() {
        evenDragonButton = false;
        oddDragonButton = false;
        blackDragonButton = false;
        redDragonButton = false;
        evenTigerButton = false;
        oddTigerButton = false;
        blackTigerButton = false;
        redTigerButton = false;
        dragonButton = false;
        pairButton = false;
        tieButton = false;
        tigerButton = false;
      });
      getuserBalance();
      getVcLiablity();
    } else {
      DialogUtils.showOneBtnPortrait(
        context,
        result['message'],
      );
    }
  }
}
