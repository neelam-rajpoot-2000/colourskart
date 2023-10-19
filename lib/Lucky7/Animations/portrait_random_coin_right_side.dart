import 'dart:async';
import 'dart:convert';
import 'dart:math';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:virtual_casino/Utils/api_helper.dart';
import 'package:virtual_casino/Utils/apis.dart';

class PotraitRandomCoinRightSideL7 extends StatefulWidget {
  const PotraitRandomCoinRightSideL7({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _PotraitRandomCoinRightSideL7State createState() =>
      _PotraitRandomCoinRightSideL7State();
}

class _PotraitRandomCoinRightSideL7State
    extends State<PotraitRandomCoinRightSideL7>
    with SingleTickerProviderStateMixin, WidgetsBindingObserver {
  late AnimationController _controller;
  String cardNameImage6 = "";

  final List<Widget> _coins = [];
  final Random _random = Random();
  double _minX = 40;
  double _maxX = 200;
  double _minY = 40;
  double _maxY = 200;

  final List _coinImages = [
    'assets/lucky7/images/coins/five.png',
    'assets/lucky7/images/coins/hundred.png',
    'assets/lucky7/images/coins/hundred1.png',
    'assets/lucky7/images/coins/one.png',
    'assets/lucky7/images/coins/ten.png',
    'assets/lucky7/images/coins/one.png',
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
    Timer.periodic(const Duration(seconds: 1), (timer) {
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

    double _startX = _minX;
    double _startY = _minX;
    double _endX = _random.nextDouble() * (_maxX - _minX) + _minX;
    double _endY = _random.nextDouble() * (_maxY - _minY) + _minY;

    setState(() {
      cardNameImage6 == ""
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
if(startTimes>15){ Timer(Duration(seconds: 3), _startCoinAnimation);}else{Timer(Duration(seconds: 1), _startCoinAnimation);}

  }

  @override
  void dispose() {
    _controller.dispose();
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

  String autoTime = '';
  int startTimes = 0;
  Future getTimedata() async {
    var url = Apis.getCardData;
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
