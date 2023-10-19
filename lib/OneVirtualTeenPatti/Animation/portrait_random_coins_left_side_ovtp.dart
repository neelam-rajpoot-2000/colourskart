import 'dart:async';
import 'dart:convert';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';

import '../../Utils/api_helper.dart';
import '../../Utils/apis.dart';

class ProtraitRandomCoinLeftSideOVTP extends StatefulWidget {
    late final bool coinsSound;
    ProtraitRandomCoinLeftSideOVTP({super.key,required this.coinsSound});

  @override
  State<ProtraitRandomCoinLeftSideOVTP> createState() => _ProtraitRandomCoinLeftSideOVTPState();
}

class _ProtraitRandomCoinLeftSideOVTPState extends State<ProtraitRandomCoinLeftSideOVTP> with SingleTickerProviderStateMixin{
 late AnimationController _controller;
  String cardNameImage = "";

  final List<Widget> _coins = [];
  final Random _random = Random();
  double _minX = 50;
  double _maxX = 200;
  double _minY = 50;
  double _maxY = 200;
  late Timer _clockTimer;
  final _player = AudioPlayer();
  final onPressedmusic = AudioPlayer();

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

  final List _coinImages = [
    'assets/lucky7/images/coins/fifty.png',
    'assets/lucky7/images/coins/five.png',
    'assets/lucky7/images/coins/hundred.png',
    'assets/lucky7/images/coins/hundred1.png',
    'assets/lucky7/images/coins/one.png',
    'assets/lucky7/images/coins/ten.png',
    'assets/lucky7/images/coins/one.png',
    'assets/lucky7/images/coins/hundred.png',
    'assets/lucky7/images/coins/fifty.png',
    'assets/lucky7/images/coins/hundred1.png',
    'assets/lucky7/images/coins/five.png',

    // Add more image paths for each chip
  ];

  final int _totalCoins = 5000;
  int _currentCoinIndex = 0;

  @override
  void initState() {
    super.initState();
    _clockTimer = Timer.periodic(const Duration(seconds: 1), (timer) {
      getTimedata();
    });
    getTimedata().then((value) => _controller =
        AnimationController(vsync: this, duration: const Duration()));
    _controller = AnimationController(
      duration: const Duration(milliseconds: 900),
      vsync: this,
    );
    setState(() {
      _startCoinAnimation();
    });
  }

  void _startCoinAnimation() {
    if (_currentCoinIndex >= _totalCoins) {
      return;
    }

    double radius = 200; // Radius of the circular path
    double angle = _currentCoinIndex * (pi / _totalCoins);

    double _startX = _minY;
    double _startY = _minY;
    double _endX = _random.nextDouble() * (_maxX - _minX) + _minX;
    double _endY = _random.nextDouble() * (_maxY - _minY) + _minY;

    setState(() {
      cardNameImage == ""
          ? _coins.add(TweenAnimationBuilder(
              tween: Tween<double>(begin: 0, end: 1),
              duration: const Duration(milliseconds: 600),
              builder: (BuildContext context, double value, Widget? child) {
                double currentX = _startX + (_endX - _startX) * value;
                double currentY = _startY + (_endY - _startY) * value;

                return Positioned(
                    right: currentX.clamp(_minX, _maxX),
                    top: currentY.clamp(_minY, _maxY),
                    child: startTimes > 3
                        ? Image.asset(
                            _coinImages[_currentCoinIndex % _coinImages.length],
                            height: 20,
                            width: 20,
                          )
                        : SizedBox());
              },
            ))
          : _coins.clear();
    });

    _currentCoinIndex++;

 if(startTimes>15){ Timer(Duration(seconds: 2), _startCoinAnimation);}else{Timer(Duration(seconds: 3), _startCoinAnimation);}



    autoTime != "0" && widget.coinsSound == false ? onPressedMusic() : null;
    autoTime == "0" ? _coins.clear() : null;
  }

  @override
  void dispose() {
    _controller.dispose();
    _player.dispose();
    _clockTimer.cancel();
    onPressedmusic.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedSwitcher(
      duration: Duration(milliseconds: 900),
      child: Stack(
        children: _coins,
      ),
    );
  }

  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.paused) {
      widget.coinsSound = true;
      _player.pause();
    } else if (state == AppLifecycleState.resumed) {
      _player.play();
    }
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