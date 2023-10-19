import 'dart:async';
import 'dart:convert';
import 'dart:math';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';
import 'package:virtual_casino/Utils/apis.dart';

import '../../Utils/api_helper.dart';

class LandscapeRandomCoinLeftSideDt extends StatefulWidget {
  late final bool coinsSound;
double height;
double width;
double height1;

  LandscapeRandomCoinLeftSideDt({super.key, required this.coinsSound,required this.height,required this.width,required this.height1});

  @override
  // ignore: library_private_types_in_public_api
  _LandscapeRandomCoinLeftSideDtState createState() =>
      _LandscapeRandomCoinLeftSideDtState();
}

class _LandscapeRandomCoinLeftSideDtState
    extends State<LandscapeRandomCoinLeftSideDt>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  var coin = 0;
  final List<Widget> _coins = [];
  String cardNameImage6 = "";
  late Timer _clockTimer;

  final Random _random = Random();

  double _minXLeftLandRand = 0;
  double _maxXLeftLandRand = 0;
  double _minYLeftLandRand = 0;
  double _maxYLeftLandRand = 0;
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
    final List<Widget> _coinsLeftLandRand = [];

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
      _startCoinAnimationLeftLandRand();
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
    _maxXLeftLandRand = widget.height1- 700;

    _maxYLeftLandRand =widget.height1-840;

       cardNameImage6 == ""
        ? _coinsLeftLandRand.add(
      TweenAnimationBuilder(
        duration: Duration(milliseconds: 900),
        tween: Tween(
          begin: Offset(0, 0),
          end: Offset(_endX
          +60,_endY- 45), // Adjust for the fixed starting point
        ),
        builder: (BuildContext context, Offset value, Widget? child) {

          return Positioned(
            left:
         widget.height + value.dx,
            bottom: widget.width+ value.dy,
            child: child!,
          );
        },
        child:  startTimes > 1
                      ? Image.asset(
                          _coinImages[
                              _currentCoinIndex % _coinImages.length],
                          height: 15,
                          width: 15,
                        )
                      : SizedBox(),
      ),
    )
    : _coinsLeftLandRand.clear()
;
   _currentCoinIndex++;

    if (startTimes > 15) {
      Timer(Duration(seconds: 2), _startCoinAnimationLeftLandRand);
    } else {
      Timer(Duration(seconds: 3), _startCoinAnimationLeftLandRand);
    }
    autoTime != "0" && widget.coinsSound == false ? onPressedMusic() : null;

  
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
    var url = Apis.getCardDT;
    var response = await GlobalFunction.apiGetRequestae(url);
    var result = jsonDecode(response);
    if (result['status'] == true) {
      autoTime = result['data']['t1'][0]['autotime'].toString();
      cardNameImage6 = result['data']['t1'][0]['C1'].toString();
      startTimes = int.parse(autoTime.toString());
      print("====>$startTimes");
    }
  }
}
