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
import 'package:virtual_casino/OneVirtualTeenPatti/Modal/matchIdModelOTP.dart';
import 'package:virtual_casino/Utils/toast.dart';
import '../../../Widgets/customText.dart';
import '../User-Interface/change_passswod_screen.dart';
import '../User-Interface/current_bets_screen.dart';
import '../User-Interface/current_user_bet.dart';
import '../User-Interface/my_account.dart';
import '../User-Interface/profile_screen.dart';
import '../User-Interface/signin_screen.dart';
import '../Utils/api_helper.dart';
import '../Utils/apis.dart';
import '../constants/textstyle_constants.dart';
import 'Modal/winner_resuit_otp.dart';
import 'package:http/http.dart' as http;

class OpenVertualTeenPAtti extends StatefulWidget {
  final String matchId;
  final String gameCode;
  const OpenVertualTeenPAtti(
      {super.key, required this.matchId, required this.gameCode});

  @override
  State<OpenVertualTeenPAtti> createState() => _OpenVertualTeenPAttiState();
}

// class _OpenVertualTeenPAtti implements TickerProvider {
//   @override
//   Ticker createTicker(TickerCallback onTick) => Ticker(onTick);
// }

class _OpenVertualTeenPAttiState extends State<OpenVertualTeenPAtti>
    with TickerProviderStateMixin, WidgetsBindingObserver {
  AnimationController? betHistory, playBetController, controller;
  final GlobalKey<ScaffoldState> _globalKey = GlobalKey<ScaffoldState>();

  // AnimationController? playBetController;
  int stack1 = 0;
  int stack2 = 0;
  int stack3 = 0;
  int stack4 = 0;

  int stack6 = 0;
  List<MatchIdModelOPT> matchIdList = [];
  bool confirmButton = false;
  late Animation<double> _animation;
  final _player = AudioPlayer();
  final _cardPlayer = AudioPlayer();
  final stopBettingmusic = AudioPlayer();
  final startBettingmusic = AudioPlayer();
  final winnerBettingmusic = AudioPlayer();
  final onPressedmusic = AudioPlayer();
  bool playBackgroundMusic = false;
  bool redCoinAnimation = false;
  bool lightGreenCoinAnimation = false;

  bool greenCoinAnimation = false;
  bool lightBlueCoinAnimation = false;
  bool brownCoinAnimation = false;
  String autoTime = "";
 
  int startTimes = 0;
  late Timer _clockTimer;
  late AnimationController _controller;
  Animation<double>? animation;
  double height = 0;
  double width = 0;
  String userBalance = "";
  String liablity = "";
  int _currentCoinIndexRytPort = 0;
  final int _totalCoins = 7000;
  double _minXRytPort = 0;
  double _maxXRytPort = 0;
  double _minYRytPort = 0;
  double _maxYRytPort = 0;
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
  final List<Widget> _coins = [];
  final List<Widget> _coinsRytPort = [];
  final Random _random = Random();
  String cardNameImage1 = "";
  String cardNameImageWinner = "";
  List<String> cardNameImage1Array = [];
  List<String> cardNameImage1WinnerArray = [];
  double _minX = 0;
  double _maxX = 0;
  double _minY = 0;
  double _maxY = 0;
  String iPAddress = "";
  String marketId = "";
  String marketIdWinner = "";
  List<String> winnerArray = [];
  String winner = "";
  String player1 = "";
  String player2 = "";
  String player3 = "";
  String player4 = "";
  String player5 = "";
  String player6 = "";
  String player7 = "";
  String player8 = "";
  late AnimationController _controller1;
  String player1Rate = "";
  String player2Rate = "";
  String player3Rate = "";
  String player4Rate = "";
  String player5Rate = "";
  String player6Rate = "";
  String player7Rate = "";
  String player8Rate = "";
  String player1Sid = "";
  String player2Sid = "";
  String player3Sid = "";
  String player4Sid = "";
  String player5Sid = "";
  String player6Sid = "";
  String player7Sid = "";
  String player8Sid = "";

  bool player1Button = false;
  bool player2Button = false;
  bool player3Button = false;
  bool player4Button = false;
  bool player5Button = false;
  bool player6Button = false;
  bool player7Button = false;
  bool player8Button = false;

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

  final List<Widget> _coinsRyt = [];
  final List<Widget> _coinsPort = [];
  int _currentCoinIndex = 0;
  String cardImage = "";

  var stakeController = TextEditingController();
  bool manualAmount = false;

  var gameSound = "assets/lucky7/audio/bgm.mp3";

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
       int startTimeSmall=0;
  ///initState
  @override
  void initState() {
     startTimeSmall=startTimes*100;
       Timer.periodic(const Duration(milliseconds: 10), (timer) {
        startTimeSmall =startTimeSmall-1;
       });
    getStakeDetails();

    getDeviceIp();

   
      checkInternet();
 
    AudioPlayer.clearAssetCache();
    bgMusic();

    WidgetsBinding.instance.addObserver(this);

    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.landscapeLeft,
      DeviceOrientation.landscapeRight,
    ]);

    _clockTimer = Timer.periodic(const Duration(seconds: 1), (timer) {
      stopBettingMusic();
      startBettingMusic();
    });

    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 2000), // Adjust the duration as needed
    );

    getCardData().then((value) => _controller1 = AnimationController(
          vsync: this,
          duration:
              Duration(milliseconds: 1000), // Adjust the duration as needed
        ));
    _animation = CurvedAnimation(parent: _controller, curve: Curves.easeInOut);
    _controller.repeat(reverse: true);
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

 startTimes>3
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

   startTimes>3
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

 startTimes>3
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
                        )
                );
            },
          ))
        :null;
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

    double radius = 100; // Radius of the circular path
    double angle = _currentCoinIndex * (pi / _totalCoins);

    double _startX = _minXRight;
    double _startY = _minYRight;
    double _endX =
        _random.nextDouble() * (_maxXRight - _minXRight) + _minXRight;
    double _endY =
        _random.nextDouble() * (_maxYRight - _minYRight) + _minYRight;

    startTimes>3
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
                          _coinImagesRyt[
                              _currentCoinIndex % _coinImagesRyt.length],
                          height: 15,
                          width: 15,
                        )
           );
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

    double _startX = _minYLeftPort;
    double _startY = _minYLeftPort;
    double _endX =
        _random.nextDouble() * (_maxXLeftPort - _minXLeftPort) + _minXLeftPort;
    double _endY =
        _random.nextDouble() * (_maxYLeftPort - _minYLeftPort) + _minYLeftPort;

    startTimes>3
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
                        )
                   );
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

  startTimes>3
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
                        )
                    );
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

  ///Dispose
  @override
  void dispose() {
    playBetController?.dispose();
    betHistory?.dispose();
    _clockTimer.cancel();
    _controller.dispose();
    _controller1.dispose();

    startBettingmusic.dispose();
    stopBettingmusic.dispose();
    _cardPlayer.dispose();
    _player.dispose();
    WidgetsBinding.instance.removeObserver(this);

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
    autoTime == "59" && playBackgroundMusic == false
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
  Widget build(BuildContext context) {
    getuserBalance();
    getUserDetails();
    getMatchIdDetails();
    getResult().then((value) => getCardData());
    final oreintation = MediaQuery.of(context).orientation;
    print(oreintation);
    height = MediaQuery.of(context).size.height;
    width = MediaQuery.of(context).size.width;
    _minXLeft = 150;
    _maxXLeft = width - 220;
    _minYLeft = 180;
    _maxYLeft = height - 100;
    _minXRight = 150;
    _maxXRight = width - 220;
    _minYRight = 180;
    _maxYRight = height - 100;
    _minXLeftPort = 50;
    _maxXLeftPort = width - 100;
    _minYLeftPort = 50;
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
          return protraitWidget();
        }
      }),
    );
  }

  ///portrait mode
  Widget protraitWidget() {
    return Scaffold(
               backgroundColor: Colors.transparent,
        key: _globalKey,
        drawerEnableOpenDragGesture: false,
        drawer: SizedBox(
          width: width * 0.55,
          child: Drawer(
            child: drawerWidget(),
          ),
        ),
        body: Container(
            height: height * 1.35,
            width: width,
            decoration: BoxDecoration(
                image: DecorationImage(
              image: AssetImage(
                'assets/vertual_teen_patti/background.png',
              ),
              fit: BoxFit.fill,
            )),
            child: SingleChildScrollView(
              child: autoTime == "0" && cardNameImage1 != ""
                  ? Padding(
                      padding: EdgeInsets.only(
                          left: width * 0.05,
                          right: width * 0.05,
                          bottom: height * 0.05,
                          top: height * 0.03),
                      child: currentResultPortrait())
                  : Column(children: [
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
                                          'assets/vertual_teen_patti/amount_bg.png'),
                                      fit: BoxFit.fill)),
                              child: Container(
                                padding: EdgeInsets.symmetric(
                                    horizontal: width * 0.02,
                                    vertical: height * 0.001),
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
                                  'assets/vertual_teen_patti/menu.png',
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
                                        'assets/vertual_teen_patti/sound.png',
                                        fit: BoxFit.fill,
                                        height: height * 0.055),
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
                                        'assets/vertual_teen_patti/music_off.png',
                                        fit: BoxFit.fill,
                                        height: height * 0.055),
                                  ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(
                          horizontal: width * 0.02,
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
                                  gradient: LinearGradient(colors: const [
                                    Color(0xffff22ab79),
                                    Color(0xffff061f16),
                                    Color(0xffff22ab79),
                                  ]),
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
                                    context, _createRouteCurrentBetsList());
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
                                          'assets/vertual_teen_patti/myBet.png',
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
                      Container(
                          height: height * 0.04,
                          width: width,
                          padding: EdgeInsets.only(
                              left: width * 0.01, top: height * 0.002),
                          margin: EdgeInsets.symmetric(
                              horizontal: width * 0.02, vertical: width * 0.03),
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              gradient: LinearGradient(
                                  begin: Alignment.topCenter,
                                  end: Alignment.bottomCenter,
                                  colors: const [
                                    Color(0xffff22ab79),
                                    Color(0xffff061f16),
                                    Color(0xffff000000)
                                  ])),
                          child: ListView.builder(
                              shrinkWrap: true,
                              itemCount: cardResultList.length,
                              scrollDirection: Axis.horizontal,
                              itemBuilder: (context, index) {
                                var item = cardResultList[index];
                                var cardList = item.c1?.split(',');
                                var winnerList = item.winner?.split(',');
                                print("carddd------->${cardList?[0]}");
                                print("carddd2------->${cardList?[1]}");

                                return InkWell(
                                  onTap: () {
                                    setState(() {
                                      playBackgroundMusic == false
                                          ? onPressedMusic()
                                          : Vibration.vibrate();
                                    });
                                    print("=========>show dialog");
                                    pastResultPortrait(
                                        context,
                                        cardList![0],
                                        cardList[1],
                                        cardList[2],
                                        cardList[3],
                                        cardList[4],
                                        cardList[5],
                                        cardList[6],
                                        cardList[7],
                                        cardList[8],
                                        cardList[9],
                                        cardList[10],
                                        cardList[11],
                                        cardList[12],
                                        cardList[13],
                                        cardList[14],
                                        cardList[15],
                                        cardList[16],
                                        cardList[17],
                                        cardList[18],
                                        cardList[19],
                                        cardList[20],
                                        cardList[21],
                                        cardList[22],
                                        cardList[23],
                                        cardList[24],
                                        cardList[25],
                                        cardList[26],
                                        winnerList![0],
                                        winnerList[1],
                                        winnerList[2],
                                        winnerList[3],
                                        winnerList[4],
                                        winnerList[5],
                                        winnerList[6],
                                        winnerList[7]);
                                  },
                                  child:
                                      _bettButtonPort('A', Color(0xffffb41e88)),
                                );
                              })),
                      Padding(
                        padding: EdgeInsets.only(
                            right: width * 0.04, bottom: height * 0.01),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: const [
                            Text(
                              "Min:100 Max: 250000",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 10),
                            ),
                          ],
                        ),
                      ),
                      BlinkText(
                        "Round ID : $marketId",
                        style: TextStyle(
                            color: Colors.white, fontWeight: FontWeight.bold),
                      ),
                      SizedBox(
                        height: height * 0.02,
                      ),
                      Image.asset(
                        'assets/lucky7/images/tableGirl.png',
                        //  height: height * 0.3,
                      ),
                      Stack(children: [
                        Image.asset(
                          'assets/vertual_teen_patti/table.png',
                          width: width,
                        ),
                        Positioned(
                             top: 15,
                      right: 25,
                          child:  Image.asset(
                                  'assets/vertual_teen_patti/user.png',
                                  fit: BoxFit.cover,
                                  height: height * 0.05,
                                ),
                        ),
                        Positioned(
                           top: 15,
                    left: 30,
                          child:  Image.asset(
                                  'assets/vertual_teen_patti/user2.png',
                                  fit: BoxFit.cover,
                                  height: height * 0.05,
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
                        startTimes >= 1
                            ? Positioned(
                                left: width * 0.40,
                                top: height * 0.013,
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
                                top: height * 0.013,
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
                          top: height * 0.036,
                          child: startTimes >= 1
                              ? Column(
                                  children: [
                                    SizedBox(
                                      height: 5,
                                      width: width * 0.25,
                                      child: LinearProgressIndicator(
                                  value:
                                     startTimeSmall/6000, // Calculate the progress
                                  backgroundColor: Colors.grey,
                                  valueColor:
                                      AlwaysStoppedAnimation(Color(0xaa9919D2)),
                                  
                                ),
                                    ),
                                  ],
                                )
                              : SizedBox(),
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
                           startTimes <= 3 && autoTime != '0'
                            ? gameStopBettingPortrait(autoTime)
                            : SizedBox(),
                        autoTime == "60"
                            ? placeyourbetWidgetPortrait(autoTime)
                            : autoTime == "3" ||
                                    autoTime == "2" ||
                                    autoTime == "1"
                                ? goWidgetPort()
                                : SizedBox(),
                     
                      ]),
                      Transform.translate(
                        offset: Offset(0, -24),
                        child: Container(
                          height: 65,
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                            image: DecorationImage(
                                fit: BoxFit.cover,
                                image: AssetImage(
                                    'assets/vertual_teen_patti/bottem.png')),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
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
                                  height: redCoinAnimation == true
                                      ? height * 0.075
                                      : height * 0.05,
                                  width: redCoinAnimation == true
                                      ? width * 0.16
                                      : width * 0.10,
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
                                    playBackgroundMusic == false
                                        ? ''
                                        : Vibration.vibrate();
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
                                  height: lightGreenCoinAnimation == true
                                      ? height * 0.08
                                      : height * 0.05,
                                  width: lightGreenCoinAnimation == true
                                      ? width * 0.16
                                      : width * 0.10,
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
                                      ? height * 0.08
                                      : height * 0.05,
                                  width: lightBlueCoinAnimation == true
                                      ? width * 0.16
                                      : width * 0.10,
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

                                    greenCoinAnimation = !greenCoinAnimation;
                                    lightBlueCoinAnimation = false;
                                    brownCoinAnimation = false;
                                  });
                                },
                                child: AnimatedContainer(
                                  duration: Duration(milliseconds: 700),
                                  alignment: Alignment.center,
                                  height: greenCoinAnimation == true
                                      ? height * 0.08
                                      : height * 0.05,
                                  width: greenCoinAnimation == true
                                      ? width * 0.16
                                      : width * 0.10,
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
                                width: width * 0.055,
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
                                  height: brownCoinAnimation == true
                                      ? height * 0.12
                                      : height * 0.06,
                                  width: brownCoinAnimation == true
                                      ? width * 0.17
                                      : width * 0.12,
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
                      ),
                      Container(
                        padding: EdgeInsets.symmetric(vertical: 16),
                        color: Color(0xffff111e19),
                        child: Column(children: [
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
                                player1Button = !player1Button;
                              }
                              if (player1Button == true) {
                                player2Button = false;
                                player3Button = false;
                                player4Button = false;
                                player5Button = false;
                                player6Button = false;
                                player7Button = false;
                                player8Button = false;
                                betSucessfulllyPlacedPort(
                                    context,
                                    height * 0.24,
                                    width * 0.8,
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
                            },
                            child: _betButtons(
                                'PLAYER 1', 358, player1Rate, player1Rate),
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
                                player1Button = !player1Button;
                              }
                              if (player1Button == true) {
                                player2Button = false;
                                player3Button = false;
                                player4Button = false;
                                player5Button = false;
                                player6Button = false;
                                player7Button = false;
                                player8Button = false;
                                betSucessfulllyPlacedPort(
                                    context,
                                    height * 0.24,
                                    width * 0.8,
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
                            },
                            child: _betButtons(
                                'PLAYER 2', 358, player2Rate, player2Rate),
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
                                player1Button = !player1Button;
                              }
                              if (player1Button == true) {
                                player2Button = false;
                                player3Button = false;
                                player4Button = false;
                                player5Button = false;
                                player6Button = false;
                                player7Button = false;
                                player8Button = false;
                                betSucessfulllyPlacedPort(
                                    context,
                                    height * 0.24,
                                    width * 0.8,
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
                            },
                            child: _betButtons(
                                'PLAYER 3', 358, player3Rate, player3Rate),
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
                                player1Button = !player1Button;
                              }
                              if (player1Button == true) {
                                player2Button = false;
                                player3Button = false;
                                player4Button = false;
                                player5Button = false;
                                player6Button = false;
                                player7Button = false;
                                player8Button = false;
                                betSucessfulllyPlacedPort(
                                    context,
                                    height * 0.24,
                                    width * 0.8,
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
                            },
                            child: _betButtons(
                                'PLAYER 4', 358, player4Rate, player4Rate),
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
                                player1Button = !player1Button;
                              }
                              if (player1Button == true) {
                                player2Button = false;
                                player3Button = false;
                                player4Button = false;
                                player5Button = false;
                                player6Button = false;
                                player7Button = false;
                                player8Button = false;
                                betSucessfulllyPlacedPort(
                                    context,
                                    height * 0.24,
                                    width * 0.8,
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
                            },
                            child: _betButtons(
                                'PLAYER 5', 358, player5Rate, player5Rate),
                          ),
                          SizedBox(
                            height: height * 0.005,
                          ),
                          Text(
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
                                player1Button = !player1Button;
                              }
                              if (player1Button == true) {
                                player2Button = false;
                                player3Button = false;
                                player4Button = false;
                                player5Button = false;
                                player6Button = false;
                                player7Button = false;
                                player8Button = false;
                                betSucessfulllyPlacedPort(
                                    context,
                                    height * 0.24,
                                    width * 0.8,
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
                            },
                            child: _betButtons(
                                'PLAYER 6', 358, player6Rate, player6Rate),
                          ),
                          SizedBox(
                            height: height * 0.005,
                          ),
                          Text(
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
                                player1Button = !player1Button;
                              }
                              if (player1Button == true) {
                                player2Button = false;
                                player3Button = false;
                                player4Button = false;
                                player5Button = false;
                                player6Button = false;
                                player7Button = false;
                                player8Button = false;
                                betSucessfulllyPlacedPort(
                                    context,
                                    height * 0.24,
                                    width * 0.8,
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
                            },
                            child: _betButtons(
                                'PLAYER 7', 358, player7Rate, player7Rate),
                          ),
                          SizedBox(
                            height: height * 0.005,
                          ),
                          Text(
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
                                player1Button = !player1Button;
                              }
                              if (player1Button == true) {
                                player2Button = false;
                                player3Button = false;
                                player4Button = false;
                                player5Button = false;
                                player6Button = false;
                                player7Button = false;
                                player8Button = false;
                                betSucessfulllyPlacedPort(
                                    context,
                                    height * 0.24,
                                    width * 0.8,
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
                            },
                            child: _betButtons(
                                'PLAYER 8', 358, player8Rate, player8Rate),
                          ),
                          SizedBox(
                            height: height * 0.005,
                          ),
                          Text(
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
                          SizedBox(height: 10)
                        ]),
                      ),
                    ]),
            )));
  }

  ///lanscape mode
  Widget landscapeWidget() {
    return Scaffold(
        backgroundColor: Colors.transparent,
        key: _globalKey,
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
                height: height * 1,
                width: width,
                decoration: BoxDecoration(
                   

                    image: DecorationImage(
                        image: AssetImage(
                          "assets/vertual_teen_patti/bg_landscape.png",
                        ),
                        fit: BoxFit.fill,
                  )),
                child: autoTime == '0' && cardNameImage1 != ""
                    ? Padding(
                        padding: EdgeInsets.symmetric(
                          horizontal: width * 0.099,
                          vertical: height * 0.05,
                        ),
                        child: currentResultLand())
                    : Stack(
                        alignment: Alignment.center,
                        children: [
                          Positioned(
                            top: height * 0.03,
                            left: width * 0.02,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
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
                                          'assets/vertual_teen_patti/menu.png',
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
                                                  'assets/vertual_teen_patti/amount_bg.png'),
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
                                                  color: Color.fromARGB(
                                                      255, 248, 244, 204),
                                                  fontSize: height * 0.03,
                                                  fontWeight: FontWeight.bold),
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
                                        context, _createRouteCurrentBetsList());
                                  },
                                  child: Container(
                                    padding: EdgeInsets.only(
                                        left: width * 0.103,
                                        top: height * 0.027),
                                    height: height * 0.10,
                                    width: width * 0.15,
                                    decoration: BoxDecoration(
                                        image: DecorationImage(
                                            image: AssetImage(
                                              'assets/vertual_teen_patti/myBet.png',
                                            ),
                                            fit: BoxFit.fill)),
                                    child: CustomText(
                                      text: matchIdList.length.toString(),
                                      fontWeight: FontWeight.w500,
                                      color: Color.fromARGB(255, 248, 244, 204),
                                      fontSize: height * 0.03,
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
                                  top: height * 0.05,
                                  child: Image.asset(
                                    'assets/lucky7/images/tableGirl.png',
                                    fit: BoxFit.cover,
                                    height: height * 0.28,
                                  ),
                                )
                              ,
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
                                                child: LinearProgressIndicator(
                                  value:
                                     startTimeSmall/6000, // Calculate the progress
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
                                                'assets/vertual_teen_patti/sound.png',
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
                                              _player.play();
                                              setState(() {
                                                playBackgroundMusic = false;
                                              });
                                            },
                                            child: Image.asset(
                                                'assets/vertual_teen_patti/music_off.png',
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
                                  'assets/vertual_teen_patti/table1.png',
                                  fit: BoxFit.fill,
                                  height: height * 0.67,
                                ),
                              ],
                            ),
                          ),
                          Positioned(
                            top: height * 0.4,
                            left: width * 0.17,
                            child: Image.asset(
                                    'assets/vertual_teen_patti/user.png',
                                    fit: BoxFit.cover,
                                    height: height * 0.10,
                                  ),
                          ),
                          Positioned(
                            top: height * 0.4,
                            right: width * 0.17,
                            child:  Image.asset(
                                    'assets/vertual_teen_patti/user.png',
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
                          AnimatedSwitcher(
                            duration: Duration(milliseconds: 500),
                            child: Stack(
                              children: _coins,
                            ),
                          ),
                            startTimes <= 3 && autoTime != '0'
                              ? gameStopBetting(autoTime)
                              : SizedBox(),
                          autoTime == "60"
                              ? placeyourbetWidget(autoTime)
                              : autoTime == "3" ||
                                      autoTime == "2" ||
                                      autoTime == "1"
                                  ? goWidget()
                                  : SizedBox(),
                        
                          Positioned(
                            bottom: height * 0.01,
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
                                    height: redCoinAnimation == true
                                        ? height * 0.19
                                        : height * 0.13,
                                    width: redCoinAnimation == true
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
                                    height: lightGreenCoinAnimation == true
                                        ? height * 0.19
                                        : height * 0.13,
                                    width: lightGreenCoinAnimation == true
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
                                    height: lightBlueCoinAnimation == true
                                        ? height * 0.19
                                        : height * 0.13,
                                    width: lightBlueCoinAnimation == true
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
                                    height: greenCoinAnimation == true
                                        ? height * 0.19
                                        : height * 0.13,
                                    width: greenCoinAnimation == true
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
                                          fontWeight: FontWeight.bold,
                                          fontSize: 10),
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  width: width * 0.03,
                                ),
                                // InkWell(
                                //   onTap: () {
                                //     setState(() {
                                //       redCoinAnimation = false;
                                //       lightGreenCoinAnimation = false;
                                //       blueCoinAnimation = false;
                                //       greenCoinAnimation = false;
                                //       lightBlueCoinAnimation =
                                //           !lightBlueCoinAnimation;
                                //       brownCoinAnimation = false;
                                //     });
                                //   },
                                //   child: AnimatedContainer(
                                //     duration: Duration(milliseconds: 700),
                                //     alignment: Alignment.center,
                                //     height: lightBlueCoinAnimation == true
                                //         ? height * 0.19
                                //         : height * 0.13,

                                //     width: lightBlueCoinAnimation == true
                                //       ? width * 0.09
                                //         : width * 0.06,

                                //     decoration: BoxDecoration(
                                //         image: DecorationImage(
                                //       image: AssetImage(

                                //     "assets/lucky7/images/coins/blue.png"),
                                //       fit: BoxFit.fill,
                                //     )),
                                //     child: Text(
                                //       stack4 != 0 ? "10K" : stack5.toString(),
                                //       style: TextStyle(
                                //           fontWeight: FontWeight.bold,
                                //           fontSize: 10),
                                //     ),
                                //   ),
                                // ),
                                // SizedBox(
                                //   width: width * 0.02,
                                // ),

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
                                    height: brownCoinAnimation == true
                                        ? height * 0.19
                                        : height * 0.15,
                                    width: brownCoinAnimation == true
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
                            bottom: height * 0.1,
                            left: width * 0.06,
                            child: Container(
                              padding: EdgeInsets.only(
                                  left: width * 0.02, right: width * 0.02),
                              alignment: Alignment.center,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(2),
                                gradient: LinearGradient(colors: const [
                                  Color(0xffff22ab79),
                                  Color(0xffff061f16),
                                  Color(0xffff22ab79),
                                ]),
                              ),
                              height: height * 0.07,
                              //    width: width * 0.1,
                              child: CustomText(
                                  text: 'EXP $liablity',
                                  color: Color(0xffFFEFC1),
                                  fontSize: height * 0.025,
                                  fontWeight: FontWeight.w500),
                            ),
                          ),
                          Positioned(
                            top: 60,
                            right: 25,
                            child: Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(100),
                                  gradient: LinearGradient(
                                      end: Alignment.topCenter,
                                      begin: Alignment.bottomCenter,
                                      colors: const [
                                        Color(0xffff22ab79),
                                        Color(0xffff061f16),
                                        Color(0xffff000000)
                                      ]),
                                ),
                                child: SizedBox(
                                  height: height * 0.7,
                                  width: width * 0.04,
                                  child: ListView.builder(
                                      shrinkWrap: true,
                                      itemCount: cardResultList.length,
                                      scrollDirection: Axis.vertical,
                                      itemBuilder: (context, index) {
                                        var item = cardResultList[index];
                                        var cardList = item.c1?.split(',');
                                        var winnerList =
                                            item.winner?.split(',');

                                        return InkWell(
                                          onTap: () {
                                            playBackgroundMusic == false
                                                ? onPressedMusic()
                                                : Vibration.vibrate();
                                            print("=========>show dialog");
                                          pastResultPortrait(
                                                context,
                                                cardList![0],
                                                cardList[1],
                                                cardList[2],
                                                cardList[3],
                                                cardList[4],
                                                cardList[5],
                                                cardList[6],
                                                cardList[7],
                                                cardList[8],
                                                cardList[9],
                                                cardList[10],
                                                cardList[11],
                                                cardList[12],
                                                cardList[13],
                                                cardList[14],
                                                cardList[15],
                                                cardList[16],
                                                cardList[17],
                                                cardList[18],
                                                cardList[19],
                                                cardList[20],
                                                cardList[21],
                                                cardList[22],
                                                cardList[23],
                                                cardList[24],
                                                cardList[25],
                                                cardList[26],
                                                winnerList![0],
                                                winnerList[1],
                                                winnerList[2],
                                                winnerList[3],
                                                winnerList[4],
                                                winnerList[5],
                                                winnerList[6],
                                                winnerList[7]);
                                          },
                                          child: _bettButton(
                                              'A', Color(0xffffb41e88)),
                                        );
                                      }),
                                )),
                          ),
                        
                        ],
                      ),
              ),
              Container(
                alignment: Alignment.center,
                decoration: BoxDecoration(
                    image: DecorationImage(
                        image: AssetImage(
                            "assets/vertual_teen_patti/bg_landscape.png"),
                        fit: BoxFit.cover)),
                height: height * 0.99,
                width: width,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 40),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
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
                                    player1Button = !player1Button;
                                  }
                                  if (player1Button == true) {
                                    player2Button = false;
                                    player3Button = false;
                                    player4Button = false;
                                    player5Button = false;
                                    player6Button = false;
                                    player7Button = false;
                                    player8Button = false;
                                    betSucessfulllyPlaced(
                                        context,
                                        height * 0.5,
                                        width * 0.35,
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
                                                        : brownCoinAnimation ==
                                                                true
                                                            ? stack6
                                                            : 0);
                                  }
                                },
                                child: _betButtons(
                                    'PLAYER 1', 298, player1Rate, player1Rate),
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
                                    player2Button = !player2Button;
                                  }
                                  if (player2Button == true) {
                                    player1Button = false;
                                    player3Button = false;
                                    player4Button = false;
                                    player5Button = false;
                                    player6Button = false;
                                    player7Button = false;
                                    player8Button = false;
                                    betSucessfulllyPlaced(
                                        context,
                                        height * 0.5,
                                        width * 0.4,
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
                                                        : brownCoinAnimation ==
                                                                true
                                                            ? stack6
                                                            : 0);
                                  }
                                },
                                child: _betButtons(
                                    'PLAYER 2', 298, player2Rate, player2Rate),
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
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
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
                                    player3Button = !player3Button;
                                  }
                                  if (player3Button == true) {
                                    player2Button = false;
                                    player1Button = false;
                                    player4Button = false;
                                    player5Button = false;
                                    player6Button = false;
                                    player7Button = false;
                                    player8Button = false;
                                    betSucessfulllyPlaced(
                                        context,
                                        height * 0.5,
                                        width * 0.4,
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
                                                        : brownCoinAnimation ==
                                                                true
                                                            ? stack6
                                                            : 0);
                                  }
                                },
                                child: _betButtons(
                                    'PLAYER 3', 298, player3Rate, player3Rate),
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
                                    player4Button = !player4Button;
                                  }
                                  if (player4Button == true) {
                                    player2Button = false;
                                    player3Button = false;
                                    player1Button = false;
                                    player5Button = false;
                                    player6Button = false;
                                    player7Button = false;
                                    player8Button = false;
                                    betSucessfulllyPlaced(
                                        context,
                                        height * 0.5,
                                        width * 0.4,
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
                                                        : brownCoinAnimation ==
                                                                true
                                                            ? stack6
                                                            : 0);
                                  }
                                },
                                child: _betButtons(
                                    'PLAYER 4', 298, player4Rate, player4Rate),
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
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
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
                                    player5Button = !player5Button;
                                  }
                                  if (player5Button == true) {
                                    player2Button = false;
                                    player3Button = false;
                                    player4Button = false;
                                    player1Button = false;
                                    player6Button = false;
                                    player7Button = false;
                                    player8Button = false;
                                    betSucessfulllyPlaced(
                                        context,
                                        height * 0.5,
                                        width * 0.4,
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
                                                        : brownCoinAnimation ==
                                                                true
                                                            ? stack6
                                                            : 0);
                                  }
                                },
                                child: _betButtons(
                                    'PLAYER 5', 298, player5Rate, player5Rate),
                              ),
                              SizedBox(
                                height: height * 0.005,
                              ),
                              Text(
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
                                        ? onPressedMusic()
                                        : Vibration.vibrate();
                                  });

                                  if ((redCoinAnimation == true ||
                                          lightBlueCoinAnimation == true ||
                                          lightGreenCoinAnimation == true ||
                                          brownCoinAnimation == true ||
                                          greenCoinAnimation == true) &&
                                      startTimes > 1) {
                                    player6Button = !player6Button;
                                  }
                                  if (player6Button == true) {
                                    player2Button = false;
                                    player3Button = false;
                                    player4Button = false;
                                    player5Button = false;
                                    player1Button = false;
                                    player7Button = false;
                                    player8Button = false;
                                    betSucessfulllyPlaced(
                                        context,
                                        height * 0.5,
                                        width * 0.4,
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
                                                        : brownCoinAnimation ==
                                                                true
                                                            ? stack6
                                                            : 0);
                                  }
                                },
                                child: _betButtons(
                                    'PLAYER 6', 298, player6Rate, player6Rate),
                              ),
                              SizedBox(
                                height: height * 0.005,
                              ),
                              Text(
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
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
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
                                    player7Button = !player7Button;
                                  }
                                  if (player7Button == true) {
                                    player2Button = false;
                                    player3Button = false;
                                    player4Button = false;
                                    player5Button = false;
                                    player6Button = false;
                                    player1Button = false;
                                    player8Button = false;
                                    betSucessfulllyPlaced(
                                        context,
                                        height * 0.5,
                                        width * 0.4,
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
                                                        : brownCoinAnimation ==
                                                                true
                                                            ? stack6
                                                            : 0);
                                  }
                                },
                                child: _betButtons(
                                    'PLAYER 7', 298, player7Rate, player7Rate),
                              ),
                              SizedBox(
                                height: height * 0.005,
                              ),
                              Text(
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
                                        ? onPressedMusic()
                                        : Vibration.vibrate();
                                  });
                                  if ((redCoinAnimation == true ||
                                          lightBlueCoinAnimation == true ||
                                          lightGreenCoinAnimation == true ||
                                          brownCoinAnimation == true ||
                                          greenCoinAnimation == true) &&
                                      startTimes > 1) {
                                    player8Button = !player8Button;
                                  }
                                  if (player8Button == true) {
                                    player2Button = false;
                                    player3Button = false;
                                    player4Button = false;
                                    player5Button = false;
                                    player6Button = false;
                                    player7Button = false;
                                    player1Button = false;
                                    betSucessfulllyPlaced(
                                        context,
                                        height * 0.5,
                                        width * 0.4,
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
                                                        : brownCoinAnimation ==
                                                                true
                                                            ? stack6
                                                            : 0);
                                  }
                                },
                                child: _betButtons(
                                    'PLAYER 8', 298, player8Rate, player8Rate),
                              ),
                              SizedBox(
                                height: height * 0.005,
                              ),
                              Text(
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
                  ),
                ),
              )
            ],
          ),
        ));
  }

  ///design bet button
  _betButtons(String user, double height, String rate1, String rate2) {
    return Container(
      height: 47,
      width: height,
      margin: EdgeInsets.all(10),
      padding: EdgeInsets.all(2),
      decoration: BoxDecoration(
          image: DecorationImage(
              fit: BoxFit.fill,
              image: AssetImage('assets/vertual_teen_patti/betTab.png'))),
      child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
        Container(
          margin: EdgeInsets.all(5),
          height: 39,
          alignment: Alignment.center,
          width: 38,
          decoration: BoxDecoration(
              color: Color(0xffff6bcffe),
              border: Border.all(color: Color(0xffff6bcffe)),
              borderRadius: BorderRadius.circular(10)),
          child: Text(
            rate1,
            style: TextStyle(
                fontSize: 14, fontWeight: FontWeight.w600, color: Colors.white),
          ),
        ),
        SizedBox(
          width: 30,
        ),
        Text(
          user,
          style: text14w700,
        ),
        Image.asset('assets/vertual_teen_patti/iconCard.png'),
        SizedBox(
          width: 30,
        ),
        Container(
          margin: EdgeInsets.all(5),
          height: 39,
          alignment: Alignment.center,
          width: 38,
          decoration: BoxDecoration(
              color: Color(0xffff6bcffe),
              border: Border.all(color: Color(0xffff6bcffe)),
              borderRadius: BorderRadius.circular(10)),
          child: Text(
            rate2,
            style: TextStyle(
                fontSize: 14, fontWeight: FontWeight.w600, color: Colors.white),
          ),
        )
      ]),
    );
  }

  ///bet successful pop up in portrait mode
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
            content: SizedBox(
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
                          Color(0xff01452B),
                          Color(0xff002114),
                        ],
                      ),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        //  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Amount",
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold),
                          ),
                          SizedBox(
                            height: height * 0.05,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Container(
                                margin:
                                    const EdgeInsets.symmetric(horizontal: 5),
                                // alignment: Alignment.center,
                                child: Image.asset(
                                  "assets/User-interface/minus-image.png",
                                  scale: 3,
                                ),
                              ),
                              SizedBox(
                                   height: height * 0.125,
                                width: width * 0.5,
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
                                        borderRadius: BorderRadius.circular(1),
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
                                margin:
                                    const EdgeInsets.symmetric(horizontal: 5),
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
                                fontSize: 9,
                                fontWeight: FontWeight.bold),
                          ),
                          SizedBox(
                            height: height * 0.04,
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

                                    if (player1Button == true ||
                                        player2Button == true ||
                                        player3Button == true ||
                                        player4Button == true ||
                                        player5Button == true ||
                                        player6Button == true ||
                                        player7Button == true ||
                                        player8Button == true) {
                                      makeBetPortrait();
                                      Navigator.pop(context);

                                      player1Button = false;
                                      player2Button = false;
                                      player3Button = false;
                                      player4Button = false;
                                      player5Button = false;
                                      player6Button = false;
                                      player7Button = false;
                                      player8Button = false;
                                      setState(() {
                                        confirmButton = true;
                                      });
                                    }
                                  },
                                  child: Container(
                                      margin: const EdgeInsets.symmetric(
                                          vertical: 2),
                                      width: width * 0.6,
                                      height: height * 0.10,
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

                                        if (player1Button == true ||
                                            player2Button == true ||
                                            player3Button == true ||
                                            player4Button == true ||
                                            player5Button == true ||
                                            player6Button == true ||
                                            player7Button == true ||
                                            player8Button == true) {
                                          makeBetPortrait();
                                          Navigator.pop(context);

                                          player1Button = false;
                                          player2Button = false;
                                          player3Button = false;
                                          player4Button = false;
                                          player5Button = false;
                                          player6Button = false;
                                          player7Button = false;
                                          player8Button = false;
                                          setState(() {
                                            confirmButton = true;
                                          });
                                        }
                                      },
                                      child: Container(
                                          margin: const EdgeInsets.symmetric(
                                              vertical: 2),
                                          width: width * 0.6,
                                          height: height * 0.10,
                                          decoration: BoxDecoration(
                                              image: DecorationImage(
                                                  image: AssetImage(
                                                      "assets/lucky7/images/button/comfirm.png")))),
                                    )
                                  : InkWell(
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
                                          margin: const EdgeInsets.symmetric(
                                              vertical: 2),
                                          width: width * 0.6,
                                          height: height * 0.10,
                                          decoration: BoxDecoration(
                                              image: DecorationImage(
                                                  image: AssetImage(
                                                      "assets/lucky7/images/button/comfirm.png")))),
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
          );
        });
  }

  ///bet successful pop up in landscape mode
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
                      // padding:
                      //     EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                      height: heightImage,
                      width: widthImage,
                      // width: width * 0.4,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        gradient: LinearGradient(
                          colors: const <Color>[
                            Color(0xff01452B),
                            Color(0xff002114),
                          ],
                        ),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: Column(
                          children: [
                            Text(
                              "Amount",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold),
                            ),
                            SizedBox(
                              height: height * 0.08,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Container(
                                  margin:
                                      const EdgeInsets.symmetric(horizontal: 10),
                                  // alignment: Alignment.center,
                                  child: Image.asset(
                                    "assets/User-interface/minus-image.png",
                                    scale: 3,
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsets.only(top: height * 0.0),
                                  child: SizedBox(
                                                height: height * 0.26,
                                    width: width * 0.25,
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
                                ),
                                Container(
                                  margin:
                                      const EdgeInsets.symmetric(horizontal: 10),
                                  // alignment: Alignment.center,
                                  child: Image.asset(
                                    "assets/User-interface/plus-image.png",
                                    scale: 3,
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: height * 0.07,
                            ),
                            Text(
                              "Are you sure you want to continue?",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 10,
                                  fontWeight: FontWeight.bold),
                            ),
                            //    SizedBox(
                            //   height: height * 0.03,
                            // ),
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
            
                                      if (player1Button == true ||
                                          player2Button == true ||
                                          player3Button == true ||
                                          player4Button == true ||
                                          player5Button == true ||
                                          player6Button == true ||
                                          player7Button == true ||
                                          player8Button == true) {
                                        makeBet();
                                        Navigator.pop(context);
            
                                        player1Button = false;
                                        player2Button = false;
                                        player3Button = false;
                                        player4Button = false;
                                        player5Button = false;
                                        player6Button = false;
                                        player7Button = false;
                                        player8Button = false;
                                        setState(() {
                                          confirmButton = true;
                                        });
                                      }
                                    },
                                    child: Container(
                                        // margin: const EdgeInsets.symmetric(
                                        //     vertical: 10),
                                        height: 60,
                                        width: width * 0.25,
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
            
                                          if (player1Button == true ||
                                              player2Button == true ||
                                              player3Button == true ||
                                              player4Button == true ||
                                              player5Button == true ||
                                              player6Button == true ||
                                              player7Button == true ||
                                              player8Button == true) {
                                            makeBet();
                                            Navigator.pop(context);
            
                                            player1Button = false;
                                            player2Button = false;
                                            player3Button = false;
                                            player4Button = false;
                                            player5Button = false;
                                            player6Button = false;
                                            player7Button = false;
                                            player8Button = false;
                                            setState(() {
                                              confirmButton = true;
                                            });
                                          }
                                        },
                                        child: Container(
                                            // margin: const EdgeInsets.symmetric(
                                            //     vertical: 10),
                                            height: 60,
                                            width: width * 0.25,
                                            decoration: BoxDecoration(
                                                image: DecorationImage(
                                                    image: AssetImage(
                                                        "assets/lucky7/images/button/comfirm.png")))),
                                      )
                                    : InkWell(
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
                                            // margin: const EdgeInsets.symmetric(
                                            //     vertical: 10),
                                            height: 60,
                                            width: width * 0.25,
                                            decoration: BoxDecoration(
                                                image: DecorationImage(
                                                    image: AssetImage(
                                                        "assets/lucky7/images/button/comfirm.png")))),
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

  ///design bet history
  showAlertDialog(BuildContext context, hBg, wBg) {
    return showDialog(
        context: context,
        builder: (_) {
          return AlertDialog(
            backgroundColor: Colors.transparent,
            alignment: Alignment.center,
            content: Stack(alignment: Alignment.center, children: [
              Container(
                padding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                height: height * 0.7,
                width: width * 0.78,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  gradient: LinearGradient(
                    colors: const <Color>[
                      Color.fromARGB(255, 11, 105, 74),
                      Color.fromARGB(255, 14, 44, 26)
                    ],
                  ),
                ),
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 5),
                      child: CustomText(
                        text: "MY BET",
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                        fontSize: 16.0,
                        textAlign: TextAlign.center,
                      ),
                    ),
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(4),
                        border: Border.all(
                          color: Color.fromARGB(255, 48, 170, 96),
                          width: 1,
                        ),
                      ),
                      child: Column(
                        children: [
                          Container(
                            padding: EdgeInsets.symmetric(
                                vertical: 5, horizontal: 10),
                            color: Color.fromARGB(255, 14, 44, 26),
                            child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: const [
                                  CustomText(
                                    text: "PLAYER NAME",
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                    fontSize: 12.0,
                                    textAlign: TextAlign.center,
                                  ),
                                  CustomText(
                                    text: "ODD",
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                    fontSize: 12.0,
                                    textAlign: TextAlign.center,
                                  ),
                                  CustomText(
                                    text: "AMOUNT",
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                    fontSize: 12.0,
                                    textAlign: TextAlign.center,
                                  ),
                                ]),
                          ),
                          SizedBox(
                            height: height * 0.37,
                            width: width * 0.7,
                            child: ListView.builder(
                                physics: ScrollPhysics(),
                                scrollDirection: Axis.vertical,
                                itemCount: matchIdList.length,
                                itemBuilder: (context, index) {
                                  var items = matchIdList[index];
                                  print(
                                      'match opt>----------${items.nation.toString()}');

                                  return Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        SizedBox(
                                          width: width * 0.13,
                                          child: CustomText(
                                            text: items.nation.toString(),
                                            fontWeight: FontWeight.bold,
                                            color: Colors.white,
                                            fontSize: 12.0,
                                            textAlign: TextAlign.start,
                                          ),
                                        ),
                                        SizedBox(
                                          width: width * 0.06,
                                          child: Text(
                                            items.rate.toString(),
                                            textAlign: TextAlign.start,
                                            style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              color: Colors.white,
                                              fontSize: 12.0,
                                            ),
                                          ),
                                        ),
                                        SizedBox(
                                          width: width * 0.06,
                                          child: CustomText(
                                            text: items.amount.toString(),
                                            fontWeight: FontWeight.bold,
                                            color: Colors.white,
                                            fontSize: 12.0,
                                            textAlign: TextAlign.start,
                                          ),
                                        ),
                                      ]);
                                }),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
              InkWell(
                onTap: () {
                  Navigator.pop(context);

                  setState(() {
                    playBackgroundMusic == false
                        ? onPressedMusic()
                        : Vibration.vibrate();
                  });
                },
                child: Container(
                  alignment: Alignment.topRight,
                  height: hBg,
                  width: wBg,
                  margin: const EdgeInsets.only(left: 100, bottom: 20),
                  child: Container(
                      alignment: Alignment.center,
                      height: height * 0.05,
                      width: width * 0.05,
                      decoration: BoxDecoration(
                          image: DecorationImage(
                              image: AssetImage(
                                  "assets/User-interface/Buttons/close-button.png")))),
                ),
              ),
            ]),
          );
        });
  }

  ///showing current result in protrait mode
  currentResultPortrait() {
    return Container(
        height: height * 0.88,
        width: width * 0.7,
        padding: EdgeInsets.all(10),
        alignment: Alignment.topCenter,
        decoration: BoxDecoration(
            gradient: LinearGradient(
                begin: Alignment.topCenter,
                colors: const [Color(0xffff01452b), Color(0xffff002114)])),
        child: SingleChildScrollView(
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.center, children: [
            Text(
              'RESULT',
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                  fontWeight: FontWeight.w900,
                  fontSize: 16,
                  color: Colors.white),
            ),
            SizedBox(height: height * 0.02),
            Container(
              padding: EdgeInsets.only(left: width * 0.1),
              height: height * 0.07,
              width: width,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                image: DecorationImage(
                    image: marketId == marketIdWinner
                        ? winnerArray[0] == 'L'
                            ? AssetImage(
                                'assets/vertual_teen_patti/Group 1681.png')
                            : AssetImage(
                                'assets/vertual_teen_patti/Group 1682.png')
                        : AssetImage('assets/vertual_teen_patti/player_bg.png'),
                    fit: BoxFit.fill),
              ),
              child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'PLAYER 1',
                      style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w700,
                          color: Colors.white),
                    ),
                    SizedBox(width: width * 0.24),
                    cardNameImage1Array[0].isNotEmpty
                        ? FlipCard(
                            flipOnTouch: false,
                            autoFlipDuration: Duration(seconds: 1),
                            front: Image.asset(
                              'assets/lucky7/images/cardBg.png',
                              height: height * 0.05,
                              width: width * 0.07,
                              fit: BoxFit.fill,
                            ),
                            back: SizedBox(
                                height: height * 0.05,
                                width: width * 0.07,
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(2.5),
                                  child: Image.network(
                                      'http://admin.kalyanexch.com/images/cards/${cardNameImage1Array[0]}.png',
                                      fit: BoxFit.cover),
                                )))
                        : Image.asset(
                            'assets/lucky7/images/cardBg.png',
                            height: height * 0.05,
                            width: width * 0.07,
                            fit: BoxFit.fill,
                          ),
                    SizedBox(width: width * 0.03),
                    cardNameImage1Array.length > 9
                        ? FlipCard(
                            flipOnTouch: false,
                            autoFlipDuration: Duration(seconds: 1),
                            front: Image.asset(
                              'assets/lucky7/images/cardBg.png',
                              height: height * 0.05,
                              width: width * 0.07,
                              fit: BoxFit.fill,
                            ),
                            back: SizedBox(
                                height: height * 0.05,
                                width: width * 0.07,
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(2.5),
                                  child: Image.network(
                                      'http://admin.kalyanexch.com/images/cards/${cardNameImage1Array[9]}.png',
                                      fit: BoxFit.cover),
                                )))
                        : Image.asset(
                            'assets/lucky7/images/cardBg.png',
                            height: height * 0.05,
                            width: width * 0.07,
                            fit: BoxFit.fill,
                          ),
                    SizedBox(width: width * 0.03),
                    cardNameImage1Array.length > 18
                        ? FlipCard(
                            flipOnTouch: false,
                            autoFlipDuration: Duration(seconds: 1),
                            front: Image.asset(
                              'assets/lucky7/images/cardBg.png',
                              height: height * 0.05,
                              width: width * 0.07,
                              fit: BoxFit.fill,
                            ),
                            back: SizedBox(
                                height: height * 0.05,
                                width: width * 0.07,
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(2.5),
                                  child: Image.network(
                                      'http://admin.kalyanexch.com/images/cards/${cardNameImage1Array[18]}.png',
                                      fit: BoxFit.cover),
                                )))
                        : Image.asset(
                            'assets/lucky7/images/cardBg.png',
                            height: height * 0.05,
                            width: width * 0.07,
                            fit: BoxFit.fill,
                          ),
                  ]),
            ),
            SizedBox(height: height * 0.02),
            Container(
              padding: EdgeInsets.only(left: width * 0.1),
              height: height * 0.07,
              width: width,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                image: DecorationImage(
                    image: marketId == marketIdWinner
                        ? winnerArray[1] == 'L'
                            ? AssetImage(
                                'assets/vertual_teen_patti/Group 1681.png')
                            : AssetImage(
                                'assets/vertual_teen_patti/Group 1682.png')
                        : AssetImage('assets/vertual_teen_patti/player_bg.png'),
                    fit: BoxFit.fill),
              ),
              child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'PLAYER 2',
                      style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w700,
                          color: Colors.white),
                    ),
                    SizedBox(width: width * 0.24),
                    cardNameImage1Array.length > 1
                        ? FlipCard(
                            flipOnTouch: false,
                            autoFlipDuration: Duration(seconds: 1),
                            front: Image.asset(
                              'assets/lucky7/images/cardBg.png',
                              height: height * 0.05,
                              width: width * 0.07,
                              fit: BoxFit.fill,
                            ),
                            back: SizedBox(
                                height: height * 0.05,
                                width: width * 0.07,
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(2.5),
                                  child: Image.network(
                                      'http://admin.kalyanexch.com/images/cards/${cardNameImage1Array[1]}.png',
                                      fit: BoxFit.cover),
                                )))
                        : Image.asset(
                            'assets/lucky7/images/cardBg.png',
                            height: height * 0.05,
                            width: width * 0.07,
                            fit: BoxFit.fill,
                          ),
                    SizedBox(width: width * 0.03),
                    cardNameImage1Array.length > 10
                        ? FlipCard(
                            flipOnTouch: false,
                            autoFlipDuration: Duration(seconds: 1),
                            front: Image.asset(
                              'assets/lucky7/images/cardBg.png',
                              height: height * 0.05,
                              width: width * 0.07,
                              fit: BoxFit.fill,
                            ),
                            back: SizedBox(
                                height: height * 0.05,
                                width: width * 0.07,
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(2.5),
                                  child: Image.network(
                                      'http://admin.kalyanexch.com/images/cards/${cardNameImage1Array[10]}.png',
                                      fit: BoxFit.cover),
                                )))
                        : Image.asset(
                            'assets/lucky7/images/cardBg.png',
                            height: height * 0.05,
                            width: width * 0.07,
                            fit: BoxFit.fill,
                          ),
                    SizedBox(width: width * 0.03),
                    cardNameImage1Array.length > 19
                        ? FlipCard(
                            flipOnTouch: false,
                            autoFlipDuration: Duration(seconds: 1),
                            front: Image.asset(
                              'assets/lucky7/images/cardBg.png',
                              height: height * 0.05,
                              width: width * 0.07,
                              fit: BoxFit.fill,
                            ),
                            back: SizedBox(
                                height: height * 0.05,
                                width: width * 0.07,
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(2.5),
                                  child: Image.network(
                                      'http://admin.kalyanexch.com/images/cards/${cardNameImage1Array[19]}.png',
                                      fit: BoxFit.cover),
                                )))
                        : Image.asset(
                            'assets/lucky7/images/cardBg.png',
                            height: height * 0.05,
                            width: width * 0.07,
                            fit: BoxFit.fill,
                          ),
                  ]),
            ),
            SizedBox(height: height * 0.02),
            Container(
              padding: EdgeInsets.only(left: width * 0.1),
              height: height * 0.07,
              width: width,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                image: DecorationImage(
                    image: marketId == marketIdWinner
                        ? winnerArray[2] == 'L'
                            ? AssetImage(
                                'assets/vertual_teen_patti/Group 1681.png')
                            : AssetImage(
                                'assets/vertual_teen_patti/Group 1682.png')
                        : AssetImage('assets/vertual_teen_patti/player_bg.png'),
                    fit: BoxFit.fill),
              ),
              child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'PLAYER 3',
                      style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w700,
                          color: Colors.white),
                    ),
                    SizedBox(width: width * 0.24),
                    cardNameImage1Array.length > 2
                        ? FlipCard(
                            flipOnTouch: false,
                            autoFlipDuration: Duration(seconds: 1),
                            front: Image.asset(
                              'assets/lucky7/images/cardBg.png',
                              height: height * 0.05,
                              width: width * 0.07,
                              fit: BoxFit.fill,
                            ),
                            back: SizedBox(
                                height: height * 0.05,
                                width: width * 0.07,
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(2.5),
                                  child: Image.network(
                                      'http://admin.kalyanexch.com/images/cards/${cardNameImage1Array[2]}.png',
                                      fit: BoxFit.cover),
                                )))
                        : Image.asset(
                            'assets/lucky7/images/cardBg.png',
                            height: height * 0.05,
                            width: width * 0.07,
                            fit: BoxFit.fill,
                          ),
                    SizedBox(width: width * 0.03),
                    cardNameImage1Array.length > 11
                        ? FlipCard(
                            flipOnTouch: false,
                            autoFlipDuration: Duration(seconds: 1),
                            front: Image.asset(
                              'assets/lucky7/images/cardBg.png',
                              height: height * 0.05,
                              width: width * 0.07,
                              fit: BoxFit.fill,
                            ),
                            back: SizedBox(
                                height: height * 0.05,
                                width: width * 0.07,
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(2.5),
                                  child: Image.network(
                                      'http://admin.kalyanexch.com/images/cards/${cardNameImage1Array[11]}.png',
                                      fit: BoxFit.cover),
                                )))
                        : Image.asset(
                            'assets/lucky7/images/cardBg.png',
                            height: height * 0.05,
                            width: width * 0.07,
                            fit: BoxFit.fill,
                          ),
                    SizedBox(width: width * 0.03),
                    cardNameImage1Array.length > 20
                        ? FlipCard(
                            flipOnTouch: false,
                            autoFlipDuration: Duration(seconds: 1),
                            front: Image.asset(
                              'assets/lucky7/images/cardBg.png',
                              height: height * 0.05,
                              width: width * 0.07,
                              fit: BoxFit.fill,
                            ),
                            back: SizedBox(
                                height: height * 0.05,
                                width: width * 0.07,
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(2.5),
                                  child: Image.network(
                                      'http://admin.kalyanexch.com/images/cards/${cardNameImage1Array[20]}.png',
                                      fit: BoxFit.cover),
                                )))
                        : Image.asset(
                            'assets/lucky7/images/cardBg.png',
                            height: height * 0.05,
                            width: width * 0.07,
                            fit: BoxFit.fill,
                          ),
                  ]),
            ),
            SizedBox(height: height * 0.02),
            Container(
              padding: EdgeInsets.only(left: width * 0.1),
              height: height * 0.07,
              width: width,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                image: DecorationImage(
                    image: marketId == marketIdWinner
                        ? winnerArray[3] == 'L'
                            ? AssetImage(
                                'assets/vertual_teen_patti/Group 1681.png')
                            : AssetImage(
                                'assets/vertual_teen_patti/Group 1682.png')
                        : AssetImage('assets/vertual_teen_patti/player_bg.png'),
                    fit: BoxFit.fill),
              ),
              child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'PLAYER 4',
                      style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w700,
                          color: Colors.white),
                    ),
                    SizedBox(width: width * 0.24),
                    cardNameImage1Array.length > 3
                        ? FlipCard(
                            flipOnTouch: false,
                            autoFlipDuration: Duration(seconds: 1),
                            front: Image.asset(
                              'assets/lucky7/images/cardBg.png',
                              height: height * 0.05,
                              width: width * 0.07,
                              fit: BoxFit.fill,
                            ),
                            back: SizedBox(
                                height: height * 0.05,
                                width: width * 0.07,
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(2.5),
                                  child: Image.network(
                                      'http://admin.kalyanexch.com/images/cards/${cardNameImage1Array[3]}.png',
                                      fit: BoxFit.cover),
                                )))
                        : Image.asset(
                            'assets/lucky7/images/cardBg.png',
                            height: height * 0.05,
                            width: width * 0.07,
                            fit: BoxFit.fill,
                          ),
                    SizedBox(width: width * 0.03),
                    cardNameImage1Array.length > 12
                        ? FlipCard(
                            flipOnTouch: false,
                            autoFlipDuration: Duration(seconds: 1),
                            front: Image.asset(
                              'assets/lucky7/images/cardBg.png',
                              height: height * 0.05,
                              width: width * 0.07,
                              fit: BoxFit.fill,
                            ),
                            back: SizedBox(
                                height: height * 0.05,
                                width: width * 0.07,
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(2.5),
                                  child: Image.network(
                                      'http://admin.kalyanexch.com/images/cards/${cardNameImage1Array[12]}.png',
                                      fit: BoxFit.cover),
                                )))
                        : Image.asset(
                            'assets/lucky7/images/cardBg.png',
                            height: height * 0.05,
                            width: width * 0.07,
                            fit: BoxFit.fill,
                          ),
                    SizedBox(width: width * 0.03),
                    cardNameImage1Array.length > 21
                        ? FlipCard(
                            flipOnTouch: false,
                            autoFlipDuration: Duration(seconds: 1),
                            front: Image.asset(
                              'assets/lucky7/images/cardBg.png',
                              height: height * 0.05,
                              width: width * 0.07,
                              fit: BoxFit.fill,
                            ),
                            back: SizedBox(
                                height: height * 0.05,
                                width: width * 0.07,
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(2.5),
                                  child: Image.network(
                                      'http://admin.kalyanexch.com/images/cards/${cardNameImage1Array[21]}.png',
                                      fit: BoxFit.cover),
                                )))
                        : Image.asset(
                            'assets/lucky7/images/cardBg.png',
                            height: height * 0.05,
                            width: width * 0.07,
                            fit: BoxFit.fill,
                          ),
                  ]),
            ),
            SizedBox(height: height * 0.02),
            Container(
              padding: EdgeInsets.only(left: width * 0.1),
              height: height * 0.07,
              width: width,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                image: DecorationImage(
                    image: marketId == marketIdWinner
                        ? winnerArray[4] == 'L'
                            ? AssetImage(
                                'assets/vertual_teen_patti/Group 1681.png')
                            : AssetImage(
                                'assets/vertual_teen_patti/Group 1682.png')
                        : AssetImage('assets/vertual_teen_patti/player_bg.png'),
                    fit: BoxFit.fill),
              ),
              child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'PLAYER 5',
                      style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w700,
                          color: Colors.white),
                    ),
                    SizedBox(width: width * 0.24),
                    cardNameImage1Array.length > 4
                        ? FlipCard(
                            flipOnTouch: false,
                            autoFlipDuration: Duration(seconds: 1),
                            front: Image.asset(
                              'assets/lucky7/images/cardBg.png',
                              height: height * 0.05,
                              width: width * 0.07,
                              fit: BoxFit.fill,
                            ),
                            back: SizedBox(
                                height: height * 0.05,
                                width: width * 0.07,
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(2.5),
                                  child: Image.network(
                                      'http://admin.kalyanexch.com/images/cards/${cardNameImage1Array[4]}.png',
                                      fit: BoxFit.cover),
                                )))
                        : Image.asset(
                            'assets/lucky7/images/cardBg.png',
                            height: height * 0.05,
                            width: width * 0.07,
                            fit: BoxFit.fill,
                          ),
                    SizedBox(width: width * 0.03),
                    cardNameImage1Array.length > 13
                        ? FlipCard(
                            flipOnTouch: false,
                            autoFlipDuration: Duration(seconds: 1),
                            front: Image.asset(
                              'assets/lucky7/images/cardBg.png',
                              height: height * 0.05,
                              width: width * 0.07,
                              fit: BoxFit.fill,
                            ),
                            back: SizedBox(
                                height: height * 0.05,
                                width: width * 0.07,
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(2.5),
                                  child: Image.network(
                                      'http://admin.kalyanexch.com/images/cards/${cardNameImage1Array[13]}.png',
                                      fit: BoxFit.cover),
                                )))
                        : Image.asset(
                            'assets/lucky7/images/cardBg.png',
                            height: height * 0.05,
                            width: width * 0.07,
                            fit: BoxFit.fill,
                          ),
                    SizedBox(width: width * 0.03),
                    cardNameImage1Array.length > 22
                        ? FlipCard(
                            flipOnTouch: false,
                            autoFlipDuration: Duration(seconds: 1),
                            front: Image.asset(
                              'assets/lucky7/images/cardBg.png',
                              height: height * 0.05,
                              width: width * 0.07,
                              fit: BoxFit.fill,
                            ),
                            back: SizedBox(
                                height: height * 0.05,
                                width: width * 0.07,
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(2.5),
                                  child: Image.network(
                                      'http://admin.kalyanexch.com/images/cards/${cardNameImage1Array[22]}.png',
                                      fit: BoxFit.cover),
                                )))
                        : Image.asset(
                            'assets/lucky7/images/cardBg.png',
                            height: height * 0.05,
                            width: width * 0.07,
                            fit: BoxFit.fill,
                          ),
                  ]),
            ),
            SizedBox(height: height * 0.02),
            Container(
              padding: EdgeInsets.only(left: width * 0.1),
              height: height * 0.07,
              width: width,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                image: DecorationImage(
                    image: marketId == marketIdWinner
                        ? winnerArray[5] == 'L'
                            ? AssetImage(
                                'assets/vertual_teen_patti/Group 1681.png')
                            : AssetImage(
                                'assets/vertual_teen_patti/Group 1682.png')
                        : AssetImage('assets/vertual_teen_patti/player_bg.png'),
                    fit: BoxFit.fill),
              ),
              child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'PLAYER 6',
                      style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w700,
                          color: Colors.white),
                    ),
                    SizedBox(width: width * 0.24),
                    cardNameImage1Array.length > 5
                        ? FlipCard(
                            flipOnTouch: false,
                            autoFlipDuration: Duration(seconds: 1),
                            front: Image.asset(
                              'assets/lucky7/images/cardBg.png',
                              height: height * 0.05,
                              width: width * 0.07,
                              fit: BoxFit.fill,
                            ),
                            back: SizedBox(
                                height: height * 0.05,
                                width: width * 0.07,
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(2.5),
                                  child: Image.network(
                                      'http://admin.kalyanexch.com/images/cards/${cardNameImage1Array[5]}.png',
                                      fit: BoxFit.cover),
                                )))
                        : Image.asset(
                            'assets/lucky7/images/cardBg.png',
                            height: height * 0.05,
                            width: width * 0.07,
                            fit: BoxFit.fill,
                          ),
                    SizedBox(width: width * 0.03),
                    cardNameImage1Array.length > 14
                        ? FlipCard(
                            flipOnTouch: false,
                            autoFlipDuration: Duration(seconds: 1),
                            front: Image.asset(
                              'assets/lucky7/images/cardBg.png',
                              height: height * 0.05,
                              width: width * 0.07,
                              fit: BoxFit.fill,
                            ),
                            back: SizedBox(
                                height: height * 0.05,
                                width: width * 0.07,
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(2.5),
                                  child: Image.network(
                                      'http://admin.kalyanexch.com/images/cards/${cardNameImage1Array[14]}.png',
                                      fit: BoxFit.cover),
                                )))
                        : Image.asset(
                            'assets/lucky7/images/cardBg.png',
                            height: height * 0.05,
                            width: width * 0.07,
                            fit: BoxFit.fill,
                          ),
                    SizedBox(width: width * 0.03),
                    cardNameImage1Array.length > 23
                        ? FlipCard(
                            flipOnTouch: false,
                            autoFlipDuration: Duration(seconds: 1),
                            front: Image.asset(
                              'assets/lucky7/images/cardBg.png',
                              height: height * 0.05,
                              width: width * 0.07,
                              fit: BoxFit.fill,
                            ),
                            back: SizedBox(
                                height: height * 0.05,
                                width: width * 0.07,
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(2.5),
                                  child: Image.network(
                                      'http://admin.kalyanexch.com/images/cards/${cardNameImage1Array[23]}.png',
                                      fit: BoxFit.cover),
                                )))
                        : Image.asset(
                            'assets/lucky7/images/cardBg.png',
                            height: height * 0.05,
                            width: width * 0.07,
                            fit: BoxFit.fill,
                          ),
                  ]),
            ),
            SizedBox(height: height * 0.02),
            Container(
              padding: EdgeInsets.only(left: width * 0.1),
              height: height * 0.07,
              width: width,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                image: DecorationImage(
                    image: marketId == marketIdWinner
                        ? winnerArray[6] == 'L'
                            ? AssetImage(
                                'assets/vertual_teen_patti/Group 1681.png')
                            : AssetImage(
                                'assets/vertual_teen_patti/Group 1682.png')
                        : AssetImage('assets/vertual_teen_patti/player_bg.png'),
                    fit: BoxFit.fill),
              ),
              child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'PLAYER 7',
                      style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w700,
                          color: Colors.white),
                    ),
                    SizedBox(width: width * 0.24),
                    cardNameImage1Array.length > 6
                        ? FlipCard(
                            flipOnTouch: false,
                            autoFlipDuration: Duration(seconds: 1),
                            front: Image.asset(
                              'assets/lucky7/images/cardBg.png',
                              height: height * 0.05,
                              width: width * 0.07,
                              fit: BoxFit.fill,
                            ),
                            back: SizedBox(
                                height: height * 0.05,
                                width: width * 0.07,
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(2.5),
                                  child: Image.network(
                                      'http://admin.kalyanexch.com/images/cards/${cardNameImage1Array[6]}.png',
                                      fit: BoxFit.cover),
                                )))
                        : Image.asset(
                            'assets/lucky7/images/cardBg.png',
                            height: height * 0.05,
                            width: width * 0.07,
                            fit: BoxFit.fill,
                          ),
                    SizedBox(width: width * 0.03),
                    cardNameImage1Array.length > 15
                        ? FlipCard(
                            flipOnTouch: false,
                            autoFlipDuration: Duration(seconds: 1),
                            front: Image.asset(
                              'assets/lucky7/images/cardBg.png',
                              height: height * 0.05,
                              width: width * 0.07,
                              fit: BoxFit.fill,
                            ),
                            back: SizedBox(
                                height: height * 0.05,
                                width: width * 0.07,
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(2.5),
                                  child: Image.network(
                                      'http://admin.kalyanexch.com/images/cards/${cardNameImage1Array[15]}.png',
                                      fit: BoxFit.cover),
                                )))
                        : Image.asset(
                            'assets/lucky7/images/cardBg.png',
                            height: height * 0.05,
                            width: width * 0.07,
                            fit: BoxFit.fill,
                          ),
                    SizedBox(width: width * 0.03),
                    cardNameImage1Array.length > 24
                        ? FlipCard(
                            flipOnTouch: false,
                            autoFlipDuration: Duration(seconds: 1),
                            front: Image.asset(
                              'assets/lucky7/images/cardBg.png',
                              height: height * 0.05,
                              width: width * 0.07,
                              fit: BoxFit.fill,
                            ),
                            back: SizedBox(
                                height: height * 0.05,
                                width: width * 0.07,
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(2.5),
                                  child: Image.network(
                                      'http://admin.kalyanexch.com/images/cards/${cardNameImage1Array[24]}.png',
                                      fit: BoxFit.cover),
                                )))
                        : Image.asset(
                            'assets/lucky7/images/cardBg.png',
                            height: height * 0.05,
                            width: width * 0.07,
                            fit: BoxFit.fill,
                          ),
                  ]),
            ),
            SizedBox(height: height * 0.02),
            Container(
              padding: EdgeInsets.only(left: width * 0.1),
              height: height * 0.07,
              width: width,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                image: DecorationImage(
                    image: marketId == marketIdWinner
                        ? winnerArray[7] == 'L'
                            ? AssetImage(
                                'assets/vertual_teen_patti/Group 1681.png')
                            : AssetImage(
                                'assets/vertual_teen_patti/Group 1682.png')
                        : AssetImage('assets/vertual_teen_patti/player_bg.png'),
                    fit: BoxFit.fill),
              ),
              child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'PLAYER 8',
                      style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w700,
                          color: Colors.white),
                    ),
                    SizedBox(width: width * 0.24),
                    cardNameImage1Array.length > 7
                        ? FlipCard(
                            flipOnTouch: false,
                            autoFlipDuration: Duration(seconds: 1),
                            front: Image.asset(
                              'assets/lucky7/images/cardBg.png',
                              height: height * 0.05,
                              width: width * 0.07,
                              fit: BoxFit.fill,
                            ),
                            back: SizedBox(
                                height: height * 0.05,
                                width: width * 0.07,
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(2.5),
                                  child: Image.network(
                                      'http://admin.kalyanexch.com/images/cards/${cardNameImage1Array[7]}.png',
                                      fit: BoxFit.cover),
                                )))
                        : Image.asset(
                            'assets/lucky7/images/cardBg.png',
                            height: height * 0.05,
                            width: width * 0.07,
                            fit: BoxFit.fill,
                          ),
                    SizedBox(width: width * 0.03),
                    cardNameImage1Array.length > 16
                        ? FlipCard(
                            flipOnTouch: false,
                            autoFlipDuration: Duration(seconds: 1),
                            front: Image.asset(
                              'assets/lucky7/images/cardBg.png',
                              height: height * 0.05,
                              width: width * 0.07,
                              fit: BoxFit.fill,
                            ),
                            back: SizedBox(
                                height: height * 0.05,
                                width: width * 0.07,
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(2.5),
                                  child: Image.network(
                                      'http://admin.kalyanexch.com/images/cards/${cardNameImage1Array[16]}.png',
                                      fit: BoxFit.cover),
                                )))
                        : Image.asset(
                            'assets/lucky7/images/cardBg.png',
                            height: height * 0.05,
                            width: width * 0.07,
                            fit: BoxFit.fill,
                          ),
                    SizedBox(width: width * 0.03),
                    cardNameImage1Array.length > 25
                        ? FlipCard(
                            flipOnTouch: false,
                            autoFlipDuration: Duration(seconds: 1),
                            front: Image.asset(
                              'assets/lucky7/images/cardBg.png',
                              height: height * 0.05,
                              width: width * 0.07,
                              fit: BoxFit.fill,
                            ),
                            back: SizedBox(
                                height: height * 0.05,
                                width: width * 0.07,
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(2.5),
                                  child: Image.network(
                                      'http://admin.kalyanexch.com/images/cards/${cardNameImage1Array[25]}.png',
                                      fit: BoxFit.cover),
                                )))
                        : Image.asset(
                            'assets/lucky7/images/cardBg.png',
                            height: height * 0.05,
                            width: width * 0.07,
                            fit: BoxFit.fill,
                          ),
                  ]),
            ),
            SizedBox(height: height * 0.02),
            Container(
              padding: EdgeInsets.only(left: width * 0.48),
              height: height * 0.07,
              width: width,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage(
                          'assets/vertual_teen_patti/Group 1673 (1).png'),
                      fit: BoxFit.fill),
                  border: Border.all(color: Color(0xffff14ffa8)),
                  borderRadius: BorderRadius.circular(10)),
              child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    cardNameImage1Array.length > 8
                        ? FlipCard(
                            flipOnTouch: false,
                            autoFlipDuration: Duration(seconds: 1),
                            front: Image.asset(
                              'assets/lucky7/images/cardBg.png',
                              height: height * 0.05,
                              width: width * 0.07,
                              fit: BoxFit.fill,
                            ),
                            back: SizedBox(
                                height: height * 0.05,
                                width: width * 0.07,
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(2.5),
                                  child: Image.network(
                                      'http://admin.kalyanexch.com/images/cards/${cardNameImage1Array[8]}.png',
                                      fit: BoxFit.cover),
                                )))
                        : Image.asset(
                            'assets/lucky7/images/cardBg.png',
                            height: height * 0.05,
                            width: width * 0.07,
                            fit: BoxFit.fill,
                          ),
                    SizedBox(width: width * 0.03),
                    cardNameImage1Array.length > 17
                        ? FlipCard(
                            flipOnTouch: false,
                            autoFlipDuration: Duration(seconds: 1),
                            front: Image.asset(
                              'assets/lucky7/images/cardBg.png',
                              height: height * 0.05,
                              width: width * 0.07,
                              fit: BoxFit.fill,
                            ),
                            back: SizedBox(
                                height: height * 0.05,
                                width: width * 0.07,
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(2.5),
                                  child: Image.network(
                                      'http://admin.kalyanexch.com/images/cards/${cardNameImage1Array[17]}.png',
                                      fit: BoxFit.cover),
                                )))
                        : Image.asset(
                            'assets/lucky7/images/cardBg.png',
                            height: height * 0.05,
                            width: width * 0.07,
                            fit: BoxFit.fill,
                          ),
                    SizedBox(width: width * 0.03),
                    cardNameImage1Array.length > 26
                        ? FlipCard(
                            flipOnTouch: false,
                            autoFlipDuration: Duration(seconds: 1),
                            front: Image.asset(
                              'assets/lucky7/images/cardBg.png',
                              height: height * 0.05,
                              width: width * 0.07,
                              fit: BoxFit.fill,
                            ),
                            back: SizedBox(
                                height: height * 0.05,
                                width: width * 0.07,
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(2.5),
                                  child: Image.network(
                                      'http://admin.kalyanexch.com/images/cards/${cardNameImage1Array[26]}.png',
                                      fit: BoxFit.cover),
                                )))
                        : Image.asset(
                            'assets/lucky7/images/cardBg.png',
                            height: height * 0.05,
                            width: width * 0.07,
                            fit: BoxFit.fill,
                          ),
                  ]),
            ),
          ]),
        ));
  }

  ///showing past result in protrait mode
  pastResultPortrait(
      BuildContext context,
      cardImag,
      cardImage1,
      cardImage2,
      cardImage3,
      cardImage4,
      cardImage5,
      cardImage6,
      cardImage7,
      cardImage8,
      cardImage9,
      cardImage10,
      cardImage11,
      cardImage12,
      cardImage13,
      cardImage14,
      cardImage15,
      cardImage16,
      cardImage17,
      cardImage18,
      cardImage19,
      cardImage20,
      cardImage21,
      cardImage22,
      cardImage23,
      cardImage24,
      cardImage25,
      cardImage26,
      winner0,
      winner1,
      winner2,
      winner3,
      winner4,
      winner5,
      winner6,
      winner7) {
    return showDialog(
        context: context,
        builder: (_) {
          return OrientationBuilder(
              builder: (BuildContext context, Orientation orientation) {
            return  orientation==Orientation.portrait? 
            AlertDialog(
                backgroundColor: Colors.transparent,
                content: Stack(
                  children: [
                    Container(
                        height: height * 1.5,
                        //  width: width * 0.89,
                        padding: EdgeInsets.all(10),
                        alignment: Alignment.topCenter,
                        decoration: BoxDecoration(
                            gradient: LinearGradient(
                                begin: Alignment.topCenter,
                                colors: const [
                              Color(0xffff01452b),
                              Color(0xffff002114)
                            ])),
                        child: SingleChildScrollView(
                          child: Column(children: [
                            Text(
                              'RESULT',
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                  fontWeight: FontWeight.w900,
                                  fontSize: 16,
                                  color: Colors.white),
                            ),
                            SizedBox(height: height * 0.02),
                            Container(
                                padding: EdgeInsets.only(left: width * 0.05),
                                height: height * 0.07,
                                width: width,
                                alignment: Alignment.center,
                                decoration: BoxDecoration(
                                  image: DecorationImage(
                                      image: winnerArray[0] == 'L'
                                          ? AssetImage(
                                              'assets/vertual_teen_patti/Group 1681.png')
                                          : AssetImage(
                                              'assets/vertual_teen_patti/Group 1682.png'),
                                      fit: BoxFit.fill),
                                ),
                                child: Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text('PLAYER 1',
                                          style: TextStyle(
                                              fontSize: 10,
                                              fontWeight: FontWeight.w700,
                                              color: Colors.white)),
                                      SizedBox(width: width * 0.16),
                                      SizedBox(
                                          height: height * 0.05,
                                          width: width * 0.07,
                                          child: ClipRRect(
                                            borderRadius:
                                                BorderRadius.circular(2.5),
                                            child: Image.network(
                                                'http://admin.kalyanexch.com/images/cards/${cardImag}.png',
                                                fit: BoxFit.cover),
                                          )),
                                      SizedBox(width: width * 0.02),
                                      SizedBox(
                                          height: height * 0.05,
                                          width: width * 0.07,
                                          child: ClipRRect(
                                            borderRadius:
                                                BorderRadius.circular(2.5),
                                            child: Image.network(
                                                'http://admin.kalyanexch.com/images/cards/${cardImage9}.png',
                                                fit: BoxFit.cover),
                                          )),
                                      SizedBox(width: width * 0.02),
                                      SizedBox(
                                          height: height * 0.05,
                                          width: width * 0.07,
                                          child: ClipRRect(
                                            borderRadius:
                                                BorderRadius.circular(2.5),
                                            child: Image.network(
                                                'http://admin.kalyanexch.com/images/cards/${cardImage18}.png',
                                                fit: BoxFit.cover),
                                          )),
                                    ])),
                            SizedBox(height: height * 0.02),
                            Container(
                                padding: EdgeInsets.only(left: width * 0.05),
                                height: height * 0.07,
                                width: width,
                                alignment: Alignment.center,
                                decoration: BoxDecoration(
                                    image: DecorationImage(
                                        image: winnerArray[0] == 'L'
                                            ? AssetImage(
                                                'assets/vertual_teen_patti/Group 1681.png')
                                            : AssetImage(
                                                'assets/vertual_teen_patti/Group 1682.png'),
                                        fit: BoxFit.fill),
                                    border:
                                        Border.all(color: Color(0xffff14ffa8)),
                                    borderRadius: BorderRadius.circular(10)),
                                child: Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text('PLAYER 2',
                                          style: TextStyle(
                                              fontSize: 10,
                                              fontWeight: FontWeight.w700,
                                              color: Colors.white)),
                                      SizedBox(width: width * 0.15),
                                      SizedBox(
                                          height: height * 0.05,
                                          width: width * 0.07,
                                          child: ClipRRect(
                                            borderRadius:
                                                BorderRadius.circular(2.5),
                                            child: Image.network(
                                                'http://admin.kalyanexch.com/images/cards/${cardImage1}.png',
                                                fit: BoxFit.cover),
                                          )),
                                      SizedBox(width: width * 0.02),
                                      SizedBox(
                                          height: height * 0.05,
                                          width: width * 0.07,
                                          child: ClipRRect(
                                            borderRadius:
                                                BorderRadius.circular(2.5),
                                            child: Image.network(
                                                'http://admin.kalyanexch.com/images/cards/${cardImage10}.png',
                                                fit: BoxFit.cover),
                                          )),
                                      SizedBox(width: width * 0.02),
                                      SizedBox(
                                          height: height * 0.05,
                                          width: width * 0.07,
                                          child: ClipRRect(
                                            borderRadius:
                                                BorderRadius.circular(2.5),
                                            child: Image.network(
                                                'http://admin.kalyanexch.com/images/cards/${cardImage19}.png',
                                                fit: BoxFit.cover),
                                          )),
                                    ])),
                            SizedBox(height: height * 0.02),
                            Container(
                                padding: EdgeInsets.only(left: width * 0.05),
                                height: height * 0.07,
                                width: width,
                                alignment: Alignment.center,
                                decoration: BoxDecoration(
                                  image: DecorationImage(
                                      image: winnerArray[1] == 'L'
                                          ? AssetImage(
                                              'assets/vertual_teen_patti/Group 1681.png')
                                          : AssetImage(
                                              'assets/vertual_teen_patti/Group 1682.png'),
                                      fit: BoxFit.fill),
                                ),
                                child: Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text('PLAYER 3',
                                          style: TextStyle(
                                              fontSize: 10,
                                              fontWeight: FontWeight.w700,
                                              color: Colors.white)),
                                      SizedBox(width: width * 0.15),
                                      SizedBox(
                                          height: height * 0.05,
                                          width: width * 0.07,
                                          child: ClipRRect(
                                            borderRadius:
                                                BorderRadius.circular(2.5),
                                            child: Image.network(
                                                'http://admin.kalyanexch.com/images/cards/${cardImage2}.png',
                                                fit: BoxFit.cover),
                                          )),
                                      SizedBox(width: width * 0.02),
                                      SizedBox(
                                          height: height * 0.05,
                                          width: width * 0.07,
                                          child: ClipRRect(
                                            borderRadius:
                                                BorderRadius.circular(2.5),
                                            child: Image.network(
                                                'http://admin.kalyanexch.com/images/cards/${cardImage11}.png',
                                                fit: BoxFit.cover),
                                          )),
                                      SizedBox(width: width * 0.02),
                                      SizedBox(
                                          height: height * 0.05,
                                          width: width * 0.07,
                                          child: ClipRRect(
                                            borderRadius:
                                                BorderRadius.circular(2.5),
                                            child: Image.network(
                                                'http://admin.kalyanexch.com/images/cards/${cardImage20}.png',
                                                fit: BoxFit.cover),
                                          )),
                                    ])),
                            SizedBox(height: height * 0.02),
                            Container(
                                padding: EdgeInsets.only(left: width * 0.05),
                                height: height * 0.07,
                                width: width,
                                alignment: Alignment.center,
                                decoration: BoxDecoration(
                                  image: DecorationImage(
                                      image: winnerArray[3] == 'L'
                                          ? AssetImage(
                                              'assets/vertual_teen_patti/Group 1681.png')
                                          : AssetImage(
                                              'assets/vertual_teen_patti/Group 1682.png'),
                                      fit: BoxFit.fill),
                                ),
                                child: Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text('PLAYER 4',
                                          style: TextStyle(
                                              fontSize: 10,
                                              fontWeight: FontWeight.w700,
                                              color: Colors.white)),
                                      SizedBox(width: width * 0.15),
                                      SizedBox(
                                          height: height * 0.05,
                                          width: width * 0.07,
                                          child: ClipRRect(
                                            borderRadius:
                                                BorderRadius.circular(2.5),
                                            child: Image.network(
                                                'http://admin.kalyanexch.com/images/cards/${cardImage3}.png',
                                                fit: BoxFit.cover),
                                          )),
                                      SizedBox(width: width * 0.02),
                                      SizedBox(
                                          height: height * 0.05,
                                          width: width * 0.07,
                                          child: ClipRRect(
                                            borderRadius:
                                                BorderRadius.circular(2.5),
                                            child: Image.network(
                                                'http://admin.kalyanexch.com/images/cards/${cardImage12}.png',
                                                fit: BoxFit.cover),
                                          )),
                                      SizedBox(width: width * 0.02),
                                      SizedBox(
                                          height: height * 0.05,
                                          width: width * 0.07,
                                          child: ClipRRect(
                                            borderRadius:
                                                BorderRadius.circular(2.5),
                                            child: Image.network(
                                                'http://admin.kalyanexch.com/images/cards/${cardImage21}.png',
                                                fit: BoxFit.cover),
                                          )),
                                    ])),
                            SizedBox(height: height * 0.02),
                            Container(
                                padding: EdgeInsets.only(left: width * 0.05),
                                height: height * 0.07,
                                width: width,
                                alignment: Alignment.center,
                                decoration: BoxDecoration(
                                  image: DecorationImage(
                                      image: winnerArray[4] == 'L'
                                          ? AssetImage(
                                              'assets/vertual_teen_patti/Group 1681.png')
                                          : AssetImage(
                                              'assets/vertual_teen_patti/Group 1682.png'),
                                      fit: BoxFit.fill),
                                ),
                                child: Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text('PLAYER 5',
                                          style: TextStyle(
                                              fontSize: 10,
                                              fontWeight: FontWeight.w700,
                                              color: Colors.white)),
                                      SizedBox(width: width * 0.15),
                                      SizedBox(
                                          height: height * 0.05,
                                          width: width * 0.07,
                                          child: ClipRRect(
                                            borderRadius:
                                                BorderRadius.circular(2.5),
                                            child: Image.network(
                                                'http://admin.kalyanexch.com/images/cards/${cardImage4}.png',
                                                fit: BoxFit.cover),
                                          )),
                                      SizedBox(width: width * 0.02),
                                      SizedBox(
                                          height: height * 0.05,
                                          width: width * 0.07,
                                          child: ClipRRect(
                                            borderRadius:
                                                BorderRadius.circular(2.5),
                                            child: Image.network(
                                                'http://admin.kalyanexch.com/images/cards/${cardImage13}.png',
                                                fit: BoxFit.cover),
                                          )),
                                      SizedBox(width: width * 0.02),
                                      SizedBox(
                                          height: height * 0.05,
                                          width: width * 0.07,
                                          child: ClipRRect(
                                            borderRadius:
                                                BorderRadius.circular(2.5),
                                            child: Image.network(
                                                'http://admin.kalyanexch.com/images/cards/${cardImage22}.png',
                                                fit: BoxFit.cover),
                                          ))
                                    ])),
                            SizedBox(height: height * 0.02),
                            Container(
                                padding: EdgeInsets.only(left: width * 0.05),
                                height: height * 0.07,
                                width: width,
                                alignment: Alignment.center,
                                decoration: BoxDecoration(
                                  image: DecorationImage(
                                      image: winnerArray[5] == 'L'
                                          ? AssetImage(
                                              'assets/vertual_teen_patti/Group 1681.png')
                                          : AssetImage(
                                              'assets/vertual_teen_patti/Group 1682.png'),
                                      fit: BoxFit.fill),
                                ),
                                child: Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text('PLAYER 6',
                                          style: TextStyle(
                                              fontSize: 10,
                                              fontWeight: FontWeight.w700,
                                              color: Colors.white)),
                                      SizedBox(width: width * 0.15),
                                      SizedBox(
                                          height: height * 0.05,
                                          width: width * 0.07,
                                          child: ClipRRect(
                                            borderRadius:
                                                BorderRadius.circular(2.5),
                                            child: Image.network(
                                                'http://admin.kalyanexch.com/images/cards/${cardImage5}.png',
                                                fit: BoxFit.cover),
                                          )),
                                      SizedBox(width: width * 0.02),
                                      SizedBox(
                                          height: height * 0.05,
                                          width: width * 0.07,
                                          child: ClipRRect(
                                            borderRadius:
                                                BorderRadius.circular(2.5),
                                            child: Image.network(
                                                'http://admin.kalyanexch.com/images/cards/${cardImage14}.png',
                                                fit: BoxFit.cover),
                                          )),
                                      SizedBox(width: width * 0.02),
                                      SizedBox(
                                          height: height * 0.05,
                                          width: width * 0.07,
                                          child: ClipRRect(
                                            borderRadius:
                                                BorderRadius.circular(2.5),
                                            child: Image.network(
                                                'http://admin.kalyanexch.com/images/cards/${cardImage23}.png',
                                                fit: BoxFit.cover),
                                          )),
                                    ])),
                            SizedBox(height: height * 0.02),
                            Container(
                                padding: EdgeInsets.only(left: width * 0.05),
                                height: height * 0.07,
                                width: width,
                                alignment: Alignment.center,
                                decoration: BoxDecoration(
                                  image: DecorationImage(
                                      image: winnerArray[0] == 'L'
                                          ? AssetImage(
                                              'assets/vertual_teen_patti/Group 1681.png')
                                          : AssetImage(
                                              'assets/vertual_teen_patti/Group 1682.png'),
                                      fit: BoxFit.fill),
                                ),
                                child: Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text('PLAYER 7',
                                          style: TextStyle(
                                              fontSize: 10,
                                              fontWeight: FontWeight.w700,
                                              color: Colors.white)),
                                      SizedBox(width: width * 0.15),
                                      SizedBox(
                                          height: height * 0.05,
                                          width: width * 0.07,
                                          child: ClipRRect(
                                            borderRadius:
                                                BorderRadius.circular(2.5),
                                            child: Image.network(
                                                'http://admin.kalyanexch.com/images/cards/${cardImage6}.png',
                                                fit: BoxFit.cover),
                                          )),
                                      SizedBox(width: width * 0.02),
                                      SizedBox(
                                          height: height * 0.05,
                                          width: width * 0.07,
                                          child: ClipRRect(
                                            borderRadius:
                                                BorderRadius.circular(2.5),
                                            child: Image.network(
                                                'http://admin.kalyanexch.com/images/cards/${cardImage15}.png',
                                                fit: BoxFit.cover),
                                          )),
                                      SizedBox(width: width * 0.02),
                                      SizedBox(
                                          height: height * 0.05,
                                          width: width * 0.07,
                                          child: ClipRRect(
                                            borderRadius:
                                                BorderRadius.circular(2.5),
                                            child: Image.network(
                                                'http://admin.kalyanexch.com/images/cards/${cardImage24}.png',
                                                fit: BoxFit.cover),
                                          )),
                                    ])),
                            SizedBox(height: height * 0.02),
                            Container(
                                padding: EdgeInsets.only(left: width * 0.05),
                                height: height * 0.07,
                                width: width,
                                alignment: Alignment.center,
                                decoration: BoxDecoration(
                                  image: DecorationImage(
                                      image: winnerArray[7] == 'L'
                                          ? AssetImage(
                                              'assets/vertual_teen_patti/Group 1681.png')
                                          : AssetImage(
                                              'assets/vertual_teen_patti/Group 1682.png'),
                                      fit: BoxFit.fill),
                                ),
                                child: Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text('PLAYER 8',
                                          style: TextStyle(
                                              fontSize: 10,
                                              fontWeight: FontWeight.w700,
                                              color: Colors.white)),
                                      SizedBox(width: width * 0.15),
                                      SizedBox(
                                          height: height * 0.05,
                                          width: width * 0.07,
                                          child: ClipRRect(
                                            borderRadius:
                                                BorderRadius.circular(2.5),
                                            child: Image.network(
                                                'http://admin.kalyanexch.com/images/cards/${cardImage7}.png',
                                                fit: BoxFit.cover),
                                          )),
                                      SizedBox(width: width * 0.02),
                                      SizedBox(
                                          height: height * 0.05,
                                          width: width * 0.07,
                                          child: ClipRRect(
                                            borderRadius:
                                                BorderRadius.circular(2.5),
                                            child: Image.network(
                                                'http://admin.kalyanexch.com/images/cards/${cardImage16}.png',
                                                fit: BoxFit.cover),
                                          )),
                                      SizedBox(width: width * 0.02),
                                      SizedBox(
                                          height: height * 0.05,
                                          width: width * 0.07,
                                          child: ClipRRect(
                                            borderRadius:
                                                BorderRadius.circular(2.5),
                                            child: Image.network(
                                                'http://admin.kalyanexch.com/images/cards/${cardImage25}.png',
                                                fit: BoxFit.cover),
                                          )),
                                    ])),
                            SizedBox(height: height * 0.02),
                            Container(
                                padding: EdgeInsets.only(left: width * 0.05),
                                height: height * 0.07,
                                width: width,
                                alignment: Alignment.center,
                                decoration: BoxDecoration(
                                    image: DecorationImage(
                                        image: AssetImage(
                                            'assets/vertual_teen_patti/player_bg.png'),
                                        fit: BoxFit.fill),
                                    border:
                                        Border.all(color: Color(0xffff14ffa8)),
                                    borderRadius: BorderRadius.circular(10)),
                                child: Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text('DEALER',
                                          style: TextStyle(
                                              fontSize: 10,
                                              fontWeight: FontWeight.w700,
                                              color: Colors.white)),
                                      SizedBox(width: width * 0.17),
                                      SizedBox(
                                          height: height * 0.05,
                                          width: width * 0.07,
                                          child: ClipRRect(
                                            borderRadius:
                                                BorderRadius.circular(2.5),
                                            child: Image.network(
                                                'http://admin.kalyanexch.com/images/cards/${cardImage8}.png',
                                                fit: BoxFit.cover),
                                          )),
                                      SizedBox(width: width * 0.02),
                                      SizedBox(
                                          height: height * 0.05,
                                          width: width * 0.07,
                                          child: ClipRRect(
                                            borderRadius:
                                                BorderRadius.circular(2.5),
                                            child: Image.network(
                                                'http://admin.kalyanexch.com/images/cards/${cardImage17}.png',
                                                fit: BoxFit.cover),
                                          )),
                                      SizedBox(width: width * 0.02),
                                      SizedBox(
                                          height: height * 0.05,
                                          width: width * 0.07,
                                          child: ClipRRect(
                                            borderRadius:
                                                BorderRadius.circular(2.5),
                                            child: Image.network(
                                                'http://admin.kalyanexch.com/images/cards/${cardImage26}.png',
                                                fit: BoxFit.cover),
                                          )),
                                    ])),
                          ]),
                        )),
                    Positioned(
                      right: 0,
                      child: InkWell(
                        onTap: () {
                          playBackgroundMusic == false
                              ? onPressedMusic()
                              : Vibration.vibrate();
                          Navigator.pop(context);
                        },
                        child: Container(
                          height: 24,
                          width: 24,
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(20)),
                          child: Icon(
                            Icons.close,
                          ),
                        ),
                      ),
                    ),
                  ],
                )): AlertDialog(
                backgroundColor: Colors.transparent,
                content: Stack(children: [
                  Container(
                    height: height * 0.9,
                    width: width * 0.7,
                    padding: EdgeInsets.all(10),
                    alignment: Alignment.topCenter,
                    decoration: BoxDecoration(
                        image: DecorationImage(
                            fit: BoxFit.fill,
                            image: AssetImage(
                                'assets/vertual_teen_patti/vector.png')),
                        // color: Color(0xFFFF001A11),
                        gradient: LinearGradient(
                            begin: Alignment.topCenter,
                            colors: const [
                              Color(0xffff01452b),
                              Color(0xffff002114)
                            ])),
                    child: SingleChildScrollView(
                        child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                          Text(
                            'RESULT',
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                                fontWeight: FontWeight.w900,
                                fontSize: height * 0.04,
                                color: Colors.white),
                          ),
                          SizedBox(height: height * 0.03),
                          Column(
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: [
                                  Stack(
                                    children: [
                                      Container(
                                        height: height * 0.3,
                                        width: width * 0.2,
                                        padding: EdgeInsets.all(10),
                                        alignment: Alignment.topCenter,
                                        decoration: BoxDecoration(
                                          image: DecorationImage(
                                              fit: BoxFit.fill,
                                              image: AssetImage(
                                                  'assets/vertual_teen_patti/Group 1707.png')),
                                        ),
                                      ),
                                      Positioned(
                                        top: height * 0.04,
                                        left: width * 0.003,
                                        child: Column(
                                          children: [
                                            Row(children: [
                                              // SizedBox(width: 5),
                                              SizedBox(
                                                  height: height * 0.15,
                                                  width: width * 0.05,
                                                  child: ClipRRect(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            2.5),
                                                    child: Image.network(
                                                        'http://admin.kalyanexch.com/images/cards/${cardImag}.png',
                                                        fit: BoxFit.cover),
                                                  )),
                                              SizedBox(width: width * 0.01),
                                              SizedBox(
                                                  height: height * 0.15,
                                                  width: width * 0.05,
                                                  child: ClipRRect(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            2.5),
                                                    child: Image.network(
                                                        'http://admin.kalyanexch.com/images/cards/${cardImage9}.png',
                                                        fit: BoxFit.cover),
                                                  )),
                                              SizedBox(width: width * 0.01),
                                              SizedBox(
                                                  height: height * 0.15,
                                                  width: width * 0.05,
                                                  child: ClipRRect(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            2.5),
                                                    child: Image.network(
                                                        'http://admin.kalyanexch.com/images/cards/${cardImage18}.png',
                                                        fit: BoxFit.cover),
                                                  )),
                                            ]),
                                            SizedBox(height: height * 0.05),
                                            Container(
                                              padding: EdgeInsets.symmetric(
                                                  horizontal: width * 0.075,
                                                  vertical: height * 0.0065),
                                              decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(2),
                                                  color: winnerArray[0] == 'L'
                                                      ? Color(0xffFF0000)
                                                      : Color(0xff008000)),
                                              child: Text(
                                                'PLAYER 1',
                                                style: TextStyle(
                                                    // fontFamily: 'Inter',
                                                    fontSize: 9,
                                                    fontWeight: FontWeight.w700,
                                                    color: Colors.white),
                                              ),
                                            ),
                                          ],
                                        ),
                                      )
                                    ],
                                  ),
                                  Stack(
                                    children: [
                                      Container(
                                        height: height * 0.3,
                                        width: width * 0.2,
                                        padding: EdgeInsets.all(10),
                                        alignment: Alignment.topCenter,
                                        decoration: BoxDecoration(
                                          image: DecorationImage(
                                              fit: BoxFit.fill,
                                              image: AssetImage(
                                                  'assets/vertual_teen_patti/Group 1707.png')),
                                        ),
                                      ),
                                      Positioned(
                                        top: height * 0.04,
                                        left: width * 0.003,
                                        child: Column(
                                          children: [
                                            Row(children: [
                                              SizedBox(
                                                  height: height * 0.15,
                                                  width: width * 0.05,
                                                  child: ClipRRect(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            2.5),
                                                    child: Image.network(
                                                        'http://admin.kalyanexch.com/images/cards/${cardImage1}.png',
                                                        fit: BoxFit.cover),
                                                  )),
                                              SizedBox(width: width * 0.01),
                                              SizedBox(
                                                  height: height * 0.15,
                                                  width: width * 0.05,
                                                  child: ClipRRect(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            2.5),
                                                    child: Image.network(
                                                        'http://admin.kalyanexch.com/images/cards/${cardImage10}.png',
                                                        fit: BoxFit.cover),
                                                  )),
                                              SizedBox(width: width * 0.01),
                                              SizedBox(
                                                  height: height * 0.15,
                                                  width: width * 0.05,
                                                  child: ClipRRect(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            2.5),
                                                    child: Image.network(
                                                        'http://admin.kalyanexch.com/images/cards/${cardImage19}.png',
                                                        fit: BoxFit.cover),
                                                  )),
                                            ]),
                                            SizedBox(height: height * 0.05),
                                            Container(
                                              padding: EdgeInsets.symmetric(
                                                  horizontal: width * 0.073,
                                                  vertical: height * 0.0065),
                                              decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(2),
                                                  color: winnerArray[1] == 'L'
                                                      ? Color(0xffFF0000)
                                                      : Color(0xff008000)),
                                              child: Text(
                                                'PLAYER 2',
                                                style: TextStyle(
                                                    // fontFamily: 'Inter',
                                                    fontSize: 9,
                                                    fontWeight: FontWeight.w700,
                                                    color: Colors.white),
                                              ),
                                            ),
                                          ],
                                        ),
                                      )
                                    ],
                                  ),
                                  Stack(
                                    children: [
                                      Container(
                                        height: height * 0.3,
                                        width: width * 0.2,
                                        padding: EdgeInsets.all(10),
                                        alignment: Alignment.topCenter,
                                        decoration: BoxDecoration(
                                          image: DecorationImage(
                                              fit: BoxFit.fill,
                                              image: AssetImage(
                                                  'assets/vertual_teen_patti/Group 1707.png')),
                                        ),
                                      ),
                                      Positioned(
                                        top: height * 0.04,
                                        left: width * 0.003,
                                        child: Column(
                                          children: [
                                            Row(children: [
                                              SizedBox(
                                                  height: height * 0.15,
                                                  width: width * 0.05,
                                                  child: ClipRRect(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            2.5),
                                                    child: Image.network(
                                                        'http://admin.kalyanexch.com/images/cards/${cardImage2}.png',
                                                        fit: BoxFit.cover),
                                                  )),
                                              SizedBox(width: width * 0.01),
                                              SizedBox(
                                                  height: height * 0.15,
                                                  width: width * 0.05,
                                                  child: ClipRRect(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            2.5),
                                                    child: Image.network(
                                                        'http://admin.kalyanexch.com/images/cards/${cardImage11}.png',
                                                        fit: BoxFit.cover),
                                                  )),
                                              SizedBox(width: width * 0.01),
                                              SizedBox(
                                                  height: height * 0.15,
                                                  width: width * 0.05,
                                                  child: ClipRRect(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            2.5),
                                                    child: Image.network(
                                                        'http://admin.kalyanexch.com/images/cards/${cardImage20}.png',
                                                        fit: BoxFit.cover),
                                                  )),
                                            ]),
                                            SizedBox(height: height * 0.05),
                                            Container(
                                              padding: EdgeInsets.symmetric(
                                                  horizontal: width * 0.073,
                                                  vertical: height * 0.0065),
                                              decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(2),
                                                  color: winnerArray[2] == 'L'
                                                      ? Color(0xffFF0000)
                                                      : Color(0xff008000)),
                                              child: Text(
                                                'PLAYER 3',
                                                style: TextStyle(
                                                    // fontFamily: 'Inter',
                                                    fontSize: 9,
                                                    fontWeight: FontWeight.w700,
                                                    color: Colors.white),
                                              ),
                                            ),
                                          ],
                                        ),
                                      )
                                    ],
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: height * 0.03,
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: [
                                  Stack(
                                    children: [
                                      Container(
                                        height: height * 0.3,
                                        width: width * 0.2,
                                        padding: EdgeInsets.all(10),
                                        alignment: Alignment.topCenter,
                                        decoration: BoxDecoration(
                                          image: DecorationImage(
                                              fit: BoxFit.fill,
                                              image: AssetImage(
                                                  'assets/vertual_teen_patti/Group 1707.png')),
                                        ),
                                      ),
                                      Positioned(
                                        top: height * 0.04,
                                        left: width * 0.003,
                                        child: Column(
                                          children: [
                                            Row(children: [
                                              // SizedBox(width: 5),
                                              SizedBox(
                                                  height: height * 0.15,
                                                  width: width * 0.05,
                                                  child: ClipRRect(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            2.5),
                                                    child: Image.network(
                                                        'http://admin.kalyanexch.com/images/cards/${cardImage3}.png',
                                                        fit: BoxFit.cover),
                                                  )),
                                              SizedBox(width: width * 0.01),
                                              SizedBox(
                                                  height: height * 0.15,
                                                  width: width * 0.05,
                                                  child: ClipRRect(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            2.5),
                                                    child: Image.network(
                                                        'http://admin.kalyanexch.com/images/cards/${cardImage12}.png',
                                                        fit: BoxFit.cover),
                                                  )),
                                              SizedBox(width: width * 0.01),
                                              SizedBox(
                                                  height: height * 0.15,
                                                  width: width * 0.05,
                                                  child: ClipRRect(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            2.5),
                                                    child: Image.network(
                                                        'http://admin.kalyanexch.com/images/cards/${cardImage21}.png',
                                                        fit: BoxFit.cover),
                                                  )),
                                            ]),
                                            SizedBox(height: height * 0.05),
                                            Container(
                                              padding: EdgeInsets.symmetric(
                                                  horizontal: width * 0.073,
                                                  vertical: height * 0.0065),
                                              decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(2),
                                                  color: winnerArray[3] == 'L'
                                                      ? Color(0xffFF0000)
                                                      : Color(0xff008000)),
                                              child: Text(
                                                'PLAYER 4',
                                                style: TextStyle(
                                                    // fontFamily: 'Inter',
                                                    fontSize: 9,
                                                    fontWeight: FontWeight.w700,
                                                    color: Colors.white),
                                              ),
                                            ),
                                          ],
                                        ),
                                      )
                                    ],
                                  ),
                                  Stack(
                                    children: [
                                      Container(
                                        height: height * 0.3,
                                        width: width * 0.2,
                                        padding: EdgeInsets.all(10),
                                        alignment: Alignment.topCenter,
                                        decoration: BoxDecoration(
                                          image: DecorationImage(
                                              fit: BoxFit.fill,
                                              image: AssetImage(
                                                  'assets/vertual_teen_patti/Group 1707.png')),
                                        ),
                                      ),
                                      Positioned(
                                        top: height * 0.04,
                                        left: width * 0.003,
                                        child: Column(
                                          children: [
                                            Row(children: [
                                              SizedBox(
                                                  height: height * 0.15,
                                                  width: width * 0.05,
                                                  child: ClipRRect(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            2.5),
                                                    child: Image.network(
                                                        'http://admin.kalyanexch.com/images/cards/${cardImage4}.png',
                                                        fit: BoxFit.cover),
                                                  )),
                                              SizedBox(width: width * 0.01),
                                              SizedBox(
                                                  height: height * 0.15,
                                                  width: width * 0.05,
                                                  child: ClipRRect(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            2.5),
                                                    child: Image.network(
                                                        'http://admin.kalyanexch.com/images/cards/${cardImage13}.png',
                                                        fit: BoxFit.cover),
                                                  )),
                                              SizedBox(width: width * 0.01),
                                              SizedBox(
                                                  height: height * 0.15,
                                                  width: width * 0.05,
                                                  child: ClipRRect(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            2.5),
                                                    child: Image.network(
                                                        'http://admin.kalyanexch.com/images/cards/${cardImage22}.png',
                                                        fit: BoxFit.cover),
                                                  ))
                                            ]),
                                            SizedBox(height: height * 0.05),
                                            Container(
                                              padding: EdgeInsets.symmetric(
                                                  horizontal: width * 0.073,
                                                  vertical: height * 0.0065),
                                              decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(2),
                                                  color: winnerArray[4] == 'L'
                                                      ? Color(0xffFF0000)
                                                      : Color(0xff008000)),
                                              child: Text(
                                                'PLAYER 5',
                                                style: TextStyle(
                                                    // fontFamily: 'Inter',
                                                    fontSize: 9,
                                                    fontWeight: FontWeight.w700,
                                                    color: Colors.white),
                                              ),
                                            ),
                                          ],
                                        ),
                                      )
                                    ],
                                  ),
                                  Stack(
                                    children: [
                                      Container(
                                        height: height * 0.3,
                                        width: width * 0.2,
                                        padding: EdgeInsets.all(10),
                                        alignment: Alignment.topCenter,
                                        decoration: BoxDecoration(
                                          image: DecorationImage(
                                              fit: BoxFit.fill,
                                              image: AssetImage(
                                                  'assets/vertual_teen_patti/Group 1707.png')),
                                        ),
                                      ),
                                      Positioned(
                                        top: height * 0.04,
                                        left: width * 0.003,
                                        child: Column(
                                          children: [
                                            Row(children: [
                                              SizedBox(
                                                  height: height * 0.15,
                                                  width: width * 0.05,
                                                  child: ClipRRect(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            2.5),
                                                    child: Image.network(
                                                        'http://admin.kalyanexch.com/images/cards/${cardImage5}.png',
                                                        fit: BoxFit.cover),
                                                  )),
                                              SizedBox(width: width * 0.01),
                                              SizedBox(
                                                  height: height * 0.15,
                                                  width: width * 0.05,
                                                  child: ClipRRect(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            2.5),
                                                    child: Image.network(
                                                        'http://admin.kalyanexch.com/images/cards/${cardImage14}.png',
                                                        fit: BoxFit.cover),
                                                  )),
                                              SizedBox(width: width * 0.01),
                                              SizedBox(
                                                  height: height * 0.15,
                                                  width: width * 0.05,
                                                  child: ClipRRect(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            2.5),
                                                    child: Image.network(
                                                        'http://admin.kalyanexch.com/images/cards/${cardImage23}.png',
                                                        fit: BoxFit.cover),
                                                  )),
                                            ]),
                                            SizedBox(height: height * 0.05),
                                            Container(
                                              padding: EdgeInsets.symmetric(
                                                  horizontal: width * 0.073,
                                                  vertical: height * 0.0065),
                                              decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(2),
                                                  color: winnerArray[5] == 'L'
                                                      ? Color(0xffFF0000)
                                                      : Color(0xff008000)),
                                              child: Text(
                                                'PLAYER 6',
                                                style: TextStyle(
                                                    // fontFamily: 'Inter',
                                                    fontSize: 9,
                                                    fontWeight: FontWeight.w700,
                                                    color: Colors.white),
                                              ),
                                            ),
                                          ],
                                        ),
                                      )
                                    ],
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: height * 0.03,
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: [
                                  Stack(
                                    children: [
                                      Container(
                                        height: height * 0.3,
                                        width: width * 0.2,
                                        padding: EdgeInsets.all(10),
                                        alignment: Alignment.topCenter,
                                        decoration: BoxDecoration(
                                          image: DecorationImage(
                                              fit: BoxFit.fill,
                                              image: AssetImage(
                                                  'assets/vertual_teen_patti/Group 1707.png')),
                                        ),
                                      ),
                                      Positioned(
                                        top: height * 0.04,
                                        left: width * 0.003,
                                        child: Column(
                                          children: [
                                            Row(children: [
                                              // SizedBox(width: 5),
                                              SizedBox(
                                                  height: height * 0.15,
                                                  width: width * 0.05,
                                                  child: ClipRRect(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            2.5),
                                                    child: Image.network(
                                                        'http://admin.kalyanexch.com/images/cards/${cardImage6}.png',
                                                        fit: BoxFit.cover),
                                                  )),
                                              SizedBox(width: width * 0.01),
                                              SizedBox(
                                                  height: height * 0.15,
                                                  width: width * 0.05,
                                                  child: ClipRRect(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            2.5),
                                                    child: Image.network(
                                                        'http://admin.kalyanexch.com/images/cards/${cardImage15}.png',
                                                        fit: BoxFit.cover),
                                                  )),
                                              SizedBox(width: width * 0.01),
                                              SizedBox(
                                                  height: height * 0.15,
                                                  width: width * 0.05,
                                                  child: ClipRRect(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            2.5),
                                                    child: Image.network(
                                                        'http://admin.kalyanexch.com/images/cards/${cardImage24}.png',
                                                        fit: BoxFit.cover),
                                                  )),
                                            ]),
                                            SizedBox(height: height * 0.05),
                                            Container(
                                              padding: EdgeInsets.symmetric(
                                                  horizontal: width * 0.073,
                                                  vertical: height * 0.0065),
                                              decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(2),
                                                  color: winnerArray[6] == 'L'
                                                      ? Color(0xffFF0000)
                                                      : Color(0xff008000)),
                                              child: Text(
                                                'PLAYER 7',
                                                style: TextStyle(
                                                    // fontFamily: 'Inter',
                                                    fontSize: 9,
                                                    fontWeight: FontWeight.w700,
                                                    color: Colors.white),
                                              ),
                                            ),
                                          ],
                                        ),
                                      )
                                    ],
                                  ),
                                  Stack(
                                    children: [
                                      Container(
                                        height: height * 0.3,
                                        width: width * 0.2,
                                        padding: EdgeInsets.all(10),
                                        alignment: Alignment.topCenter,
                                        decoration: BoxDecoration(
                                          image: DecorationImage(
                                              fit: BoxFit.fill,
                                              image: AssetImage(
                                                  'assets/vertual_teen_patti/Group 1707.png')),
                                        ),
                                      ),
                                      Positioned(
                                        top: height * 0.04,
                                        left: width * 0.003,
                                        child: Column(
                                          children: [
                                            Row(children: [
                                              SizedBox(
                                                  height: height * 0.15,
                                                  width: width * 0.05,
                                                  child: ClipRRect(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            2.5),
                                                    child: Image.network(
                                                        'http://admin.kalyanexch.com/images/cards/${cardImage7}.png',
                                                        fit: BoxFit.cover),
                                                  )),
                                              SizedBox(width: width * 0.01),
                                              SizedBox(
                                                  height: height * 0.15,
                                                  width: width * 0.05,
                                                  child: ClipRRect(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            2.5),
                                                    child: Image.network(
                                                        'http://admin.kalyanexch.com/images/cards/${cardImage16}.png',
                                                        fit: BoxFit.cover),
                                                  )),
                                              SizedBox(width: width * 0.01),
                                              SizedBox(
                                                  height: height * 0.15,
                                                  width: width * 0.05,
                                                  child: ClipRRect(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            2.5),
                                                    child: Image.network(
                                                        'http://admin.kalyanexch.com/images/cards/${cardImage25}.png',
                                                        fit: BoxFit.cover),
                                                  )),
                                            ]),
                                            SizedBox(height: height * 0.05),
                                            Container(
                                              padding: EdgeInsets.symmetric(
                                                  horizontal: width * 0.073,
                                                  vertical: height * 0.0065),
                                              decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(2),
                                                  color: winnerArray[7] == 'L'
                                                      ? Color(0xffFF0000)
                                                      : Color(0xff008000)),
                                              child: Text(
                                                'PLAYER 8',
                                                style: TextStyle(
                                                    // fontFamily: 'Inter',
                                                    fontSize: 9,
                                                    fontWeight: FontWeight.w700,
                                                    color: Colors.white),
                                              ),
                                            ),
                                          ],
                                        ),
                                      )
                                    ],
                                  ),
                                  Stack(
                                    children: [
                                      Container(
                                        height: height * 0.3,
                                        width: width * 0.2,
                                        padding: EdgeInsets.all(10),
                                        alignment: Alignment.topCenter,
                                        decoration: BoxDecoration(
                                          image: DecorationImage(
                                              fit: BoxFit.fill,
                                              image: AssetImage(
                                                  'assets/vertual_teen_patti/Group 1708.png')),
                                        ),
                                      ),
                                      Positioned(
                                        top: height * 0.04,
                                        left: width * 0.02,
                                        child: Column(
                                          children: [
                                            Row(children: [
                                              SizedBox(
                                                  height: height * 0.15,
                                                  width: width * 0.05,
                                                  child: ClipRRect(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            2.5),
                                                    child: Image.network(
                                                        'http://admin.kalyanexch.com/images/cards/${cardImage8}.png',
                                                        fit: BoxFit.cover),
                                                  )),
                                              SizedBox(width: width * 0.01),
                                              SizedBox(
                                                  height: height * 0.15,
                                                  width: width * 0.05,
                                                  child: ClipRRect(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            2.5),
                                                    child: Image.network(
                                                        'http://admin.kalyanexch.com/images/cards/${cardImage17}.png',
                                                        fit: BoxFit.cover),
                                                  )),
                                              SizedBox(width: width * 0.01),
                                              SizedBox(
                                                  height: height * 0.15,
                                                  width: width * 0.05,
                                                  child: ClipRRect(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            2.5),
                                                    child: Image.network(
                                                        'http://admin.kalyanexch.com/images/cards/${cardImage26}.png',
                                                        fit: BoxFit.cover),
                                                  )),
                                            ]),
                                          ],
                                        ),
                                      )
                                    ],
                                  ),
                                ],
                              ),
                            ],
                          )
                        ])),
                  ),
                  Positioned(
                    right: 0,
                    child: InkWell(
                      onTap: () {
                        playBackgroundMusic == false
                            ? onPressedMusic()
                            : Vibration.vibrate();
                        Navigator.pop(context);
                      },
                      child: Container(
                        height: 24,
                        width: 24,
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(20)),
                        child: Icon(
                          Icons.close,
                        ),
                      ),
                    ),
                  ),
                ]));
       ;
          });
        });
  }

  ///showing current result in landscape mode
  currentResultLand() {
    return Container(
      height: height * 0.9,
      width: width * 0.7,
      padding: EdgeInsets.all(10),
      alignment: Alignment.topCenter,
      decoration: BoxDecoration(
        image: DecorationImage(
            fit: BoxFit.fill,
            image: AssetImage('assets/vertual_teen_patti/vector.png')),
        // color: Color(0xFFFF001A11),
      ),
      child: SingleChildScrollView(
          child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
            Text(
              'RESULT',
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                  fontWeight: FontWeight.w900,
                  fontSize: height * 0.04,
                  color: Colors.white),
            ),
            SizedBox(height: height * 0.03),
            Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Stack(
                      children: [
                        Container(
                          height: height * 0.3,
                          width: width * 0.2,
                          padding: EdgeInsets.all(10),
                          alignment: Alignment.topCenter,
                          decoration: BoxDecoration(
                            image: DecorationImage(
                                fit: BoxFit.fill,
                                image: AssetImage(
                                    'assets/vertual_teen_patti/Group 1707.png')),
                          ),
                        ),
                        Positioned(
                          top: height * 0.04,
                          left: marketIdWinner == marketId
                              ? width * 0.003
                              : width * 0.015,
                          child: Column(
                            children: [
                              Row(
                                children: [
                                  cardNameImage1Array[0].isNotEmpty
                                      ? FlipCard(
                                          flipOnTouch: false,
                                          autoFlipDuration:
                                              Duration(seconds: 1),
                                          front: Image.asset(
                                            'assets/lucky7/images/cardBg.png',
                                            height: height * 0.15,
                                            width: width * 0.05,
                                            fit: BoxFit.fill,
                                          ),
                                          back: SizedBox(
                                              height: height * 0.15,
                                              width: width * 0.05,
                                              child: ClipRRect(
                                                borderRadius:
                                                    BorderRadius.circular(2.5),
                                                child: Image.network(
                                                    'http://admin.kalyanexch.com/images/cards/${cardNameImage1Array[0]}.png',
                                                    fit: BoxFit.cover),
                                              )))
                                      : Image.asset(
                                          'assets/lucky7/images/cardBg.png',
                                          height: height * 0.15,
                                          width: width * 0.05,
                                          fit: BoxFit.fill,
                                        ),
                                  SizedBox(width: width * 0.01),
                                  cardNameImage1Array.length > 9
                                      ? FlipCard(
                                          flipOnTouch: false,
                                          autoFlipDuration:
                                              Duration(seconds: 1),
                                          front: Image.asset(
                                            'assets/lucky7/images/cardBg.png',
                                            height: height * 0.15,
                                            width: width * 0.05,
                                            fit: BoxFit.fill,
                                          ),
                                          back: SizedBox(
                                              height: height * 0.15,
                                              width: width * 0.05,
                                              child: ClipRRect(
                                                borderRadius:
                                                    BorderRadius.circular(2.5),
                                                child: Image.network(
                                                    'http://admin.kalyanexch.com/images/cards/${cardNameImage1Array[9]}.png',
                                                    fit: BoxFit.cover),
                                              )))
                                      : Image.asset(
                                          'assets/lucky7/images/cardBg.png',
                                          height: height * 0.15,
                                          width: width * 0.05,
                                          fit: BoxFit.fill,
                                        ),
                                  SizedBox(width: width * 0.01),
                                  cardNameImage1Array.length > 18
                                      ? FlipCard(
                                          flipOnTouch: false,
                                          autoFlipDuration:
                                              Duration(seconds: 1),
                                          front: Image.asset(
                                            'assets/lucky7/images/cardBg.png',
                                            height: height * 0.15,
                                            width: width * 0.05,
                                            fit: BoxFit.fill,
                                          ),
                                          back: SizedBox(
                                              height: height * 0.15,
                                              width: width * 0.05,
                                              child: ClipRRect(
                                                borderRadius:
                                                    BorderRadius.circular(2.5),
                                                child: Image.network(
                                                    'http://admin.kalyanexch.com/images/cards/${cardNameImage1Array[18]}.png',
                                                    fit: BoxFit.cover),
                                              )))
                                      : Image.asset(
                                          'assets/lucky7/images/cardBg.png',
                                          height: height * 0.15,
                                          width: width * 0.05,
                                          fit: BoxFit.fill,
                                        ),
                                ],
                              ),
                              SizedBox(height: height * 0.05),
                              marketId == marketIdWinner
                                  ? Container(
                                      padding: EdgeInsets.symmetric(
                                          horizontal: width * 0.075,
                                          vertical: height * 0.0065),
                                      decoration: BoxDecoration(
                                          color: winnerArray[0] == 'L'
                                              ? Color(0xffFF0000)
                                              : Color(0xff008000)),
                                      child: Text(
                                        'PLAYER 1',
                                        style: TextStyle(
                                            // fontFamily: 'Inter',
                                            fontSize: 9,
                                            fontWeight: FontWeight.w500,
                                            color: Colors.white),
                                      ),
                                    )
                                  : Text(
                                      'PLAYER 1',
                                      style: TextStyle(
                                          // fontFamily: 'Inter',
                                          fontSize: 9,
                                          fontWeight: FontWeight.w500,
                                          color: Colors.white),
                                    ),
                            ],
                          ),
                        )
                      ],
                    ),
                    Stack(
                      children: [
                        Container(
                          height: height * 0.3,
                          width: width * 0.2,
                          padding: EdgeInsets.all(10),
                          alignment: Alignment.topCenter,
                          decoration: BoxDecoration(
                            image: DecorationImage(
                                fit: BoxFit.fill,
                                image: AssetImage(
                                    'assets/vertual_teen_patti/Group 1707.png')),
                          ),
                        ),
                        Positioned(
                          top: height * 0.04,
                          left: marketIdWinner == marketId
                              ? width * 0.003
                              : width * 0.015,
                          child: Column(
                            children: [
                              Row(children: [
                                cardNameImage1Array.length > 1
                                    ? FlipCard(
                                        flipOnTouch: false,
                                        autoFlipDuration: Duration(seconds: 1),
                                        front: Image.asset(
                                          'assets/lucky7/images/cardBg.png',
                                          height: height * 0.15,
                                          width: width * 0.05,
                                          fit: BoxFit.fill,
                                        ),
                                        back: SizedBox(
                                            height: height * 0.15,
                                            width: width * 0.05,
                                            child: ClipRRect(
                                              borderRadius:
                                                  BorderRadius.circular(2.5),
                                              child: Image.network(
                                                  'http://admin.kalyanexch.com/images/cards/${cardNameImage1Array[1]}.png',
                                                  fit: BoxFit.cover),
                                            )))
                                    : Image.asset(
                                        'assets/lucky7/images/cardBg.png',
                                        height: height * 0.15,
                                        width: width * 0.05,
                                        fit: BoxFit.fill,
                                      ),
                                SizedBox(width: width * 0.01),
                                cardNameImage1Array.length > 10
                                    ? FlipCard(
                                        flipOnTouch: false,
                                        autoFlipDuration: Duration(seconds: 1),
                                        front: Image.asset(
                                          'assets/lucky7/images/cardBg.png',
                                          height: height * 0.15,
                                          width: width * 0.05,
                                          fit: BoxFit.fill,
                                        ),
                                        back: SizedBox(
                                            height: height * 0.15,
                                            width: width * 0.05,
                                            child: ClipRRect(
                                              borderRadius:
                                                  BorderRadius.circular(2.5),
                                              child: Image.network(
                                                  'http://admin.kalyanexch.com/images/cards/${cardNameImage1Array[10]}.png',
                                                  fit: BoxFit.cover),
                                            )))
                                    : Image.asset(
                                        'assets/lucky7/images/cardBg.png',
                                        height: height * 0.15,
                                        width: width * 0.05,
                                        fit: BoxFit.fill,
                                      ),
                                SizedBox(width: width * 0.01),
                                cardNameImage1Array.length > 19
                                    ? FlipCard(
                                        flipOnTouch: false,
                                        autoFlipDuration: Duration(seconds: 1),
                                        front: Image.asset(
                                          'assets/lucky7/images/cardBg.png',
                                          height: height * 0.15,
                                          width: width * 0.05,
                                          fit: BoxFit.fill,
                                        ),
                                        back: SizedBox(
                                            height: height * 0.15,
                                            width: width * 0.05,
                                            child: ClipRRect(
                                              borderRadius:
                                                  BorderRadius.circular(2.5),
                                              child: Image.network(
                                                  'http://admin.kalyanexch.com/images/cards/${cardNameImage1Array[19]}.png',
                                                  fit: BoxFit.cover),
                                            )))
                                    : Image.asset(
                                        'assets/lucky7/images/cardBg.png',
                                        height: height * 0.15,
                                        width: width * 0.05,
                                        fit: BoxFit.fill,
                                      ),
                              ]),
                              SizedBox(height: height * 0.05),
                              marketId == marketIdWinner
                                  ? Container(
                                      padding: EdgeInsets.symmetric(
                                          horizontal: width * 0.073,
                                          vertical: height * 0.0065),
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(2),
                                          color: winnerArray[1] == 'L'
                                              ? Color(0xffFF0000)
                                              : Color(0xff008000)),
                                      child: Text(
                                        'PLAYER 2',
                                        style: TextStyle(
                                            // fontFamily: 'Inter',
                                            fontSize: 9,
                                            fontWeight: FontWeight.w500,
                                            color: Colors.white),
                                      ),
                                    )
                                  : Text(
                                      'PLAYER 2',
                                      style: TextStyle(
                                          // fontFamily: 'Inter',
                                          fontSize: 9,
                                          fontWeight: FontWeight.w500,
                                          color: Colors.white),
                                    ),
                            ],
                          ),
                        )
                      ],
                    ),
                    Stack(
                      children: [
                        Container(
                          height: height * 0.3,
                          width: width * 0.2,
                          padding: EdgeInsets.all(10),
                          alignment: Alignment.topCenter,
                          decoration: BoxDecoration(
                            image: DecorationImage(
                                fit: BoxFit.fill,
                                image: AssetImage(
                                    'assets/vertual_teen_patti/Group 1707.png')),
                          ),
                        ),
                        Positioned(
                          top: height * 0.04,
                          left: marketIdWinner == marketId
                              ? width * 0.003
                              : width * 0.015,
                          child: Column(
                            children: [
                              Row(children: [
                                cardNameImage1Array.length > 2
                                    ? FlipCard(
                                        flipOnTouch: false,
                                        autoFlipDuration: Duration(seconds: 1),
                                        front: Image.asset(
                                          'assets/lucky7/images/cardBg.png',
                                          height: height * 0.15,
                                          width: width * 0.05,
                                          fit: BoxFit.fill,
                                        ),
                                        back: SizedBox(
                                            height: height * 0.15,
                                            width: width * 0.05,
                                            child: ClipRRect(
                                              borderRadius:
                                                  BorderRadius.circular(2.5),
                                              child: Image.network(
                                                  'http://admin.kalyanexch.com/images/cards/${cardNameImage1Array[2]}.png',
                                                  fit: BoxFit.cover),
                                            )))
                                    : Image.asset(
                                        'assets/lucky7/images/cardBg.png',
                                        height: height * 0.15,
                                        width: width * 0.05,
                                        fit: BoxFit.fill,
                                      ),
                                SizedBox(width: width * 0.01),
                                cardNameImage1Array.length > 11
                                    ? FlipCard(
                                        flipOnTouch: false,
                                        autoFlipDuration: Duration(seconds: 1),
                                        front: Image.asset(
                                          'assets/lucky7/images/cardBg.png',
                                          height: height * 0.15,
                                          width: width * 0.05,
                                          fit: BoxFit.fill,
                                        ),
                                        back: SizedBox(
                                            height: height * 0.15,
                                            width: width * 0.05,
                                            child: ClipRRect(
                                              borderRadius:
                                                  BorderRadius.circular(2.5),
                                              child: Image.network(
                                                  'http://admin.kalyanexch.com/images/cards/${cardNameImage1Array[11]}.png',
                                                  fit: BoxFit.cover),
                                            )))
                                    : Image.asset(
                                        'assets/lucky7/images/cardBg.png',
                                        height: height * 0.15,
                                        width: width * 0.05,
                                        fit: BoxFit.fill,
                                      ),
                                SizedBox(width: width * 0.01),
                                cardNameImage1Array.length > 20
                                    ? FlipCard(
                                        flipOnTouch: false,
                                        autoFlipDuration: Duration(seconds: 1),
                                        front: Image.asset(
                                          'assets/lucky7/images/cardBg.png',
                                          height: height * 0.15,
                                          width: width * 0.05,
                                          fit: BoxFit.fill,
                                        ),
                                        back: SizedBox(
                                            height: height * 0.15,
                                            width: width * 0.05,
                                            child: ClipRRect(
                                              borderRadius:
                                                  BorderRadius.circular(2.5),
                                              child: Image.network(
                                                  'http://admin.kalyanexch.com/images/cards/${cardNameImage1Array[20]}.png',
                                                  fit: BoxFit.cover),
                                            )))
                                    : Image.asset(
                                        'assets/lucky7/images/cardBg.png',
                                        height: height * 0.15,
                                        width: width * 0.05,
                                        fit: BoxFit.fill,
                                      ),
                              ]),
                              SizedBox(height: height * 0.05),
                              marketId == marketIdWinner
                                  ? Container(
                                      padding: EdgeInsets.symmetric(
                                          horizontal: width * 0.073,
                                          vertical: height * 0.0065),
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(2),
                                          color: winnerArray[2] == 'L'
                                              ? Color(0xffFF0000)
                                              : Color(0xff008000)),
                                      child: Text(
                                        'PLAYER 3',
                                        style: TextStyle(
                                            // fontFamily: 'Inter',
                                            fontSize: 9,
                                            fontWeight: FontWeight.w500,
                                            color: Colors.white),
                                      ),
                                    )
                                  : Text(
                                      'PLAYER 3',
                                      style: TextStyle(
                                          // fontFamily: 'Inter',
                                          fontSize: 9,
                                          fontWeight: FontWeight.w500,
                                          color: Colors.white),
                                    ),
                            ],
                          ),
                        )
                      ],
                    ),
                  ],
                ),
                SizedBox(
                  height: height * 0.03,
                ),
                Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Stack(
                        children: [
                          Container(
                            height: height * 0.3,
                            width: width * 0.2,
                            padding: EdgeInsets.all(10),
                            alignment: Alignment.topCenter,
                            decoration: BoxDecoration(
                              image: DecorationImage(
                                  fit: BoxFit.fill,
                                  image: AssetImage(
                                      'assets/vertual_teen_patti/Group 1707.png')),
                            ),
                          ),
                          Positioned(
                            top: height * 0.04,
                            left: marketIdWinner == marketId
                                ? width * 0.003
                                : width * 0.015,
                            child: Column(
                              children: [
                                Row(children: [
                                  // SizedBox(width: 5),
                                  cardNameImage1Array.length > 3
                                      ? FlipCard(
                                          flipOnTouch: false,
                                          autoFlipDuration:
                                              Duration(seconds: 1),
                                          front: Image.asset(
                                            'assets/lucky7/images/cardBg.png',
                                            height: height * 0.15,
                                            width: width * 0.05,
                                            fit: BoxFit.fill,
                                          ),
                                          back: SizedBox(
                                              height: height * 0.15,
                                              width: width * 0.05,
                                              child: ClipRRect(
                                                borderRadius:
                                                    BorderRadius.circular(2.5),
                                                child: Image.network(
                                                    'http://admin.kalyanexch.com/images/cards/${cardNameImage1Array[3]}.png',
                                                    fit: BoxFit.cover),
                                              )))
                                      : Image.asset(
                                          'assets/lucky7/images/cardBg.png',
                                          height: height * 0.15,
                                          width: width * 0.05,
                                          fit: BoxFit.fill,
                                        ),
                                  SizedBox(width: width * 0.01),
                                  cardNameImage1Array.length > 12
                                      ? FlipCard(
                                          flipOnTouch: false,
                                          autoFlipDuration:
                                              Duration(seconds: 1),
                                          front: Image.asset(
                                            'assets/lucky7/images/cardBg.png',
                                            height: height * 0.15,
                                            width: width * 0.05,
                                            fit: BoxFit.fill,
                                          ),
                                          back: SizedBox(
                                              height: height * 0.15,
                                              width: width * 0.05,
                                              child: ClipRRect(
                                                borderRadius:
                                                    BorderRadius.circular(2.5),
                                                child: Image.network(
                                                    'http://admin.kalyanexch.com/images/cards/${cardNameImage1Array[12]}.png',
                                                    fit: BoxFit.cover),
                                              )))
                                      : Image.asset(
                                          'assets/lucky7/images/cardBg.png',
                                          height: height * 0.15,
                                          width: width * 0.05,
                                          fit: BoxFit.fill,
                                        ),
                                  SizedBox(width: width * 0.01),
                                  cardNameImage1Array.length > 21
                                      ? FlipCard(
                                          flipOnTouch: false,
                                          autoFlipDuration:
                                              Duration(seconds: 1),
                                          front: Image.asset(
                                            'assets/lucky7/images/cardBg.png',
                                            height: height * 0.15,
                                            width: width * 0.05,
                                            fit: BoxFit.fill,
                                          ),
                                          back: SizedBox(
                                              height: height * 0.15,
                                              width: width * 0.05,
                                              child: ClipRRect(
                                                borderRadius:
                                                    BorderRadius.circular(2.5),
                                                child: Image.network(
                                                    'http://admin.kalyanexch.com/images/cards/${cardNameImage1Array[21]}.png',
                                                    fit: BoxFit.cover),
                                              )))
                                      : Image.asset(
                                          'assets/lucky7/images/cardBg.png',
                                          height: height * 0.15,
                                          width: width * 0.05,
                                          fit: BoxFit.fill,
                                        ),
                                ]),
                                SizedBox(height: height * 0.05),
                                marketId == marketIdWinner
                                    ? Container(
                                        padding: EdgeInsets.symmetric(
                                            horizontal: width * 0.073,
                                            vertical: height * 0.0065),
                                        decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(2),
                                            color: winnerArray[3] == 'L'
                                                ? Color(0xffFF0000)
                                                : Color(0xff008000)),
                                        child: Text(
                                          'PLAYER 4',
                                          style: TextStyle(
                                              // fontFamily: 'Inter',
                                              fontSize: 9,
                                              fontWeight: FontWeight.w500,
                                              color: Colors.white),
                                        ),
                                      )
                                    : Text(
                                        'PLAYER 4',
                                        style: TextStyle(
                                            // fontFamily: 'Inter',
                                            fontSize: 9,
                                            fontWeight: FontWeight.w500,
                                            color: Colors.white),
                                      ),
                              ],
                            ),
                          )
                        ],
                      ),
                      Stack(
                        children: [
                          Container(
                            height: height * 0.3,
                            width: width * 0.2,
                            padding: EdgeInsets.all(10),
                            alignment: Alignment.topCenter,
                            decoration: BoxDecoration(
                              image: DecorationImage(
                                  fit: BoxFit.fill,
                                  image: AssetImage(
                                      'assets/vertual_teen_patti/Group 1707.png')),
                            ),
                          ),
                          Positioned(
                            top: height * 0.04,
                            left: marketIdWinner == marketId
                                ? width * 0.003
                                : width * 0.015,
                            child: Column(
                              children: [
                                Row(children: [
                                  cardNameImage1Array.length > 4
                                      ? FlipCard(
                                          flipOnTouch: false,
                                          autoFlipDuration:
                                              Duration(seconds: 1),
                                          front: Image.asset(
                                            'assets/lucky7/images/cardBg.png',
                                            height: height * 0.15,
                                            width: width * 0.05,
                                            fit: BoxFit.fill,
                                          ),
                                          back: SizedBox(
                                              height: height * 0.15,
                                              width: width * 0.05,
                                              child: ClipRRect(
                                                borderRadius:
                                                    BorderRadius.circular(2.5),
                                                child: Image.network(
                                                    'http://admin.kalyanexch.com/images/cards/${cardNameImage1Array[4]}.png',
                                                    fit: BoxFit.cover),
                                              )))
                                      : Image.asset(
                                          'assets/lucky7/images/cardBg.png',
                                          height: height * 0.15,
                                          width: width * 0.05,
                                          fit: BoxFit.fill,
                                        ),
                                  SizedBox(width: width * 0.01),
                                  cardNameImage1Array.length > 13
                                      ? FlipCard(
                                          flipOnTouch: false,
                                          autoFlipDuration:
                                              Duration(seconds: 1),
                                          front: Image.asset(
                                            'assets/lucky7/images/cardBg.png',
                                            height: height * 0.15,
                                            width: width * 0.05,
                                            fit: BoxFit.fill,
                                          ),
                                          back: SizedBox(
                                              height: height * 0.15,
                                              width: width * 0.05,
                                              child: ClipRRect(
                                                borderRadius:
                                                    BorderRadius.circular(2.5),
                                                child: Image.network(
                                                    'http://admin.kalyanexch.com/images/cards/${cardNameImage1Array[13]}.png',
                                                    fit: BoxFit.cover),
                                              )))
                                      : Image.asset(
                                          'assets/lucky7/images/cardBg.png',
                                          height: height * 0.15,
                                          width: width * 0.05,
                                          fit: BoxFit.fill,
                                        ),
                                  SizedBox(width: width * 0.01),
                                  cardNameImage1Array.length > 22
                                      ? FlipCard(
                                          flipOnTouch: false,
                                          autoFlipDuration:
                                              Duration(seconds: 1),
                                          front: Image.asset(
                                            'assets/lucky7/images/cardBg.png',
                                            height: height * 0.15,
                                            width: width * 0.05,
                                            fit: BoxFit.fill,
                                          ),
                                          back: SizedBox(
                                              height: height * 0.15,
                                              width: width * 0.05,
                                              child: ClipRRect(
                                                borderRadius:
                                                    BorderRadius.circular(2.5),
                                                child: Image.network(
                                                    'http://admin.kalyanexch.com/images/cards/${cardNameImage1Array[22]}.png',
                                                    fit: BoxFit.cover),
                                              )))
                                      : Image.asset(
                                          'assets/lucky7/images/cardBg.png',
                                          height: height * 0.15,
                                          width: width * 0.05,
                                          fit: BoxFit.fill,
                                        ),
                                ]),
                                SizedBox(height: height * 0.05),
                                marketId == marketIdWinner
                                    ? Container(
                                        padding: EdgeInsets.symmetric(
                                            horizontal: width * 0.073,
                                            vertical: height * 0.0065),
                                        decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(2),
                                            color: winnerArray[4] == 'L'
                                                ? Color(0xffFF0000)
                                                : Color(0xff008000)),
                                        child: Text(
                                          'PLAYER 5',
                                          style: TextStyle(
                                              // fontFamily: 'Inter',
                                              fontSize: 9,
                                              fontWeight: FontWeight.w500,
                                              color: Colors.white),
                                        ),
                                      )
                                    : Text(
                                        'PLAYER 5',
                                        style: TextStyle(
                                            // fontFamily: 'Inter',
                                            fontSize: 9,
                                            fontWeight: FontWeight.w500,
                                            color: Colors.white),
                                      ),
                              ],
                            ),
                          )
                        ],
                      ),
                      Stack(
                        children: [
                          Container(
                            height: height * 0.3,
                            width: width * 0.2,
                            padding: EdgeInsets.all(10),
                            alignment: Alignment.topCenter,
                            decoration: BoxDecoration(
                              image: DecorationImage(
                                  fit: BoxFit.fill,
                                  image: AssetImage(
                                      'assets/vertual_teen_patti/Group 1707.png')),
                            ),
                          ),
                          Positioned(
                            top: height * 0.04,
                            left: marketIdWinner == marketId
                                ? width * 0.003
                                : width * 0.015,
                            child: Column(
                              children: [
                                Row(children: [
                                  cardNameImage1Array.length > 5
                                      ? FlipCard(
                                          flipOnTouch: false,
                                          autoFlipDuration:
                                              Duration(seconds: 1),
                                          front: Image.asset(
                                            'assets/lucky7/images/cardBg.png',
                                            height: height * 0.15,
                                            width: width * 0.05,
                                            fit: BoxFit.fill,
                                          ),
                                          back: SizedBox(
                                              height: height * 0.15,
                                              width: width * 0.05,
                                              child: ClipRRect(
                                                borderRadius:
                                                    BorderRadius.circular(2.5),
                                                child: Image.network(
                                                    'http://admin.kalyanexch.com/images/cards/${cardNameImage1Array[5]}.png',
                                                    fit: BoxFit.cover),
                                              )))
                                      : Image.asset(
                                          'assets/lucky7/images/cardBg.png',
                                          height: height * 0.15,
                                          width: width * 0.05,
                                          fit: BoxFit.fill,
                                        ),
                                  SizedBox(width: width * 0.01),
                                  cardNameImage1Array.length > 14
                                      ? FlipCard(
                                          flipOnTouch: false,
                                          autoFlipDuration:
                                              Duration(seconds: 1),
                                          front: Image.asset(
                                            'assets/lucky7/images/cardBg.png',
                                            height: height * 0.15,
                                            width: width * 0.05,
                                            fit: BoxFit.fill,
                                          ),
                                          back: SizedBox(
                                              height: height * 0.15,
                                              width: width * 0.05,
                                              child: ClipRRect(
                                                borderRadius:
                                                    BorderRadius.circular(2.5),
                                                child: Image.network(
                                                    'http://admin.kalyanexch.com/images/cards/${cardNameImage1Array[14]}.png',
                                                    fit: BoxFit.cover),
                                              )))
                                      : Image.asset(
                                          'assets/lucky7/images/cardBg.png',
                                          height: height * 0.15,
                                          width: width * 0.05,
                                          fit: BoxFit.fill,
                                        ),
                                  SizedBox(width: width * 0.01),
                                  cardNameImage1Array.length > 23
                                      ? FlipCard(
                                          flipOnTouch: false,
                                          autoFlipDuration:
                                              Duration(seconds: 1),
                                          front: Image.asset(
                                            'assets/lucky7/images/cardBg.png',
                                            height: height * 0.15,
                                            width: width * 0.05,
                                            fit: BoxFit.fill,
                                          ),
                                          back: SizedBox(
                                              height: height * 0.15,
                                              width: width * 0.05,
                                              child: ClipRRect(
                                                borderRadius:
                                                    BorderRadius.circular(2.5),
                                                child: Image.network(
                                                    'http://admin.kalyanexch.com/images/cards/${cardNameImage1Array[23]}.png',
                                                    fit: BoxFit.cover),
                                              )))
                                      : Image.asset(
                                          'assets/lucky7/images/cardBg.png',
                                          height: height * 0.15,
                                          width: width * 0.05,
                                          fit: BoxFit.fill,
                                        ),
                                ]),
                                SizedBox(height: height * 0.05),
                                marketId == marketIdWinner
                                    ? Container(
                                        padding: EdgeInsets.symmetric(
                                            horizontal: width * 0.073,
                                            vertical: height * 0.0065),
                                        decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(2),
                                            color: winnerArray[5] == 'L'
                                                ? Color(0xffFF0000)
                                                : Color(0xff008000)),
                                        child: Text(
                                          'PLAYER 6',
                                          style: TextStyle(
                                              // fontFamily: 'Inter',
                                              fontSize: 9,
                                              fontWeight: FontWeight.w500,
                                              color: Colors.white),
                                        ),
                                      )
                                    : Text(
                                        'PLAYER 6',
                                        style: TextStyle(
                                            // fontFamily: 'Inter',
                                            fontSize: 9,
                                            fontWeight: FontWeight.w500,
                                            color: Colors.white),
                                      ),
                              ],
                            ),
                          )
                        ],
                      ),
                    ]),
                SizedBox(
                  height: height * 0.03,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Stack(
                      children: [
                        Container(
                          height: height * 0.3,
                          width: width * 0.2,
                          padding: EdgeInsets.all(10),
                          alignment: Alignment.topCenter,
                          decoration: BoxDecoration(
                            image: DecorationImage(
                                fit: BoxFit.fill,
                                image: AssetImage(
                                    'assets/vertual_teen_patti/Group 1707.png')),
                          ),
                        ),
                        Positioned(
                          top: height * 0.04,
                          left: marketIdWinner == marketId
                              ? width * 0.003
                              : width * 0.015,
                          child: Column(
                            children: [
                              Row(children: [
                                cardNameImage1Array.length > 6
                                    ? FlipCard(
                                        flipOnTouch: false,
                                        autoFlipDuration: Duration(seconds: 1),
                                        front: Image.asset(
                                          'assets/lucky7/images/cardBg.png',
                                          height: height * 0.15,
                                          width: width * 0.05,
                                          fit: BoxFit.fill,
                                        ),
                                        back: SizedBox(
                                            height: height * 0.15,
                                            width: width * 0.05,
                                            child: ClipRRect(
                                              borderRadius:
                                                  BorderRadius.circular(2.5),
                                              child: Image.network(
                                                  'http://admin.kalyanexch.com/images/cards/${cardNameImage1Array[6]}.png',
                                                  fit: BoxFit.cover),
                                            )))
                                    : Image.asset(
                                        'assets/lucky7/images/cardBg.png',
                                        height: height * 0.15,
                                        width: width * 0.05,
                                        fit: BoxFit.fill,
                                      ),
                                SizedBox(width: width * 0.01),
                                cardNameImage1Array.length > 15
                                    ? FlipCard(
                                        flipOnTouch: false,
                                        autoFlipDuration: Duration(seconds: 1),
                                        front: Image.asset(
                                          'assets/lucky7/images/cardBg.png',
                                          height: height * 0.15,
                                          width: width * 0.05,
                                          fit: BoxFit.fill,
                                        ),
                                        back: SizedBox(
                                            height: height * 0.15,
                                            width: width * 0.05,
                                            child: ClipRRect(
                                              borderRadius:
                                                  BorderRadius.circular(2.5),
                                              child: Image.network(
                                                  'http://admin.kalyanexch.com/images/cards/${cardNameImage1Array[15]}.png',
                                                  fit: BoxFit.cover),
                                            )))
                                    : Image.asset(
                                        'assets/lucky7/images/cardBg.png',
                                        height: height * 0.15,
                                        width: width * 0.05,
                                        fit: BoxFit.fill,
                                      ),
                                SizedBox(width: width * 0.01),
                                cardNameImage1Array.length > 24
                                    ? FlipCard(
                                        flipOnTouch: false,
                                        autoFlipDuration: Duration(seconds: 1),
                                        front: Image.asset(
                                          'assets/lucky7/images/cardBg.png',
                                          height: height * 0.15,
                                          width: width * 0.05,
                                          fit: BoxFit.fill,
                                        ),
                                        back: SizedBox(
                                            height: height * 0.15,
                                            width: width * 0.05,
                                            child: ClipRRect(
                                              borderRadius:
                                                  BorderRadius.circular(2.5),
                                              child: Image.network(
                                                  'http://admin.kalyanexch.com/images/cards/${cardNameImage1Array[24]}.png',
                                                  fit: BoxFit.cover),
                                            )))
                                    : Image.asset(
                                        'assets/lucky7/images/cardBg.png',
                                        height: height * 0.15,
                                        width: width * 0.05,
                                        fit: BoxFit.fill,
                                      ),
                              ]),
                              SizedBox(height: height * 0.05),
                              marketId == marketIdWinner
                                  ? Container(
                                      padding: EdgeInsets.symmetric(
                                          horizontal: width * 0.073,
                                          vertical: height * 0.0065),
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(2),
                                          color: winnerArray[6] == 'L'
                                              ? Color(0xffFF0000)
                                              : Color(0xff008000)),
                                      child: Text(
                                        'PLAYER 7',
                                        style: TextStyle(
                                            // fontFamily: 'Inter',
                                            fontSize: 9,
                                            fontWeight: FontWeight.w500,
                                            color: Colors.white),
                                      ),
                                    )
                                  : Text(
                                      'PLAYER 7',
                                      style: TextStyle(
                                          // fontFamily: 'Inter',
                                          fontSize: 9,
                                          fontWeight: FontWeight.w500,
                                          color: Colors.white),
                                    ),
                            ],
                          ),
                        )
                      ],
                    ),
                    Stack(
                      children: [
                        Container(
                          height: height * 0.3,
                          width: width * 0.2,
                          padding: EdgeInsets.all(10),
                          alignment: Alignment.topCenter,
                          decoration: BoxDecoration(
                            image: DecorationImage(
                                fit: BoxFit.fill,
                                image: AssetImage(
                                    'assets/vertual_teen_patti/Group 1707.png')),
                          ),
                        ),
                        Positioned(
                          top: height * 0.04,
                          left: marketIdWinner == marketId
                              ? width * 0.003
                              : width * 0.015,
                          child: Column(
                            children: [
                              Row(children: [
                                cardNameImage1Array.length > 7
                                    ? FlipCard(
                                        flipOnTouch: false,
                                        autoFlipDuration: Duration(seconds: 1),
                                        front: Image.asset(
                                          'assets/lucky7/images/cardBg.png',
                                          height: height * 0.15,
                                          width: width * 0.05,
                                          fit: BoxFit.fill,
                                        ),
                                        back: SizedBox(
                                            height: height * 0.15,
                                            width: width * 0.05,
                                            child: ClipRRect(
                                              borderRadius:
                                                  BorderRadius.circular(2.5),
                                              child: Image.network(
                                                  'http://admin.kalyanexch.com/images/cards/${cardNameImage1Array[7]}.png',
                                                  fit: BoxFit.cover),
                                            )))
                                    : Image.asset(
                                        'assets/lucky7/images/cardBg.png',
                                        height: height * 0.15,
                                        width: width * 0.05,
                                        fit: BoxFit.fill,
                                      ),
                                SizedBox(width: width * 0.01),
                                cardNameImage1Array.length > 16
                                    ? FlipCard(
                                        flipOnTouch: false,
                                        autoFlipDuration: Duration(seconds: 1),
                                        front: Image.asset(
                                          'assets/lucky7/images/cardBg.png',
                                          height: height * 0.15,
                                          width: width * 0.05,
                                          fit: BoxFit.fill,
                                        ),
                                        back: SizedBox(
                                            height: height * 0.15,
                                            width: width * 0.05,
                                            child: ClipRRect(
                                              borderRadius:
                                                  BorderRadius.circular(2.5),
                                              child: Image.network(
                                                  'http://admin.kalyanexch.com/images/cards/${cardNameImage1Array[16]}.png',
                                                  fit: BoxFit.cover),
                                            )))
                                    : Image.asset(
                                        'assets/lucky7/images/cardBg.png',
                                        height: height * 0.15,
                                        width: width * 0.05,
                                        fit: BoxFit.fill,
                                      ),
                                SizedBox(width: width * 0.01),
                                cardNameImage1Array.length > 25
                                    ? FlipCard(
                                        flipOnTouch: false,
                                        autoFlipDuration: Duration(seconds: 1),
                                        front: Image.asset(
                                          'assets/lucky7/images/cardBg.png',
                                          height: height * 0.15,
                                          width: width * 0.05,
                                          fit: BoxFit.fill,
                                        ),
                                        back: SizedBox(
                                            height: height * 0.15,
                                            width: width * 0.05,
                                            child: ClipRRect(
                                              borderRadius:
                                                  BorderRadius.circular(2.5),
                                              child: Image.network(
                                                  'http://admin.kalyanexch.com/images/cards/${cardNameImage1Array[25]}.png',
                                                  fit: BoxFit.cover),
                                            )))
                                    : Image.asset(
                                        'assets/lucky7/images/cardBg.png',
                                        height: height * 0.15,
                                        width: width * 0.05,
                                        fit: BoxFit.fill,
                                      ),
                              ]),
                              SizedBox(height: height * 0.05),
                              marketId == marketIdWinner
                                  ? Container(
                                      padding: EdgeInsets.symmetric(
                                          horizontal: width * 0.073,
                                          vertical: height * 0.0065),
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(2),
                                          color: winnerArray[7] == 'L'
                                              ? Color(0xffFF0000)
                                              : Color(0xff008000)),
                                      child: Text(
                                        'PLAYER 8',
                                        style: TextStyle(
                                            // fontFamily: 'Inter',
                                            fontSize: 9,
                                            fontWeight: FontWeight.w500,
                                            color: Colors.white),
                                      ),
                                    )
                                  : Text(
                                      'PLAYER 8',
                                      style: TextStyle(
                                          // fontFamily: 'Inter',
                                          fontSize: 9,
                                          fontWeight: FontWeight.w500,
                                          color: Colors.white),
                                    ),
                            ],
                          ),
                        )
                      ],
                    ),
                    Stack(
                      children: [
                        Container(
                          height: height * 0.3,
                          width: width * 0.2,
                          padding: EdgeInsets.all(10),
                          alignment: Alignment.topCenter,
                          decoration: BoxDecoration(
                            image: DecorationImage(
                                fit: BoxFit.fill,
                                image: AssetImage(
                                    'assets/vertual_teen_patti/Group 1708.png')),
                          ),
                        ),
                        Positioned(
                          top: height * 0.04,
                          left: width * 0.015,
                          child: Column(
                            children: [
                              Row(children: [
                                cardNameImage1Array.length > 8
                                    ? FlipCard(
                                        flipOnTouch: false,
                                        autoFlipDuration: Duration(seconds: 1),
                                        front: Image.asset(
                                          'assets/lucky7/images/cardBg.png',
                                          height: height * 0.15,
                                          width: width * 0.05,
                                          fit: BoxFit.fill,
                                        ),
                                        back: SizedBox(
                                            height: height * 0.15,
                                            width: width * 0.05,
                                            child: ClipRRect(
                                              borderRadius:
                                                  BorderRadius.circular(2.5),
                                              child: Image.network(
                                                  'http://admin.kalyanexch.com/images/cards/${cardNameImage1Array[8]}.png',
                                                  fit: BoxFit.cover),
                                            )))
                                    : Image.asset(
                                        'assets/lucky7/images/cardBg.png',
                                        height: height * 0.15,
                                        width: width * 0.05,
                                        fit: BoxFit.fill,
                                      ),
                                SizedBox(width: width * 0.01),
                                cardNameImage1Array.length > 17
                                    ? FlipCard(
                                        flipOnTouch: false,
                                        autoFlipDuration: Duration(seconds: 1),
                                        front: Image.asset(
                                          'assets/lucky7/images/cardBg.png',
                                          height: height * 0.15,
                                          width: width * 0.05,
                                          fit: BoxFit.fill,
                                        ),
                                        back: SizedBox(
                                            height: height * 0.15,
                                            width: width * 0.05,
                                            child: ClipRRect(
                                              borderRadius:
                                                  BorderRadius.circular(2.5),
                                              child: Image.network(
                                                  'http://admin.kalyanexch.com/images/cards/${cardNameImage1Array[17]}.png',
                                                  fit: BoxFit.cover),
                                            )))
                                    : Image.asset(
                                        'assets/lucky7/images/cardBg.png',
                                        height: height * 0.15,
                                        width: width * 0.05,
                                        fit: BoxFit.fill,
                                      ),
                                SizedBox(width: width * 0.01),
                                cardNameImage1Array.length > 26
                                    ? FlipCard(
                                        flipOnTouch: false,
                                        autoFlipDuration: Duration(seconds: 1),
                                        front: Image.asset(
                                          'assets/lucky7/images/cardBg.png',
                                          height: height * 0.15,
                                          width: width * 0.05,
                                          fit: BoxFit.fill,
                                        ),
                                        back: SizedBox(
                                            height: height * 0.15,
                                            width: width * 0.05,
                                            child: ClipRRect(
                                              borderRadius:
                                                  BorderRadius.circular(2.5),
                                              child: Image.network(
                                                  'http://admin.kalyanexch.com/images/cards/${cardNameImage1Array[26]}.png',
                                                  fit: BoxFit.cover),
                                            )))
                                    : Image.asset(
                                        'assets/lucky7/images/cardBg.png',
                                        height: height * 0.15,
                                        width: width * 0.05,
                                        fit: BoxFit.fill,
                                      ),
                              ]),
                            ],
                          ),
                        )
                      ],
                    ),
                  ],
                ),
              ],
            )
          ])),
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

 
  ///design reult button
  _bettButton(String text, Color color) {
    return Container(
      height: 18,
      width: 18,
      margin: const EdgeInsets.symmetric(vertical: 3),
      alignment: Alignment.center,
      decoration: BoxDecoration(shape: BoxShape.circle, color: color),
      child: Text(
        text,
        style: TextStyle(color: Colors.white, fontSize: 9),
      ),
    );
  }

  _bettButtonPort(String text, Color color) {
    return Container(
      height: 20,
      width: 20,
      margin: const EdgeInsets.symmetric(horizontal: 7),
      alignment: Alignment.center,
      decoration: BoxDecoration(shape: BoxShape.circle, color: color),
      child: Text(
        text,
        style: TextStyle(color: Colors.white, fontSize: 10),
      ),
    );
  }

  ///place your bet widget in landscape mode
  Widget placeyourbetWidget(String time) {
    return autoTime == '59'
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

  ///stop betting widget in landscape mode
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

  ///3 2 1 go widget in landscape mode
  goWidget() {
    return Visibility(
      visible: autoTime == "3" || autoTime == "2" || autoTime == "1",
      child: Lottie.asset("assets/Teen-patti/audio/countdown.json",
          height: height * 0.4, width: width),
    );
  }

  ///Main data api
  Future getCardData() async {
    var url = Apis.getCardDataOVTP;
    var response = await GlobalFunction.apiGetRequestae(url);
    var result = jsonDecode(response);
    if (result['status'] == true) {
       if (marketId != result['data']['t1'][0]['mid'].toString()) {
        _coins.clear();
        _coinsPort.clear();
        _coinsRytPort.clear();
      }
      setState(() {
        autoTime = result['data']['t1'][0]['autotime'].toString();
         if (startTimes != int.parse(autoTime.toString())) {
        startTimeSmall = startTimes * 100;
      }
        cardNameImage1 = result['data']['t1'][0]['C1'].toString();

        startTimes = int.parse(autoTime.toString());
        print("====>$autoTime");
        marketId = result['data']['t1'][0]['mid'].toString();
        player1 = result['data']['t2'][0]['nat'].toString();
        player2 = result['data']['t2'][1]['nat'].toString();
        player3 = result['data']['t2'][2]['nat'].toString();
        player4 = result['data']['t2'][3]['nat'].toString();
        player5 = result['data']['t2'][4]['nat'].toString();
        player6 = result['data']['t2'][5]['nat'].toString();
        player7 = result['data']['t2'][6]['nat'].toString();
        player8 = result['data']['t2'][7]['nat'].toString();

        player1Rate = result['data']['t2'][0]['rate'].toString();
        player2Rate = result['data']['t2'][1]['rate'].toString();
        player3Rate = result['data']['t2'][2]['rate'].toString();
        player4Rate = result['data']['t2'][3]['rate'].toString();
        player5Rate = result['data']['t2'][4]['rate'].toString();
        player6Rate = result['data']['t2'][5]['rate'].toString();
        player7Rate = result['data']['t2'][6]['rate'].toString();
        player8Rate = result['data']['t2'][7]['rate'].toString();

        player1Sid = result['data']['t2'][0]['sid'].toString();
        player2Sid = result['data']['t2'][1]['sid'].toString();
        player3Sid = result['data']['t2'][2]['sid'].toString();
        player4Sid = result['data']['t2'][3]['sid'].toString();
        player5Sid = result['data']['t2'][4]['sid'].toString();
        player6Sid = result['data']['t2'][5]['sid'].toString();
        player7Sid = result['data']['t2'][6]['sid'].toString();
        player8Sid = result['data']['t2'][7]['sid'].toString();
      });
      if (cardNameImage1 != "") {
        setState(() {
          cardNameImage1Array = cardNameImage1.split(",");

          print('hello');
          print("--------------->${cardNameImage1}");
          print("===============>$cardNameImage1Array");
          print("array length===============>${cardNameImage1Array.length}");
          print("mid data===============>${marketId}");
        });
      }

      autoTime == "0"
          ? setState(() {
              redCoinAnimation = false;
              lightGreenCoinAnimation = false;

              greenCoinAnimation = false;
              lightBlueCoinAnimation = false;
              brownCoinAnimation = false;
              player1Button = false;
              player2Button = false;
              player3Button = false;
              player4Button = false;
              player5Button = false;
              player6Button = false;
              player7Button = false;
              player8Button = false;
            })
          : SizedBox();
    }
  }

  ///result data api
  List<WinnerResultOPT> cardResultList = [];
  Future getResult() async {
    var url = Apis.getResultOVTP;
    var response = await GlobalFunction.apiGetRequestae(url);
    var result = jsonDecode(response);

    var list = result as List;

    setState(() {
      cardResultList.clear();
      var listdata = list.map((e) => WinnerResultOPT.fromJson(e)).toList();
      cardResultList.addAll(listdata);

      winner = result[0]['winner'].toString();
      winnerArray = winner.split(',');
      print('---------->winnerARRAY${winnerArray}');
      print('---------->winnerARRAY${winner}');

      marketIdWinner = result[0]['mid'].toString();
      cardNameImageWinner = result[0]['C1'].toString();
      cardNameImage1WinnerArray = cardNameImageWinner.split(',');
      print("mid winner===============>${marketIdWinner}");
    });
  }

  ///stake details api
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

        stack6 = result['data']['stack6'];
      });
    }
  }

  ///place your bet widget in protrait mode
  Widget placeyourbetWidgetPortrait(String time) {
    return autoTime == '59'
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

  ///stop betting widget in protrait mode
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

  ///3 2 1 go widget in protrait mode
  goWidgetPort() {
    return Visibility(
      visible: autoTime == "3" || autoTime == "2" || autoTime == "1",
      child: Lottie.asset("assets/lucky7/audio/countdown.json",
          height: height * 0.2, width: width),
    );
  }

  ///user balance api
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

//device ip
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

  ///make bet api in landscape mode
  Future makeBet() async {
    getUserDetails();
    DateTime currentTime = DateTime.now();
    var url = "http://13.250.53.81/VirtualCasinoBetPlacer/vc/place-bet";
    var body = {
      "casinoName": 1,
      "isBack": true,
      "odds": player1Button == true
          ? player1Rate
          : player2Button == true
              ? player2Rate
              : player3Button == true
                  ? player3Rate
                  : player4Button == true
                      ? player4Rate
                      : player5Button == true
                          ? player5Rate
                          : player6Button == true
                              ? player6Rate
                              : player7Button == true
                                  ? player7Rate
                                  : player8Button == true
                                      ? player8Rate
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
      "selectionId": player1Button == true
          ? player1Sid.toString()
          : player2Button == true
              ? player2Sid.toString()
              : player3Button == true
                  ? player3Sid.toString()
                  : player4Button == true
                      ? player4Sid.toString()
                      : player5Button == true
                          ? player5Sid.toString()
                          : player6Button == true
                              ? player6Sid.toString()
                              : player7Button == true
                                  ? player7Sid.toString()
                                  : player8Button == true
                                      ? player8Sid.toString()
                                      : SizedBox(),
      "placeTime": currentTime.toString(),
      "marketId": marketId.toString(),
      "matchId": 24,
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
        result['message'],playBackgroundMusic
      );

      setState(() {
        _currentCoinIndex++;
        _startCoinAnimation();
      });
     
      setState(() {
        manualAmount = false;
        stakeController.clear();
        player1Button = false;
        player2Button = false;
        player3Button = false;
        player4Button = false;
        player5Button = false;
        player6Button = false;
        player7Button = false;
        player8Button = false;
      });

      getVcLiablity();
    }else {
      manualAmount = false;
      stakeController.clear();
      DialogUtils.showOneBtn(
        context,
        result['message'],playBackgroundMusic
      );
    }

    stakeController.clear();
    manualAmount = false;
  
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
        liablity1 = result['data'][0]['liability']; //player1 sid-1
        liablity2 = result['data'][1]['liability']; // player2 sid2
        liablity3 = result['data'][2]['liability']; // player3 sid3
        liablity4 = result['data'][3]['liability']; // player4 sid4
        liablity5 = result['data'][4]['liability']; // player5 sid6
        liablity6 = result['data'][5]['liability']; // player6 sid7
        liablity7 = result['data'][6]['liability']; // player7 sid8
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

  ///match id details
  Future getMatchIdDetails() async {
    var url = Apis.matchId;
    var body = {"matchId": "24"};
    var response = await GlobalFunction.apiPostRequestToken(url, body);
    var result = jsonDecode(response);
    print("----------result match id ---------$result");
    if (result['status'] == true) {
      var list = result['data']['VOpen Teenpatti'] as List;
      matchIdList.clear();
      var listdata = list.map((e) => MatchIdModelOPT.fromJson(e)).toList();
      matchIdList.addAll(listdata);
    }
  }

  ///user details
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

  ///make bet api in protrait mode
  Future makeBetPortrait() async {
    getUserDetails();
    DateTime currentTime = DateTime.now();
    var url = "http://13.250.53.81/VirtualCasinoBetPlacer/vc/place-bet";
    var body = {
      "casinoName": 1,
      "isBack": true,
      "odds": player1Button == true
          ? player1Rate
          : player2Button == true
              ? player2Rate
              : player3Button == true
                  ? player3Rate
                  : player4Button == true
                      ? player4Rate
                      : player5Button == true
                          ? player5Rate
                          : player6Button == true
                              ? player6Rate
                              : player7Button == true
                                  ? player7Rate
                                  : player8Button == true
                                      ? player8Rate
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
      "selectionId": player1Button == true
          ? player1Sid.toString()
          : player2Button == true
              ? player2Sid.toString()
              : player3Button == true
                  ? player3Sid.toString()
                  : player4Button == true
                      ? player4Sid.toString()
                      : player5Button == true
                          ? player5Sid.toString()
                          : player6Button == true
                              ? player6Sid.toString()
                              : player7Button == true
                                  ? player7Sid.toString()
                                  : player8Button == true
                                      ? player8Sid.toString()
                                      : SizedBox(),
      "placeTime": currentTime.toString(),
      "marketId": marketId.toString(),
      "matchId": 24,
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
        result['message'],playBackgroundMusic
      );

      setState(() {
        _currentCoinIndexRytPort++;
        _startCoinAnimationRightPort();
      });
     
      setState(() {
        manualAmount = false;
        stakeController.clear();
        player1Button = false;
        player2Button = false;
        player3Button = false;
        player4Button = false;
        player5Button = false;
        player6Button = false;
        player7Button = false;
        player8Button = false;
      });

      getVcLiablity();
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
}
