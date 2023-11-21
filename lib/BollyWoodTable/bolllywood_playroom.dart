// ignore_for_file: use_build_context_synchronously

import 'dart:async';
import 'dart:convert';
import 'dart:math';
import 'package:blinking_text/blinking_text.dart';
import 'package:connectivity/connectivity.dart';
import 'package:flip_card/flip_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:just_audio/just_audio.dart';
import 'package:lottie/lottie.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:vibration/vibration.dart';
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
  double _minX = 0;
  double _maxX = 0;
  double _minY = 0;
  double _maxY = 0;

  double _minXLeft = 0, _maxXLeft = 0, _minYLeft = 0, _maxYLeft = 0;
  double _minXRight = 0;
  double _maxXRight = 0;
  double _minYRight = 0;
  double _maxYRight = 0;
  double _minXLeftPort = 0;
  double _maxXLeftPort = 0;
  double _minYLeftPort = 0;
  double _maxYLeftPort = 0;
  double _minXRightPort = 0;
  double _maxXRightPort = 0;
  double _minYRightPort = 0;
  double _maxYRightPort = 0;
  final int _totalCoins = 7000;
  final Random _random = Random();
  bool showLiablity = false;
  int _currentCoinIndex = 0;
  String cardImage = "";

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
  int _currentCoinIndexRytPort = 0;
  double _minXRytPort = 0;
  double _maxXRytPort = 0;
  double _minYRytPort = 0;
  double _maxYRytPort = 0;
  final _player = AudioPlayer();
  final _cardPlayer = AudioPlayer();

  final winnerBettingmusic = AudioPlayer();

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
  late Timer _clockTimer;

  var gameSound = "assets/lucky7/audio/bgm.mp3";

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
    startTimes > 3 || playBackgroundMusic == false
        ? onPressedmusic.play()
        : onPressedmusic.stop();
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
    autoTime == "3" && playBackgroundMusic == false
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
    setState(() {
      playBackgroundMusic == false ? null : onPressedmusic.play();
    });
  }

       int startTimeSmall=0;

  @override
  void initState() {
      startTimeSmall=startTimes*100;
       Timer.periodic(const Duration(milliseconds: 10), (timer) {
        startTimeSmall =startTimeSmall-1;
       });
    getStakeDetails();
    checkInternet();

    AudioPlayer.clearAssetCache();
    WidgetsBinding.instance.addObserver(this);
    bgMusic();
    _clockTimer = Timer.periodic(const Duration(seconds: 1), (timer) {
      stopBettingMusic();
      startBettingMusic();
    });

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

  Future<void> checkInternet() async {
    var connectivityResult = await Connectivity().checkConnectivity();
    if (connectivityResult == ConnectivityResult.none) {
      // No internet connection

      print('No internet connection');
    } else {
      // Internet connection is available
      _startCoinAnimationLeftRandom();
      _startCoinAnimationRightRandom();
      _startCoinAnimationLeftRandomPort();
      _startCoinAnimationRightRandomPort();
    }
  }

  ///user chips animation -in protrait mode
  void _startCoinAnimation() {
    if (_currentCoinIndex >= _totalCoins) {
      return;
    }

    double _startX = _minX;
    double _startY = _minY;
    double _endX = _random.nextDouble() * (_maxX - _minX) + _minX;
    double _endY = _random.nextDouble() * (_maxY - _minY) + _minY;

    startTimes > 3
        ? _coins.add(TweenAnimationBuilder(
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
                              : lightBlueCoinAnimation == true
                                  ? Image.asset(
                                      _skybluecoinImages[_currentCoinIndex %
                                          _skybluecoinImages.length],
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
                                      : brownCoinAnimation == true
                                          ? Image.asset(
                                              _browncoinImages[
                                                  _currentCoinIndex %
                                                      _browncoinImages.length],
                                              height: 15,
                                              width: 15,
                                            )
                                          : SizedBox()
                      : SizedBox());
            },
          ))
        : _coins.clear();
    startTimes > 3 && playBackgroundMusic == false
        ? onPressedMusicForBet()
        : null;
  }

  ///user chips animation -in landscape mode
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
                              : lightBlueCoinAnimation == true
                                  ? Image.asset(
                                      _skybluecoinImages[_currentCoinIndex %
                                          _skybluecoinImages.length],
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
                                      : brownCoinAnimation == true
                                          ? Image.asset(
                                              _browncoinImages[
                                                  _currentCoinIndexRytPort %
                                                      _browncoinImages.length],
                                              height: 15,
                                              width: 15,
                                            )
                                          : SizedBox()
                      : SizedBox());
            },
          ))
        : _coinsRytPort.reversed;

    startTimes > 3 && playBackgroundMusic == false
        ? onPressedMusicForBet()
        : null;
  }

  void _startCoinAnimationLeftRandom() {
    if (_currentCoinIndex >= _totalCoins) {
      return;
    }

    double radius = 200; // Radius of the circular path
    double angle = _currentCoinIndex * (pi / _totalCoins);

    double _startX = _minXLeft;
    double _startY = _minYLeft;
    double _endX = _random.nextDouble() * (_maxXLeft - _minXLeft) + _minXLeft;
    double _endY = _random.nextDouble() * (_maxYLeft - _minYLeft) + _minYLeft;

    // coin = int.parse(widget.autotime.toString());
    //   print("====>$coin");

    startTimes > 3
        ? _coins.add(TweenAnimationBuilder(
            tween: Tween<double>(begin: 0, end: 1),
            duration: const Duration(milliseconds: 1000),
            builder: (BuildContext context, double value, Widget? child) {
              double currentX = _startX + (_endX - _startX) * value;
              double currentY = _startY + (_endY - _startY) * value;

              return Positioned(
                  left: currentX.clamp(_minXLeft, _maxXLeft),
                  top: currentY.clamp(_minYLeft, _maxYLeft),
                  child: Image.asset(
                    _coinImages[_currentCoinIndex % _coinImages.length],
                    height: 15,
                    width: 15,
                  ));
            },
          ))
        : null;
    _currentCoinIndex++;
    if (startTimes > 15) {
      //_checkInternetConnection();
      Timer(
        Duration(seconds: 2),
        _startCoinAnimationLeftRandom,
      );
    } else {
      // _checkInternetConnection();
      Timer(Duration(seconds: 3), _startCoinAnimationLeftRandom);
    }

    startTimes > 3 && playBackgroundMusic == false
        ? onPressedMusicForBet()
        : null;
  }

  void _startCoinAnimationRightRandom() {
    if (_currentCoinIndex >= _totalCoins) {
      return;
    }
    double _startX = _minXRight;
    double _startY = _minYRight;
    double _endX =
        _random.nextDouble() * (_maxXRight - _minXRight) + _minXRight;
    double _endY =
        _random.nextDouble() * (_maxYRight - _minYRight) + _minYRight;

    startTimes > 3
        ? _coins.add(TweenAnimationBuilder(
            tween: Tween<double>(begin: 0, end: 1),
            duration: const Duration(milliseconds: 1000),
            builder: (BuildContext context, double value, Widget? child) {
              double currentX = _startX + (_endX - _startX) * value;
              double currentY = _startY + (_endY - _startY) * value;

              return Positioned(
                  right: currentX.clamp(_minXRight, _maxXRight),
                  top: currentY.clamp(_minYRight, _maxYRight),
                  child: Image.asset(
                    _coinImagesRyt[_currentCoinIndex % _coinImagesRyt.length],
                    height: 15,
                    width: 15,
                  ));
            },
          ))
        : null;

    _currentCoinIndex++;

    if (startTimes > 15) {
      Timer(Duration(seconds: 3), _startCoinAnimationRightRandom);
    } else {
      Timer(Duration(seconds: 1), _startCoinAnimationRightRandom);
    }
  }

  void _startCoinAnimationLeftRandomPort() {
    if (_currentCoinIndex >= _totalCoins) {
      return;
    }
    double _startX = _minYLeftPort;
    double _startY = _minYLeftPort;
    double _endX =
        _random.nextDouble() * (_maxXLeftPort - _minXLeftPort) + _minXLeftPort;
    double _endY =
        _random.nextDouble() * (_maxYLeftPort - _minYLeftPort) + _minYLeftPort;

    startTimes > 3
        ? _coinsPort.add(TweenAnimationBuilder(
            tween: Tween<double>(begin: 0, end: 1),
            duration: const Duration(milliseconds: 600),
            builder: (BuildContext context, double value, Widget? child) {
              double currentX = _startX + (_endX - _startX) * value;
              double currentY = _startY + (_endY - _startY) * value;

              return Positioned(
                  right: currentX.clamp(_minXLeftPort, _maxXLeftPort),
                  top: currentY.clamp(_minYLeftPort, _maxYLeftPort),
                  child: Image.asset(
                    _coinImages[_currentCoinIndex % _coinImages.length],
                    height: 15,
                    width: 15,
                  ));
            },
          ))
        : null;

    _currentCoinIndex++;

    if (startTimes > 15) {
      Timer(Duration(seconds: 2), _startCoinAnimationLeftRandomPort);
    } else {
      Timer(Duration(seconds: 3), _startCoinAnimationLeftRandomPort);
    }

    startTimes > 3 && playBackgroundMusic == false
        ? onPressedMusicForBet()
        : null;
  }

  void _startCoinAnimationRightRandomPort() {
    if (_currentCoinIndex >= _totalCoins) {
      return;
    }

    double radius = 200; // Radius of the circular path
    double angle = _currentCoinIndex * (pi / _totalCoins);

    double _startX = _minXRightPort;
    double _startY = _minXRightPort;
    double _endX = _random.nextDouble() * (_maxXRightPort - _minXRightPort) +
        _minXRightPort;
    double _endY = _random.nextDouble() * (_maxYRightPort - _minYRightPort) +
        _minYRightPort;

    startTimes > 3
        ? _coinsRytPort.add(TweenAnimationBuilder(
            tween: Tween<double>(begin: 0, end: 1),
            duration: const Duration(milliseconds: 600),
            builder: (BuildContext context, double value, Widget? child) {
              double currentX = _startX + (_endX - _startX) * value;
              double currentY = _startY + (_endY - _startY) * value;

              return Positioned(
                left: currentX.clamp(_minXRightPort, _maxXRightPort),
                top: currentY.clamp(_minYRightPort, _maxYRightPort),
                child: Image.asset(
                  _coinImages[_currentCoinIndex % _coinImages.length],
                  height: 15,
                  width: 15,
                ),
              );
            }))
        : null;

    _currentCoinIndex++;
    if (startTimes > 15) {
      Timer(Duration(seconds: 3), _startCoinAnimationRightRandomPort);
    } else {
      Timer(Duration(seconds: 1), _startCoinAnimationRightRandomPort);
    }
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.paused) {
      playBackgroundMusic = true;
      _player.pause();

      _player.stop();
    } else if (state == AppLifecycleState.resumed) {
      // _player.play();
    }
  }

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
  Widget build(BuildContext context) {
       getCardData();
    getResult();
    getuserBalance();
 
    getMatchIdDetails();
    getUserDetails();

    height = MediaQuery.of(context).size.height;
    width = MediaQuery.of(context).size.width;
    _minXLeft = 160;
    _maxXLeft = width - 220;
    _minYLeft = 190;
    _maxYLeft = height - 100;
    _minXRight = 160;
    _maxXRight = width - 220;
    _minYRight = 190;
    _maxYRight = height - 100;
    _minXLeftPort = 40;
    _maxXLeftPort = width - 100;
    _minYLeftPort = 40;
    _maxYLeftPort = height - 600;
    _minXRightPort = 40;
    _maxXRightPort = width - 100;
    _minYRightPort = 40;
    _maxYRightPort = height - 600;
    _minXRytPort = 60;
    _maxXRytPort = width - 100;
    _minYRytPort = 60;
    _maxYRytPort = height - 600;
    _minX = 80;
    _maxX = width - 220;
    _minY = 80;
    _maxY = height - 140;

    return WillPopScope(
      onWillPop: () {
        _player.stop();
        _clockTimer.cancel();
        setState(() {
          playBackgroundMusic = true;
        });
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

  Widget landscapeWidget() {
    return Scaffold(
      drawerEnableOpenDragGesture: false,
      backgroundColor: Colors.transparent,
      key: _globalKey,
      drawer: SizedBox(
                width: width * 0.3,
        child: Drawer(child: drawerWidget())),
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
                                  setState(() {
                                    playBackgroundMusic == false
                                        ? onPressedMusic()
                                        : Vibration.vibrate();
                                  });

                                  _globalKey.currentState!.openDrawer();
                                },
                                child: Image.asset(
                                    'assets/bollywoodTable/menu-button.png',
                                    fit: BoxFit.fill,
                                    width: width * 0.05),
                              ),
                              SizedBox(
                                width: width * 0.02,
                              ),
                              Container(
                                alignment: Alignment.center,
                                decoration: BoxDecoration(
                                    image: DecorationImage(
                                        image: AssetImage(
                                            'assets/bollywoodTable/balance.png'),
                                        fit: BoxFit.fill)),
                                child: Container(
                                  padding: EdgeInsets.symmetric(
                                      horizontal: width * 0.02,
                                      vertical: height * 0.015),
                                  child: Row(
                                    children: [
                                      Image.asset(
                                        'assets/lucky7/images/Group 658.png',
                                        height: height * 0.05,
                                        width: width * 0.03,
                                      ),
                                      Text(
                                        " ${mainBalance.toStringAsFixed(2)}",
                                        style: TextStyle(
                                            color: Color(0xffFFEFC1),
                                            fontSize: height * 0.03,
                                            fontWeight: FontWeight.w500),
                                      ),
                                    ],
                                  ),
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
                                  context, _createRouteCurrentBets());
                            },
                            child: Container(
                              padding: EdgeInsets.only(
                                  left: width * 0.095, top: height * 0.001),
                              height: height * 0.09,
                              width: width * 0.14,
                              alignment: Alignment.center,
                              decoration: BoxDecoration(
                                  image: DecorationImage(
                                      image: AssetImage(
                                        'assets/bollywoodTable/show-my-bet.png',
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
                      top: height * 0.05,
                      child: Image.asset(
                        'assets/dragonTigerLion/tableImges/table-girl.png',
                        fit: BoxFit.cover,
                        height: height * 0.28,
                      ),
                    ),
                    startTimes >= 1
                        ? Positioned(
                            top: height * 0.025,
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
                            top: height * 0.025,
                            right: width * 0.14,
                            child: SizedBox(
                              width: width * 0.04,
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
                      right: width * 0.03,
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
                                          child:  LinearProgressIndicator(
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
                                              fontSize: 9),
                                        )
                                      ],
                                    )
                                  : SizedBox(),
                              SizedBox(
                                width: width * 0.035,
                              ),
                              playBackgroundMusic == false
                                  ? InkWell(
                                      onTap: () {
                                        setState(() {
                                          playBackgroundMusic == false
                                              ? onPressedMusic()
                                              : Vibration.vibrate();
                                        });

                                        setState(() {
                                          playBackgroundMusic = true;
                                        });
                                        _player.stop();
                                      },
                                      child: Image.asset(
                                          'assets/bollywoodTable/sound-on-button.png',
                                          fit: BoxFit.cover,
                                          width: width * 0.045),
                                    )
                                  : InkWell(
                                      onTap: () {
                                        setState(() {
                                          playBackgroundMusic == false
                                              ? onPressedMusic()
                                              : Vibration.vibrate();
                                        });

                                        setState(() {
                                          playBackgroundMusic = false;
                                        });
                                        _player.play();
                                      },
                                      child: Image.asset(
                                          'assets/bollywoodTable/mute.png',
                                          fit: BoxFit.cover,
                                          width: width * 0.045),
                                    ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    Positioned(
                      top: height * 0.33,
                      child: Column(
                        children: [
                          Image.asset(
                            'assets/bollywoodTable/bollywood-table.png',
                            fit: BoxFit.fill,
                            height: height * 0.67,
                          ),
                        ],
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
                    AnimatedSwitcher(
                      duration: Duration(milliseconds: 500),
                      child: Stack(
                        children: _coins,
                      ),
                    ),

                    Positioned(
                      top: height * 0.42,
                      left: width * 0.17,
                      child: Image.asset(
                        'assets/lucky7/images/frame/logo.png',
                        fit: BoxFit.cover,
                        height: height * 0.10,
                      ),
                    ),
                    Positioned(
                      top: height * 0.42,
                      right: width * 0.17,
                      child: Image.asset(
                        'assets/lucky7/images/frame/logo.png',
                        fit: BoxFit.cover,
                        height: height * 0.10,
                      ),
                    ),
                  

                    //------------------- RESULT IMAGE----------------//
                    startTimes <= 3 && autoTime != '0'
                        ? gameStopBetting(autoTime)
                        : SizedBox(),

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

                                

                    Positioned(
                      bottom: height * 0.0,
                      left: width * 0.28,
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

                                greenCoinAnimation = false;
                                lightBlueCoinAnimation = false;
                                brownCoinAnimation = false;
                              });
                            },
                            child: AnimatedContainer(
                              duration: Duration(milliseconds: 700),
                              alignment: Alignment.center,
                              height: redCoinAnimation == true && startTimes > 1
                                  ? height * 0.19
                                  : height * 0.13,
                              width: redCoinAnimation == true && startTimes > 1
                                  ? width * 0.09
                                  : width * 0.06,
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
                                lightGreenCoinAnimation =
                                    !lightBlueCoinAnimation;
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
                                  ? height * 0.19
                                  : height * 0.13,
                              width: lightGreenCoinAnimation == true &&
                                      startTimes > 1
                                  ? width * 0.09
                                  : width * 0.06,
                              decoration: BoxDecoration(
                                  image: DecorationImage(
                                      image: AssetImage(
                                          "assets/lucky7/images/coins/light_green_coin.png"),
                                      fit: BoxFit.fill)),
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
                                lightBlueCoinAnimation =
                                    !lightBlueCoinAnimation;
                                greenCoinAnimation = false;

                                brownCoinAnimation = false;
                              });
                            },
                            child: AnimatedContainer(
                              duration: Duration(milliseconds: 700),
                              alignment: Alignment.center,
                              height: lightBlueCoinAnimation == true &&
                                      startTimes > 1
                                  ? height * 0.19
                                  : height * 0.13,
                              width: lightBlueCoinAnimation == true &&
                                      startTimes > 1
                                  ? width * 0.09
                                  : width * 0.06,
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

                                greenCoinAnimation = !greenCoinAnimation;
                                lightBlueCoinAnimation = false;
                                brownCoinAnimation = false;
                              });
                            },
                            child: AnimatedContainer(
                              duration: Duration(milliseconds: 700),
                              alignment: Alignment.center,
                              height:
                                  greenCoinAnimation == true && startTimes > 1
                                      ? height * 0.19
                                      : height * 0.13,
                              width:
                                  greenCoinAnimation == true && startTimes > 1
                                      ? width * 0.09
                                      : width * 0.06,
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

                                greenCoinAnimation = false;
                                lightBlueCoinAnimation = false;
                                brownCoinAnimation = !brownCoinAnimation;
                              });
                            },
                            child: AnimatedContainer(
                              duration: Duration(milliseconds: 700),
                              alignment: Alignment.center,
                              height:
                                  brownCoinAnimation == true && startTimes > 1
                                      ? height * 0.19
                                      : height * 0.15,
                              width:
                                  brownCoinAnimation == true && startTimes > 1
                                      ? width * 0.09
                                      : width * 0.07,
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
                      top: height * 0.16,
                      right: 25,
                      child: Container(
                        padding: EdgeInsets.only(top: 15),
                        height: height * 0.7,
                        width: width * 0.04,
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
                                  setState(() {
                                    playBackgroundMusic == false
                                        ? onPressedMusic()
                                        : Vibration.vibrate();
                                  });
                                  DialogUtils.showResultBollyWood(
                                      context,
                                      items.c1,
                                      items.mid,
                                      items.detail,
                                      playBackgroundMusic);
                                },
                                child: Container(
                                  margin: EdgeInsets.all(2),
                                  padding: EdgeInsets.all(2),
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
                                      fontSize: 10.0,
                                    ),
                                  ),
                                ),
                              );
                            }),
                      ),
                    ),
                    Positioned(
                      bottom: height * 0.1,
                      left: width * 0.06,
                      child: Row(
                        children: [
                          Container(
                            height: height * 0.07,
                            padding: EdgeInsets.only(
                                left: width * 0.02, right: width * 0.02),
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                                image: DecorationImage(
                                    image: AssetImage(
                                        "assets/bollywoodTable/exposure-balance.png"))),
                            child: CustomText(
                                text: 'EXP $liablity',
                                color: Color(0xffFFEFC1),
                                fontSize: height * 0.025,
                                fontWeight: FontWeight.w500),
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
      backgroundColor: Colors.transparent,
      drawer: SizedBox(
                width: width * 0.55,
        child:Drawer(child: drawerWidget())),
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
                    top: height * 0.01),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                              image: DecorationImage(
                                  image: AssetImage(
                                      'assets/bollywoodTable/balance.png'),
                                  fit: BoxFit.fill)),
                          child: Row(
                            children: [
                              Container(
                                padding: EdgeInsets.symmetric(
                                    horizontal: width * 0.016),
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
                              )
                            ],
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
                              'assets/bollywoodTable/menu-button.png',
                              fit: BoxFit.cover,
                              height: height * 0.05),
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        playBackgroundMusic == false
                            ? InkWell(
                                onTap: () {
                                  setState(() {
                                    playBackgroundMusic == false
                                        ? onPressedMusic()
                                        : Vibration.vibrate();
                                  });

                                  setState(() {
                                    playBackgroundMusic = true;
                                  });
                                  _player.stop();
                                },
                                child: Image.asset(
                                    'assets/bollywoodTable/sound-on-button.png',
                                    fit: BoxFit.cover,
                                    height: height * 0.04),
                              )
                            : InkWell(
                                onTap: () {
                                  setState(() {
                                    playBackgroundMusic == false
                                        ? onPressedMusic()
                                        : Vibration.vibrate();
                                  });

                                  setState(() {
                                    playBackgroundMusic = false;
                                  });
                                  _player.play();
                                },
                                child: Image.asset(
                                    'assets/bollywoodTable/mute.png',
                                    fit: BoxFit.cover,
                                    height: height * 0.04),
                              )
                      ],
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(
                        vertical: width * 0.02,
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            padding: EdgeInsets.only(
                                left: width * 0.015,
                                right: width * 0.015,
                                top: height * 0.001),
                            height: height * 0.035,
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                                image: DecorationImage(
                                  image: AssetImage(
                                      "assets/bollywoodTable/exposure-balance.png"),
                                  fit: BoxFit.cover,
                                ),
                                borderRadius: BorderRadius.circular(2)),
                            child: CustomText(
                                text: 'EXP $liablity',
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
                              Navigator.push(
                                  context, _createRouteCurrentBets());
                            },
                            child: Container(
                              padding: EdgeInsets.only(
                                  left: width * 0.167, top: height * 0.001),
                              height: height * 0.040,
                              width: width * 0.25,
                              alignment: Alignment.center,
                              decoration: BoxDecoration(
                                  image: DecorationImage(
                                      image: AssetImage(
                                        'assets/bollywoodTable/show-my-bet.png',
                                      ),
                                      fit: BoxFit.fill)),
                              child: CustomText(
                                text: matchIdList.length.toString(),
                                fontWeight: FontWeight.w700,
                                color: Colors.white,
                                fontSize: width * 0.026,
                                textAlign: TextAlign.center,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                height: height * 0.04,
                width: width,
                padding:
                    EdgeInsets.only(left: width * 0.01, top: height * 0.002),
                margin: EdgeInsets.symmetric(horizontal: width * 0.01),
                alignment: Alignment.center,
                decoration: BoxDecoration(
                    image: DecorationImage(
                  image: AssetImage("assets/bollywoodTable/past-result-p.png"),
                  fit: BoxFit.fill,
                )),
                child: ListView.builder(
                    shrinkWrap: true,
                    itemCount: cardResultList.length,
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (context, index) {
                      var items = cardResultList[index];
                      return InkWell(
                        onTap: () {
                          setState(() {
                            playBackgroundMusic == false
                                ? onPressedMusic()
                                : Vibration.vibrate();
                          });
                          DialogUtils.showResultBollyWoodPortrait(
                              context,
                              items.c1,
                              items.mid,
                              items.detail,
                              playBackgroundMusic);
                        },
                        child: Container(
                          alignment: Alignment.center,
                          margin: const EdgeInsets.symmetric(horizontal: 6),
                          height: 20,
                          width: 20,
                          decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: items.winner == "1" || items.winner == "4"
                                  ? Color(0xaa028BA9)
                                  : items.winner == "2" || items.winner == "5"
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
                              fontSize: 10.0,
                            ),
                          ),
                        ),
                      );
                    }),
              ),
              SizedBox(
                height: height * 0.01,
              ),
              Container(
                margin: EdgeInsets.symmetric(horizontal: 20),
                alignment: Alignment.centerRight,
                child: Text(
                  "Min: 100 Max: 25000",
                  style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 10),
                ),
              ),
              BlinkText(
                "Round Id : $marketId",
                style: TextStyle(color: Colors.white),
              ),
              SizedBox(
                height: height * 0.02,
              ),
              Image.asset(
                'assets/lucky7/images/tableGirl.png',
                //  height: height * 0.3,
              ),
              Stack(
                children: [
                  Image.asset(
                    'assets/bollywoodTable/table-p[.png',
                    fit: BoxFit.cover,
                    height: height * 0.36,
                    //width: width * 1.00,
                  ),
                  Positioned(
                    top: 15,
                    left: 35,
                    child: Image.asset(
                      'assets/lucky7/images/frame/logo.png',
                      fit: BoxFit.cover,
                      height: height * 0.05,
                    ),
                  ),
                  Positioned(
                      top: 15,
                      right: 15,
                      child: Image.asset(
                        'assets/lucky7/images/frame/logo.png',
                        fit: BoxFit.cover,
                        height: height * 0.05,
                      )),
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
                      child: AnimatedSwitcher(
                        duration: Duration(milliseconds: 900),
                        child: Stack(
                          children: _coinsPort,
                        ),
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
                    left: width * 0.39,
                    top: height * 0.035,
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
                  startTimes <= 3 && autoTime != '0'
                      ? gameStopBettingPortrait(autoTime)
                      : SizedBox(),
                  autoTime == "45"
                      ? placeyourbetWidgetPortrait(autoTime)
                      : autoTime == "3" || autoTime == "2" || autoTime == "1"
                          ? goWidgetPort()
                          : autoTime == '0'
                              ? Positioned(
                                  top: height * 0.06,
                                  left: width * 0.2,
                                  child: showCurrentCardPort())
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
                    height: height * 0.1,
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
                              playBackgroundMusic == false
                                  ? onPressedMusic()
                                  : Vibration.vibrate();
                            });
                            if ((redCoinAnimation == true ||
                                    lightBlueCoinAnimation == true ||
                                    lightGreenCoinAnimation == true ||
                                    brownCoinAnimation == true ||
                                    greenCoinAnimation == true) &&
                                startTimes > 1) {
                              donButton = !donButton;
                            }
                            if (donButton == true) {
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
                              showMyDialogForBet(redCoinAnimation == true
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
                          },
                          child: Container(
                            alignment: Alignment.center,
                            margin: EdgeInsets.symmetric(
                                vertical: 5, horizontal: 5),
                            padding: EdgeInsets.symmetric(
                                vertical: 5, horizontal: 5),
                            decoration: BoxDecoration(
                                color: Color(0xaa72BBEF),
                                borderRadius: BorderRadius.circular(5)),
                            child: Text(
                              donRate,
                              style: TextStyle(
                                  fontWeight: FontWeight.w600, fontSize: 10),
                            ),
                          ),
                        ),
                        Text(
                          "Don",
                          style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.w600,
                              fontSize: 9),
                        ),
                        InkWell(
                          onTap: () {
                            setState(() {
                              playBackgroundMusic == false
                                  ? onPressedMusic()
                                  : Vibration.vibrate();
                            });
                            if ((redCoinAnimation == true ||
                                    lightBlueCoinAnimation == true ||
                                    lightGreenCoinAnimation == true ||
                                    brownCoinAnimation == true ||
                                    greenCoinAnimation == true) &&
                                startTimes > 1) {
                              donLayButton = !donLayButton;
                            }
                            if (donLayButton == true) {
                              donButton = false;
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
                              showMyDialogForBet(redCoinAnimation == true
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
                          },
                          child: Container(
                            alignment: Alignment.center,
                            margin: EdgeInsets.symmetric(
                                vertical: 5, horizontal: 5),
                            padding: EdgeInsets.symmetric(
                                vertical: 5, horizontal: 5),
                            decoration: BoxDecoration(
                                color: Color(0xaaFAA9BA),
                                borderRadius: BorderRadius.circular(5)),
                            child: Text(
                              donLayRate,
                              style: TextStyle(
                                  fontWeight: FontWeight.w600, fontSize: 10),
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
                    height: height * 0.1,
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
                              playBackgroundMusic == false
                                  ? onPressedMusic()
                                  : Vibration.vibrate();
                            });
                            if ((redCoinAnimation == true ||
                                    lightBlueCoinAnimation == true ||
                                    lightGreenCoinAnimation == true ||
                                    brownCoinAnimation == true ||
                                    greenCoinAnimation == true) &&
                                startTimes > 1) {
                              amarAkbarutton = !amarAkbarutton;
                            }
                            if (amarAkbarutton == true) {
                              donButton = false;
                              donLayButton = false;
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
                              showMyDialogForBet(redCoinAnimation == true
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
                          },
                          child: Container(
                            alignment: Alignment.center,
                            margin: EdgeInsets.symmetric(
                                vertical: 5, horizontal: 5),
                            padding: EdgeInsets.symmetric(
                                vertical: 5, horizontal: 5),
                            decoration: BoxDecoration(
                                color: Color(0xaa72BBEF),
                                borderRadius: BorderRadius.circular(5)),
                            child: Text(
                              amarakbarRate,
                              style: TextStyle(
                                  fontWeight: FontWeight.w600, fontSize: 10),
                            ),
                          ),
                        ),
                        Text(
                          "AMAR AKBAR ANTHONY",
                          style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.w600,
                              fontSize: 9),
                        ),
                        InkWell(
                          onTap: () {
                            setState(() {
                              playBackgroundMusic == false
                                  ? onPressedMusic()
                                  : Vibration.vibrate();
                            });
                            if ((redCoinAnimation == true ||
                                    lightBlueCoinAnimation == true ||
                                    lightGreenCoinAnimation == true ||
                                    brownCoinAnimation == true ||
                                    greenCoinAnimation == true) &&
                                startTimes > 1) {
                              amarLayAkbarutton = !amarLayAkbarutton;
                            }
                            if (amarLayAkbarutton == true) {
                              donButton = false;
                              donLayButton = false;
                              amarAkbarutton = false;
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
                              showMyDialogForBet(redCoinAnimation == true
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
                          },
                          child: Container(
                            alignment: Alignment.center,
                            margin: EdgeInsets.symmetric(
                                vertical: 5, horizontal: 5),
                            padding: EdgeInsets.symmetric(
                                vertical: 5, horizontal: 5),
                            decoration: BoxDecoration(
                                color: Color(0xaaFAA9BA),
                                borderRadius: BorderRadius.circular(5)),
                            child: Text(
                              amarAkbarLayRate,
                              style: TextStyle(
                                  fontWeight: FontWeight.w600, fontSize: 10),
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
                    height: height * 0.1,
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
                              playBackgroundMusic == false
                                  ? onPressedMusic()
                                  : Vibration.vibrate();
                            });
                            if ((redCoinAnimation == true ||
                                    lightBlueCoinAnimation == true ||
                                    lightGreenCoinAnimation == true ||
                                    brownCoinAnimation == true ||
                                    greenCoinAnimation == true) &&
                                startTimes > 1) {
                              sahibButton = !sahibButton;
                            }
                            if (sahibButton == true) {
                              donButton = false;
                              donLayButton = false;
                              amarAkbarutton = false;
                              amarLayAkbarutton = false;
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
                              showMyDialogForBet(redCoinAnimation == true
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
                          },
                          child: Container(
                            alignment: Alignment.center,
                            margin: EdgeInsets.symmetric(
                                vertical: 5, horizontal: 5),
                            padding: EdgeInsets.symmetric(
                                vertical: 5, horizontal: 5),
                            decoration: BoxDecoration(
                                color: Color(0xaa72BBEF),
                                borderRadius: BorderRadius.circular(5)),
                            child: Text(
                              sahibRate,
                              style: TextStyle(
                                  fontWeight: FontWeight.w600, fontSize: 10),
                            ),
                          ),
                        ),
                        Text(
                          "SHAHIB BIWI GULAM",
                          style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.w600,
                              fontSize: 9),
                        ),
                        InkWell(
                          onTap: () {
                            setState(() {
                              playBackgroundMusic == false
                                  ? onPressedMusic()
                                  : Vibration.vibrate();
                            });
                            if ((redCoinAnimation == true ||
                                    lightBlueCoinAnimation == true ||
                                    lightGreenCoinAnimation == true ||
                                    brownCoinAnimation == true ||
                                    greenCoinAnimation == true) &&
                                startTimes > 1) {
                              sahibLayButton = !sahibLayButton;
                            }
                            if (sahibLayButton == true) {
                              donButton = false;
                              donLayButton = false;
                              amarAkbarutton = false;
                              amarLayAkbarutton = false;
                              sahibButton = false;
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
                              showMyDialogForBet(redCoinAnimation == true
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
                          },
                          child: Container(
                            alignment: Alignment.center,
                            margin: EdgeInsets.symmetric(
                                vertical: 5, horizontal: 5),
                            padding: EdgeInsets.symmetric(
                                vertical: 5, horizontal: 5),
                            decoration: BoxDecoration(
                                color: Color(0xaaFAA9BA),
                                borderRadius: BorderRadius.circular(5)),
                            child: Text(
                              sahibLayRate,
                              style: TextStyle(
                                  fontWeight: FontWeight.w600, fontSize: 10),
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
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                children: [
                  Container(
                    height: height * 0.1,
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
                              playBackgroundMusic == false
                                  ? onPressedMusic()
                                  : Vibration.vibrate();
                            });
                            if ((redCoinAnimation == true ||
                                    lightBlueCoinAnimation == true ||
                                    lightGreenCoinAnimation == true ||
                                    brownCoinAnimation == true ||
                                    greenCoinAnimation == true) &&
                                startTimes > 1) {
                              dharamButton = !dharamButton;
                            }
                            if (dharamButton == true) {
                              donButton = false;
                              donLayButton = false;
                              amarAkbarutton = false;
                              amarLayAkbarutton = false;
                              sahibButton = false;
                              sahibLayButton = false;
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
                              showMyDialogForBet(redCoinAnimation == true
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
                          },
                          child: Container(
                            alignment: Alignment.center,
                            margin: EdgeInsets.symmetric(
                                vertical: 5, horizontal: 5),
                            padding: EdgeInsets.symmetric(
                                vertical: 5, horizontal: 5),
                            decoration: BoxDecoration(
                                color: Color(0xaa72BBEF),
                                borderRadius: BorderRadius.circular(5)),
                            child: Text(
                              dharamRate,
                              style: TextStyle(
                                  fontWeight: FontWeight.w600, fontSize: 10),
                            ),
                          ),
                        ),
                        Text(
                          "DHARAM VEER",
                          style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.w600,
                              fontSize: 9),
                        ),
                        InkWell(
                          onTap: () {
                            setState(() {
                              playBackgroundMusic == false
                                  ? onPressedMusic()
                                  : Vibration.vibrate();
                            });
                            if ((redCoinAnimation == true ||
                                    lightBlueCoinAnimation == true ||
                                    lightGreenCoinAnimation == true ||
                                    brownCoinAnimation == true ||
                                    greenCoinAnimation == true) &&
                                startTimes > 1) {
                              dharamLayButton = !dharamLayButton;
                            }
                            if (dharamLayButton == true) {
                              donButton = false;
                              donLayButton = false;
                              amarAkbarutton = false;
                              amarLayAkbarutton = false;
                              sahibButton = false;
                              sahibLayButton = false;
                              dharamButton = false;
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
                              showMyDialogForBet(redCoinAnimation == true
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
                          },
                          child: Container(
                            alignment: Alignment.center,
                            margin: EdgeInsets.symmetric(
                                vertical: 5, horizontal: 5),
                            padding: EdgeInsets.symmetric(
                                vertical: 5, horizontal: 5),
                            decoration: BoxDecoration(
                                color: Color(0xaaFAA9BA),
                                borderRadius: BorderRadius.circular(5)),
                            child: Text(
                              dharamLayRate,
                              style: TextStyle(
                                  fontWeight: FontWeight.w600, fontSize: 10),
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
                    height: height * 0.1,
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
                              playBackgroundMusic == false
                                  ? onPressedMusic()
                                  : Vibration.vibrate();
                            });
                            if ((redCoinAnimation == true ||
                                    lightBlueCoinAnimation == true ||
                                    lightGreenCoinAnimation == true ||
                                    brownCoinAnimation == true ||
                                    greenCoinAnimation == true) &&
                                startTimes > 1) {
                              kiskisButton = !kiskisButton;
                            }
                            if (kiskisButton == true) {
                              donButton = false;
                              donLayButton = false;
                              amarAkbarutton = false;
                              amarLayAkbarutton = false;
                              sahibButton = false;
                              sahibLayButton = false;
                              dharamButton = false;
                              dharamLayButton = false;
                              kiskisLayButton = false;
                              ghulamButton = false;
                              ghulamLayButton = false;
                              oddButton = false;
                              oddLayButton = false;
                              dulhaButton = false;
                              baratiButton = false;
                              redButton = false;
                              blackButton = false;
                              showMyDialogForBet(redCoinAnimation == true
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
                          },
                          child: Container(
                            alignment: Alignment.center,
                            margin: EdgeInsets.symmetric(
                                vertical: 5, horizontal: 5),
                            padding: EdgeInsets.symmetric(
                                vertical: 5, horizontal: 5),
                            decoration: BoxDecoration(
                                color: Color(0xaa72BBEF),
                                borderRadius: BorderRadius.circular(5)),
                            child: Text(
                              kiskisRate,
                              style: TextStyle(
                                  fontWeight: FontWeight.w600, fontSize: 10),
                            ),
                          ),
                        ),
                        Text(
                          "KIS KIS KO PYAR KAROON",
                          style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.w600,
                              fontSize: 9),
                        ),
                        InkWell(
                          onTap: () {
                            setState(() {
                              playBackgroundMusic == false
                                  ? onPressedMusic()
                                  : Vibration.vibrate();
                            });
                            if ((redCoinAnimation == true ||
                                    lightBlueCoinAnimation == true ||
                                    lightGreenCoinAnimation == true ||
                                    brownCoinAnimation == true ||
                                    greenCoinAnimation == true) &&
                                startTimes > 1) {
                              kiskisLayButton = !kiskisLayButton;
                            }
                            if (kiskisLayButton == true) {
                              donButton = false;
                              donLayButton = false;
                              amarAkbarutton = false;
                              amarLayAkbarutton = false;
                              sahibButton = false;
                              sahibLayButton = false;
                              dharamButton = false;
                              dharamLayButton = false;
                              kiskisButton = false;
                              ghulamButton = false;
                              ghulamLayButton = false;
                              oddButton = false;
                              oddLayButton = false;
                              dulhaButton = false;
                              baratiButton = false;
                              redButton = false;
                              blackButton = false;
                              showMyDialogForBet(redCoinAnimation == true
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
                          },
                          child: Container(
                            alignment: Alignment.center,
                            margin: EdgeInsets.symmetric(
                                vertical: 5, horizontal: 5),
                            padding: EdgeInsets.symmetric(
                                vertical: 5, horizontal: 5),
                            decoration: BoxDecoration(
                                color: Color(0xaaFAA9BA),
                                borderRadius: BorderRadius.circular(5)),
                            child: Text(
                              kiskisLayRate,
                              style: TextStyle(
                                  fontWeight: FontWeight.w600, fontSize: 10),
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
                    height: height * 0.1,
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
                              playBackgroundMusic == false
                                  ? onPressedMusic()
                                  : Vibration.vibrate();
                            });
                            if ((redCoinAnimation == true ||
                                    lightBlueCoinAnimation == true ||
                                    lightGreenCoinAnimation == true ||
                                    brownCoinAnimation == true ||
                                    greenCoinAnimation == true) &&
                                startTimes > 1) {
                              ghulamButton = !ghulamButton;
                            }
                            if (ghulamButton == true) {
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
                              ghulamLayButton = false;
                              oddButton = false;
                              oddLayButton = false;
                              dulhaButton = false;
                              baratiButton = false;
                              redButton = false;
                              blackButton = false;
                              showMyDialogForBet(redCoinAnimation == true
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
                          },
                          child: Container(
                            alignment: Alignment.center,
                            margin: EdgeInsets.symmetric(
                                vertical: 5, horizontal: 5),
                            padding: EdgeInsets.symmetric(
                                vertical: 5, horizontal: 5),
                            decoration: BoxDecoration(
                                color: Color(0xaa72BBEF),
                                borderRadius: BorderRadius.circular(5)),
                            child: Text(
                              ghulamRate,
                              style: TextStyle(
                                  fontWeight: FontWeight.w600, fontSize: 10),
                            ),
                          ),
                        ),
                        Text(
                          "GHULAM",
                          style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.w600,
                              fontSize: 9),
                        ),
                        InkWell(
                          onTap: () {
                            setState(() {
                              playBackgroundMusic == false
                                  ? onPressedMusic()
                                  : Vibration.vibrate();
                            });
                            if ((redCoinAnimation == true ||
                                    lightBlueCoinAnimation == true ||
                                    lightGreenCoinAnimation == true ||
                                    brownCoinAnimation == true ||
                                    greenCoinAnimation == true) &&
                                startTimes > 1) {
                              ghulamLayButton = !ghulamLayButton;
                            }
                            if (ghulamLayButton == true) {
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
                              oddButton = false;
                              oddLayButton = false;
                              dulhaButton = false;
                              baratiButton = false;
                              redButton = false;
                              blackButton = false;
                              showMyDialogForBet(redCoinAnimation == true
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
                          },
                          child: Container(
                            alignment: Alignment.center,
                            margin: EdgeInsets.symmetric(
                                vertical: 5, horizontal: 5),
                            padding: EdgeInsets.symmetric(
                                vertical: 5, horizontal: 5),
                            decoration: BoxDecoration(
                                color: Color(0xaaFAA9BA),
                                borderRadius: BorderRadius.circular(5)),
                            child: Text(
                              ghulamLayRate,
                              style: TextStyle(
                                  fontWeight: FontWeight.w600, fontSize: 10),
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
          Container(
            height: 2,
            width: width,
            decoration: BoxDecoration(
                image: DecorationImage(
                    image: AssetImage("assets/bollywoodTable/Line 42 (3).png"),
                    fit: BoxFit.cover)),
          ),
          SizedBox(
            height: height * 0.02,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Column(
                children: [
                  Container(
                    height: height * 0.1,
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
                              playBackgroundMusic == false
                                  ? onPressedMusic()
                                  : Vibration.vibrate();
                            });
                            if ((redCoinAnimation == true ||
                                    lightBlueCoinAnimation == true ||
                                    lightGreenCoinAnimation == true ||
                                    brownCoinAnimation == true ||
                                    greenCoinAnimation == true) &&
                                startTimes > 1) {
                              oddButton = !oddButton;
                            }
                            if (oddButton == true) {
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
                              oddLayButton = false;
                              dulhaButton = false;
                              baratiButton = false;
                              redButton = false;
                              blackButton = false;
                              showMyDialogForBet(redCoinAnimation == true
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
                          },
                          child: Container(
                            alignment: Alignment.center,
                            margin: EdgeInsets.symmetric(
                                vertical: 5, horizontal: 5),
                            padding: EdgeInsets.symmetric(
                                vertical: 5, horizontal: 5),
                            decoration: BoxDecoration(
                                color: Color(0xaa72BBEF),
                                borderRadius: BorderRadius.circular(5)),
                            child: Text(
                              oddRate,
                              style: TextStyle(
                                  fontWeight: FontWeight.w600, fontSize: 10),
                            ),
                          ),
                        ),
                        Text(
                          "ODD",
                          style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.w600,
                              fontSize: 9),
                        ),
                        InkWell(
                          onTap: () {
                            setState(() {
                              playBackgroundMusic == false
                                  ? onPressedMusic()
                                  : Vibration.vibrate();
                            });
                            if ((redCoinAnimation == true ||
                                    lightBlueCoinAnimation == true ||
                                    lightGreenCoinAnimation == true ||
                                    brownCoinAnimation == true ||
                                    greenCoinAnimation == true) &&
                                startTimes > 1) {
                              oddLayButton = !oddLayButton;
                            }
                            if (oddLayButton == true) {
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
                              dulhaButton = false;
                              baratiButton = false;
                              redButton = false;
                              blackButton = false;
                              showMyDialogForBet(redCoinAnimation == true
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
                          },
                          child: Container(
                            alignment: Alignment.center,
                            margin: EdgeInsets.symmetric(
                                vertical: 5, horizontal: 5),
                            padding: EdgeInsets.symmetric(
                                vertical: 5, horizontal: 5),
                            decoration: BoxDecoration(
                                color: Color(0xaaFAA9BA),
                                borderRadius: BorderRadius.circular(5)),
                            child: Text(
                              oddLayRate,
                              style: TextStyle(
                                  fontWeight: FontWeight.w600, fontSize: 10),
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
                width: width * 0.05,
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
                width: width * 0.05,
              ),
              Column(
                children: [
                  SizedBox(
                    height: height * 0.03,
                  ),
                  Container(
                    height: height * 0.1,
                    width: width * 0.2,
                    padding: EdgeInsets.only(left: 10),
                    decoration: BoxDecoration(
                        border: Border.all(color: Color(0xaa873800), width: 2),
                        borderRadius: BorderRadius.circular(5)),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "DULHA DULHAN K-Q",
                          style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.w600,
                              fontSize: 9),
                        ),
                        InkWell(
                          onTap: () {
                            setState(() {
                              playBackgroundMusic == false
                                  ? onPressedMusic()
                                  : Vibration.vibrate();
                            });
                            if ((redCoinAnimation == true ||
                                    lightBlueCoinAnimation == true ||
                                    lightGreenCoinAnimation == true ||
                                    brownCoinAnimation == true ||
                                    greenCoinAnimation == true) &&
                                startTimes > 1) {
                              dulhaButton = !dulhaButton;
                            }
                            if (dulhaButton == true) {
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
                              baratiButton = false;
                              redButton = false;
                              blackButton = false;
                              showMyDialogForBet(redCoinAnimation == true
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
                          },
                          child: Container(
                            alignment: Alignment.center,
                            margin: EdgeInsets.symmetric(
                                vertical: 5, horizontal: 5),
                            padding: EdgeInsets.symmetric(
                                vertical: 5, horizontal: 5),
                            decoration: BoxDecoration(
                                color: Color(0xaa72BBEF),
                                borderRadius: BorderRadius.circular(5)),
                            child: Text(
                              dulhaDulhanRate,
                              style: TextStyle(
                                  fontWeight: FontWeight.w600, fontSize: 10),
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
                  Container(
                    height: height * 0.1,
                    width: width * 0.2,
                    decoration: BoxDecoration(
                        border: Border.all(color: Color(0xaa873800), width: 2),
                        borderRadius: BorderRadius.circular(5)),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          height: height * 0.05,
                          width: width * 0.06,
                          decoration: BoxDecoration(
                              image: DecorationImage(
                                  image: AssetImage(
                                      "assets/bollywoodTable/black-image.png"),
                                  fit: BoxFit.contain)),
                        ),
                        InkWell(
                          onTap: () {
                            setState(() {
                              playBackgroundMusic == false
                                  ? onPressedMusic()
                                  : Vibration.vibrate();
                            });
                            if ((redCoinAnimation == true ||
                                    lightBlueCoinAnimation == true ||
                                    lightGreenCoinAnimation == true ||
                                    brownCoinAnimation == true ||
                                    greenCoinAnimation == true) &&
                                startTimes > 1) {
                              blackButton = !blackButton;
                            }
                            if (blackButton == true) {
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
                              baratiButton = false;
                              redButton = false;
                              dulhaButton = false;
                              showMyDialogForBet(redCoinAnimation == true
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
                          },
                          child: Container(
                            alignment: Alignment.center,
                            margin: EdgeInsets.symmetric(
                                vertical: 5, horizontal: 5),
                            padding: EdgeInsets.symmetric(
                                vertical: 5, horizontal: 5),
                            decoration: BoxDecoration(
                                color: Color(0xaa72BBEF),
                                borderRadius: BorderRadius.circular(5)),
                            child: Text(
                              blackRate,
                              style: TextStyle(
                                  fontWeight: FontWeight.w600, fontSize: 10),
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
                width: width * 0.02,
              ),
              Column(
                children: [
                  SizedBox(
                    height: height * 0.03,
                  ),
                  Container(
                    height: height * 0.1,
                    width: width * 0.2,
                    padding: EdgeInsets.only(left: 10),
                    decoration: BoxDecoration(
                        border: Border.all(color: Color(0xaa873800), width: 2),
                        borderRadius: BorderRadius.circular(5)),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "BARATI J-A",
                          style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.w600,
                              fontSize: 9),
                        ),
                        InkWell(
                          onTap: () {
                            setState(() {
                              playBackgroundMusic == false
                                  ? onPressedMusic()
                                  : Vibration.vibrate();
                            });
                            if ((redCoinAnimation == true ||
                                    lightBlueCoinAnimation == true ||
                                    lightGreenCoinAnimation == true ||
                                    brownCoinAnimation == true ||
                                    greenCoinAnimation == true) &&
                                startTimes > 1) {
                              baratiButton = !baratiButton;
                            }
                            if (baratiButton == true) {
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
                              blackButton = false;
                              redButton = false;
                              dulhaButton = false;
                              showMyDialogForBet(redCoinAnimation == true
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
                          },
                          child: Container(
                            alignment: Alignment.center,
                            margin: EdgeInsets.symmetric(
                                vertical: 5, horizontal: 5),
                            padding: EdgeInsets.symmetric(
                                vertical: 5, horizontal: 5),
                            decoration: BoxDecoration(
                                color: Color(0xaa72BBEF),
                                borderRadius: BorderRadius.circular(5)),
                            child: Text(
                              baratiRate,
                              style: TextStyle(
                                  fontWeight: FontWeight.w600, fontSize: 10),
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
                  Container(
                    height: height * 0.1,
                    width: width * 0.2,
                    decoration: BoxDecoration(
                        border: Border.all(color: Color(0xaa873800), width: 2),
                        borderRadius: BorderRadius.circular(5)),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          height: height * 0.05,
                          width: width * 0.06,
                          decoration: BoxDecoration(
                              image: DecorationImage(
                                  image: AssetImage(
                                      "assets/bollywoodTable/red-image.png"),
                                  fit: BoxFit.contain)),
                        ),
                        InkWell(
                          onTap: () {
                            setState(() {
                              playBackgroundMusic == false
                                  ? onPressedMusic()
                                  : Vibration.vibrate();
                            });
                            if ((redCoinAnimation == true ||
                                    lightBlueCoinAnimation == true ||
                                    lightGreenCoinAnimation == true ||
                                    brownCoinAnimation == true ||
                                    greenCoinAnimation == true) &&
                                startTimes > 1) {
                              redButton = !redButton;
                            }
                            if (redButton == true) {
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
                              blackButton = false;
                              baratiButton = false;
                              dulhaButton = false;
                              showMyDialogForBet(redCoinAnimation == true
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
                          },
                          child: Container(
                            alignment: Alignment.center,
                            margin: EdgeInsets.symmetric(
                                vertical: 5, horizontal: 5),
                            padding: EdgeInsets.symmetric(
                                vertical: 5, horizontal: 5),
                            decoration: BoxDecoration(
                                color: Color(0xaa72BBEF),
                                borderRadius: BorderRadius.circular(5)),
                            child: Text(
                              redRate,
                              style: TextStyle(
                                  fontWeight: FontWeight.w600, fontSize: 10),
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
            height: height * 0.05,
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
                      playBackgroundMusic == false
                          ? onPressedMusic()
                          : Vibration.vibrate();
                    });
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
                          greenCoinAnimation == true ||
                          lightBlueCoinAnimation == true ||
                          brownCoinAnimation == true) {
                        showMyDialogForBetPortrait(redCoinAnimation == true
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
                  child: Container(
                    alignment: Alignment.center,
                    margin: EdgeInsets.symmetric(vertical: 5, horizontal: 5),
                    padding: EdgeInsets.symmetric(vertical: 5, horizontal: 5),
                    decoration: BoxDecoration(
                        color: Color(0xaa72BBEF),
                        borderRadius: BorderRadius.circular(5)),
                    child: Text(
                      donRate,
                      style:
                          TextStyle(fontWeight: FontWeight.w600, fontSize: 10),
                    ),
                  ),
                ),
                Text(
                  "Don",
                  style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w600,
                      fontSize: 9),
                ),
                InkWell(
                  onTap: () {
                    setState(() {
                      playBackgroundMusic == false
                          ? onPressedMusic()
                          : Vibration.vibrate();
                    });
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
                          greenCoinAnimation == true ||
                          lightBlueCoinAnimation == true ||
                          brownCoinAnimation == true) {
                        showMyDialogForBetPortrait(redCoinAnimation == true
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
                  child: Container(
                    alignment: Alignment.center,
                    margin: EdgeInsets.symmetric(vertical: 5, horizontal: 5),
                    padding: EdgeInsets.symmetric(vertical: 5, horizontal: 5),
                    decoration: BoxDecoration(
                        color: Color(0xaaFAA9BA),
                        borderRadius: BorderRadius.circular(5)),
                    child: Text(
                      donLayRate,
                      style:
                          TextStyle(fontWeight: FontWeight.w600, fontSize: 10),
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
          Container(
            height: height * 0.05,
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
                      playBackgroundMusic == false
                          ? onPressedMusic()
                          : Vibration.vibrate();
                    });
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
                          greenCoinAnimation == true ||
                          lightBlueCoinAnimation == true ||
                          brownCoinAnimation == true) {
                        showMyDialogForBetPortrait(redCoinAnimation == true
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
                  child: Container(
                    alignment: Alignment.center,
                    margin: EdgeInsets.symmetric(vertical: 5, horizontal: 5),
                    padding: EdgeInsets.symmetric(vertical: 5, horizontal: 5),
                    decoration: BoxDecoration(
                        color: Color(0xaa72BBEF),
                        borderRadius: BorderRadius.circular(5)),
                    child: Text(
                      amarakbarRate,
                      style:
                          TextStyle(fontWeight: FontWeight.w600, fontSize: 10),
                    ),
                  ),
                ),
                Text(
                  "AMAR AKBAR ANTHONY",
                  style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w600,
                      fontSize: 9),
                ),
                InkWell(
                  onTap: () {
                    setState(() {
                      playBackgroundMusic == false
                          ? onPressedMusic()
                          : Vibration.vibrate();
                    });
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
                          greenCoinAnimation == true ||
                          lightBlueCoinAnimation == true ||
                          brownCoinAnimation == true) {
                        showMyDialogForBetPortrait(redCoinAnimation == true
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
                  child: Container(
                    alignment: Alignment.center,
                    margin: EdgeInsets.symmetric(vertical: 5, horizontal: 5),
                    padding: EdgeInsets.symmetric(vertical: 5, horizontal: 5),
                    decoration: BoxDecoration(
                        color: Color(0xaaFAA9BA),
                        borderRadius: BorderRadius.circular(5)),
                    child: Text(
                      amarAkbarLayRate,
                      style:
                          TextStyle(fontWeight: FontWeight.w600, fontSize: 10),
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
          Container(
            height: height * 0.05,
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
                      playBackgroundMusic == false
                          ? onPressedMusic()
                          : Vibration.vibrate();
                    });
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
                          greenCoinAnimation == true ||
                          lightBlueCoinAnimation == true ||
                          brownCoinAnimation == true) {
                        showMyDialogForBetPortrait(redCoinAnimation == true
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
                  child: Container(
                    alignment: Alignment.center,
                    margin: EdgeInsets.symmetric(vertical: 5, horizontal: 5),
                    padding: EdgeInsets.symmetric(vertical: 5, horizontal: 5),
                    decoration: BoxDecoration(
                        color: Color(0xaa72BBEF),
                        borderRadius: BorderRadius.circular(5)),
                    child: Text(
                      sahibRate,
                      style:
                          TextStyle(fontWeight: FontWeight.w600, fontSize: 10),
                    ),
                  ),
                ),
                Text(
                  "SHAHIB BIWI GULAM",
                  style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w600,
                      fontSize: 9),
                ),
                InkWell(
                  onTap: () {
                    setState(() {
                      playBackgroundMusic == false
                          ? onPressedMusic()
                          : Vibration.vibrate();
                    });
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
                          greenCoinAnimation == true ||
                          lightBlueCoinAnimation == true ||
                          brownCoinAnimation == true) {
                        showMyDialogForBetPortrait(redCoinAnimation == true
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
                  child: Container(
                    alignment: Alignment.center,
                    margin: EdgeInsets.symmetric(vertical: 5, horizontal: 5),
                    padding: EdgeInsets.symmetric(vertical: 5, horizontal: 5),
                    decoration: BoxDecoration(
                        color: Color(0xaaFAA9BA),
                        borderRadius: BorderRadius.circular(5)),
                    child: Text(
                      sahibLayRate,
                      style:
                          TextStyle(fontWeight: FontWeight.w600, fontSize: 10),
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
          Container(
            height: height * 0.05,
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
                      playBackgroundMusic == false
                          ? onPressedMusic()
                          : Vibration.vibrate();
                    });
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
                          greenCoinAnimation == true ||
                          lightBlueCoinAnimation == true ||
                          brownCoinAnimation == true) {
                        showMyDialogForBetPortrait(redCoinAnimation == true
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
                  child: Container(
                    alignment: Alignment.center,
                    margin: EdgeInsets.symmetric(vertical: 5, horizontal: 5),
                    padding: EdgeInsets.symmetric(vertical: 5, horizontal: 5),
                    decoration: BoxDecoration(
                        color: Color(0xaa72BBEF),
                        borderRadius: BorderRadius.circular(5)),
                    child: Text(
                      dharamRate,
                      style:
                          TextStyle(fontWeight: FontWeight.w600, fontSize: 10),
                    ),
                  ),
                ),
                Text(
                  "DHARAM VEER",
                  style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w600,
                      fontSize: 9),
                ),
                InkWell(
                  onTap: () {
                    setState(() {
                      playBackgroundMusic == false
                          ? onPressedMusic()
                          : Vibration.vibrate();
                    });
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
                          greenCoinAnimation == true ||
                          lightBlueCoinAnimation == true ||
                          brownCoinAnimation == true) {
                        showMyDialogForBetPortrait(redCoinAnimation == true
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
                  child: Container(
                    alignment: Alignment.center,
                    margin: EdgeInsets.symmetric(vertical: 5, horizontal: 5),
                    padding: EdgeInsets.symmetric(vertical: 5, horizontal: 5),
                    decoration: BoxDecoration(
                        color: Color(0xaaFAA9BA),
                        borderRadius: BorderRadius.circular(5)),
                    child: Text(
                      dharamLayRate,
                      style:
                          TextStyle(fontWeight: FontWeight.w600, fontSize: 10),
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
          Container(
            height: height * 0.05,
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
                      playBackgroundMusic == false
                          ? onPressedMusic()
                          : Vibration.vibrate();
                    });
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
                          greenCoinAnimation == true ||
                          lightBlueCoinAnimation == true ||
                          brownCoinAnimation == true) {
                        showMyDialogForBetPortrait(redCoinAnimation == true
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
                  child: Container(
                    alignment: Alignment.center,
                    margin: EdgeInsets.symmetric(vertical: 5, horizontal: 5),
                    padding: EdgeInsets.symmetric(vertical: 5, horizontal: 5),
                    decoration: BoxDecoration(
                        color: Color(0xaa72BBEF),
                        borderRadius: BorderRadius.circular(5)),
                    child: Text(
                      kiskisRate,
                      style:
                          TextStyle(fontWeight: FontWeight.w600, fontSize: 10),
                    ),
                  ),
                ),
                Text(
                  "KIS KIS KO PYAR KAROON",
                  style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w600,
                      fontSize: 9),
                ),
                InkWell(
                  onTap: () {
                    setState(() {
                      playBackgroundMusic == false
                          ? onPressedMusic()
                          : Vibration.vibrate();
                    });
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
                          greenCoinAnimation == true ||
                          lightBlueCoinAnimation == true ||
                          brownCoinAnimation == true) {
                        showMyDialogForBetPortrait(redCoinAnimation == true
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
                  child: Container(
                    alignment: Alignment.center,
                    margin: EdgeInsets.symmetric(vertical: 5, horizontal: 5),
                    padding: EdgeInsets.symmetric(vertical: 5, horizontal: 5),
                    decoration: BoxDecoration(
                        color: Color(0xaaFAA9BA),
                        borderRadius: BorderRadius.circular(5)),
                    child: Text(
                      kiskisLayRate,
                      style:
                          TextStyle(fontWeight: FontWeight.w600, fontSize: 10),
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
                      color: liablity9 >= 0.0 ? Colors.green : Colors.red),
                )
              : Text(""),
          Container(
            height: height * 0.05,
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
                      playBackgroundMusic == false
                          ? onPressedMusic()
                          : Vibration.vibrate();
                    });
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
                          greenCoinAnimation == true ||
                          lightBlueCoinAnimation == true ||
                          brownCoinAnimation == true) {
                        showMyDialogForBetPortrait(redCoinAnimation == true
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
                  child: Container(
                    alignment: Alignment.center,
                    margin: EdgeInsets.symmetric(vertical: 5, horizontal: 5),
                    padding: EdgeInsets.symmetric(vertical: 5, horizontal: 5),
                    decoration: BoxDecoration(
                        color: Color(0xaa72BBEF),
                        borderRadius: BorderRadius.circular(5)),
                    child: Text(
                      ghulamRate,
                      style:
                          TextStyle(fontWeight: FontWeight.w600, fontSize: 10),
                    ),
                  ),
                ),
                Text(
                  "GHULAM",
                  style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w600,
                      fontSize: 9),
                ),
                InkWell(
                  onTap: () {
                    setState(() {
                      playBackgroundMusic == false
                          ? onPressedMusic()
                          : Vibration.vibrate();
                    });
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
                          greenCoinAnimation == true ||
                          lightBlueCoinAnimation == true ||
                          brownCoinAnimation == true) {
                        showMyDialogForBetPortrait(redCoinAnimation == true
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
                  child: Container(
                    alignment: Alignment.center,
                    margin: EdgeInsets.symmetric(vertical: 5, horizontal: 5),
                    padding: EdgeInsets.symmetric(vertical: 5, horizontal: 5),
                    decoration: BoxDecoration(
                        color: Color(0xaaFAA9BA),
                        borderRadius: BorderRadius.circular(5)),
                    child: Text(
                      ghulamLayRate,
                      style:
                          TextStyle(fontWeight: FontWeight.w600, fontSize: 10),
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
                      color: liablity10 >= 0.0 ? Colors.green : Colors.red),
                )
              : Text(""),
          Container(
            margin: EdgeInsets.symmetric(vertical: height * 0.01),
            height: 2,
            width: width,
            decoration: BoxDecoration(
                image: DecorationImage(
                    image: AssetImage("assets/bollywoodTable/Line 42 (3).png"),
                    fit: BoxFit.contain)),
          ),
          Column(
            children: [
              Container(
                height: height * 0.05,
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
                          playBackgroundMusic == false
                              ? onPressedMusic()
                              : Vibration.vibrate();
                        });
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
                              greenCoinAnimation == true ||
                              lightBlueCoinAnimation == true ||
                              brownCoinAnimation == true) {
                            showMyDialogForBetPortrait(redCoinAnimation == true
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
                      child: Container(
                        alignment: Alignment.center,
                        margin:
                            EdgeInsets.symmetric(vertical: 5, horizontal: 5),
                        padding:
                            EdgeInsets.symmetric(vertical: 5, horizontal: 5),
                        decoration: BoxDecoration(
                            color: Color(0xaa72BBEF),
                            borderRadius: BorderRadius.circular(5)),
                        child: Text(
                          oddRate,
                          style: TextStyle(
                              fontWeight: FontWeight.w600, fontSize: 10),
                        ),
                      ),
                    ),
                    Text(
                      "ODD",
                      style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w600,
                          fontSize: 9),
                    ),
                    InkWell(
                      onTap: () {
                        setState(() {
                          playBackgroundMusic == false
                              ? onPressedMusic()
                              : Vibration.vibrate();
                        });
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
                              greenCoinAnimation == true ||
                              lightBlueCoinAnimation == true ||
                              brownCoinAnimation == true) {
                            showMyDialogForBetPortrait(redCoinAnimation == true
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
                      child: Container(
                        alignment: Alignment.center,
                        margin:
                            EdgeInsets.symmetric(vertical: 5, horizontal: 5),
                        padding:
                            EdgeInsets.symmetric(vertical: 5, horizontal: 5),
                        decoration: BoxDecoration(
                            color: Color(0xaaFAA9BA),
                            borderRadius: BorderRadius.circular(5)),
                        child: Text(
                          oddLayRate,
                          style: TextStyle(
                              fontWeight: FontWeight.w600, fontSize: 10),
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
                          color: liablity11 >= 0.0 ? Colors.green : Colors.red),
                    )
                  : Text(""),
            ],
          ),
          Container(
            margin: EdgeInsets.symmetric(vertical: height * 0.01),
            height: 2,
            width: width,
            decoration: BoxDecoration(
                image: DecorationImage(
                    image: AssetImage("assets/bollywoodTable/Line 42 (3).png"),
                    fit: BoxFit.contain)),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(children: [
                Container(
                  height: height * 0.05,
                  width: width * 0.4,
                  padding: EdgeInsets.only(left: width * 0.02),
                  decoration: BoxDecoration(
                      border: Border.all(color: Color(0xaa873800), width: 2),
                      borderRadius: BorderRadius.circular(5)),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "DULHA DULHAN K-Q",
                        style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.w600,
                            fontSize: 9),
                      ),
                      InkWell(
                        onTap: () {
                          setState(() {
                            playBackgroundMusic == false
                                ? onPressedMusic()
                                : Vibration.vibrate();
                          });
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
                                greenCoinAnimation == true ||
                                lightBlueCoinAnimation == true ||
                                brownCoinAnimation == true) {
                              showMyDialogForBetPortrait(
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
                        child: Container(
                          alignment: Alignment.center,
                          margin:
                              EdgeInsets.symmetric(vertical: 5, horizontal: 5),
                          padding:
                              EdgeInsets.symmetric(vertical: 5, horizontal: 5),
                          decoration: BoxDecoration(
                              color: Color(0xaa0288A5),
                              borderRadius: BorderRadius.circular(5)),
                          child: Text(
                            dulhaDulhanRate,
                            style: TextStyle(
                                fontWeight: FontWeight.w600, fontSize: 10),
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
              ]),
              Column(
                children: [
                  Container(
                    height: height * 0.05,
                    width: width * 0.4,
                    padding: EdgeInsets.only(left: width * 0.02),
                    decoration: BoxDecoration(
                        border: Border.all(color: Color(0xaa873800), width: 2),
                        borderRadius: BorderRadius.circular(5)),
                    child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "BARATI J-A",
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.w600,
                                fontSize: 9),
                          ),
                          InkWell(
                            onTap: () {
                              setState(() {
                                playBackgroundMusic == false
                                    ? onPressedMusic()
                                    : Vibration.vibrate();
                              });
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
                                    greenCoinAnimation == true ||
                                    lightBlueCoinAnimation == true ||
                                    brownCoinAnimation == true) {
                                  showMyDialogForBetPortrait(redCoinAnimation ==
                                          true
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
                            child: Container(
                              alignment: Alignment.center,
                              margin: EdgeInsets.symmetric(
                                  vertical: 5, horizontal: 5),
                              padding: EdgeInsets.symmetric(
                                  vertical: 5, horizontal: 5),
                              decoration: BoxDecoration(
                                  color: Color(0xaa0288A5),
                                  borderRadius: BorderRadius.circular(5)),
                              child: Text(
                                baratiRate,
                                style: TextStyle(
                                    fontWeight: FontWeight.w600, fontSize: 10),
                              ),
                            ),
                          ),
                        ]),
                  ),
                  showLiablity == true
                      ? Text(
                          liablity4.toString(),
                          style: TextStyle(
                              color:
                                  liablity4 >= 0.0 ? Colors.green : Colors.red),
                        )
                      : Text(""),
                ],
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(children: [
                Container(
                  height: height * 0.05,
                  width: width * 0.4,
                  padding: EdgeInsets.only(left: width * 0.02),
                  decoration: BoxDecoration(
                      border: Border.all(color: Color(0xaa873800), width: 2),
                      borderRadius: BorderRadius.circular(5)),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
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
                            playBackgroundMusic == false
                                ? onPressedMusic()
                                : Vibration.vibrate();
                          });
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
                                greenCoinAnimation == true ||
                                lightBlueCoinAnimation == true ||
                                brownCoinAnimation == true) {
                              showMyDialogForBetPortrait(
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
                        child: Container(
                          alignment: Alignment.center,
                          margin:
                              EdgeInsets.symmetric(vertical: 5, horizontal: 5),
                          padding:
                              EdgeInsets.symmetric(vertical: 5, horizontal: 5),
                          decoration: BoxDecoration(
                              color: Color(0xaa0288A5),
                              borderRadius: BorderRadius.circular(5)),
                          child: Text(
                            blackRate,
                            style: TextStyle(
                                fontWeight: FontWeight.w600, fontSize: 10),
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
                            color:
                                liablity12 >= 0.0 ? Colors.green : Colors.red),
                      )
                    : Text(""),
              ]),
              Column(
                children: [
                  Container(
                    height: height * 0.05,
                    width: width * 0.4,
                    padding: EdgeInsets.only(left: width * 0.02),
                    decoration: BoxDecoration(
                        border: Border.all(color: Color(0xaa873800), width: 2),
                        borderRadius: BorderRadius.circular(5)),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
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
                              playBackgroundMusic == false
                                  ? onPressedMusic()
                                  : Vibration.vibrate();
                            });
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
                                  greenCoinAnimation == true ||
                                  lightBlueCoinAnimation == true ||
                                  brownCoinAnimation == true) {
                                showMyDialogForBetPortrait(
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
                          child: Container(
                            alignment: Alignment.center,
                            margin: EdgeInsets.symmetric(
                                vertical: 5, horizontal: 5),
                            padding: EdgeInsets.symmetric(
                                vertical: 5, horizontal: 5),
                            decoration: BoxDecoration(
                                color: Color(0xaa0288A5),
                                borderRadius: BorderRadius.circular(5)),
                            child: Text(
                              redRate,
                              style: TextStyle(
                                  fontWeight: FontWeight.w600, fontSize: 10),
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
            top: height * 0.42,
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
                  width: width * 0.4,
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
    return Container(
      alignment: Alignment.center,
      height: height * 0.5,
      width: width * 0.3,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          image: DecorationImage(
              image: AssetImage(
                "assets/bollywoodTable/current-result-background.png",
              ),
              fit: BoxFit.cover)),
      child: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
            Container(
              margin: EdgeInsets.symmetric(horizontal: height * 0.05),
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
            Container(
              alignment: Alignment.center,
              margin: const EdgeInsets.symmetric(
                horizontal: 20,
              ),
              height: height * 0.08,
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
                    fontSize: height * 0.02,
                    fontWeight: FontWeight.bold),
              ),
            ),
          ],
        ),
      ),
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
    return startTimes == 45
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
    return Container(
      // margin: EdgeInsets.only(left: width * 2),
      alignment: Alignment.center,
      height: height * 0.2,
      width: width * 0.63,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          image: DecorationImage(
              image: AssetImage(
                "assets/bollywoodTable/current-result-background.png",
              ),
              fit: BoxFit.fill)),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
            Container(
              alignment: Alignment.center,
              margin: const EdgeInsets.symmetric(
                horizontal: 20,
              ),
              height: 40,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(
                    color: Color(0xaa89560C),
                  )),
              child: Text(
                mid == marketId ? resultOfBT.replaceAll('||', '|') : "",
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 9,
                    fontWeight: FontWeight.bold),
              ),
            ),
          ],
        ),
      ),
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
      if (marketId != result['data']['t1'][0]['mid'].toString()) {
        _coins.clear();
        _coinsPort.clear();
        _coinsRytPort.clear();
      }
      var list = result['data']['t2'] as List;
      setState(() {
        autoTime = result['data']['t1'][0]['autotime'].toString();
         autoTime = result['data']['t1'][0]['autotime'].toString();
            if (startTimes != int.parse(autoTime.toString())) {
        startTimeSmall = startTimes * 100;
      }
        marketId = result['data']['t1'][0]['mid'].toString();
        cardNameImage1 = result['data']['t1'][0]['C1'].toString();

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
    var list = result['data'][widget.gameCode] as List;
    if (result['status'] == true) {
      setState(() {
        matchIdList.clear();

        var listdata = list.map((e) => MatchIdModel.fromJson(e)).toList();
        matchIdList.addAll(listdata);
      });
    }
  }

  Future<void> showMyDialogForBet(int stake) async {
    return showDialog<void>(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            backgroundColor: Colors.transparent,
            content: SingleChildScrollView(
              child: SizedBox(
                height: height * 0.45,
                width: width * 0.35,
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    Container(
                      height: height * 0.45,
                      width: width * 0.35,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          image: DecorationImage(
                              image: AssetImage(
                                  "assets/User-interface/amar-show-amount.png"),
                              fit: BoxFit.fill)),
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
                              height: height * 0.04,
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
                                Padding(
                                  padding: EdgeInsets.only(top: height * 0.0),
                                  child: SizedBox(
                                    height: height * 0.1,
                                    width: width * 0.17,
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
                                          fontSize: 9,
                                        ),
                                        keyboardType: TextInputType.number,
                                        decoration: InputDecoration(
                                          counterText: "",
                                          hintText: '$stake',
                                          hintStyle: TextStyle(
                                              fontSize: 9,
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
                              height: height * 0.02,
                            ),
                            Text(
                              "Are you sure you want to continue?",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 11,
                                  fontWeight: FontWeight.bold),
                            ),
                            SizedBox(
                              height: height * 0.04,
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

                                      makeBet();
                                      Navigator.pop(context);
                                    },
                                    child: Container(
                                      height: height * 0.07,
                                      width: width * 0.25,
                                      decoration: BoxDecoration(
                                          image: DecorationImage(
                                        image: AssetImage(
                                            "assets/User-interface/confirm-button.png"),
                                      )),
                                    ),
                                  )
                                : manualAmount == false
                                    ? GestureDetector(
                                        onTap: () {
                                          HapticFeedback.vibrate();

                                          makeBet();
                                          Navigator.pop(context);
                                          setState(() {
                                            playBackgroundMusic == false
                                                ? onPressedMusicForBet()
                                                : Vibration.vibrate();
                                          });
                                        },
                                        child: Container(
                                          height: height * 0.07,
                                          width: width * 0.25,
                                          decoration: BoxDecoration(
                                              image: DecorationImage(
                                            image: AssetImage(
                                                "assets/User-interface/confirm-button.png"),
                                          )),
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
                                          DialogUtils.showOneBtn(
                                            context,
                                            "Please Select Existing amount",
                                          );
                                        },
                                        child: Container(
                                          height: height * 0.07,
                                          width: width * 0.25,
                                          decoration: BoxDecoration(
                                              image: DecorationImage(
                                            image: AssetImage(
                                                "assets/User-interface/confirm-button.png"),
                                          )),
                                        ),
                                      )
                          ],
                        ),
                      ),
                    ),
                    Positioned(
                      right: 1,
                      top: 1,
                      child: InkWell(
                        onTap: () {
                          setState(() {
                            playBackgroundMusic == false
                                ? ''
                                : Vibration.vibrate();
                          });
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
                      height: height * 0.23,
                      width: width,
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
                                height: height * 0.02,
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
                                          fontSize: 10,
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
                                height: height * 0.03,
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
                                            setState(() {
                                              playBackgroundMusic == false
                                                  ? onPressedMusicForBet()
                                                  : Vibration.vibrate();
                                            });

                                            makeBetPortrait();
                                            Navigator.pop(context);
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
                          setState(() {
                            playBackgroundMusic == false
                                ? ''
                                : Vibration.vibrate();
                          });
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
                  : lightBlueCoinAnimation == true && manualAmount == false
                      ? stack3.toString()
                      : greenCoinAnimation == true && manualAmount == false
                          ? stack4.toString()
                          : brownCoinAnimation == true && manualAmount == false
                              ? stack6.toString()
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
      DialogUtils.showOneBtn(
        context,
        result['message'],
      );
      setState(() {
        manualAmount = false;
        stakeController.clear();
      });

      setState(() {
        _currentCoinIndex++;
        _startCoinAnimation();
      });
      // getVcLiablity();
    } else {
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
                  : lightBlueCoinAnimation == true && manualAmount == false
                      ? stack3.toString()
                      : greenCoinAnimation == true && manualAmount == false
                          ? stack4.toString()
                          : brownCoinAnimation == true && manualAmount == false
                              ? stack6.toString()
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
      getVcLiablity();
      print("response--->$result");
      DialogUtils.showOneBtnPortrait(
        context,
        result['message'],
      );
      setState(() {
        _currentCoinIndexRytPort++;
        _startCoinAnimationRightPort();
      });
      setState(() {
        manualAmount = false;
        stakeController.clear();
      });
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
}
