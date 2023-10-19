import 'dart:async';
import 'dart:convert';
import 'dart:math';

import 'package:flutter/material.dart';

import '../../Utils/api_helper.dart';
import '../../Utils/apis.dart';

// ignore: must_be_immutable
class RandomCoinThroughRightSideAmar extends StatefulWidget {
  RandomCoinThroughRightSideAmar({
    super.key,
  });

  @override
  // ignore: library_private_types_in_public_api
  _RandomCoinThroughRightSideAmarState createState() =>
      _RandomCoinThroughRightSideAmarState();
}

class _RandomCoinThroughRightSideAmarState
    extends State<RandomCoinThroughRightSideAmar>
    with SingleTickerProviderStateMixin {
  String cardNameImage6 = "";
  late AnimationController _controller;
  final List<Widget> _coins = [];
  final Random _random = Random();
  double _minX = 170;
  double _maxX = 630;
  double _minY = 170;
  double _maxY = 300;

  final List _coinImages = [
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

  final int _totalCoins = 200000;
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
      duration: const Duration(milliseconds: 600),
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

    double radius = 100; // Radius of the circular path
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
                    right: currentX.clamp(_minX, _maxX),
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

    Timer(Duration(seconds: 3), _startCoinAnimation);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
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
    var url = Apis.getCardDataAmar;
    var response = await GlobalFunction.apiGetRequestae(url);
    var result = jsonDecode(response);
    if (result['status'] == true) {
      autoTime = result['data']['t1'][0]['autotime'].toString();
      cardNameImage6 = result['data']['t1'][0]['C1'].toString();
      startTimes = int.parse(autoTime.toString());
    }
  }
}
