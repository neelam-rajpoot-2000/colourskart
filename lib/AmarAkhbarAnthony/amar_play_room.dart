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
import 'package:shared_preferences/shared_preferences.dart';
import 'package:vibration/vibration.dart';
import 'package:virtual_casino/AmarAkhbarAnthony/Animations/portrait_random_coin_right_side_amar.dart';
import 'package:virtual_casino/User-Interface/current_user_bet.dart';
import 'package:virtual_casino/Utils/toast.dart';
import 'package:virtual_casino/data/model/match_id_model.dart';
import '../User-Interface/change_passswod_screen.dart';
import '../User-Interface/my_account.dart';
import '../User-Interface/profile_screen.dart';
import '../User-Interface/signin_screen.dart';
import '../Utils/api_helper.dart';
import '../Utils/apis.dart';
import '../Widgets/customText.dart';
import 'package:http/http.dart' as http;
import '../constants/color_constants.dart';
import '../data/model/winner_result_lucky7.dart';
import 'Animations/landscape_random_coin_left_side_amar.dart';
import 'Animations/landscape_random_coin_right_side_amar.dart';
import 'Animations/portrait_random_coin_left_side_amar.dart';

class AmarPlayRoom extends StatefulWidget {
  final String matchId;
  final String gameCode;
  const AmarPlayRoom(
      {super.key, required this.matchId, required this.gameCode});

  @override
  State<AmarPlayRoom> createState() => _AmarPlayRoomState();
}

