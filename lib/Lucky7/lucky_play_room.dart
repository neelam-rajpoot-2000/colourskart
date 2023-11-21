// ignore_for_file: non_constant_identifier_names

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
import 'package:virtual_casino/User-Interface/signin_screen.dart';
import 'package:virtual_casino/Utils/toast.dart';
import 'package:virtual_casino/Widgets/custom_image.dart';
import '../DragonTiger/Constants/images_constant_dt.dart';
import '../User-Interface/change_passswod_screen.dart';
import '../User-Interface/current_bets_screen.dart';
import '../User-Interface/current_user_bet.dart';
import '../User-Interface/my_account.dart';
import '../User-Interface/profile_screen.dart';
import '../Utils/api_helper.dart';
import '../Utils/apis.dart';
import '../Widgets/customButton.dart';
import '../Widgets/customText.dart';
import '../constants/color_constants.dart';
import 'Modal/matchIdModelLucky.dart';
import 'Modal/winner_result_lucky7.dart';
import 'package:http/http.dart' as http;

class PlayRoomLucky7Screen extends StatefulWidget {
  final String matchId;
  final String gameCode;
  const PlayRoomLucky7Screen(
      {super.key, required this.matchId, required this.gameCode});

  @override
  State<PlayRoomLucky7Screen> createState() => _PlayRoomLucky7ScreenState();
}

