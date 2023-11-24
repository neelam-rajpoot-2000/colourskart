import 'dart:async';
import 'dart:convert';
import 'dart:math';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';
import 'package:virtual_casino/Utils/apis.dart';

import '../../Utils/api_helper.dart';

class LandscapeRandomCoinLeftSideOVTP extends StatefulWidget {
  late final bool coinsSound;
  LandscapeRandomCoinLeftSideOVTP({super.key, required this.coinsSound});

  @override
  // ignore: library_private_types_in_public_api
  _LandscapeRandomCoinLeftSideOVTPState createState() =>
      _LandscapeRandomCoinLeftSideOVTPState();
}

class _LandscapeRandomCoinLeftSideOVTPState
    extends State<LandscapeRandomCoinLeftSideOVTP>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  var coin = 0;
  final List<Widget> _coins = [];
  String cardNameImage = "";
  late Timer _clockTimer;

  final Random _random = Random();
  double _minX = 170;
  double _maxX = 630;
  double _minY = 170;
  double _maxY = 320;
  final _player = AudioPlayer();

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

  final int _totalCoins = 2000;
  int _currentCoinIndex = 0;
  final onPressedmusic = AudioPlayer();

  @override
  void initState() {
    super.initState();
    _clockTimer = Timer.periodic(const Duration(seconds: 1), (timer) {
      getTimedata();
    });
    getTimedata().then((value) => _controller =
        AnimationController(vsync: this, duration: const Duration()));
    _controller = AnimationController(
      duration: const Duration(milliseconds: 600),
      vsync: this,
    );
    setState(() {
      _startCoinAnimation();
    });

    // Timer(Duration(seconds: 45), _stopCoinAnimation);
  }

  Future<void> onPressedMusic() async {
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

  void _startCoinAnimation() {
    if (_currentCoinIndex >= _totalCoins) {
      return;
    }

    double radius = 200; // Radius of the circular path
    double angle = _currentCoinIndex * (pi / _totalCoins);

    double startX = _minX;
    double startY = _minX;
    double endX = _random.nextDouble() * (_maxX - _minX) + _minX;
    double endY = _random.nextDouble() * (_maxY - _minY) + _minY;

    // coin = int.parse(widget.autotime.toString());
    //   print("====>$coin");

    setState(() {
      cardNameImage == ''
          ? _coins.add(TweenAnimationBuilder(
              tween: Tween<double>(begin: 0, end: 1),
              duration: const Duration(milliseconds: 600),
              builder: (BuildContext context, double value, Widget? child) {
                double currentX = startX + (endX - startX) * value;
                double currentY = startY + (endY - startY) * value;

                return Positioned(
                    left: currentX.clamp(_minX, _maxX),
                    top: currentY.clamp(_minY, _maxY),
                    child: startTimes > 1
                        ? Image.asset(
                            _coinImages[_currentCoinIndex % _coinImages.length],
                            height: 20,
                            width: 20,
                          )
                        : SizedBox());
              },
            ))
          : _coins.clear();
      _currentCoinIndex++;
   if(startTimes>15){ Timer(Duration(seconds: 2), _startCoinAnimation);}else{Timer(Duration(seconds: 3), _startCoinAnimation);}



      autoTime != "0" && widget.coinsSound == false ? onPressedMusic() : null;
      autoTime == "0" ? _coins.clear() : null;
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    _player.dispose();
    onPressedmusic.dispose();
    _clockTimer.cancel();
    super.dispose();
  }

  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.paused) {
      widget.coinsSound = true;
      _player.pause();
    } else if (state == AppLifecycleState.resumed) {
      _player.play();
    }
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedSwitcher(
      duration: Duration(milliseconds: 500),
      child: Stack(
        children: _coins,
      ),
    );
  }

  String autoTime = '';
  int startTimes = 0;
  Future getTimedata() async {
    var url = Apis.getCardDataOVTP;
    var response = await GlobalFunction.apiGetRequestae(url);
    var result = jsonDecode(response);
    if (result['status'] == true) {
      autoTime = result['data']['t1'][0]['autotime'].toString();
      cardNameImage = result['data']['t1'][0]['C1'].toString();
      startTimes = int.parse(autoTime.toString());
      print("====>$startTimes");
    }
  }
}