class _AmarPlayRoomState extends State<AmarPlayRoom>
    with TickerProviderStateMixin, WidgetsBindingObserver {
  double height = 0;
  double width = 0;
  String autoTime = "";
  bool menubar = false;
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
  bool confirmButton = false;
  int stack1 = 0;
  int stack2 = 0;
  int stack3 = 0;
  int stack4 = 0;
  int stack5 = 0;
  int stack6 = 0;
  bool selectCard = false;
  var coin = 0;
  final List<Widget> _coins = [];
  final List<Widget> _coinsRyt = [];
  final List<Widget> _coinsPort = [];
  final List<Widget> _coinsRytPort = [];
  String cardNameImage6 = "";
  final Random _random = Random();
  final double _minX = 170;
  final double _maxX = 630;
  final double _minY = 170;
  final double _maxY = 320;
  final double _minXLeftPort = 50;
  final double _maxXLeftPort = 200;
  final double _minYLeftPort = 50;
  final double _maxYLeftPort = 200;
  final double _minXRytPort = 100;
  final double _maxXRytPort = 200;
  final double _minYRytPort = 40;
  final double _maxYRytPort = 200;
  bool redCoinAnimation = false;
  bool lightGreenCoinAnimation = false;
  bool blueCoinAnimation = false;
  bool greenCoinAnimation = false;
  bool lightBlueCoinAnimation = false;
  bool brownCoinAnimation = false;
  bool akbarAButton = false;
  bool akbarBButton = false;
  bool amarAButton = false;
  bool amarBButton = false;
  bool anthonyAButton = false;
  bool anthonyBButton = false;
  bool evenButton = false;
  bool oddButton = false;
  bool redButton = false;
  bool blackButton = false;
  bool under7Button = false;
  bool over7Button = false;
  bool manualAmount = false;
  String sidNumber = "";
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
  double liablity20 = 0;
  double liablity21 = 0;
  double liablity22 = 0;
  double liablity23 = 0;
  bool showLiablity = false;

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

  final int _totalCoins = 7000;
  int _currentCoinIndex = 0;
  int _currentCoinIndexRyt = 0;
  int _currentCoinIndexPort = 0;
  int _currentCoinIndexRytPort = 0;

  late Timer _clockTimer;
  late Timer _musicTimer;
     int startTimeSmall=0;

  var gameSound = "assets/Teen-patti/audio/teen-patti-bgm.mp3";
  var stakeController = TextEditingController();

  @override
  void initState() {
         startTimeSmall=startTimes*100;
       Timer.periodic(const Duration(milliseconds: 10), (timer) {
        startTimeSmall =startTimeSmall-1;
       });
    getMatchIdDetails();
    getUserDetails();
    getDeviceIp();

    getStakeDetails();
    AudioPlayer.clearAssetCache();
    WidgetsBinding.instance.addObserver(this);
    // bgMusic();

    getuserBalance();
    // winnerMusic();
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.landscapeLeft,
      DeviceOrientation.landscapeRight,
      DeviceOrientation.portraitUp
    ]);
    _clockTimer = Timer.periodic(const Duration(seconds: 1), (timer) {
      getCardData();
      getResult();
      stopBettingMusic();
      startBettingMusic();
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
    });

    super.initState();
    _controller1 = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 600), // Adjust the duration as needed
    );

    _controller = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 2000), // Adjust the duration as needed
    );

    _animation = CurvedAnimation(parent: _controller, curve: Curves.easeInOut);
    _controller.repeat(reverse: true);
  }

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

    setState(() {
      startTimes > 1
          ? _coinsRytPort.add(TweenAnimationBuilder(
              tween: Tween<double>(begin: 0, end: 1),
              duration: const Duration(milliseconds: 600),
              builder: (BuildContext context, double value, Widget? child) {
                double currentX = _startX + (_endX - _startX) * value;
                double currentY = _startY + (_endY - _startY) * value;

                return Positioned(
                    right: currentX.clamp(_minXRytPort, _maxXRytPort),
                    bottom: currentY.clamp(_minYRytPort, _maxYRytPort),
                    child: startTimes > 1
                        ? redCoinAnimation == true
                            ? Image.asset(
                                _redcoinImages[_currentCoinIndexRytPort %
                                    _redcoinImages.length],
                                height: 20,
                                width: 20,
                              )
                            : lightGreenCoinAnimation == true
                                ? Image.asset(
                                    _lightGreencoinImages[
                                        _currentCoinIndexRytPort %
                                            _lightGreencoinImages.length],
                                    height: 20,
                                    width: 20,
                                  )
                                : blueCoinAnimation == true
                                    ? Image.asset(
                                        _bluecoinImages[
                                            _currentCoinIndexRytPort %
                                                _bluecoinImages.length],
                                        height: 20,
                                        width: 20,
                                      )
                                    : greenCoinAnimation == true
                                        ? Image.asset(
                                            _greencoinImages[
                                                _currentCoinIndexRytPort %
                                                    _greencoinImages.length],
                                            height: 20,
                                            width: 20,
                                          )
                                        : lightBlueCoinAnimation == true
                                            ? Image.asset(
                                                _skybluecoinImages[
                                                    _currentCoinIndexRytPort %
                                                        _skybluecoinImages
                                                            .length],
                                                height: 20,
                                                width: 20,
                                              )
                                            : brownCoinAnimation == true
                                                ? Image.asset(
                                                    _browncoinImages[
                                                        _currentCoinIndexRytPort %
                                                            _browncoinImages
                                                                .length],
                                                    height: 20,
                                                    width: 20,
                                                  )
                                                : SizedBox()
                        : SizedBox());
              },
            ))
          : _coinsRytPort.reversed;
    });

    autoTime != "0" && playBackgroundMusic == false
        ? onPressedMusicForBet()
        : null;
  }

  void _startCoinAnimationLeftPort() {
    if (_currentCoinIndexPort >= _totalCoins) {
      return;
    }

    double _startX = _minYLeftPort;
    double _startY = _minYLeftPort;
    double _endX =
        _random.nextDouble() * (_maxXLeftPort - _minXLeftPort) + _minXLeftPort;
    double _endY =
        _random.nextDouble() * (_maxYLeftPort - _minYLeftPort) + _minYLeftPort;

    setState(() {
      startTimes > 1
          ? _coinsPort.add(TweenAnimationBuilder(
              tween: Tween<double>(begin: 0, end: 1),
              duration: const Duration(milliseconds: 600),
              builder: (BuildContext context, double value, Widget? child) {
                double currentX = _startX + (_endX - _startX) * value;
                double currentY = _startY + (_endY - _startY) * value;

                return Positioned(
                    left: currentX.clamp(_minXLeftPort, _maxXLeftPort),
                    top: currentY.clamp(_minYLeftPort, _maxYLeftPort),
                    child: startTimes > 1
                        ? redCoinAnimation == true
                            ? Image.asset(
                                _redcoinImages[_currentCoinIndexPort %
                                    _redcoinImages.length],
                                height: 20,
                                width: 20,
                              )
                            : lightGreenCoinAnimation == true
                                ? Image.asset(
                                    _lightGreencoinImages[
                                        _currentCoinIndexPort %
                                            _lightGreencoinImages.length],
                                    height: 20,
                                    width: 20,
                                  )
                                : blueCoinAnimation == true
                                    ? Image.asset(
                                        _bluecoinImages[_currentCoinIndexPort %
                                            _bluecoinImages.length],
                                        height: 20,
                                        width: 20,
                                      )
                                    : greenCoinAnimation == true
                                        ? Image.asset(
                                            _greencoinImages[
                                                _currentCoinIndexPort %
                                                    _greencoinImages.length],
                                            height: 20,
                                            width: 20,
                                          )
                                        : lightBlueCoinAnimation == true
                                            ? Image.asset(
                                                _skybluecoinImages[
                                                    _currentCoinIndexPort %
                                                        _skybluecoinImages
                                                            .length],
                                                height: 20,
                                                width: 20,
                                              )
                                            : brownCoinAnimation == true
                                                ? Image.asset(
                                                    _browncoinImages[
                                                        _currentCoinIndexPort %
                                                            _browncoinImages
                                                                .length],
                                                    height: 20,
                                                    width: 20,
                                                  )
                                                : SizedBox()
                        : SizedBox());
              },
            ))
          : _coinsPort.reversed;
    });

    autoTime != "0" && playBackgroundMusic == false
        ? onPressedMusicForBet()
        : null;
    autoTime == "0" ? _coinsPort.reversed : null;
    autoTime == "0" ? _coinsPort.clear() : null;
  }

  void _startCoinAnimation() {
    if (_currentCoinIndex >= _totalCoins) {
      return;
    }

    double _startX = _minX;
    double _startY = _minX;
    double _endX = _random.nextDouble() * (_maxX - _minX) + _minX;
    double _endY = _random.nextDouble() * (_maxY - _minY) + _minY;

    setState(() {
      startTimes > 1
          ? _coins.add(TweenAnimationBuilder(
              tween: Tween<double>(begin: 0, end: 1),
              duration: const Duration(milliseconds: 600),
              builder: (BuildContext context, double value, Widget? child) {
                double currentX = _startX + (_endX - _startX) * value;
                double currentY = _startY + (_endY - _startY) * value;

                return Positioned(
                    left: currentX.clamp(_minX, _maxX),
                    top: currentY.clamp(_minY, _maxY),
                    child: startTimes > 1
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
                                : blueCoinAnimation == true
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
                                        : lightBlueCoinAnimation == true
                                            ? Image.asset(
                                                _skybluecoinImages[
                                                    _currentCoinIndex %
                                                        _skybluecoinImages
                                                            .length],
                                                height: 20,
                                                width: 20,
                                              )
                                            : brownCoinAnimation == true
                                                ? Image.asset(
                                                    _browncoinImages[
                                                        _currentCoinIndex %
                                                            _browncoinImages
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

  void _startCoinAnimationRyt() {
    if (_currentCoinIndexRyt >= _totalCoins) {
      return;
    }

    double radius = 200; // Radius of the circular path
    double angle = _currentCoinIndexRyt * (pi / _totalCoins);

    double _startX = _minX;
    double _startY = _minX;
    double _endX = _random.nextDouble() * (_maxX - _minX) + _minX;
    double _endY = _random.nextDouble() * (_maxY - _minY) + _minY;

    setState(() {
      startTimes > 1
          ? _coinsRyt.add(TweenAnimationBuilder(
              tween: Tween<double>(begin: 0, end: 1),
              duration: const Duration(milliseconds: 600),
              builder: (BuildContext context, double value, Widget? child) {
                double currentX = _startX + (_endX - _startX) * value;
                double currentY = _startY + (_endY - _startY) * value;

                return Positioned(
                    right: currentX.clamp(_minX, _maxX),
                    top: currentY.clamp(_minY, _maxY),
                    child: startTimes > 1
                        ? redCoinAnimation == true
                            ? Image.asset(
                                _redcoinImages[_currentCoinIndexRyt %
                                    _redcoinImages.length],
                                height: 20,
                                width: 20,
                              )
                            : lightGreenCoinAnimation == true
                                ? Image.asset(
                                    _lightGreencoinImages[_currentCoinIndexRyt %
                                        _lightGreencoinImages.length],
                                    height: 20,
                                    width: 20,
                                  )
                                : blueCoinAnimation == true
                                    ? Image.asset(
                                        _bluecoinImages[_currentCoinIndexRyt %
                                            _bluecoinImages.length],
                                        height: 20,
                                        width: 20,
                                      )
                                    : greenCoinAnimation == true
                                        ? Image.asset(
                                            _greencoinImages[
                                                _currentCoinIndexRyt %
                                                    _greencoinImages.length],
                                            height: 20,
                                            width: 20,
                                          )
                                        : lightBlueCoinAnimation == true
                                            ? Image.asset(
                                                _skybluecoinImages[
                                                    _currentCoinIndexRyt %
                                                        _skybluecoinImages
                                                            .length],
                                                height: 20,
                                                width: 20,
                                              )
                                            : brownCoinAnimation == true
                                                ? Image.asset(
                                                    _browncoinImages[
                                                        _currentCoinIndexRyt %
                                                            _browncoinImages
                                                                .length],
                                                    height: 20,
                                                    width: 20,
                                                  )
                                                : SizedBox()
                        : SizedBox());
              },
            ))
          : _coinsRyt.clear();
    });

    autoTime != "0" && playBackgroundMusic == false
        ? onPressedMusicForBet()
        : null;
  }

  @override
  void dispose() {
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
    await _player.setVolume(0.07);
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
        "assets/lucky7/audio/flipcard.mp3",
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
        "assets/lucky7/audio/stopbetting.mp3",
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
        "assets/lucky7/audio/startbetting.mp3",
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
        "assets/lucky7/audio/winsong.mp3",
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
        "assets/lucky7/audio/flipcard.mp3",
      ));
    } catch (e) {
      print("Error loading audio source: $e");
    }
    onPressedmusic.play();
  }

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

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.paused) {
      playBackgroundMusic = true;
      _player.pause();
    } else if (state == AppLifecycleState.resumed) {
      _player.play();
    }
  }

  final GlobalKey<ScaffoldState> _globalKey = GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {
    getuserBalance();
    getUserDetails();
    getMatchIdDetails();
    height = MediaQuery.of(context).size.height;
    width = MediaQuery.of(context).size.width;
    return OrientationBuilder(builder: (context, oreintation) {
      if (oreintation == Orientation.landscape) {
        return landscapeWidget();
      } else {
        return protraitModeWidget();
      }
    });
  }

  Widget landscapeWidget() {
    return Scaffold(
      drawerEnableOpenDragGesture: false,
      backgroundColor: Colors.transparent,
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
                            "assets/AmarAkhbarAnthony/Images/AMAR AKBAR ANTHONY (1).png"),
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
                                    menubar = true;
                                  });
                                  HapticFeedback.vibrate();

                                  _globalKey.currentState!.openDrawer();
                                },
                                child: Image.asset(
                                    'assets/AmarAkhbarAnthony/Images/menu-button.png',
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
                                            'assets/AmarAkhbarAnthony/Images/balance-frame.png'),
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
                              HapticFeedback.vibrate();
                              onPressedMusic();
                              Navigator.push(
                                  context, _createRouteCurrentBets());
                            },
                            child: Image.asset(
                              'assets/AmarAkhbarAnthony/Images/show-my-bet.png',
                              fit: BoxFit.fill,
                              height: height * 0.10,
                              width: width * 0.15,
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
                      top: height * 0.17,
                      left: width * 0.135,
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
                                          height: 2,
                                          width: width * 0.20,
                                          child: LinearProgressIndicator(
                                  value:
                                     startTimeSmall/4500, // Calculate the progress
                                  backgroundColor: Colors.grey,
                                  valueColor:
                                      AlwaysStoppedAnimation(Color(0xaa9919D2)),
                                  
                                ),
                                        ),
                                        Container(
                                          margin: const EdgeInsets.symmetric(
                                              horizontal: 30),
                                          alignment: Alignment.centerRight,
                                          child: Text(
                                            "( Min:100 Max: 25000 )",
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontWeight: FontWeight.bold,
                                                fontSize: 11),
                                          ),
                                        ),
                                        SizedBox(
                                          height: 10,
                                        ),
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
                                onPressedMusic();
                                _player.stop();
                                setState(() {
                                  playBackgroundMusic = true;
                                });
                              },
                              child: Image.asset(
                                  'assets/AmarAkhbarAnthony/Images/sound-button.png',
                                  fit: BoxFit.cover,
                                  width: width * 0.04),
                            )
                          : InkWell(
                              onTap: () {
                                HapticFeedback.vibrate();
                                onPressedMusic();
                                _player.play();
                                setState(() {
                                  playBackgroundMusic = false;
                                });
                              },
                              child: Image.asset(
                                  'assets/AmarAkhbarAnthony/Images/sound-off.png',
                                  fit: BoxFit.cover,
                                  width: width * 0.04),
                            ),
                    ),

                    Positioned(
                      bottom: 1,
                      child: Image.asset(
                        'assets/AmarAkhbarAnthony/Images/table-a-landscepe.png',
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
                    LandscapeRandomCoinLeftSideAmar(
                        coinsSound: playBackgroundMusic),
                    RandomCoinThroughRightSideAmar(),
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
                      left: width * 0.29,
                      child: Row(
                        children: [
                          InkWell(
                            onTap: () {
                              if (autoTime != "0") {
                                setState(() {
                                  redCoinAnimation = !redCoinAnimation;
                                  lightGreenCoinAnimation = false;
                                  blueCoinAnimation = false;
                                  greenCoinAnimation = false;
                                  lightBlueCoinAnimation = false;
                                  brownCoinAnimation = false;
                                });
                              }
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
                                    "assets/Teen-patti/images/coins-image/Group 115.png"),
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
                              if (autoTime != '0') {
                                setState(() {
                                  lightGreenCoinAnimation =
                                      !lightBlueCoinAnimation;
                                  redCoinAnimation = false;
                                  blueCoinAnimation = false;
                                  greenCoinAnimation = false;
                                  lightBlueCoinAnimation = false;
                                  brownCoinAnimation = false;
                                });
                              }
                            },
                            child: AnimatedContainer(
                              duration: Duration(milliseconds: 700),
                              alignment: Alignment.center,
                              height: lightGreenCoinAnimation == true
                                  ? height * 0.16
                                  : height * 0.11,
                              width: lightGreenCoinAnimation == true
                                  ? width * 0.08
                                  : width * 0.05,
                              decoration: BoxDecoration(
                                  image: DecorationImage(
                                image: AssetImage(
                                    "assets/Teen-patti/images/coins-image/Group 654.png"),
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
                              if (autoTime != "0") {
                                setState(() {
                                  redCoinAnimation = false;
                                  lightGreenCoinAnimation = false;
                                  blueCoinAnimation = !blueCoinAnimation;
                                  greenCoinAnimation = false;
                                  lightBlueCoinAnimation = false;
                                  brownCoinAnimation = false;
                                });
                              }
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
                                    "assets/Teen-patti/images/coins-image/Group 656.png"),
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
                              if (autoTime != "0") {
                                setState(() {
                                  redCoinAnimation = false;
                                  lightGreenCoinAnimation = false;
                                  blueCoinAnimation = false;
                                  greenCoinAnimation = !greenCoinAnimation;
                                  lightBlueCoinAnimation = false;
                                  brownCoinAnimation = false;
                                });
                              }
                            },
                            child: AnimatedContainer(
                              duration: Duration(milliseconds: 700),
                              alignment: Alignment.center,
                              height: greenCoinAnimation == true
                                  ? height * 0.16
                                  : height * 0.11,
                              width: greenCoinAnimation == true
                                  ? width * 0.08
                                  : width * 0.05,
                              decoration: BoxDecoration(
                                  image: DecorationImage(
                                image: AssetImage(
                                    "assets/Teen-patti/images/coins-image/Group 657 (1).png"),
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
                              if (autoTime != "0") {
                                setState(() {
                                  redCoinAnimation = false;
                                  lightGreenCoinAnimation = false;
                                  blueCoinAnimation = false;
                                  greenCoinAnimation = false;
                                  lightBlueCoinAnimation =
                                      !lightBlueCoinAnimation;
                                  brownCoinAnimation = false;
                                });
                              }
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
                                    "assets/Teen-patti/images/coins-image/Group 677 (1).png"),
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
                          //         : width * 0.055,
                          //     decoration: BoxDecoration(
                          //         image: DecorationImage(
                          //       image: AssetImage(
                          //           "assets/Teen-patti/images/coins-image/Group 678.png"),
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
                              "assets/AmarAkhbarAnthony/Images/small-result-.png"),
                          fit: BoxFit.cover,
                        )),
                        child: ListView.builder(
                            shrinkWrap: true,
                            physics: NeverScrollableScrollPhysics(),
                            itemCount: cardResultList.length,
                            scrollDirection: Axis.vertical,
                            itemBuilder: (context, index) {
                              var items = cardResultList[index];
                              return InkWell(
                                onTap: () {
                                  HapticFeedback.vibrate();
                                  onPressedMusic();
                                  DialogUtils.showResultAmar(
                                      context,
                                      items.detail.toString(),
                                      items.c1,
                                      items.mid,
                                      playBackgroundMusic);
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
                                        ? "A"
                                        : items.winner == "2"
                                            ? "B"
                                            : "C",
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
                            padding: EdgeInsets.only(
                                left: width * 0.04, right: width * 0.02),
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                                image: DecorationImage(
                                    image: AssetImage(
                                        "assets/AmarAkhbarAnthony/Images/exp-balance.png"))),
                            height: height * 0.1,
                            width: width * 0.15,
                            child: Text(
                              liablity,
                              style: TextStyle(
                                  color: Colors.yellow[50],
                                  fontWeight: FontWeight.bold,
                                  fontSize: 12),
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
                          "assets/AmarAkhbarAnthony/Images/AMAR AKBAR ANTHONY (1).png"),
                      fit: BoxFit.cover)),
              height: height * 0.6,
              width: width,
              child: Column(
                children: [
                  amarAkhbarButtons(),
                  evenOddButtons(),
                  SizedBox(
                    height: 20,
                  ),
                  Container(
                    height: height * 0.01,
                    width: width * 0.9,
                    decoration: BoxDecoration(
                        image: DecorationImage(
                            image: AssetImage(
                                "assets/User-interface/Line 43.png"))),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  // Text(
                  //   "12:00",
                  //   style: TextStyle(
                  //       color: Colors.white, fontWeight: FontWeight.w600),
                  // ),
                  // Container(
                  //   alignment: Alignment.center,
                  //   height: height * 0.2,
                  //   width: width * 0.8,
                  //   child: ListView.builder(
                  //       physics: NeverScrollableScrollPhysics(),
                  //       scrollDirection: Axis.horizontal,
                  //       itemCount: 13,
                  //       itemBuilder: (context, index) {
                  //         return Column(
                  //           crossAxisAlignment: CrossAxisAlignment.center,
                  //           mainAxisAlignment: MainAxisAlignment.center,
                  //           children: [
                  //             InkWell(
                  //               onTap: () {
                  //                 setState(() {
                  //                   cardIndex = index;
                  //                   selectCard = true;
                  //                 });
                  //                 if (redCoinAnimation == true ||
                  //                     lightGreenCoinAnimation == true ||
                  //                     blueCoinAnimation == true ||
                  //                     greenCoinAnimation == true ||
                  //                     lightBlueCoinAnimation == true ||
                  //                     brownCoinAnimation == true) {
                  //                   showMyDialog(redCoinAnimation == true
                  //                       ? stack1
                  //                       : lightGreenCoinAnimation == true
                  //                           ? stack2
                  //                           : blueCoinAnimation == true
                  //                               ? stack3
                  //                               : greenCoinAnimation == true
                  //                                   ? stack4
                  //                                   : lightBlueCoinAnimation ==
                  //                                           true
                  //                                       ? stack5
                  //                                       : brownCoinAnimation ==
                  //                                               true
                  //                                           ? stack6
                  //                                           : 0);
                  //                 }
                  //               },
                  //               child: Container(
                  //                 height: height * 0.12,
                  //                 width: width * 0.06,
                  //                 decoration: BoxDecoration(
                  //                     image: DecorationImage(
                  //                         image: AssetImage(
                  //                             "assets/AmarAkhbarAnthony/Images/card-image.png"))),
                  //               ),
                  //             ),
                  //           ],
                  //         );
                  //       }),
                  // ),
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
      drawerEnableOpenDragGesture: false,
      backgroundColor: Colors.transparent,
      key: _globalKey,
      drawer: drawerWidgetPotrait(),
      body: Container(
          height: height * 1.35,
          width: width,
          decoration: BoxDecoration(
              image: DecorationImage(
            image: AssetImage(
              "assets/AmarAkhbarAnthony/Images/AMAR AKBAR ANTHONY.png",
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
                  children: [
                    Container(
                      height: 45,
                      width: width * 0.35,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                          image: DecorationImage(
                              image: AssetImage(
                                  'assets/AmarAkhbarAnthony/Images/balance-frame.png'),
                              fit: BoxFit.fill)),
                      child: Container(
                        padding: EdgeInsets.symmetric(
                            horizontal: width * 0.02, vertical: height * 0.001),
                        child: Text(
                          "       ${mainBalance.toStringAsFixed(2)}",
                          style: TextStyle(
                              color: Color.fromARGB(255, 248, 244, 204),
                              fontSize: height * 0.015,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                    Expanded(
                      child: SizedBox(),
                    ),
                    InkWell(
                      onTap: () {
                        HapticFeedback.heavyImpact();
                        onPressedMusic();
                        _globalKey.currentState!.openDrawer();
                      },
                      child: Padding(
                        padding: const EdgeInsets.only(top: 5.0),
                        child: Image.asset(
                            'assets/AmarAkhbarAnthony/Images/menu-button.png',
                            fit: BoxFit.contain,
                            height: height * 0.05),
                      ),
                    ),
                    SizedBox(
                      width: width * 0.02,
                    ),
                    playBackgroundMusic == false
                        ? InkWell(
                            onTap: () {
                              HapticFeedback.vibrate();
                              onPressedMusic();
                              _player.stop();
                              setState(() {
                                playBackgroundMusic = true;
                              });
                            },
                            child: Image.asset(
                                'assets/AmarAkhbarAnthony/Images/sound-button.png',
                                fit: BoxFit.contain,
                                height: height * 0.047),
                          )
                        : InkWell(
                            onTap: () {
                              HapticFeedback.vibrate();
                              onPressedMusic();
                              _player.play();
                              setState(() {
                                playBackgroundMusic = false;
                              });
                            },
                            child: Image.asset(
                                'assets/AmarAkhbarAnthony/Images/sound-off.png',
                                fit: BoxFit.contain,
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
                      height: height * 0.04,
                      width: width * 0.35,
                      margin: const EdgeInsets.only(left: 5),
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                          image: DecorationImage(
                              image: AssetImage(
                                  'assets/AmarAkhbarAnthony/Images/exp-balance.png'),
                              fit: BoxFit.fill)),
                      child: CustomText(
                        text: "       $liablity",
                        fontWeight: FontWeight.w500,
                        color: Colors.yellow[50],
                        fontSize: width * 0.03,
                        textAlign: TextAlign.center,
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        HapticFeedback.heavyImpact();
                        onPressedMusic();

                        Navigator.push(context, _createRouteCurrentBets());
                      },
                      child: Container(
                        padding: EdgeInsets.only(
                            left: width * 0.16, top: height * 0.004),
                        height: height * 0.05,
                        width: width * 0.25,
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                            image: DecorationImage(
                                image: AssetImage(
                                  'assets/AmarAkhbarAnthony/Images/show-my-bet.png',
                                ),
                                fit: BoxFit.fill)),
                        child: CustomText(
                          text: matchIdList.length.toString(),
                          fontWeight: FontWeight.w500,
                          color: Colors.yellow[50],
                          fontSize: width * 0.03,
                          textAlign: TextAlign.center,
                        ),
                      ),
                    )
                  ],
                ),
              ),
              SizedBox(
                height: 10,
              ),
              BlinkText(
                "Round ID : $marketId",
                style:
                    TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
              ),
              SizedBox(
                height: 10,
              ),
              Container(
                height: 35,
                width: width * 0.9,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                    image: DecorationImage(
                        image: AssetImage(
                            "assets/AmarAkhbarAnthony/Images/small-result-portrait.png"),
                        fit: BoxFit.cover)),
                child: Padding(
                  padding: const EdgeInsets.only(left: 20.0, top: 8),
                  child: ListView.builder(
                      physics: NeverScrollableScrollPhysics(),
                      scrollDirection: Axis.horizontal,
                      itemCount: cardResultList.length,
                      itemBuilder: (context, index) {
                        var items = cardResultList[index];
                        return Column(
                          children: [
                            InkWell(
                              onTap: () {
                                onPressedMusic();
                                HapticFeedback.vibrate();
                                DialogUtils.showResultAmarPortrait(
                                    context,
                                    items.detail.toString(),
                                    items.c1,
                                    items.mid,
                                    playBackgroundMusic);
                              },
                              child: Container(
                                alignment: Alignment.center,
                                margin:
                                    const EdgeInsets.symmetric(horizontal: 5),
                                height: 20,
                                width: 20,
                                decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: items.winner == "1"
                                        ? Color(0xaa028BA9)
                                        : items.winner == "2"
                                            ? Color(0xaaA90270)
                                            : ColorConstants.lightGreenColor),
                                child: Text(
                                  items.winner == "1"
                                      ? "A"
                                      : items.winner == "2"
                                          ? "B"
                                          : "C",
                                  style: TextStyle(
                                    fontWeight: FontWeight.w600,
                                    color: ColorConstants.whiteColor,
                                    fontSize: 12.0,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        );
                      }),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 30),
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
              SizedBox(
                height: 30,
              ),
              Image.asset(
                'assets/dragonTigerLion/tableImges/table-girl.png',
                fit: BoxFit.cover,
                height: height * 0.13,
              ),
              Stack(
                children: [
                  Image.asset(
                    'assets/AmarAkhbarAnthony/Images/table-p.png',
                    fit: BoxFit.cover,
                    height: height * 0.35,
                    width: width * 0.99,
                  ),
                  Positioned(
                    left: 30,
                    child: Image.asset(
                      'assets/lucky7/images/frame/logo.png',
                      fit: BoxFit.cover,
                      height: height * 0.05,
                    ),
                  ),
                  Positioned(
                    right: 30,
                    child: Image.asset(
                      'assets/lucky7/images/frame/logo.png',
                      fit: BoxFit.cover,
                      height: height * 0.05,
                    ),
                  ),
                  Positioned(
                    top: height * 0.28,
                    left: width * 0.13,
                    child: Row(
                      children: [
                        InkWell(
                          onTap: () {
                            if (autoTime != "0") {
                              setState(() {
                                redCoinAnimation = !redCoinAnimation;
                                lightGreenCoinAnimation = false;
                                blueCoinAnimation = false;
                                greenCoinAnimation = false;
                                lightBlueCoinAnimation = false;
                                brownCoinAnimation = false;
                              });
                            }
                          },
                          child: AnimatedContainer(
                            alignment: Alignment.center,
                            duration: Duration(milliseconds: 300),
                            height: redCoinAnimation == false
                                ? height * 0.055
                                : height * 0.08,
                            width: redCoinAnimation == false
                                ? width * 0.12
                                : width * 0.17,
                            decoration: BoxDecoration(
                                image: DecorationImage(
                              image: AssetImage(
                                  "assets/Teen-patti/images/coins-image/Group 115.png"),
                              fit: BoxFit.cover,
                            )),
                            child: Text(
                              stack1 != 0 ? "100" : stack6.toString(),
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 10),
                            ),
                          ),
                        ),
                        SizedBox(
                          width: 14,
                        ),
                        InkWell(
                          onTap: () {
                            if (autoTime != "0") {
                              setState(() {
                                redCoinAnimation = false;
                                lightGreenCoinAnimation =
                                    !lightGreenCoinAnimation;
                                blueCoinAnimation = false;
                                greenCoinAnimation = false;
                                lightBlueCoinAnimation = false;
                                brownCoinAnimation = false;
                              });
                            }
                          },
                          child: AnimatedContainer(
                            alignment: Alignment.center,
                            duration: Duration(milliseconds: 300),
                            height: lightGreenCoinAnimation == false
                                ? height * 0.055
                                : height * 0.08,
                            width: lightGreenCoinAnimation == false
                                ? width * 0.12
                                : width * 0.17,
                            decoration: BoxDecoration(
                                image: DecorationImage(
                              image: AssetImage(
                                  "assets/Teen-patti/images/coins-image/Group 654.png"),
                              fit: BoxFit.cover,
                            )),
                            child: Text(
                              stack2 != 0 ? "1K" : stack6.toString(),
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 10),
                            ),
                          ),
                        ),
                        SizedBox(
                          width: 14,
                        ),
                        InkWell(
                          onTap: () {
                            if (autoTime != "0") {
                              setState(() {
                                redCoinAnimation = false;
                                lightGreenCoinAnimation = false;
                                blueCoinAnimation = !blueCoinAnimation;
                                greenCoinAnimation = false;
                                lightBlueCoinAnimation = false;
                                brownCoinAnimation = false;
                              });
                            }
                          },
                          child: AnimatedContainer(
                            alignment: Alignment.center,
                            duration: Duration(milliseconds: 300),
                            height: blueCoinAnimation == false
                                ? height * 0.055
                                : height * 0.08,
                            width: blueCoinAnimation == false
                                ? width * 0.12
                                : width * 0.17,
                            decoration: BoxDecoration(
                                image: DecorationImage(
                              image: AssetImage(
                                  "assets/Teen-patti/images/coins-image/Group 656.png"),
                              fit: BoxFit.cover,
                            )),
                            child: Text(
                              stack3 != 0 ? "2K" : stack6.toString(),
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 10),
                            ),
                          ),
                        ),
                        SizedBox(
                          width: 14,
                        ),
                        InkWell(
                          onTap: () {
                            if (autoTime != "0") {
                              setState(() {
                                redCoinAnimation = false;
                                lightGreenCoinAnimation = false;
                                blueCoinAnimation = false;
                                greenCoinAnimation = !greenCoinAnimation;
                                lightBlueCoinAnimation = false;
                                brownCoinAnimation = false;
                              });
                            }
                          },
                          child: AnimatedContainer(
                            alignment: Alignment.center,
                            duration: Duration(milliseconds: 300),
                            height: greenCoinAnimation == false
                                ? height * 0.058
                                : height * 0.08,
                            width: greenCoinAnimation == false
                                ? width * 0.14
                                : width * 0.19,
                            decoration: BoxDecoration(
                                image: DecorationImage(
                              image: AssetImage(
                                  "assets/Teen-patti/images/coins-image/Group 677.png"),
                              fit: BoxFit.cover,
                            )),
                            child: Text(
                              stack4 != 0 ? "5K" : stack6.toString(),
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 10),
                            ),
                          ),
                        ),
                        SizedBox(
                          width: 14,
                        ),
                        InkWell(
                          onTap: () {
                            if (autoTime != "0") {
                              setState(() {
                                redCoinAnimation = false;
                                lightGreenCoinAnimation = false;
                                blueCoinAnimation = false;
                                greenCoinAnimation = false;
                                lightBlueCoinAnimation =
                                    !lightBlueCoinAnimation;
                                brownCoinAnimation = false;
                              });
                            }
                          },
                          child: AnimatedContainer(
                            alignment: Alignment.center,
                            duration: Duration(milliseconds: 300),
                            height: lightBlueCoinAnimation == false
                                ? height * 0.055
                                : height * 0.08,
                            width: lightBlueCoinAnimation == false
                                ? width * 0.12
                                : width * 0.17,
                            decoration: BoxDecoration(
                                image: DecorationImage(
                              image: AssetImage(
                                  "assets/Teen-patti/images/coins-image/Group 657.png"),
                              fit: BoxFit.cover,
                            )),
                            child: Text(
                              stack6 != 0 ? "10K" : stack6.toString(),
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 10),
                            ),
                          ),
                        ),
                      ],
                    ),
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
                                height: 10,
                              ),
                              Text(
                                "Starting in $autoTime sec",
                                style: TextStyle(
                                    color: Colors.white, fontSize: 10),
                              ),
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
                      child: PotraitRandomCoinLeftSideL7Amar(
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
                  SizedBox(
                      height: 200, child: PotraitRandomCoinRightSideL7Amar()),
                  autoTime == "45"
                      ? placeyourbetWidget(autoTime)
                      : autoTime == "3" || autoTime == "2" || autoTime == "1"
                          ? goWidget()
                          : autoTime != "0"
                              ? SizedBox()
                              : Positioned(
                                  left: width * 0.26,
                                  top: height * 0.05,
                                  child: showCurrentCardPort()),
                  startTimes <= 3 && autoTime != '0'
                      ? gameStopBettingPortrait(autoTime)
                      : SizedBox(),
                ],
              ),
              Stack(
                children: [
                  Column(
                    children: [
                      amarAkhbarAnthonyButtonWidgetProtrait(),
                    ],
                  ),
                ],
              ),
              Stack(
                children: [
                  oddEvenWidgetPortrait(),
                ],
              ),
              Stack(
                children: [
                  dividerLineProtrait(),
                ],
              )
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
      pageBuilder: (context, animation, secondaryAnimation) => ProfileScreen(),
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
        matchId: widget.matchId,
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
          ChangePasswordScreen(),
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

  int cardIndex = 0;
  Widget amarAkhbarButtons() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: Row(
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
                          akbarAButton = false;
                          akbarBButton = false;
                          amarAButton = true;
                          anthonyAButton = false;
                          anthonyBButton = false;

                          evenButton = false;
                          oddButton = false;
                          redButton = false;
                          blackButton = false;
                          under7Button = false;
                          over7Button = false;
                          if (redCoinAnimation == true ||
                              lightGreenCoinAnimation == true ||
                              blueCoinAnimation == true ||
                              greenCoinAnimation == true ||
                              lightBlueCoinAnimation == true ||
                              brownCoinAnimation == true) {
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
                          amarRate,
                          style: TextStyle(fontWeight: FontWeight.w600),
                        ),
                      ),
                    ),
                    Text(
                      "AMAR ",
                      style: TextStyle(
                          color: Colors.white, fontWeight: FontWeight.w600),
                    ),
                    InkWell(
                      onTap: () {
                        setState(() {
                          akbarAButton = false;
                          akbarBButton = false;
                          amarAButton = false;
                          amarBButton = true;
                          anthonyAButton = false;
                          anthonyBButton = false;
                          evenButton = false;
                          oddButton = false;
                          redButton = false;
                          blackButton = false;
                          under7Button = false;
                          over7Button = false;
                          if (redCoinAnimation == true ||
                              lightGreenCoinAnimation == true ||
                              blueCoinAnimation == true ||
                              greenCoinAnimation == true ||
                              lightBlueCoinAnimation == true ||
                              brownCoinAnimation == true) {
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
                          amarLayRate,
                          style: TextStyle(fontWeight: FontWeight.w600),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 5,
              ),
              showLiablity == true
                  ? Text(
                      liablity10.toString(),
                      style: TextStyle(
                          color: liablity10 >= 0 ? Colors.green : Colors.red),
                    )
                  : SizedBox()
            ],
          ),
          Column(
            children: [
              InkWell(
                child: Container(
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
                          akbarBButton = false;
                          akbarAButton = true;
                          amarAButton = false;
                          amarBButton = false;
                          anthonyAButton = false;
                          anthonyBButton = false;
                          evenButton = false;
                          oddButton = false;
                          redButton = false;
                          blackButton = false;
                          under7Button = false;
                          over7Button = false;
                          if (redCoinAnimation == true ||
                              lightGreenCoinAnimation == true ||
                              blueCoinAnimation == true ||
                              greenCoinAnimation == true ||
                              lightBlueCoinAnimation == true ||
                              brownCoinAnimation == true) {
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
                        child: Container(
                          alignment: Alignment.center,
                          height: height * 0.1,
                          width: width * 0.06,
                          decoration: BoxDecoration(
                              color: Color(0xaa72BBEF),
                              borderRadius: BorderRadius.circular(5)),
                          child: Text(
                            akbarRate,
                            style: TextStyle(fontWeight: FontWeight.w600),
                          ),
                        ),
                      ),
                      Text(
                        "AKBAR",
                        style: TextStyle(
                            color: Colors.white, fontWeight: FontWeight.w600),
                      ),
                      InkWell(
                        onTap: () {
                          akbarBButton = true;
                          akbarAButton = false;
                          amarAButton = false;
                          amarBButton = false;
                          anthonyAButton = false;
                          anthonyBButton = false;
                          evenButton = false;
                          oddButton = false;
                          redButton = false;
                          blackButton = false;
                          under7Button = false;
                          over7Button = false;
                          if (redCoinAnimation == true ||
                              lightGreenCoinAnimation == true ||
                              blueCoinAnimation == true ||
                              greenCoinAnimation == true ||
                              lightBlueCoinAnimation == true ||
                              brownCoinAnimation == true) {
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
                        child: Container(
                          alignment: Alignment.center,
                          height: height * 0.1,
                          width: width * 0.06,
                          decoration: BoxDecoration(
                              color: Color(0xaaFAA9BA),
                              borderRadius: BorderRadius.circular(5)),
                          child: Text(
                            akbarLayRate,
                            style: TextStyle(fontWeight: FontWeight.w600),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: 5,
              ),
              showLiablity == true
                  ? Text(
                      liablity11.toString(),
                      style: TextStyle(
                          color: liablity11 >= 0 ? Colors.green : Colors.red),
                    )
                  : SizedBox()
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
                        akbarAButton = false;
                        akbarBButton = false;

                        amarAButton = false;
                        amarBButton = false;

                        anthonyAButton = true;
                        anthonyBButton = false;
                        evenButton = false;
                        oddButton = false;
                        redButton = false;
                        blackButton = false;
                        under7Button = false;
                        over7Button = false;
                        if (redCoinAnimation == true ||
                            lightGreenCoinAnimation == true ||
                            blueCoinAnimation == true ||
                            greenCoinAnimation == true ||
                            lightBlueCoinAnimation == true ||
                            brownCoinAnimation == true) {
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
                      child: Container(
                        alignment: Alignment.center,
                        height: height * 0.1,
                        width: width * 0.06,
                        decoration: BoxDecoration(
                            color: Color(0xaa72BBEF),
                            borderRadius: BorderRadius.circular(5)),
                        child: Text(
                          anthonyRate,
                          style: TextStyle(fontWeight: FontWeight.w600),
                        ),
                      ),
                    ),
                    Text(
                      "ANTHONY",
                      style: TextStyle(
                          color: Colors.white, fontWeight: FontWeight.w600),
                    ),
                    InkWell(
                      onTap: () {
                        akbarAButton = false;
                        akbarBButton = false;
                        amarBButton = false;

                        amarAButton = false;
                        anthonyAButton = false;
                        anthonyBButton = true;
                        evenButton = false;
                        oddButton = false;
                        redButton = false;
                        blackButton = false;
                        under7Button = false;
                        over7Button = false;
                        if (redCoinAnimation == true ||
                            lightGreenCoinAnimation == true ||
                            blueCoinAnimation == true ||
                            greenCoinAnimation == true ||
                            lightBlueCoinAnimation == true ||
                            brownCoinAnimation == true) {
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
                      child: Container(
                        alignment: Alignment.center,
                        height: height * 0.1,
                        width: width * 0.06,
                        decoration: BoxDecoration(
                            color: Color(0xaaFAA9BA),
                            borderRadius: BorderRadius.circular(5)),
                        child: Text(
                          anthonyLayRate,
                          style: TextStyle(fontWeight: FontWeight.w600),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 5,
              ),
              showLiablity == true
                  ? Text(
                      liablity12.toString(),
                      style: TextStyle(
                          color: liablity12 >= 0 ? Colors.green : Colors.red),
                    )
                  : SizedBox()
            ],
          ),
        ],
      ),
    );
  }

  Widget evenOddButtons() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          SizedBox(
            child: Row(
              children: [
                Column(
                  children: [
                    InkWell(
                      onTap: () {
                        akbarAButton = false;
                        akbarBButton = false;

                        amarAButton = false;
                        amarBButton = false;
                        anthonyAButton = false;
                        anthonyBButton = false;
                        evenButton = true;
                        oddButton = false;
                        redButton = false;
                        blackButton = false;
                        under7Button = false;
                        over7Button = false;
                        if (redCoinAnimation == true ||
                            lightGreenCoinAnimation == true ||
                            blueCoinAnimation == true ||
                            greenCoinAnimation == true ||
                            lightBlueCoinAnimation == true ||
                            brownCoinAnimation == true) {
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
                      child: Container(
                        height: height * 0.1,
                        width: width * 0.13,
                        decoration: BoxDecoration(
                            border: Border.all(
                              color: Color(0xaaC28934),
                            ),
                            borderRadius: BorderRadius.circular(5)),
                        child: Container(
                          margin: const EdgeInsetsDirectional.symmetric(
                              horizontal: 5),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "EVEN",
                                style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.w600),
                              ),
                              Container(
                                alignment: Alignment.center,
                                height: height * 0.08,
                                width: width * 0.05,
                                decoration: BoxDecoration(
                                    color: Color(0xaa0288A5),
                                    borderRadius: BorderRadius.circular(5)),
                                child: Text(
                                  evenRate,
                                  style: TextStyle(fontWeight: FontWeight.w600),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    showLiablity == true
                        ? Text(
                            liablity13.toString(),
                            style: TextStyle(
                                color: liablity13 >= 0
                                    ? Colors.green
                                    : Colors.red),
                          )
                        : SizedBox()
                  ],
                ),
                SizedBox(
                  width: 30,
                ),
                Column(
                  children: [
                    InkWell(
                      onTap: () {
                        akbarAButton = false;
                        akbarBButton = false;
                        amarAButton = false;
                        amarBButton = false;
                        anthonyAButton = false;
                        anthonyBButton = false;
                        evenButton = false;
                        oddButton = true;
                        redButton = false;
                        blackButton = false;
                        under7Button = false;
                        over7Button = false;
                        if (redCoinAnimation == true ||
                            lightGreenCoinAnimation == true ||
                            blueCoinAnimation == true ||
                            greenCoinAnimation == true ||
                            lightBlueCoinAnimation == true ||
                            brownCoinAnimation == true) {
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
                      child: Container(
                        height: height * 0.1,
                        width: width * 0.13,
                        decoration: BoxDecoration(
                            border: Border.all(
                              color: Color(0xaaC28934),
                            ),
                            borderRadius: BorderRadius.circular(5)),
                        child: Container(
                          margin: const EdgeInsetsDirectional.symmetric(
                              horizontal: 5),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "ODD",
                                style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.w600),
                              ),
                              Container(
                                alignment: Alignment.center,
                                height: height * 0.08,
                                width: width * 0.05,
                                decoration: BoxDecoration(
                                    color: Color(0xaa0288A5),
                                    borderRadius: BorderRadius.circular(5)),
                                child: Text(
                                  oddRate,
                                  style: TextStyle(fontWeight: FontWeight.w600),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    showLiablity == true
                        ? Text(
                            liablity14.toString(),
                            style: TextStyle(
                                color: liablity14 >= 0
                                    ? Colors.green
                                    : Colors.red),
                          )
                        : SizedBox()
                  ],
                ),
                SizedBox(
                  width: 4,
                ),
                Container(
                  height: height * 0.1,
                  width: width * 0.02,
                  decoration: BoxDecoration(
                      image: DecorationImage(
                          image:
                              AssetImage("assets/User-interface/Line 41.png"))),
                ),
              ],
            ),
          ),
          SizedBox(
            child: Row(
              children: [
                Column(
                  children: [
                    InkWell(
                      onTap: () {
                        akbarAButton = false;
                        akbarBButton = false;
                        amarAButton = false;
                        amarBButton = false;
                        anthonyAButton = false;
                        anthonyBButton = false;
                        evenButton = false;
                        oddButton = false;
                        redButton = true;
                        blackButton = false;
                        under7Button = false;
                        over7Button = false;
                        if (redCoinAnimation == true ||
                            lightGreenCoinAnimation == true ||
                            blueCoinAnimation == true ||
                            greenCoinAnimation == true ||
                            lightBlueCoinAnimation == true ||
                            brownCoinAnimation == true) {
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
                      child: Container(
                        height: height * 0.1,
                        width: width * 0.13,
                        decoration: BoxDecoration(
                            border: Border.all(
                              color: Color(0xaaC28934),
                            ),
                            borderRadius: BorderRadius.circular(5)),
                        child: Container(
                          margin: const EdgeInsetsDirectional.symmetric(
                              horizontal: 5),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Image.asset(
                                "assets/bollywoodTable/red-image.png",
                                scale: 2,
                              ),
                              Container(
                                alignment: Alignment.center,
                                height: height * 0.08,
                                width: width * 0.05,
                                decoration: BoxDecoration(
                                    color: Color(0xaa0288A5),
                                    borderRadius: BorderRadius.circular(5)),
                                child: Text(
                                  blackRate,
                                  style: TextStyle(fontWeight: FontWeight.w600),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    showLiablity == true
                        ? Text(
                            liablity15.toString(),
                            style: TextStyle(
                                color: liablity15 >= 0
                                    ? Colors.green
                                    : Colors.red),
                          )
                        : SizedBox()
                  ],
                ),
                SizedBox(
                  width: 30,
                ),
                Column(
                  children: [
                    InkWell(
                      onTap: () {
                        akbarAButton = false;
                        akbarBButton = false;
                        amarAButton = false;
                        amarBButton = false;
                        anthonyAButton = false;
                        anthonyBButton = false;
                        evenButton = false;
                        oddButton = false;
                        redButton = false;
                        blackButton = true;
                        under7Button = false;
                        over7Button = false;
                        if (redCoinAnimation == true ||
                            lightGreenCoinAnimation == true ||
                            blueCoinAnimation == true ||
                            greenCoinAnimation == true ||
                            lightBlueCoinAnimation == true ||
                            brownCoinAnimation == true) {
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
                      child: Container(
                        height: height * 0.1,
                        width: width * 0.13,
                        decoration: BoxDecoration(
                            border: Border.all(
                              color: Color(0xaaC28934),
                            ),
                            borderRadius: BorderRadius.circular(5)),
                        child: Container(
                          margin: const EdgeInsetsDirectional.symmetric(
                              horizontal: 5),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Image.asset(
                                "assets/bollywoodTable/black-image.png",
                                scale: 2,
                              ),
                              Container(
                                alignment: Alignment.center,
                                height: height * 0.08,
                                width: width * 0.05,
                                decoration: BoxDecoration(
                                    color: Color(0xaa0288A5),
                                    borderRadius: BorderRadius.circular(5)),
                                child: Text(
                                  redRate,
                                  style: TextStyle(fontWeight: FontWeight.w600),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    showLiablity == true
                        ? Text(
                            liablity16.toString(),
                            style: TextStyle(
                                color: liablity16 >= 0
                                    ? Colors.green
                                    : Colors.red),
                          )
                        : SizedBox()
                  ],
                ),
                SizedBox(
                  width: 4,
                ),
                Container(
                  height: height * 0.1,
                  width: width * 0.02,
                  decoration: BoxDecoration(
                      image: DecorationImage(
                          image:
                              AssetImage("assets/User-interface/Line 41.png"))),
                ),
              ],
            ),
          ),
          SizedBox(
            child: Row(
              children: [
                Column(
                  children: [
                    InkWell(
                      onTap: () {
                        akbarAButton = false;
                        akbarBButton = false;
                        amarAButton = false;
                        amarBButton = false;
                        anthonyAButton = false;
                        anthonyBButton = false;
                        evenButton = false;
                        oddButton = false;
                        redButton = false;
                        blackButton = false;
                        under7Button = true;
                        over7Button = false;
                        if (redCoinAnimation == true ||
                            lightGreenCoinAnimation == true ||
                            blueCoinAnimation == true ||
                            greenCoinAnimation == true ||
                            lightBlueCoinAnimation == true ||
                            brownCoinAnimation == true) {
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
                      child: Container(
                        height: height * 0.1,
                        width: width * 0.13,
                        decoration: BoxDecoration(
                            border: Border.all(
                              color: Color(0xaaC28934),
                            ),
                            borderRadius: BorderRadius.circular(5)),
                        child: Container(
                          margin: const EdgeInsetsDirectional.symmetric(
                              horizontal: 5),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "UNDER7",
                                style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.w600,
                                    fontSize: 12),
                              ),
                              Container(
                                alignment: Alignment.center,
                                height: height * 0.08,
                                width: width * 0.05,
                                decoration: BoxDecoration(
                                    color: Color(0xaa0288A5),
                                    borderRadius: BorderRadius.circular(5)),
                                child: Text(
                                  under7Rate,
                                  style: TextStyle(fontWeight: FontWeight.w600),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    showLiablity == true
                        ? Text(
                            liablity23.toString(),
                            style: TextStyle(
                                color: liablity23 >= 0
                                    ? Colors.green
                                    : Colors.red),
                          )
                        : SizedBox()
                  ],
                ),
                SizedBox(
                  width: 30,
                ),
                Column(
                  children: [
                    InkWell(
                      onTap: () {
                        akbarAButton = false;
                        akbarBButton = false;
                        amarAButton = false;
                        amarBButton = false;
                        anthonyAButton = false;
                        anthonyBButton = false;
                        evenButton = false;
                        oddButton = false;
                        redButton = false;
                        blackButton = false;
                        under7Button = false;
                        over7Button = true;
                        if (redCoinAnimation == true ||
                            lightGreenCoinAnimation == true ||
                            blueCoinAnimation == true ||
                            greenCoinAnimation == true ||
                            lightBlueCoinAnimation == true ||
                            brownCoinAnimation == true) {
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
                      child: Container(
                        height: height * 0.1,
                        width: width * 0.13,
                        decoration: BoxDecoration(
                            border: Border.all(
                              color: Color(0xaaC28934),
                            ),
                            borderRadius: BorderRadius.circular(5)),
                        child: Container(
                          margin: const EdgeInsetsDirectional.symmetric(
                              horizontal: 5),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "OVER7",
                                style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.w600),
                              ),
                              Container(
                                alignment: Alignment.center,
                                height: height * 0.08,
                                width: width * 0.05,
                                decoration: BoxDecoration(
                                    color: Color(0xaa0288A5),
                                    borderRadius: BorderRadius.circular(5)),
                                child: Text(
                                  over7Rate,
                                  style: TextStyle(fontWeight: FontWeight.w600),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    showLiablity == true
                        ? Text(
                            liablity1.toString(),
                            style: TextStyle(
                                color:
                                    liablity1 >= 0 ? Colors.green : Colors.red),
                          )
                        : SizedBox()
                  ],
                ),
                SizedBox(
                  width: 4,
                ),
              ],
            ),
          ),
        ],
      ),
    );
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

  Widget showCurrentCardPort() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Container(
          // margin: EdgeInsets.only(left: width * 2),
          alignment: Alignment.center,
          height: height * 0.18,
          width: width * 0.5,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              image: DecorationImage(
                  image: AssetImage(
                    "assets/User-interface/amarResultBackground.png",
                  ),
                  fit: BoxFit.cover)),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              winnerResult != ""
                  ? buildImagePortrait(cardNameImage1)
                  : Image.asset(
                      'assets/lucky7/images/cardBg.png',
                      height: height * 0.19,
                      width: width * 0.06,
                      fit: BoxFit.fill,
                    ),
              SizedBox(
                height: 10,
              ),
              Container(
                alignment: Alignment.center,
                margin: const EdgeInsets.symmetric(
                  horizontal: 10,
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
                    "assets/User-interface/amarResultBackground.png",
                  ),
                  fit: BoxFit.cover)),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              winnerResult != ""
                  ? buildImageLand(cardNameImage1)
                  : Image.asset(
                      'assets/lucky7/images/cardBg.png',
                      height: height * 0.19,
                      width: width * 0.06,
                      fit: BoxFit.fill,
                    ),
              SizedBox(
                height: 30,
              ),
              Container(
                alignment: Alignment.center,
                margin: const EdgeInsets.symmetric(
                  horizontal: 10,
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

  Widget amarAkhbarAnthonyButtonWidgetProtrait() {
    return Column(
      children: [
        SizedBox(
          height: 10,
        ),
        Container(
          margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 0),
          height: height * 0.06,
          width: width,
          decoration: BoxDecoration(
              image: DecorationImage(
                  image: AssetImage(
                      "assets/AmarAkhbarAnthony/Images/amar-button.png"),
                  fit: BoxFit.fitWidth)),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              InkWell(
                onTap: () {
                  setState(() {
                    akbarAButton = false;
                    akbarBButton = false;
                    amarAButton = false;
                    amarBButton = true;
                    anthonyAButton = false;
                    anthonyBButton = false;
                    evenButton = false;
                    oddButton = false;
                    redButton = false;
                    blackButton = false;
                    under7Button = false;
                    over7Button = false;
                    if (redCoinAnimation == true ||
                        lightGreenCoinAnimation == true ||
                        blueCoinAnimation == true ||
                        greenCoinAnimation == true ||
                        lightBlueCoinAnimation == true ||
                        brownCoinAnimation == true) {
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
                  margin: const EdgeInsets.symmetric(horizontal: 7),
                  height: height * 0.045,
                  width: width * 0.12,
                  decoration: BoxDecoration(
                      color: Color(0xaa72BBEF),
                      borderRadius: BorderRadius.circular(10)),
                  child: Text(
                    amarRate,
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
              ),
              Text(
                "AMAR",
                style:
                    TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
              ),
              InkWell(
                onTap: () {
                  setState(() {
                    akbarAButton = false;
                    akbarBButton = false;
                    amarAButton = false;
                    amarBButton = true;
                    anthonyAButton = false;
                    anthonyBButton = false;
                    evenButton = false;
                    oddButton = false;
                    redButton = false;
                    blackButton = false;
                    under7Button = false;
                    over7Button = false;
                    if (redCoinAnimation == true ||
                        lightGreenCoinAnimation == true ||
                        blueCoinAnimation == true ||
                        greenCoinAnimation == true ||
                        lightBlueCoinAnimation == true ||
                        brownCoinAnimation == true) {
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
                  margin: const EdgeInsets.symmetric(horizontal: 7),
                  height: height * 0.045,
                  width: width * 0.12,
                  decoration: BoxDecoration(
                      color: Color(0xaaFAA9BA),
                      borderRadius: BorderRadius.circular(10)),
                  child: Text(
                    amarLayRate,
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
              )
            ],
          ),
        ),
        SizedBox(
          height: 10,
        ),
        showLiablity == true
            ? Text(
                liablity10.toString(),
                style: TextStyle(
                    color: liablity10 >= 0 ? Colors.green : Colors.red),
              )
            : SizedBox(),
        Container(
          margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 0),
          height: height * 0.06,
          width: width,
          decoration: BoxDecoration(
              image: DecorationImage(
                  image: AssetImage(
                      "assets/AmarAkhbarAnthony/Images/amar-button.png"),
                  fit: BoxFit.fitWidth)),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              InkWell(
                onTap: () {
                  akbarBButton = false;
                  akbarAButton = true;
                  amarAButton = false;
                  amarBButton = false;
                  anthonyAButton = false;
                  anthonyBButton = false;
                  evenButton = false;
                  oddButton = false;
                  redButton = false;
                  blackButton = false;
                  under7Button = false;
                  over7Button = false;
                  if (redCoinAnimation == true ||
                      lightGreenCoinAnimation == true ||
                      blueCoinAnimation == true ||
                      greenCoinAnimation == true ||
                      lightBlueCoinAnimation == true ||
                      brownCoinAnimation == true) {
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
                child: Container(
                  alignment: Alignment.center,
                  margin: const EdgeInsets.symmetric(horizontal: 7),
                  height: height * 0.045,
                  width: width * 0.12,
                  decoration: BoxDecoration(
                      color: Color(0xaa72BBEF),
                      borderRadius: BorderRadius.circular(10)),
                  child: Text(
                    akbarRate,
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
              ),
              Text(
                "AKBAR",
                style:
                    TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
              ),
              InkWell(
                onTap: () {
                  akbarBButton = true;
                  akbarAButton = false;
                  amarAButton = false;
                  amarBButton = false;
                  anthonyAButton = false;
                  anthonyBButton = false;
                  evenButton = false;
                  oddButton = false;
                  redButton = false;
                  blackButton = false;
                  under7Button = false;
                  over7Button = false;
                  if (redCoinAnimation == true ||
                      lightGreenCoinAnimation == true ||
                      blueCoinAnimation == true ||
                      greenCoinAnimation == true ||
                      lightBlueCoinAnimation == true ||
                      brownCoinAnimation == true) {
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
                child: Container(
                  alignment: Alignment.center,
                  margin: const EdgeInsets.symmetric(horizontal: 7),
                  height: height * 0.045,
                  width: width * 0.12,
                  decoration: BoxDecoration(
                      color: Color(0xaaFAA9BA),
                      borderRadius: BorderRadius.circular(10)),
                  child: Text(
                    akbarLayRate,
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
              )
            ],
          ),
        ),
        SizedBox(
          height: 10,
        ),
        showLiablity == true
            ? Text(
                liablity11.toString(),
                style: TextStyle(
                    color: liablity11 >= 0 ? Colors.green : Colors.red),
              )
            : SizedBox(),
        Container(
          margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 0),
          height: height * 0.06,
          width: width,
          decoration: BoxDecoration(
              image: DecorationImage(
                  image: AssetImage(
                      "assets/AmarAkhbarAnthony/Images/amar-button.png"),
                  fit: BoxFit.fitWidth)),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              InkWell(
                onTap: () {
                  akbarAButton = false;
                  akbarBButton = false;

                  amarAButton = false;
                  amarBButton = false;

                  anthonyAButton = true;
                  anthonyBButton = false;
                  evenButton = false;
                  oddButton = false;
                  redButton = false;
                  blackButton = false;
                  under7Button = false;
                  over7Button = false;
                  if (redCoinAnimation == true ||
                      lightGreenCoinAnimation == true ||
                      blueCoinAnimation == true ||
                      greenCoinAnimation == true ||
                      lightBlueCoinAnimation == true ||
                      brownCoinAnimation == true) {
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
                child: Container(
                  alignment: Alignment.center,
                  margin: const EdgeInsets.symmetric(horizontal: 7),
                  height: height * 0.045,
                  width: width * 0.12,
                  decoration: BoxDecoration(
                      color: Color(0xaa72BBEF),
                      borderRadius: BorderRadius.circular(10)),
                  child: Text(
                    anthonyRate,
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
              ),
              Text(
                "ANTHONY",
                style:
                    TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
              ),
              InkWell(
                onTap: () {
                  akbarAButton = false;
                  akbarBButton = false;
                  amarBButton = false;

                  amarAButton = false;
                  anthonyAButton = false;
                  anthonyBButton = true;
                  evenButton = false;
                  oddButton = false;
                  redButton = false;
                  blackButton = false;
                  under7Button = false;
                  over7Button = false;
                  if (redCoinAnimation == true ||
                      lightGreenCoinAnimation == true ||
                      blueCoinAnimation == true ||
                      greenCoinAnimation == true ||
                      lightBlueCoinAnimation == true ||
                      brownCoinAnimation == true) {
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
                child: Container(
                  alignment: Alignment.center,
                  margin: const EdgeInsets.symmetric(horizontal: 7),
                  height: height * 0.045,
                  width: width * 0.12,
                  decoration: BoxDecoration(
                      color: Color(0xaaFAA9BA),
                      borderRadius: BorderRadius.circular(10)),
                  child: Text(
                    anthonyLayRate,
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
              )
            ],
          ),
        ),
        SizedBox(
          height: 10,
        ),
        showLiablity == true
            ? Text(
                liablity12.toString(),
                style: TextStyle(
                    color: liablity12 >= 0 ? Colors.green : Colors.red),
              )
            : SizedBox()
      ],
    );
  }

  Widget oddEvenWidgetPortrait() {
    return Container(
      height: height * 0.30,
      width: width,
      margin: const EdgeInsets.symmetric(horizontal: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            children: [
              InkWell(
                onTap: () {
                  akbarAButton = false;
                  akbarBButton = false;

                  amarAButton = false;
                  amarBButton = false;
                  anthonyAButton = false;
                  anthonyBButton = false;
                  evenButton = true;
                  oddButton = false;
                  redButton = false;
                  blackButton = false;
                  under7Button = false;
                  over7Button = false;
                  if (redCoinAnimation == true ||
                      lightGreenCoinAnimation == true ||
                      blueCoinAnimation == true ||
                      greenCoinAnimation == true ||
                      lightBlueCoinAnimation == true ||
                      brownCoinAnimation == true) {
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
                child: Container(
                  height: height * 0.06,
                  width: width * 0.4,
                  decoration: BoxDecoration(
                      border: Border.all(
                        color: Color(0xaaC28934),
                      ),
                      borderRadius: BorderRadius.circular(5)),
                  child: Container(
                    margin:
                        const EdgeInsetsDirectional.symmetric(horizontal: 5),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "EVEN",
                          style: TextStyle(
                              color: Colors.white, fontWeight: FontWeight.w600),
                        ),
                        Container(
                          alignment: Alignment.center,
                          height: height * 0.05,
                          width: width * 0.15,
                          decoration: BoxDecoration(
                              color: Color(0xaa0288A5),
                              borderRadius: BorderRadius.circular(5)),
                          child: Text(
                            evenRate,
                            style: TextStyle(fontWeight: FontWeight.w600),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              showLiablity == true
                  ? Text(
                      liablity13.toString(),
                      style: TextStyle(
                          color: liablity13 >= 0 ? Colors.green : Colors.red),
                    )
                  : SizedBox(),
              SizedBox(
                height: 10,
              ),
              Column(
                children: [
                  InkWell(
                    onTap: () {
                      akbarAButton = false;
                      akbarBButton = false;
                      amarAButton = false;
                      amarBButton = false;
                      anthonyAButton = false;
                      anthonyBButton = false;
                      evenButton = false;
                      oddButton = false;
                      redButton = true;
                      blackButton = false;
                      under7Button = false;
                      over7Button = false;
                      if (redCoinAnimation == true ||
                          lightGreenCoinAnimation == true ||
                          blueCoinAnimation == true ||
                          greenCoinAnimation == true ||
                          lightBlueCoinAnimation == true ||
                          brownCoinAnimation == true) {
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
                    child: Container(
                      height: height * 0.06,
                      width: width * 0.4,
                      decoration: BoxDecoration(
                          border: Border.all(
                            color: Color(0xaaC28934),
                          ),
                          borderRadius: BorderRadius.circular(5)),
                      child: Container(
                        margin: const EdgeInsetsDirectional.symmetric(
                            horizontal: 5),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Image.asset(
                              "assets/bollywoodTable/red-image.png",
                              scale: 2,
                            ),
                            Container(
                              alignment: Alignment.center,
                              height: height * 0.05,
                              width: width * 0.15,
                              decoration: BoxDecoration(
                                  color: Color(0xaa0288A5),
                                  borderRadius: BorderRadius.circular(5)),
                              child: Text(
                                oddRate,
                                style: TextStyle(fontWeight: FontWeight.w600),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  showLiablity == true
                      ? Text(
                          liablity15.toString(),
                          style: TextStyle(
                              color:
                                  liablity15 >= 0 ? Colors.green : Colors.red),
                        )
                      : SizedBox()
                ],
              ),
              SizedBox(
                height: 10,
              ),
              Column(
                children: [
                  InkWell(
                    onTap: () {
                      akbarAButton = false;
                      akbarBButton = false;
                      amarAButton = false;
                      amarBButton = false;
                      anthonyAButton = false;
                      anthonyBButton = false;
                      evenButton = false;
                      oddButton = false;
                      redButton = false;
                      blackButton = false;
                      under7Button = true;
                      over7Button = false;
                      if (redCoinAnimation == true ||
                          lightGreenCoinAnimation == true ||
                          blueCoinAnimation == true ||
                          greenCoinAnimation == true ||
                          lightBlueCoinAnimation == true ||
                          brownCoinAnimation == true) {
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
                    child: Container(
                      height: height * 0.06,
                      width: width * 0.4,
                      decoration: BoxDecoration(
                          border: Border.all(
                            color: Color(0xaaC28934),
                          ),
                          borderRadius: BorderRadius.circular(5)),
                      child: Container(
                        margin: const EdgeInsetsDirectional.symmetric(
                            horizontal: 5),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "UNDER 7",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w600),
                            ),
                            Container(
                              alignment: Alignment.center,
                              height: height * 0.05,
                              width: width * 0.15,
                              decoration: BoxDecoration(
                                  color: Color(0xaa0288A5),
                                  borderRadius: BorderRadius.circular(5)),
                              child: Text(
                                oddRate,
                                style: TextStyle(fontWeight: FontWeight.w600),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  showLiablity == true
                      ? Text(
                          liablity23.toString(),
                          style: TextStyle(
                              color:
                                  liablity23 >= 0 ? Colors.green : Colors.red),
                        )
                      : SizedBox()
                ],
              ),
            ],
          ),
          Column(
            children: [
              Container(
                height: height * 0.17,
                margin: const EdgeInsets.symmetric(vertical: 15),
                child: VerticalDivider(
                  color: Color(0xaaFFB546),
                  thickness: 1,
                ),
              ),
            ],
          ),
          Column(
            children: [
              InkWell(
                onTap: () {
                  akbarAButton = false;
                  akbarBButton = false;
                  amarAButton = false;
                  amarBButton = false;
                  anthonyAButton = false;
                  anthonyBButton = false;
                  evenButton = false;
                  oddButton = true;
                  redButton = false;
                  blackButton = false;
                  under7Button = false;
                  over7Button = false;
                  if (redCoinAnimation == true ||
                      lightGreenCoinAnimation == true ||
                      blueCoinAnimation == true ||
                      greenCoinAnimation == true ||
                      lightBlueCoinAnimation == true ||
                      brownCoinAnimation == true) {
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
                child: Container(
                  height: height * 0.06,
                  width: width * 0.4,
                  decoration: BoxDecoration(
                      border: Border.all(
                        color: Color(0xaaC28934),
                      ),
                      borderRadius: BorderRadius.circular(5)),
                  child: Container(
                    margin:
                        const EdgeInsetsDirectional.symmetric(horizontal: 5),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "ODD",
                          style: TextStyle(
                              color: Colors.white, fontWeight: FontWeight.w600),
                        ),
                        Container(
                          alignment: Alignment.center,
                          height: height * 0.05,
                          width: width * 0.15,
                          decoration: BoxDecoration(
                              color: Color(0xaa0288A5),
                              borderRadius: BorderRadius.circular(5)),
                          child: Text(
                            oddRate,
                            style: TextStyle(fontWeight: FontWeight.w600),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              showLiablity == true
                  ? Text(
                      liablity14.toString(),
                      style: TextStyle(
                          color: liablity14 >= 0 ? Colors.green : Colors.red),
                    )
                  : SizedBox(),
              SizedBox(
                height: 10,
              ),
              Column(
                children: [
                  InkWell(
                    onTap: () {
                      akbarAButton = false;
                      akbarBButton = false;
                      amarAButton = false;
                      amarBButton = false;
                      anthonyAButton = false;
                      anthonyBButton = false;
                      evenButton = false;
                      oddButton = false;
                      redButton = false;
                      blackButton = true;
                      under7Button = false;
                      over7Button = false;
                      if (redCoinAnimation == true ||
                          lightGreenCoinAnimation == true ||
                          blueCoinAnimation == true ||
                          greenCoinAnimation == true ||
                          lightBlueCoinAnimation == true ||
                          brownCoinAnimation == true) {
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
                    child: Container(
                      height: height * 0.06,
                      width: width * 0.4,
                      decoration: BoxDecoration(
                          border: Border.all(
                            color: Color(0xaaC28934),
                          ),
                          borderRadius: BorderRadius.circular(5)),
                      child: Container(
                        margin: const EdgeInsetsDirectional.symmetric(
                            horizontal: 5),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Image.asset(
                              "assets/bollywoodTable/black-image.png",
                              scale: 2,
                            ),
                            Container(
                              alignment: Alignment.center,
                              height: height * 0.05,
                              width: width * 0.15,
                              decoration: BoxDecoration(
                                  color: Color(0xaa0288A5),
                                  borderRadius: BorderRadius.circular(5)),
                              child: Text(
                                oddRate,
                                style: TextStyle(fontWeight: FontWeight.w600),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  showLiablity == true
                      ? Text(
                          liablity16.toString(),
                          style: TextStyle(
                              color:
                                  liablity16 >= 0 ? Colors.green : Colors.red),
                        )
                      : SizedBox()
                ],
              ),
              SizedBox(
                height: 10,
              ),
              Column(
                children: [
                  InkWell(
                    onTap: () {
                      akbarAButton = false;
                      akbarBButton = false;
                      amarAButton = false;
                      amarBButton = false;
                      anthonyAButton = false;
                      anthonyBButton = false;
                      evenButton = false;
                      oddButton = false;
                      redButton = false;
                      blackButton = false;
                      under7Button = false;
                      over7Button = true;
                      if (redCoinAnimation == true ||
                          lightGreenCoinAnimation == true ||
                          blueCoinAnimation == true ||
                          greenCoinAnimation == true ||
                          lightBlueCoinAnimation == true ||
                          brownCoinAnimation == true) {
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
                    child: Container(
                      height: height * 0.06,
                      width: width * 0.4,
                      decoration: BoxDecoration(
                          border: Border.all(
                            color: Color(0xaaC28934),
                          ),
                          borderRadius: BorderRadius.circular(5)),
                      child: Container(
                        margin: const EdgeInsetsDirectional.symmetric(
                            horizontal: 5),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "OVER 7",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w600),
                            ),
                            Container(
                              alignment: Alignment.center,
                              height: height * 0.05,
                              width: width * 0.15,
                              decoration: BoxDecoration(
                                  color: Color(0xaa0288A5),
                                  borderRadius: BorderRadius.circular(5)),
                              child: Text(
                                oddRate,
                                style: TextStyle(fontWeight: FontWeight.w600),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  showLiablity == true
                      ? Text(
                          liablity1.toString(),
                          style: TextStyle(
                              color:
                                  liablity1 >= 0 ? Colors.green : Colors.red),
                        )
                      : SizedBox()
                ],
              ),
              SizedBox(
                width: 4,
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget dividerLineProtrait() {
    return Column(
      children: [
        Container(
          margin: const EdgeInsets.symmetric(vertical: 5),
          height: height * 0.01,
          width: width * 0.99,
          decoration: BoxDecoration(
              image: DecorationImage(
                  image: AssetImage(
                      "assets/AmarAkhbarAnthony/Images/Line 42 (1).png"),
                  fit: BoxFit.fitWidth)),
        ),
        // Text(
        //   "12.0",
        //   style: TextStyle(color: Colors.white),
        // ),
        // SizedBox(
        //   height: 10,
        // ),
        // SizedBox(
        //   height: height * 0.2,
        //   width: width,
        //   child: GridView.builder(
        //       gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
        //           maxCrossAxisExtent: 50,
        //           childAspectRatio: 3 / 2,
        //           crossAxisSpacing: 10,
        //           mainAxisSpacing: 10),
        //       itemCount: 13,
        //       itemBuilder: (BuildContext ctx, index) {
        //         return InkWell(
        //           onTap: () {
        //             setState(() {
        //               cardIndex = index;
        //               selectCard = true;
        //             });
        //             if (redCoinAnimation == true ||
        //                 lightGreenCoinAnimation == true ||
        //                 blueCoinAnimation == true ||
        //                 greenCoinAnimation == true ||
        //                 lightBlueCoinAnimation == true ||
        //                 brownCoinAnimation == true) {
        //               showMyDialogPortrait(redCoinAnimation == true
        //                   ? stack1
        //                   : lightGreenCoinAnimation == true
        //                       ? stack2
        //                       : blueCoinAnimation == true
        //                           ? stack3
        //                           : greenCoinAnimation == true
        //                               ? stack4
        //                               : lightBlueCoinAnimation == true
        //                                   ? stack5
        //                                   : brownCoinAnimation == true
        //                                       ? stack6
        //                                       : 0);
        //             }
        //           },
        //           child: Container(
        //             height: height * 0.12,
        //             width: width * 0.06,
        //             decoration: BoxDecoration(
        //                 image: DecorationImage(
        //                     image: AssetImage(
        //                         "assets/AmarAkhbarAnthony/Images/card-image.png"))),
        //           ),
        //         );
        //       }),
        // ),
      ],
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

  String amarRate = "";
  String akbarRate = "";
  String anthonyRate = "";
  String evenRate = "";
  String oddRate = "";
  String redRate = "";
  String blackRate = "";
  String cardARate = "";
  String card2Rate = "";
  String card3Rate = "";
  String card4Rate = "";
  String card5Rate = "";
  String card6Rate = "";
  String card7Rate = "";
  String card8Rate = "";
  String card9Rate = "";
  String card10Rate = "";
  String cardJRate = "";
  String cardQRate = "";
  String cardKRate = "";
  String under7Rate = "";
  String over7Rate = "";
  String marketId = "";
  String amarLayRate = "";
  String akbarLayRate = "";
  String anthonyLayRate = "";

  Future getCardData() async {
    var url = Apis.getCardDataAmar;
    var response = await GlobalFunction.apiGetRequestae(url);
    var result = jsonDecode(response);
    if (result['status'] == true) {
      setState(() {
        autoTime = result['data']['t1'][0]['autotime'].toString();
         autoTime = result['data']['t1'][0]['autotime'].toString();
            if (startTimes != int.parse(autoTime.toString())) {
        startTimeSmall = startTimes * 100;
      }
        marketId = result['data']['t1'][0]['mid'].toString();

        cardNameImage1 = result['data']['t1'][0]['C1'].toString();
        startTimes = int.parse(autoTime.toString());
        amarRate = result['data']['t2'][0]['rate'];
        akbarRate = result['data']['t2'][1]['rate'];
        anthonyRate = result['data']['t2'][2]['rate'];
        evenRate = result['data']['t2'][3]['rate'];
        oddRate = result['data']['t2'][4]['rate'];
        redRate = result['data']['t2'][5]['rate'];
        blackRate = result['data']['t2'][6]['rate'];
        cardARate = result['data']['t2'][7]['rate'];
        card2Rate = result['data']['t2'][8]['rate'];
        card3Rate = result['data']['t2'][9]['rate'];
        card4Rate = result['data']['t2'][10]['rate'];
        card5Rate = result['data']['t2'][11]['rate'];
        card6Rate = result['data']['t2'][12]['rate'];
        card7Rate = result['data']['t2'][13]['rate'];
        card8Rate = result['data']['t2'][14]['rate'];
        card9Rate = result['data']['t2'][15]['rate'];
        card10Rate = result['data']['t2'][16]['rate'];
        cardJRate = result['data']['t2'][17]['rate'];
        cardQRate = result['data']['t2'][18]['rate'];
        cardKRate = result['data']['t2'][19]['rate'];
        under7Rate = result['data']['t2'][20]['rate'];
        over7Rate = result['data']['t2'][21]['rate'];
        amarLayRate = result['data']['t2'][0]['layrate'];
        akbarLayRate = result['data']['t2'][1]['layrate'];
        anthonyLayRate = result['data']['t2'][2]['layrate'];
      });
      autoTime == "0"
          ? setState(() {
              showLiablity = false;
              redCoinAnimation = false;
              lightGreenCoinAnimation = false;
              blueCoinAnimation = false;
              greenCoinAnimation = false;
              lightBlueCoinAnimation = false;
              brownCoinAnimation = false;
              amarAButton = false;
              amarBButton = false;
              akbarAButton = false;
              akbarBButton = false;
              anthonyAButton = false;
              anthonyAButton = false;
              evenButton = false;
              oddButton = false;
              redButton = false;
              blackButton = false;
              under7Button = false;
              over7Button = false;
              confirmButton = false;
              liablity1 = 0;
              liablity2 = 0;
              liablity3 = 0;
              liablity4 = 0;
              liablity5 = 0;
              liablity6 = 0;
              liablity7 = 0;
              liablity8 = 0;
              liablity9 = 0;
              liablity10 = 0;
              liablity11 = 0;
              liablity12 = 0;
              liablity13 = 0;
              liablity14 = 0;
              liablity15 = 0;
              liablity16 = 0;
              liablity17 = 0;
              liablity18 = 0;
              liablity19 = 0;
              liablity20 = 0;
              liablity21 = 0;
              liablity22 = 0;
            })
          : SizedBox();
    }
  }

  String mid = "";
  String resultOfBT = "";
  Future getResult() async {
    var url = Apis.getResultAmar;
    var response = await GlobalFunction.apiGetRequestae(url);
    var result = jsonDecode(response);

    var list = result as List;

    setState(() {
      cardResultList.clear();
      var listdata = list.map((e) => WinnerResult.fromJson(e)).toList();
      cardResultList.addAll(listdata);

      winnerResult = result[0]['winner'].toString();
      mid = result[0]['mid'].toString();
      resultOfBT = result[0]['detail'].toString();
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
        stack2 = result['data']['stack2'];
        stack3 = result['data']['stack3'];
        stack4 = result['data']['stack4'];
        stack5 = result['data']['stack5'];
        stack6 = result['data']['stack6'];
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

  String iPAddress = "";

  Future makeBet() async {
    DateTime currentTime = DateTime.now();
    var url = "http://13.250.53.81/VirtualCasinoBetPlacer/vc/place-bet";
    var body = {
      "casinoName": 1,
      "isBack": amarAButton == true ||
              akbarAButton == true ||
              anthonyAButton == true ||
              oddButton == true ||
              evenButton == true ||
              redButton == true ||
              blackButton == true ||
              over7Button == true ||
              under7Button == true ||
              selectCard == true
          ? true
          : false,
      "odds": cardIndex == 0 && selectCard == true
          ? cardARate
          : cardIndex == 1 && selectCard == true
              ? card2Rate
              : cardIndex == 2 && selectCard == true
                  ? card3Rate
                  : cardIndex == 3 && selectCard == true
                      ? card4Rate
                      : cardIndex == 4 && selectCard == true
                          ? card5Rate
                          : cardIndex == 5 && selectCard == true
                              ? card6Rate
                              : cardIndex == 6 && selectCard == true
                                  ? card7Rate
                                  : cardIndex == 7 && selectCard == true
                                      ? card8Rate
                                      : cardIndex == 8 && selectCard == true
                                          ? card9Rate
                                          : cardIndex == 9 && selectCard == true
                                              ? card10Rate
                                              : cardIndex == 10 &&
                                                      selectCard == true
                                                  ? cardJRate
                                                  : cardIndex == 11 &&
                                                          selectCard == true
                                                      ? cardQRate
                                                      : cardIndex == 12 &&
                                                              selectCard == true
                                                          ? cardKRate
                                                          : amarAButton == true
                                                              ? amarRate
                                                              : amarBButton ==
                                                                      true
                                                                  ? amarLayRate
                                                                  : akbarAButton ==
                                                                          true
                                                                      ? akbarRate
                                                                      : akbarBButton ==
                                                                              true
                                                                          ? akbarLayRate
                                                                          : anthonyAButton == true
                                                                              ? anthonyRate
                                                                              : anthonyBButton == true
                                                                                  ? anthonyLayRate
                                                                                  : evenButton == true
                                                                                      ? evenRate
                                                                                      : oddButton == true
                                                                                          ? oddRate
                                                                                          : redButton == true
                                                                                              ? redRate
                                                                                              : blackButton == true
                                                                                                  ? blackRate
                                                                                                  : under7Button == true
                                                                                                      ? under7Rate
                                                                                                      : over7Button == true
                                                                                                          ? over7Rate
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
                                  ? stack6.toString()
                                  : "",
      "selectionId": cardIndex == 1 && selectCard == true
          ? "9"
          : cardIndex == 2 && selectCard == true
              ? "10"
              : cardIndex == 3 && selectCard == true
                  ? "11"
                  : cardIndex == 4 && selectCard == true
                      ? '12'
                      : cardIndex == 5 && selectCard == true
                          ? "13"
                          : cardIndex == 6 && selectCard == true
                              ? "14"
                              : cardIndex == 7 && selectCard == true
                                  ? "15"
                                  : cardIndex == 8 && selectCard == true
                                      ? "16"
                                      : cardIndex == 9 && selectCard == true
                                          ? "17"
                                          : cardIndex == 10 &&
                                                  selectCard == true
                                              ? "18"
                                              : cardIndex == 11 &&
                                                      selectCard == true
                                                  ? "19"
                                                  : cardIndex == 12 &&
                                                          selectCard == true
                                                      ? "20"
                                                      : amarAButton == true ||
                                                              amarBButton ==
                                                                  true
                                                          ? "1"
                                                          : akbarAButton ==
                                                                      true ||
                                                                  akbarBButton ==
                                                                      true
                                                              ? "2"
                                                              : anthonyAButton ==
                                                                          true ||
                                                                      anthonyBButton ==
                                                                          true
                                                                  ? "3"
                                                                  : evenButton ==
                                                                          true
                                                                      ? "4"
                                                                      : oddButton ==
                                                                              true
                                                                          ? "5"
                                                                          : redButton == true
                                                                              ? "6"
                                                                              : blackButton == true
                                                                                  ? "7"
                                                                                  : under7Button == true
                                                                                      ? "21"
                                                                                      : over7Button == true
                                                                                          ? "22"
                                                                                          : cardIndex == 0 && selectCard == true
                                                                                              ? "8"
                                                                                              : "",
      "placeTime": currentTime.toString(),
      "marketId": marketId.toString(),
      "matchId": 20,
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
        akbarAButton = false;
        akbarBButton = false;
        amarAButton = false;
        amarBButton = false;
        anthonyAButton = false;
        anthonyBButton = false;
        evenButton = false;
        oddButton = false;
        redButton = false;
        blackButton = false;
        under7Button = false;
        over7Button = false;
        selectCard = false;
        manualAmount = false;
      });
      getuserBalance();
      getVcLiablity();
       setState(() {
        _currentCoinIndex++;
        _startCoinAnimation();
      });
    } else {
      DialogUtils.showOneBtn(
        context,
        result['message'],
      );
      selectCard = false;
      manualAmount = false;
    }
    manualAmount = false;
    selectCard = false;
  }

  Future makeBetPortrait() async {
    DateTime currentTime = DateTime.now();
    var url = "http://13.250.53.81/VirtualCasinoBetPlacer/vc/place-bet";

    var body = {
      "casinoName": 1,
      "isBack": amarAButton == true ||
              akbarAButton == true ||
              anthonyAButton == true ||
              oddButton == true ||
              evenButton == true ||
              redButton == true ||
              blackButton == true ||
              over7Button == true ||
              under7Button == true ||
              selectCard == true
          ? true
          : false,
      "odds": cardIndex == 0 && selectCard == true
          ? cardARate
          : cardIndex == 1 && selectCard == true
              ? card2Rate
              : cardIndex == 2 && selectCard == true
                  ? card3Rate
                  : cardIndex == 3 && selectCard == true
                      ? card4Rate
                      : cardIndex == 4 && selectCard == true
                          ? card5Rate
                          : cardIndex == 5 && selectCard == true
                              ? card6Rate
                              : cardIndex == 6 && selectCard == true
                                  ? card7Rate
                                  : cardIndex == 7 && selectCard == true
                                      ? card8Rate
                                      : cardIndex == 8 && selectCard == true
                                          ? card9Rate
                                          : cardIndex == 9 && selectCard == true
                                              ? card10Rate
                                              : cardIndex == 10 &&
                                                      selectCard == true
                                                  ? cardJRate
                                                  : cardIndex == 11 &&
                                                          selectCard == true
                                                      ? cardQRate
                                                      : cardIndex == 12 &&
                                                              selectCard == true
                                                          ? cardKRate
                                                          : amarAButton == true
                                                              ? amarRate
                                                              : amarBButton ==
                                                                      true
                                                                  ? amarLayRate
                                                                  : akbarAButton ==
                                                                          true
                                                                      ? akbarRate
                                                                      : akbarBButton ==
                                                                              true
                                                                          ? akbarLayRate
                                                                          : anthonyAButton == true
                                                                              ? anthonyRate
                                                                              : anthonyBButton == true
                                                                                  ? anthonyLayRate
                                                                                  : evenButton == true
                                                                                      ? evenRate
                                                                                      : oddButton == true
                                                                                          ? oddRate
                                                                                          : redButton == true
                                                                                              ? redRate
                                                                                              : blackButton == true
                                                                                                  ? blackRate
                                                                                                  : under7Button == true
                                                                                                      ? under7Rate
                                                                                                      : over7Button == true
                                                                                                          ? over7Rate
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
      "selectionId": cardIndex == 1 && selectCard == true
          ? "9"
          : cardIndex == 2 && selectCard == true
              ? "10"
              : cardIndex == 3 && selectCard == true
                  ? "11"
                  : cardIndex == 4 && selectCard == true
                      ? '12'
                      : cardIndex == 5 && selectCard == true
                          ? "13"
                          : cardIndex == 6 && selectCard == true
                              ? "14"
                              : cardIndex == 7 && selectCard == true
                                  ? "15"
                                  : cardIndex == 8 && selectCard == true
                                      ? "16"
                                      : cardIndex == 9 && selectCard == true
                                          ? "17"
                                          : cardIndex == 10 &&
                                                  selectCard == true
                                              ? "18"
                                              : cardIndex == 11 &&
                                                      selectCard == true
                                                  ? "19"
                                                  : cardIndex == 12 &&
                                                          selectCard == true
                                                      ? "20"
                                                      : amarAButton == true ||
                                                              amarBButton ==
                                                                  true
                                                          ? "1"
                                                          : akbarAButton ==
                                                                      true ||
                                                                  akbarBButton ==
                                                                      true
                                                              ? "2"
                                                              : anthonyAButton ==
                                                                          true ||
                                                                      anthonyBButton ==
                                                                          true
                                                                  ? "3"
                                                                  : evenButton ==
                                                                          true
                                                                      ? "4"
                                                                      : oddButton ==
                                                                              true
                                                                          ? "5"
                                                                          : redButton == true
                                                                              ? "6"
                                                                              : blackButton == true
                                                                                  ? "7"
                                                                                  : under7Button == true
                                                                                      ? "21"
                                                                                      : over7Button == true
                                                                                          ? "22"
                                                                                          : cardIndex == 0 && selectCard == true
                                                                                              ? "8"
                                                                                              : "",
      "placeTime": currentTime.toString(),
      "marketId": marketId.toString(),
      "matchId": 20,
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
        url, body, context, stakeController);

    selectCard = false;
    manualAmount = false;
    var result = jsonDecode(response);
    print("betBody--->$body");
    if (result['status'] == true) {
      print("response--->$result");
      DialogUtils.showOneBtnPortrait(
        context,
        result['message'],
      );
      setState(() {
        akbarAButton = false;
        akbarBButton = false;
        amarAButton = false;
        amarBButton = false;
        anthonyAButton = false;
        anthonyBButton = false;
        evenButton = false;
        oddButton = false;
        redButton = false;
        blackButton = false;
        under7Button = false;
        over7Button = false;
        selectCard = false;
      });
      getuserBalance();
      getVcLiablity();
        setState(() {
        _currentCoinIndexRytPort++;
        _startCoinAnimationRightPort();
      });
    } else {
      DialogUtils.showOneBtnPortrait(
        context,
        result['message'],
      );
      selectCard = false;
    }
    selectCard = false;
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
                                  "assets/User-interface/amar-show-amount.png"),
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
                                      if (amarAButton == true ||
                                          akbarAButton == true ||
                                          anthonyAButton == true ||
                                          oddButton == true ||
                                          evenButton == true ||
                                          redButton == true ||
                                          blackButton == true ||
                                          over7Button == true ||
                                          under7Button == true ||
                                          selectCard == true) {
                                        makeBet();
                                        Navigator.pop(context);

                                        amarAButton = false;
                                        akbarAButton = false;
                                        oddButton = false;
                                        anthonyAButton = false;
                                        evenButton = false;
                                        redButton = false;
                                        blackButton = false;
                                        over7Button = false;
                                        under7Button = false;
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

                                          if (amarAButton == true ||
                                              akbarAButton == true ||
                                              anthonyAButton == true ||
                                              oddButton == true ||
                                              evenButton == true ||
                                              redButton == true ||
                                              blackButton == true ||
                                              over7Button == true ||
                                              under7Button == true ||
                                              selectCard == true) {
                                            makeBet();
                                            Navigator.pop(context);

                                            amarAButton = false;
                                            akbarAButton = false;
                                            oddButton = false;
                                            anthonyAButton = false;
                                            evenButton = false;
                                            redButton = false;
                                            blackButton = false;
                                            over7Button = false;
                                            under7Button = false;
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

                                        if (amarAButton == true ||
                                            akbarAButton == true ||
                                            anthonyAButton == true ||
                                            oddButton == true ||
                                            evenButton == true ||
                                            redButton == true ||
                                            blackButton == true ||
                                            over7Button == true ||
                                            under7Button == true ||
                                            selectCard == true) {
                                          makeBetPortrait();
                                          Navigator.pop(context);

                                          amarAButton = false;
                                          akbarAButton = false;
                                          oddButton = false;
                                          anthonyAButton = false;
                                          evenButton = false;
                                          redButton = false;
                                          blackButton = false;
                                          over7Button = false;
                                          under7Button = false;
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

                                            if (amarAButton == true ||
                                                akbarAButton == true ||
                                                anthonyAButton == true ||
                                                oddButton == true ||
                                                evenButton == true ||
                                                redButton == true ||
                                                blackButton == true ||
                                                over7Button == true ||
                                                under7Button == true ||
                                                selectCard == true) {
                                              makeBetPortrait();
                                              Navigator.pop(context);

                                              amarAButton = false;
                                              akbarAButton = false;
                                              oddButton = false;
                                              anthonyAButton = false;
                                              evenButton = false;
                                              redButton = false;
                                              blackButton = false;
                                              over7Button = false;
                                              under7Button = false;
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

  List<MatchIdModel> matchIdList = [];
  Future getMatchIdDetails() async {
    var url = Apis.matchId;
    var body = {"matchId": "20"};
    var response = await GlobalFunction.apiPostRequestToken(url, body);
    var result = jsonDecode(response);
    if (result['status'] == true) {
      var list = result['data']['VAmar Akbar Anthony'] as List;
      matchIdList.clear();
      var listdata = list.map((e) => MatchIdModel.fromJson(e)).toList();
      matchIdList.addAll(listdata);
    }
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
                                    "assets/User-interface/amarResultBackground.png"),
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
    print("res--->$response");

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
        liablity16 = result['data'][15]['liability'];
        liablity17 = result['data'][16]['liability'];
        liablity18 = result['data'][17]['liability'];
        liablity19 = result['data'][18]['liability'];
        liablity20 = result['data'][19]['liability'];
        liablity21 = result['data'][20]['liability'];
        liablity22 = result['data'][21]['liability'];
        liablity23 = result['data'][22]['liability'];
      });
    }
  }
}