class _PlayRoomLucky7ScreenState extends State<PlayRoomLucky7Screen>
    with TickerProviderStateMixin, WidgetsBindingObserver {
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
  bool confirmButton = false;
  double height = 0;
  double width = 0;
  String autoTime = "";
  String cardNameImage1 = "";
  int startTimes = 0;
  String winnerResult = "";
  String detail = "";
  String cardResult = "";
  bool result = false;
  List<WinnerResult> cardResultList = [];
  late AnimationController _controller;
  late AnimationController _controller1;
  late Animation<double> _animation;
  final _player = AudioPlayer();
  final _cardPlayer = AudioPlayer();
  final stopBettingmusic = AudioPlayer();
  final startBettingmusic = AudioPlayer();
  final winnerBettingmusic = AudioPlayer();
  final onPressedmusic = AudioPlayer();
  bool playBackgroundMusic = false;
  String userBalance = "";
  String liablity = "";
  int stack1 = 0;
  int stack2 = 0;
  int stack3 = 0;
  int stack4 = 0;

  int stack6 = 0;
  var coin = 0;
  bool lowCardButton = false;
  bool highCardButton = false;
  bool evenCardButton = false;
  bool oddCardButton = false;
  bool blackCardButton = false;
  bool redCardButton = false;
  bool selectedImage = false;
  final List<Widget> _coinsLeftRandomLand = [];
  final List<Widget> _coinsRightRandomLand = [];
  final List<Widget> _coins = [];
  final List<Widget> _coinsPort = [];
  final List<Widget> _coinsLeftRandomPort = [];
  final List<Widget> _coinsRytRandomPort = [];
  final Random _random = Random();

  bool redCoinAnimation = false;
  bool lightGreenCoinAnimation = false;

  bool greenCoinAnimation = false;
  bool lightBlueCoinAnimation = false;
  bool brownCoinAnimation = false;
  String marketId = "";
  String lowCard = "";
  String highCard = "";
  String evenCard = "";
  String oddCard = "";
  String blackCard = "";
  String redCard = "";
  String highCardRate = "";
  String lowCardRate = "";
  String evenCardRate = "";
  String oddCardRate = "";
  String blackCardRate = "";
  String redCardRate = "";
  String highCardSid = "";
  String lowCardSid = "";
  String evenCardSid = "";
  String oddCardSid = "";
  String blackCardSid = "";
  String redCardSid = "";
  String iPAddress = "";
  var stakeController = TextEditingController();
  bool manualAmount = false;
  late Timer _clockTimer;
  Timer? _timer;

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

  final int _totalCoins = 7000;
  int _currentCoinIndex = 0;
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

  late Timer _musicTimer;

  var gameSound = "assets/lucky7/audio/bgm.mp3";

  double minXLeftRandomPort = 0,
      maxXLeftRandomPort = 0,
      minYLeftRandomPort = 0,
      maxYLeftRandomPort = 0;
  double minXRightRandomPort = 0;
  double maxXRightRandomPort = 0;
  double minYRightRandomPort = 0;
  double maxYRightRandomPort = 0;
  double minXLeftRandomLand = 0;
  double maxXLeftRandomLand = 0;
  double minYLeftRandomLand = 0;
  double maxYLeftRandomLand = 0;
  double minXRightRandomLand = 0;
  double maxXRightRandomLand = 0;
  double minYRightRandomLand = 0;
  double maxYRightRandomLand = 0;
  double minXLand = 0;
  double maxXLand = 0;
  double minYLand = 0;
  double maxYLand = 0;
  double minXPort = 0;
  double maxXPort = 0;
  double minYPort = 0;
  double maxYPort = 0;
  int startTimeSmall = 0;
  int setInterval = 0;

  @override
  void initState() {
    startTimeSmall = startTimes * 100;
    Timer.periodic(const Duration(milliseconds: 10), (timer) {
      startTimeSmall = startTimeSmall - 1;
    });

    getDeviceIp();
    getStakeDetails();

    AudioPlayer.clearAssetCache();
    WidgetsBinding.instance.addObserver(this);
    bgMusic();
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.landscapeLeft,
      DeviceOrientation.landscapeRight,
      DeviceOrientation.portraitUp
    ]);

    checkInternet();

    _clockTimer = Timer.periodic(const Duration(seconds: 1), (timer) {
      stopBettingMusic();
      startBettingMusic();
    });

    super.initState();

    getCardData().then((value) => _controller1 = AnimationController(
          vsync: this,
          duration:
              Duration(milliseconds: 500), // Adjust the duration as needed
        ));

    _controller = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 2000), // Adjust the duration as needed
    );

    _animation = CurvedAnimation(parent: _controller, curve: Curves.easeInOut);
    _controller.repeat(reverse: true);
  }

  Future<void> checkInternet() async {
    var connectivityResult = await Connectivity().checkConnectivity();
    if (connectivityResult == ConnectivityResult.none) {
      // No internet connection
      // Handle this situation as needed
      print('No internet connection');
    } else {
      _startCoinAnimationLeftRandom();
      _startCoinAnimationRightRandom();
      _startCoinAnimationLeftRandomPort();
      _startCoinAnimationRightRandomPort();

      // Internet connection is available
    }
  }

  void _startCoinAnimationLeftRandom() {
    if (_currentCoinIndex >= _totalCoins) {
      return;
    }
    double _startX = minXLeftRandomLand;
    double _startY = minYLeftRandomLand;
    double _endX =
        _random.nextDouble() * (maxXLeftRandomLand - minXLeftRandomLand) +
            minXLeftRandomLand;
    double _endY =
        _random.nextDouble() * (maxYLeftRandomLand - minYLeftRandomLand) +
            minYLeftRandomLand;

    startTimes > 3
        ? _coinsLeftRandomLand.add(TweenAnimationBuilder(
            tween: Tween<double>(begin: 0, end: 1),
            duration: const Duration(milliseconds: 900),
            builder: (BuildContext context, double value, Widget? child) {
              double currentX = _startX + (_endX - _startX) * value;
              double currentY = _startY + (_endY - _startY) * value;

              return Positioned(
                  left: currentX.clamp(minXLeftRandomLand, maxXLeftRandomLand),
                  top: currentY.clamp(minYLeftRandomLand, maxYLeftRandomLand),
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
      Timer(
        Duration(seconds: 2),
        _startCoinAnimationLeftRandom,
      );
    } else {
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

    double radius = 100; // Radius of the circular path
    double angle = _currentCoinIndex * (pi / _totalCoins);

    double _startX = minXRightRandomLand;
    double _startY = minYRightRandomLand;
    double _endX =
        _random.nextDouble() * (maxXRightRandomLand - minXRightRandomLand) +
            minXRightRandomLand;
    double _endY =
        _random.nextDouble() * (maxYRightRandomLand - minYRightRandomLand) +
            minYRightRandomLand;

    startTimes > 3
        ? _coinsRightRandomLand.add(TweenAnimationBuilder(
            tween: Tween<double>(begin: 0, end: 1),
            duration: const Duration(milliseconds: 900),
            builder: (BuildContext context, double value, Widget? child) {
              double currentX = _startX + (_endX - _startX) * value;
              double currentY = _startY + (_endY - _startY) * value;

              return Positioned(
                  right:
                      currentX.clamp(minXRightRandomLand, maxXRightRandomLand),
                  top: currentY.clamp(minYRightRandomLand, maxYRightRandomLand),
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

    double radius = 200; // Radius of the circular path
    double angle = _currentCoinIndex * (pi / _totalCoins);

    double _startX = minYLeftRandomPort;
    double _startY = minYLeftRandomPort;
    double _endX =
        _random.nextDouble() * (maxXLeftRandomPort - minXLeftRandomPort) +
            minXLeftRandomPort;
    double _endY =
        _random.nextDouble() * (maxYLeftRandomPort - minYLeftRandomPort) +
            minYLeftRandomPort;

    startTimes > 3
        ? _coinsLeftRandomPort.add(TweenAnimationBuilder(
            tween: Tween<double>(begin: 0, end: 1),
            duration: const Duration(milliseconds: 900),
            builder: (BuildContext context, double value, Widget? child) {
              double currentX = _startX + (_endX - _startX) * value;
              double currentY = _startY + (_endY - _startY) * value;

              return Positioned(
                  right: currentX.clamp(minXLeftRandomPort, maxXLeftRandomPort),
                  top: currentY.clamp(minYLeftRandomPort, maxYLeftRandomPort),
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

    double _startX = minXRightRandomPort;
    double _startY = minXRightRandomPort;
    double _endX =
        _random.nextDouble() * (maxXRightRandomPort - minXRightRandomPort) +
            minXRightRandomPort;
    double _endY =
        _random.nextDouble() * (maxYRightRandomPort - minYRightRandomPort) +
            minYRightRandomPort;

    startTimes > 3
        ? _coinsRytRandomPort.add(TweenAnimationBuilder(
            tween: Tween<double>(begin: 0, end: 1),
            duration: const Duration(milliseconds: 900),
            builder: (BuildContext context, double value, Widget? child) {
              double currentX = _startX + (_endX - _startX) * value;
              double currentY = _startY + (_endY - _startY) * value;

              return Positioned(
                  left:
                      currentX.clamp(minXRightRandomPort, maxXRightRandomPort),
                  top: currentY.clamp(minYRightRandomPort, maxYRightRandomPort),
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
      Timer(Duration(seconds: 3), _startCoinAnimationRightRandomPort);
    } else {
      Timer(Duration(seconds: 1), _startCoinAnimationRightRandomPort);
    }
  }

  void _startCoinAnimationRightPort() {
    if (_currentCoinIndexRytPort >= _totalCoins) {
      return;
    }

    double _startX = minYPort;
    double _startY = minXPort;
    double _endX = _random.nextDouble() * (maxXPort - minXPort) + minXPort;
    double _endY = _random.nextDouble() * (maxYPort - minYPort) + minYPort;
    startTimes > 3
        ? _coinsPort.add(TweenAnimationBuilder(
            tween: Tween<double>(begin: 0, end: 1),
            duration: const Duration(milliseconds: 600),
            builder: (BuildContext context, double value, Widget? child) {
              double currentX = _startX + (_endX - _startX) * value;
              double currentY = _startY + (_endY - _startY) * value;

              return Positioned(
                  right: currentX.clamp(minXPort, maxXPort),
                  bottom: currentY.clamp(minYPort, maxYPort),
                  child: startTimes > 1
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
        : _coinsPort.reversed;

    startTimes > 3 && playBackgroundMusic == false
        ? onPressedMusicForBet()
        : null;
  }

  void _startCoinAnimation() {
    if (_currentCoinIndex >= _totalCoins) {
      return;
    }

    double _startX = minXLand;
    double _startY = minYLand;
    double _endX = _random.nextDouble() * (maxXLand - minXLand) + minXLand;
    double _endY = _random.nextDouble() * (maxYLand - minYLand) + minYLand;

    startTimes > 3
        ? _coins.add(TweenAnimationBuilder(
            tween: Tween<double>(begin: 0, end: 1),
            duration: const Duration(milliseconds: 600),
            builder: (BuildContext context, double value, Widget? child) {
              double currentX = _startX + (_endX - _startX) * value;
              double currentY = _startY + (_endY - _startY) * value;

              return Positioned(
                  right: currentX.clamp(minXLand, maxXLand),
                  bottom: currentY.clamp(minYLand, maxYLand),
                  child: startTimes > 1
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

  @override
  void dispose() {
    _timer?.cancel();
    _controller.dispose();
    _controller1.dispose();
    _clockTimer.cancel();
    _player.dispose();
    WidgetsBinding.instance.removeObserver(this);
    startBettingmusic.dispose();
    stopBettingmusic.dispose();
    _musicTimer.cancel();
    _cardPlayer.dispose();
    super.dispose();
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
    startTimes > 3 || playBackgroundMusic == false
        ? onPressedmusic.play()
        : onPressedmusic.stop();
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

  final GlobalKey<ScaffoldState> _globalKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    getuserBalance();
    getUserDetails();
    getMatchIdDetails();

    getResult().then((value) => getCardData());

    final oreintation = MediaQuery.of(context).orientation;
    height = MediaQuery.of(context).size.height;
    width = MediaQuery.of(context).size.width;
    minXLeftRandomLand = 195;
    maxXLeftRandomLand = width - 250;
    minYLeftRandomLand = startTimes > 3 ? 135 : 200;
    maxYLeftRandomLand = startTimes > 3 ? height - 130 : height - 50;

    minXRightRandomLand = 195;
    maxXRightRandomLand = width - 250;
    minYRightRandomLand = startTimes > 3 ? 135 : 200;
    maxYRightRandomLand = startTimes > 3 ? height - 130 : height - 50;
    minXLeftRandomPort = 50;
    maxXLeftRandomPort = width - 100;
    minYLeftRandomPort = 40;
    maxYLeftRandomPort = height - 590;
    minXRightRandomPort = 50;
    maxXRightRandomPort = width - 100;
    minYRightRandomPort = 40;
    maxYRightRandomPort = height - 590;
    minXLand = 200;
    maxXLand = width - 220;
    minYLand = 130;
    maxYLand = height - 140;
    minXPort = 60;
    maxXPort = 300;
    minYPort = 60;
    maxYPort = 240;

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
              "assets/lucky7/images/lucky7_background.png",
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
                                  'assets/lucky7/images/frame/amount_bg.png'),
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
                      child: Image.asset('assets/lucky7/images/icon/menu.png',
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
                                'assets/lucky7/images/icon/music_on.png',
                                fit: BoxFit.fill,
                                height: height * 0.055),
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
                                'assets/lucky7/images/icon/music_off.png',
                                fit: BoxFit.fill,
                                height: height * 0.055),
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
                      height: height * 0.035,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                          image: DecorationImage(
                              image: AssetImage(
                                  'assets/lucky7/images/frame/exp_amount.png'),
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
                        height: height * 0.040,
                        width: width * 0.25,
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                            image: DecorationImage(
                                image: AssetImage(
                                  'assets/lucky7/images/frame/my_bet.png',
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
              Container(
                padding:
                    EdgeInsets.only(left: width * 0.01, top: height * 0.002),
                margin: EdgeInsets.symmetric(
                    horizontal: width * 0.02, vertical: width * 0.03),
                alignment: Alignment.center,
                decoration: BoxDecoration(
                    image: DecorationImage(
                  image: AssetImage(
                    "assets/lucky7/images/result_background.png",
                  ),
                  fit: BoxFit.fill,
                )),
                height: height * 0.04,
                width: width,
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
                            ;
                          });

                          DialogUtils.showResultLucky7(
                              context,
                              item.c1,
                              item.detail,
                              height * 0.26,
                              width,
                              height * 0.1,
                              width * 0.13,
                              height * 0.04,
                              width * 0.05,
                              height * 0.21,
                              width * 0.75,
                              item.mid,
                              height * 0.015,
                              playBackgroundMusic);
                        },
                        child: Container(
                          alignment: Alignment.center,
                          margin: const EdgeInsets.symmetric(horizontal: 6),
                          height: 20,
                          width: 20,
                          decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: item.winner == "L"
                                  ? ColorConstants.skyBlueColor
                                  : item.winner == "T"
                                      ? ColorConstants.pinkColor
                                      : ColorConstants.lightGreenColor),
                          child: Text(
                            item.winner == "L"
                                ? "L"
                                : item.winner == "H"
                                    ? "H"
                                    : "T",
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
                          fontSize: 9),
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
                height: height * 0.01,
              ),
              Image.asset(
                'assets/lucky7/images/tableGirl.png',
                fit: BoxFit.cover,
                height: height * 0.15,
              ),
              Stack(
                children: [
                  Image.asset(
                    'assets/lucky7/images/table.png',
                    fit: BoxFit.cover,
                    height: height * 0.39,
                    //width: width * 1.00,
                  ),

                  Positioned(
                    top: height * 0.035,
                    left: width * 0.06,
                    child: Image.asset(
                      'assets/lucky7/images/frame/logo.png',
                      fit: BoxFit.cover,
                      height: height * 0.05,
                    ),
                  ),
                  Positioned(
                      top: height * 0.035,
                      right: width * 0.04,
                      child: Image.asset(
                        'assets/lucky7/images/frame/logo.png',
                        fit: BoxFit.cover,
                        height: height * 0.05,
                      )),
                  SizedBox(
                      height: height * 0.36,
                      child: AnimatedSwitcher(
                        duration: Duration(milliseconds: 900),
                        child: Stack(
                          children: _coinsLeftRandomPort,
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
                  SizedBox(
                      height: height * 0.36,
                      child: AnimatedSwitcher(
                        duration: Duration(milliseconds: 900),
                        child: Stack(
                          children: _coinsRytRandomPort,
                        ),
                      )),
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
                  //   startTimes >= 1
                  //           ?  Positioned(
                  //      right: width * 0.55,
                  // top: height * 0.02,
                  //     child: CustomText(
                  //                     text: "s",
                  //                     fontWeight: FontWeight.bold,
                  //                     color: Colors.white,
                  //                     fontSize: 09.0,
                  //                     textAlign: TextAlign.end,
                  //                   ),
                  //   ):SizedBox(),

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
                                  value: startTimeSmall /
                                      4500, // Calculate the progress
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
                      ? placeyourbetWidgetPortrait(autoTime)
                      : autoTime == "3" || autoTime == "2" || autoTime == "1"
                          ? goWidgetPort()
                          : autoTime != '0'
                              ? SizedBox()
                              : Positioned(
                                  top: height * 0.04,
                                  left: width * 0.16,
                                  child: showCurrentCardPort()),
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
              Column(
                children: [
                  Padding(
                    padding: EdgeInsets.only(
                        top: height * 0.02,
                        left: width * 0.01,
                        right: width * 0.01),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
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
                                  lowCardButton = !lowCardButton;
                                }
                                if (lowCardButton == true) {
                                  highCardButton = false;
                                  evenCardButton = false;
                                  oddCardButton = false;
                                  blackCardButton = false;
                                  redCardButton = false;
                                  betSucessfulllyPlacedPort(
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
                                                      : brownCoinAnimation ==
                                                              true
                                                          ? stack6
                                                          : 0);
                                }
                              },
                              child: CustomImage(
                                  color: Color(0xffB30077),
                                  text: lowCardRate,
                                  image: 'LOW CARD  ',
                                  sizedWidth: width * 0.01),
                            ),
                            SizedBox(
                              height: height * 0.005,
                            ),
                            Text(
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
                                        fontWeight: FontWeight.w500)),
                          ],
                        ),
                        Column(
                          children: [
                            InkWell(
                              onTap: () {
                                setState(() {
                                  playBackgroundMusic == false
                                      ? onPressedMusic()
                                      : Vibration.vibrate();
                                  ;
                                });

                                if ((redCoinAnimation == true ||
                                        lightBlueCoinAnimation == true ||
                                        lightGreenCoinAnimation == true ||
                                        brownCoinAnimation == true ||
                                        greenCoinAnimation == true) &&
                                    startTimes > 1) {
                                  highCardButton = !highCardButton;
                                }
                                if (highCardButton == true) {
                                  lowCardButton = false;
                                  evenCardButton = false;
                                  oddCardButton = false;
                                  blackCardButton = false;
                                  redCardButton = false;
                                  betSucessfulllyPlacedPort(
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
                                                      : brownCoinAnimation ==
                                                              true
                                                          ? stack6
                                                          : 0);
                                }
                              },
                              child: CustomImage(
                                  color: Color(0xffB30077),
                                  text: highCardRate,
                                  image: 'HIGH CARD  ',
                                  sizedWidth: width * 0.01),
                            ),
                            SizedBox(
                              height: height * 0.005,
                            ),
                            Text(
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
                                        fontWeight: FontWeight.w500)),
                          ],
                        ),
                        Column(
                          children: [
                            InkWell(
                              onTap: () {
                                setState(() {
                                  playBackgroundMusic == false
                                      ? onPressedMusic()
                                      : Vibration.vibrate();
                                  ;
                                });

                                if ((redCoinAnimation == true ||
                                        lightBlueCoinAnimation == true ||
                                        lightGreenCoinAnimation == true ||
                                        brownCoinAnimation == true ||
                                        greenCoinAnimation == true) &&
                                    startTimes > 1) {
                                  evenCardButton = !evenCardButton;
                                }
                                if (evenCardButton == true) {
                                  highCardButton = false;
                                  lowCardButton = false;
                                  oddCardButton = false;
                                  blackCardButton = false;
                                  redCardButton = false;
                                  betSucessfulllyPlacedPort(
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
                                                      : brownCoinAnimation ==
                                                              true
                                                          ? stack6
                                                          : 0);
                                }
                              },
                              child: CustomImage(
                                  color: Color(0xffB30077),
                                  text: evenCardRate,
                                  image: 'EVEN CARD  ',
                                  sizedWidth: width * 0.01),
                            ),
                            SizedBox(
                              height: height * 0.005,
                            ),
                            Text(
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
                                        fontWeight: FontWeight.w500)),
                          ],
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(
                        top: height * 0.005,
                        left: width * 0.01,
                        right: width * 0.01),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          children: [
                            InkWell(
                              onTap: () {
                                setState(() {
                                  playBackgroundMusic == false
                                      ? onPressedMusic()
                                      : Vibration.vibrate();
                                  ;
                                });

                                if ((redCoinAnimation == true ||
                                        lightBlueCoinAnimation == true ||
                                        lightGreenCoinAnimation == true ||
                                        brownCoinAnimation == true ||
                                        greenCoinAnimation == true) &&
                                    startTimes > 1) {
                                  oddCardButton = !oddCardButton;
                                }
                                if (oddCardButton == true) {
                                  highCardButton = false;
                                  evenCardButton = false;
                                  lowCardButton = false;
                                  blackCardButton = false;
                                  redCardButton = false;
                                  betSucessfulllyPlacedPort(
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
                                                      : brownCoinAnimation ==
                                                              true
                                                          ? stack6
                                                          : 0);
                                }
                              },
                              child: CustomImage(
                                  color: Color(0xffB30077),
                                  text: oddCardRate,
                                  image: 'ODD CARD  ',
                                  sizedWidth: width * 0.02),
                            ),
                            SizedBox(
                              height: height * 0.005,
                            ),
                            Text(
                                confirmButton == true && startTimes > 1
                                    ? liablity13.toString()
                                    : "",
                                style: liablity13 > 0.0
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
                                      ? onPressedMusic()
                                      : Vibration.vibrate();
                                  ;
                                });

                                if ((redCoinAnimation == true ||
                                        lightBlueCoinAnimation == true ||
                                        lightGreenCoinAnimation == true ||
                                        brownCoinAnimation == true ||
                                        greenCoinAnimation == true) &&
                                    startTimes > 1) {
                                  blackCardButton = !blackCardButton;
                                }
                                if (blackCardButton == true) {
                                  highCardButton = false;
                                  evenCardButton = false;
                                  oddCardButton = false;
                                  lowCardButton = false;
                                  redCardButton = false;
                                  betSucessfulllyPlacedPort(
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
                                                      : brownCoinAnimation ==
                                                              true
                                                          ? stack6
                                                          : 0);
                                }
                              },
                              child: CustomButton(
                                color: Color(0xffB30077),
                                sizedWidth: width * 0.06,
                                text: blackCardRate,
                                heightImage: height * 0.025,
                                image:
                                    'assets/lucky7/images/coins/black-L7.png',
                              ),
                            ),
                            SizedBox(
                              height: height * 0.005,
                            ),
                            Text(
                                confirmButton == true && startTimes > 1
                                    ? liablity15.toString()
                                    : "",
                                style: liablity15 > 0.0
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
                                      ? onPressedMusic()
                                      : Vibration.vibrate();
                                  ;
                                });

                                if ((redCoinAnimation == true ||
                                        lightBlueCoinAnimation == true ||
                                        lightGreenCoinAnimation == true ||
                                        brownCoinAnimation == true ||
                                        greenCoinAnimation == true) &&
                                    startTimes > 1) {
                                  redCardButton = !redCardButton;
                                }
                                if (redCardButton == true) {
                                  highCardButton = false;
                                  evenCardButton = false;
                                  oddCardButton = false;
                                  blackCardButton = false;
                                  lowCardButton = false;
                                  betSucessfulllyPlacedPort(
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
                                                      : brownCoinAnimation ==
                                                              true
                                                          ? stack6
                                                          : 0);
                                }
                              },
                              child: CustomButton(
                                color: Color(0xffB30077),
                                sizedWidth: width * 0.05,
                                text: redCardRate,
                                heightImage: height * 0.025,
                                image: 'assets/lucky7/images/coins/red-L7.png',
                              ),
                            ),
                            SizedBox(
                              height: height * 0.005,
                            ),
                            Text(
                                confirmButton == true && startTimes > 1
                                    ? liablity14.toString()
                                    : "",
                                style: liablity14 > 0.0
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
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ]),
          )),
    );
  }

  Widget landscapeWidget() {
    return Scaffold(
        backgroundColor: Colors.transparent,
        key: _globalKey,
        drawerEnableOpenDragGesture: false,
        body: Container(
            height: height,
            decoration: BoxDecoration(
                image: DecorationImage(
                    image: AssetImage(
                        "assets/lucky7/images/landscape_lucky7_bg.png"),
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
                                'assets/lucky7/images/icon/menu.png',
                                fit: BoxFit.fill,
                                width: width * 0.05),
                          ),
                          SizedBox(
                            width: width * 0.03,
                          ),
                          Container(
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                                image: DecorationImage(
                                    image: AssetImage(
                                        'assets/lucky7/images/frame/amount_bg.png'),
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
                                    "  ${mainBalance.toStringAsFixed(2)}",
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
                            ;
                          });
                          Navigator.push(
                              context, _createRouteCurrentBetsList());
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
                                    'assets/lucky7/images/frame/my_bet.png',
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
                            color: Colors.white, fontWeight: FontWeight.bold),
                      ),
                      SizedBox(
                        height: 1,
                      ),
                    ],
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
                                      'assets/lucky7/images/icon/music_on.png',
                                      fit: BoxFit.fill,
                                      width: width * 0.055),
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
                                      'assets/lucky7/images/icon/music_off.png',
                                      fit: BoxFit.fill,
                                      width: width * 0.055),
                                ),
                        ],
                      ),
                    ],
                  ),
                ),

                Positioned(
                  bottom: startTimes >= 1 ? height * 0.16 : 1,
                  child: Image.asset(
                    'assets/lucky7/images/landscape_tableBg.png',
                    fit: BoxFit.fill,
                    height: height * 0.57,
                  ),
                ),

                Positioned(
                  top: startTimes >= 1 ? height * 0.3 : height * 0.45,
                  left: width * 0.23,
                  child: Image.asset(
                    'assets/lucky7/images/frame/logo.png',
                    fit: BoxFit.cover,
                    height: height * 0.10,
                  ),
                ),
                Positioned(
                  top: startTimes >= 1 ? height * 0.3 : height * 0.45,
                  right: width * 0.23,
                  child: Image.asset(
                    'assets/lucky7/images/frame/logo.png',
                    fit: BoxFit.cover,
                    height: height * 0.10,
                  ),
                ),
                AnimatedSwitcher(
                  duration: Duration(milliseconds: 500),
                  child: Stack(
                    children: _coinsLeftRandomLand,
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
                    children: _coinsRightRandomLand,
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
                                top: height * 0.37,
                                right: width * 0.35,
                                child: showCurrentCardLand())
                            : SizedBox(),

                Positioned(
                  bottom: startTimes >= 1 ? height * 0.16 : height * 0.01,
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
                          height:
                              lightGreenCoinAnimation == true && startTimes > 1
                                  ? height * 0.15
                                  : height * 0.11,
                          width:
                              lightGreenCoinAnimation == true && startTimes > 1
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
                            lightBlueCoinAnimation = !lightBlueCoinAnimation;
                            brownCoinAnimation = false;
                          });
                        },
                        child: AnimatedContainer(
                            duration: Duration(milliseconds: 700),
                            alignment: Alignment.center,
                            height:
                                lightBlueCoinAnimation == true && startTimes > 1
                                    ? height * 0.15
                                    : height * 0.11,
                            width:
                                lightBlueCoinAnimation == true && startTimes > 1
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
                          height: greenCoinAnimation == true && startTimes > 1
                              ? height * 0.15
                              : height * 0.11,
                          width: greenCoinAnimation == true && startTimes > 1
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
                          height: brownCoinAnimation == true && startTimes > 1
                              ? height * 0.17
                              : height * 0.13,
                          width: brownCoinAnimation == true && startTimes > 1
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
                  top: height * 0.18,
                  right: width * 0.03,
                  child: Container(
                    height: height * 0.65,
                    width: width * 0.04,
                    padding: EdgeInsets.all(1),
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                        image: DecorationImage(
                      image: AssetImage(
                          "assets/lucky7/images/coin_background.png"),
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
                                ;
                              });

                              DialogUtils.showResultLucky7(
                                  context,
                                  item.c1,
                                  item.detail,
                                  height * 0.50,
                                  width * 0.45,
                                  height * 0.23,
                                  width * 0.15,
                                  height * 0.07,
                                  width * 0.07,
                                  height * 0.5,
                                  width * 0.50,
                                  item.mid,
                                  height * 0.03,
                                  playBackgroundMusic);
                            },
                            child: Container(
                              margin: EdgeInsets.all(1),
                              padding: EdgeInsets.all(2),
                              alignment: Alignment.center,
                              decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: item.winner == "L"
                                      ? ColorConstants.skyBlueColor
                                      : item.winner == "T"
                                          ? ColorConstants.pinkColor
                                          : ColorConstants.lightGreenColor),
                              child: Text(
                                item.winner == "L"
                                    ? "L"
                                    : item.winner == "H"
                                        ? "H"
                                        : "T",
                                style: TextStyle(
                                  fontWeight: FontWeight.w600,
                                  color: ColorConstants.whiteColor,
                                  fontSize: 10,
                                ),
                              ),
                            ),
                          );
                        }),
                  ),
                ),
                Positioned(
                  bottom: startTimes >= 1 ? height * 0.21 : height * 0.06,
                  left: width * 0.10,
                  child: Row(
                    children: [
                      Container(
                        padding: EdgeInsets.only(
                            left: width * 0.04, right: width * 0.02),
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                            image: DecorationImage(
                                image: AssetImage(
                                    "assets/lucky7/images/frame/exp_amount.png"))),
                        height: height * 0.09,
                        //    width: width * 0.1,
                        child: CustomText(
                            text: liablity.toString(),
                            color: Color(0xffFFEFC1),
                            fontSize: height * 0.025,
                            fontWeight: FontWeight.w500),
                      ),
                      SizedBox(
                        width: width * 0.57,
                      ),
                      // InkWell(
                      //   onTap: () {
                      //     setState(
                      //       () {
                      //                  Vibration.vibrate();;
                      //         onPressedMusic();
                      //         setState(() {
                      //           _currentCoinIndex++;
                      //           _startCoinAnimation();
                      //         });
                      //       },
                      //     );
                      //   },
                      //   child: Image.asset(
                      //     'assets/lucky7/images/button/bet.png',
                      //     height: height * 0.08,
                      //     fit: BoxFit.cover,
                      //   ),
                      // ),
                    ],
                  ),
                ),
                startTimes >= 1
                    ? Positioned(bottom: height * 0.005, child: betButton())
                    : Container()
              ],
            )),
        drawer: SizedBox(
          width: width * 0.3,
          child: Drawer(
            child: drawerWidget(),
          ),
        ));
  }

  betSucessfulllyPlacedPort(
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
                            Color(0xff180010),
                            Color(0xff3F042B),
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

                                        if (lowCardButton == true ||
                                            highCardButton == true ||
                                            evenCardButton == true ||
                                            oddCardButton == true ||
                                            redCardButton == true ||
                                            blackCardButton == true) {
                                          makeBetPortrait();
                                          Navigator.pop(context);

                                          lowCardButton = false;
                                          highCardButton = false;
                                          evenCardButton = false;
                                          oddCardButton = false;
                                          blackCardButton = false;
                                          redCardButton = false;
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

                                            if (lowCardButton == true ||
                                                highCardButton == true ||
                                                evenCardButton == true ||
                                                oddCardButton == true ||
                                                redCardButton == true ||
                                                blackCardButton == true) {
                                              makeBetPortrait();

                                              Navigator.pop(context);
                                              lowCardButton = false;
                                              highCardButton = false;
                                              evenCardButton = false;
                                              oddCardButton = false;
                                              blackCardButton = false;
                                              redCardButton = false;
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

  betSucessfulllyPlaced(
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

                                      if (lowCardButton == true ||
                                          highCardButton == true ||
                                          evenCardButton == true ||
                                          oddCardButton == true ||
                                          redCardButton == true ||
                                          blackCardButton == true) {
                                        makeBet();
                                        Navigator.pop(context);

                                        lowCardButton = false;
                                        highCardButton = false;
                                        evenCardButton = false;
                                        oddCardButton = false;
                                        blackCardButton = false;
                                        redCardButton = false;
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

                                          if (lowCardButton == true ||
                                              highCardButton == true ||
                                              evenCardButton == true ||
                                              oddCardButton == true ||
                                              redCardButton == true ||
                                              blackCardButton == true) {
                                            makeBet();
                                            Navigator.pop(context);

                                            lowCardButton = false;
                                            highCardButton = false;
                                            evenCardButton = false;
                                            oddCardButton = false;
                                            blackCardButton = false;
                                            redCardButton = false;
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

  betButton() {
    return Row(
      children: [
        Column(
          children: [
            InkWell(
                onTap: () {
                  setState(() {
                    playBackgroundMusic == false
                        ? onPressedMusic()
                        : Vibration.vibrate();
                    ;
                  });

                  if ((redCoinAnimation == true ||
                          lightBlueCoinAnimation == true ||
                          lightGreenCoinAnimation == true ||
                          brownCoinAnimation == true ||
                          greenCoinAnimation == true) &&
                      startTimes > 1) {
                    lowCardButton = !lowCardButton;
                  }
                  if (lowCardButton == true) {
                    highCardButton = false;
                    evenCardButton = false;
                    oddCardButton = false;
                    blackCardButton = false;
                    redCardButton = false;

                    betSucessfulllyPlaced(
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
                },
                child: CustomImage(
                    color: Color(0xffB30077),
                    text: lowCardRate,
                    image: 'LOW CARD',
                    sizedWidth: width * 0.02)),
            SizedBox(
              height: height * 0.005,
            ),
            Text(
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
                        ? onPressedMusic()
                        : Vibration.vibrate();
                    ;
                  });

                  if ((redCoinAnimation == true ||
                          lightBlueCoinAnimation == true ||
                          lightGreenCoinAnimation == true ||
                          brownCoinAnimation == true ||
                          greenCoinAnimation == true) &&
                      startTimes > 1) {
                    highCardButton = !highCardButton;
                  }
                  if (highCardButton == true) {
                    lowCardButton = false;
                    evenCardButton = false;
                    oddCardButton = false;
                    blackCardButton = false;
                    redCardButton = false;

                    betSucessfulllyPlaced(
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
                },
                child: CustomImage(
                    color: Color(0xffB30077),
                    text: highCardRate,
                    image: 'HIGH CARD',
                    sizedWidth: width * 0.02)),
            SizedBox(
              height: height * 0.005,
            ),
            Text(
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
                        ? onPressedMusic()
                        : Vibration.vibrate();
                    ;
                  });

                  if ((redCoinAnimation == true ||
                          lightBlueCoinAnimation == true ||
                          lightGreenCoinAnimation == true ||
                          brownCoinAnimation == true ||
                          greenCoinAnimation == true) &&
                      startTimes > 1) {
                    evenCardButton = !evenCardButton;
                  }
                  if (evenCardButton == true) {
                    highCardButton = false;
                    lowCardButton = false;
                    oddCardButton = false;
                    blackCardButton = false;
                    redCardButton = false;

                    betSucessfulllyPlaced(
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
                },
                child: CustomImage(
                    color: Color(0xffB30077),
                    text: evenCardRate,
                    image: 'EVEN CARD  ',
                    sizedWidth: width * 0.02)),
            SizedBox(
              height: height * 0.005,
            ),
            Text(
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
                        ? onPressedMusic()
                        : Vibration.vibrate();
                    ;
                  });

                  if ((redCoinAnimation == true ||
                          lightBlueCoinAnimation == true ||
                          lightGreenCoinAnimation == true ||
                          brownCoinAnimation == true ||
                          greenCoinAnimation == true) &&
                      startTimes > 1) {
                    oddCardButton = !oddCardButton;
                  }
                  if (oddCardButton == true) {
                    highCardButton = false;
                    evenCardButton = false;
                    lowCardButton = false;
                    blackCardButton = false;
                    redCardButton = false;

                    betSucessfulllyPlaced(
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
                },
                child: CustomImage(
                    color: Color(0xffB30077),
                    text: oddCardRate,
                    image: 'ODD CARD  ',
                    sizedWidth: width * 0.02)),
            SizedBox(
              height: height * 0.005,
            ),
            Text(
                confirmButton == true && startTimes > 1
                    ? liablity13.toString()
                    : "",
                style: liablity13 > 0.0
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
                        ? onPressedMusic()
                        : Vibration.vibrate();
                    ;
                  });

                  if ((redCoinAnimation == true ||
                          lightBlueCoinAnimation == true ||
                          lightGreenCoinAnimation == true ||
                          brownCoinAnimation == true ||
                          greenCoinAnimation == true) &&
                      startTimes > 1) {
                    blackCardButton = !blackCardButton;
                  }
                  if (blackCardButton == true) {
                    highCardButton = false;
                    evenCardButton = false;
                    oddCardButton = false;
                    lowCardButton = false;
                    redCardButton = false;

                    betSucessfulllyPlaced(
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
                },
                child: CustomButton(
                  color: Color(0xffB30077),
                  sizedWidth: width * 0.05,
                  heightImage: height * 0.045,
                  text: blackCardRate,
                  image: 'assets/lucky7/images/coins/black-L7.png',
                )),
            SizedBox(
              height: height * 0.005,
            ),
            Text(
                confirmButton == true && startTimes > 1
                    ? liablity15.toString()
                    : "",
                style: liablity15 > 0.0
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
                        ? onPressedMusic()
                        : Vibration.vibrate();
                    ;
                  });

                  if ((redCoinAnimation == true ||
                          lightBlueCoinAnimation == true ||
                          lightGreenCoinAnimation == true ||
                          brownCoinAnimation == true ||
                          greenCoinAnimation == true) &&
                      startTimes > 1) {
                    redCardButton = !redCardButton;
                  }
                  if (redCardButton == true) {
                    highCardButton = false;
                    evenCardButton = false;
                    oddCardButton = false;
                    blackCardButton = false;
                    lowCardButton = false;

                    betSucessfulllyPlaced(
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
                },
                child: CustomButton(
                  color: Color(0xffB30077),
                  sizedWidth: width * 0.04,
                  heightImage: height * 0.055,
                  text: redCardRate,
                  image: 'assets/lucky7/images/coins/red-L7.png',
                )),
            SizedBox(
              height: height * 0.005,
            ),
            Text(
                confirmButton == true && startTimes > 1
                    ? liablity14.toString()
                    : "",
                style: liablity14 > 0.0
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
        )
      ],
    );
  }

  goWidget() {
    return Positioned(
        top: height * 0.4,
        child: Visibility(
          visible: autoTime == "3" || autoTime == "2" || autoTime == "1",
          child: Lottie.asset("assets/lucky7/audio/countdown.json",
              height: height * 0.3, width: width),
        ));
  }

  goWidgetPort() {
    return Positioned(
        top: height * 0.06,
        child: Visibility(
          visible: autoTime == "3" || autoTime == "2" || autoTime == "1",
          child: Lottie.asset("assets/lucky7/audio/countdown.json",
              height: height * 0.2, width: width),
        ));
  }

  Widget placeyourbetWidgetPortrait(String time) {
    return autoTime == '45'
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
                'assets/lucky7/images/Place Your Bet.png',
                height: height * 0.08,
                width: width * 0.6,
                fit: BoxFit.fill,
              ),
            ))
        : SizedBox();
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
                  width: width * 0.3,
                  fit: BoxFit.fill,
                )))
        : SizedBox();
  }

  Widget showCurrentCardPort() {
    return Container(
      alignment: Alignment.center,
      height: height * 0.26,
      width: width * 0.7,
      decoration: BoxDecoration(
          image: DecorationImage(
              image: AssetImage(
                'assets/lucky7/images/past_results_bg.png',
              ),
              fit: BoxFit.contain)),
      child: Padding(
        padding: EdgeInsets.only(top: height * 0.05),
        child: Column(
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
    //                                 Stack(
    //     children: [
    //       Image.asset(
    //         'assets/lucky7/images/past_results_bg.png',
    //         height: height * 0.27,
    //         fit: BoxFit.fill,
    //       ),
    //       Positioned( top: height * 0.04,
    //         left: width * 0.18,child: CustomText(text: 'Round ID: ${marketId.toString()}',fontSize: 12,color: Colors.white,fontWeight: FontWeight.bold),),
    //       Positioned(
    //         top: height * 0.07,
    //         left: width * 0.24,
    //         child: cardNameImage1 != ""
    //             ? buildImage(cardNameImage1)
    //             : Image.asset(
    //                 'assets/lucky7/images/cardBg.png',
    //                 height: height * 0.09,
    //                 width: width * 0.12,
    //                 fit: BoxFit.fill,
    //               ),
    //       ),
    //     ],
    //   );
  }

  Widget showCurrentCardLand() {
    return Container(
      alignment: Alignment.center,
      height: height * 0.52,
      width: width * 0.3,
      decoration: BoxDecoration(
          image: DecorationImage(
              image: AssetImage('assets/lucky7/images/past_results_bg.png'),
              fit: BoxFit.fill)),
      child: Padding(
        padding: EdgeInsets.only(top: height * 0.1),
        child: Column(
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

  Future getCardData() async {
    var url = Apis.getCardData;
    var response = await GlobalFunction.apiGetRequestae(url);
    var result = jsonDecode(response);
    if (result['status'] == true) {
      if (marketId != result['data']['t1'][0]['mid'].toString()) {
        _coinsLeftRandomLand.clear();
        _coinsRightRandomLand.clear();
        _coinsLeftRandomPort.clear();
        _coinsRytRandomPort.clear();
      }
      marketId = result['data']['t1'][0]['mid'].toString();
      autoTime = result['data']['t1'][0]['autotime'].toString();
      cardNameImage1 = result['data']['t1'][0]['C1'].toString();
      if (startTimes != int.parse(autoTime.toString())) {
        startTimeSmall = startTimes * 100;
      }
      startTimes = int.parse(autoTime.toString());
      print("====>$startTimes");

      print("marketId====>$marketId");
      lowCard = result['data']['t2'][0]['nat'].toString();
      highCard = result['data']['t2'][1]['nat'].toString();
      evenCard = result['data']['t2'][2]['nat'].toString();
      oddCard = result['data']['t2'][3]['nat'].toString();
      blackCard = result['data']['t2'][5]['nat'].toString();
      redCard = result['data']['t2'][4]['nat'].toString();

      lowCardRate = result['data']['t2'][0]['rate'].toString();
      highCardRate = result['data']['t2'][1]['rate'].toString();
      evenCardRate = result['data']['t2'][2]['rate'].toString();
      oddCardRate = result['data']['t2'][3]['rate'].toString();
      redCardRate = result['data']['t2'][4]['rate'].toString();
      blackCardRate = result['data']['t2'][5]['rate'].toString();

      lowCardSid = result['data']['t2'][0]['sid'].toString();
      highCardSid = result['data']['t2'][1]['sid'].toString();
      evenCardSid = result['data']['t2'][2]['sid'].toString();
      oddCardSid = result['data']['t2'][3]['sid'].toString();
      redCardSid = result['data']['t2'][4]['sid'].toString();
      blackCardSid = result['data']['t2'][5]['sid'].toString();

      autoTime == "0"
          ? setState(() {
              redCoinAnimation = false;
              lightGreenCoinAnimation = false;

              greenCoinAnimation = false;
              lightBlueCoinAnimation = false;
              brownCoinAnimation = false;
              lowCardButton = false;
              highCardButton = false;
              evenCardButton = false;
              oddCardButton = false;
              blackCardButton = false;
              redCardButton = false;
              confirmButton = false;
            })
          : SizedBox();
    }
  }

  Future getResult() async {
    var url = Apis.getResult;
    var response = await GlobalFunction.apiGetRequestae(url);
    var result = jsonDecode(response);

    var list = result as List;

    setState(() {
      cardResultList.clear();
      var listdata = list.map((e) => WinnerResult.fromJson(e)).toList();
      cardResultList.addAll(listdata);

      winnerResult = result[0]['winner'].toString();
    });
  }

  Future getStakeDetails() async {
    var url = Apis.getStakeData;
    var body = {};
    var response = await GlobalFunction.apiPostRequestToken(url, body);

    var result = jsonDecode(response);
    if (result['status'] == true) {
      setState(() {
        stack1 = result['data']['stack1'];
        print("stack 1------->$stack1");
        stack2 = result['data']['stack2'];
        print("stack 2------->$stack2");

        stack3 = result['data']['stack3'];
        print("stack 3------->$stack3");
        stack4 = result['data']['stack4'];
        print("stack 4------->$stack4");

        stack6 = result['data']['stack6'];
        print("stack 6------->$stack6");
      });
    }
  }

  double mainBalance = 0;
  List mainBalanceList = [];

  Future getuserBalance() async {
    var url = Apis.getuserBalanceApi;
    var body = {};
    var response =
        await GlobalFunction.apiPostRequestToken(url, jsonEncode(body));
    var result = jsonDecode(response);
    if (result['status'] == true) {
      userBalance = result['data']['balance'];
      print("mainBalance=====>$userBalance");

      liablity = result['data']['libality'];
      mainBalance = double.parse(userBalance) - double.parse(liablity);
      mainBalanceList = mainBalance.toString().split('.');
      print("mainBalance=====>$mainBalance");
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
        liablity16 = result['data'][15]['liability'];
        liablity17 = result['data'][16]['liability'];
        liablity18 = result['data'][17]['liability'];
        liablity19 = result['data'][18]['liability'];
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
      "odds": lowCardButton == true
          ? lowCardRate
          : highCardButton == true
              ? highCardRate
              : evenCardButton == true
                  ? evenCardRate
                  : oddCardButton == true
                      ? oddCardRate
                      : blackCardButton == true
                          ? blackCardRate
                          : redCardButton == true
                              ? redCardRate
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
                              ? stack6
                              : "",
      "selectionId": lowCardButton == true
          ? lowCardSid.toString()
          : highCardButton == true
              ? highCardSid.toString()
              : evenCardButton == true
                  ? evenCardSid.toString()
                  : oddCardButton == true
                      ? oddCardSid.toString()
                      : blackCardButton == true
                          ? blackCardSid.toString()
                          : redCardButton == true
                              ? redCardSid.toString()
                              : SizedBox(),
      "placeTime": currentTime.toString(),
      "marketId": marketId.toString(),
      "matchId": 12,
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
    setState(() {
      manualAmount = false;
    });
    var result = jsonDecode(response);
    print("betBody--->$body");
    if (result['status'] == true) {
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

      getVcLiablity();
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
      "odds": lowCardButton == true
          ? lowCardRate
          : highCardButton == true
              ? highCardRate
              : evenCardButton == true
                  ? evenCardRate
                  : oddCardButton == true
                      ? oddCardRate
                      : blackCardButton == true
                          ? blackCardRate
                          : redCardButton == true
                              ? redCardRate
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
                              ? stack6
                              : "",
      "selectionId": lowCardButton == true
          ? lowCardSid.toString()
          : highCardButton == true
              ? highCardSid.toString()
              : evenCardButton == true
                  ? evenCardSid.toString()
                  : oddCardButton == true
                      ? oddCardSid.toString()
                      : blackCardButton == true
                          ? blackCardSid.toString()
                          : redCardButton == true
                              ? redCardSid.toString()
                              : SizedBox(),
      "placeTime": currentTime.toString(),
      "marketId": marketId.toString(),
      "matchId": 12,
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
        manualAmount = false;
        stakeController.clear();
      });
      setState(() {
        _currentCoinIndexRytPort++;
        _startCoinAnimationRightPort();
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

  List<MatchIdModeLL7> matchIdList = [];
  Future getMatchIdDetails() async {
    var url = Apis.matchId;
    var body = {"matchId": "12"};
    var response = await GlobalFunction.apiPostRequestToken(url, body);
    var result = jsonDecode(response);
    print("----------result match id ---------$result");
    if (result['status'] == true) {
      var list = result['data']['VLucky7A'] as List;
      matchIdList.clear();
      var listdata = list.map((e) => MatchIdModeLL7.fromJson(e)).toList();
      matchIdList.addAll(listdata);
    }
  }

  Future getUserDetails() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    var url = Apis.validateToken;
    var response = await http.post(Uri.parse(url), body: {}, headers: {
      "Authorization": "Bearer ${preferences.getString("token")}",
    });

    if (response.statusCode == 200) {
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
