import 'dart:async';
import 'dart:convert';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';
import 'package:virtual_casino/Utils/apis.dart';
import '../../Utils/api_helper.dart';

class LandscapeRandomCoinLeftSide1 extends StatefulWidget {
  late final bool coinsSound;
  LandscapeRandomCoinLeftSide1({
    required this.coinsSound,
    super.key,
  });
  @override
  // ignore: library_private_types_in_public_api
  _LandscapeRandomCoinLeftSide1State createState() =>
      _LandscapeRandomCoinLeftSide1State();
}

class _LandscapeRandomCoinLeftSide1State
    extends State<LandscapeRandomCoinLeftSide1>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  var coin = 0;
  final List<Widget> _coins = [];
  String cardNameImage6 = "";
  final Random _random = Random();
  double minX = 280;
  double maxX = 450;
  double minY = 180;
  double maxY = 280;
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
  final int _totalCoins = 200000;
  final onPressedmusic = AudioPlayer();

  int _currentCoinIndex = 0;
  Future<void> onPressedMusic() async {
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

  @override
  void initState() {
    super.initState();
    Timer.periodic(Duration(seconds: 1), (timer) {
      getTimedata();
    });
    getTimedata().then((value) => _controller =
        AnimationController(vsync: this, duration: const Duration()));
    _controller = AnimationController(
      duration: const Duration(milliseconds: 400),
      vsync: this,
    );
    _startCoinAnimation();
  }

  void _startCoinAnimation() {
    if (_currentCoinIndex >= _totalCoins) {
      return;
    }
    double radius = 200; // Radius of the circular path
    double angle = _currentCoinIndex * (pi / _totalCoins);
    double _startX = minX;
    double _startY = minX;
    double _endX = _random.nextDouble() * (maxX - minX) + minX;
    double _endY = _random.nextDouble() * (maxY - minY) + minY;
    // coin = int.parse(widget.autotime.toString());
    setState(() {
      autoTime != '45'
          ? _coins.add(TweenAnimationBuilder(
              tween: Tween<double>(begin: 0, end: 1),
              duration: const Duration(milliseconds: 600),
              builder: (BuildContext context, double value, Widget? child) {
                double currentX = _startX + (_endX - _startX) * value;
                double currentY = _startY + (_endY - _startY) * value;
                return Positioned(
                    left: currentX.clamp(minX, maxX),
                    top: currentY.clamp(minY, maxY),
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
      Timer(Duration(seconds: 2), _startCoinAnimation);
      autoTime != "0" && widget.coinsSound == false ? onPressedMusic() : null;
      autoTime == "0" ? _coins.clear() : null;
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    _player.dispose();
    onPressedmusic.dispose();
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
      duration: Duration(milliseconds: 600),
      child: Stack(
        children: _coins,
      ),
    );
  }

  String autoTime = '';
  int startTimes = 0;
  Future getTimedata() async {
    var url = Apis.getCardDataTeenPatti;
    var response = await GlobalFunction.apiGetRequestae(url);
    var result = jsonDecode(response);
    if (result['status'] == true) {
      autoTime = result['data']['t1'][0]['autotime'].toString();
      cardNameImage6 = result['data']['t1'][0]['C6'].toString();
      startTimes = int.parse(autoTime.toString());
    }
  }
}
