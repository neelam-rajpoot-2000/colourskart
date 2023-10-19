import 'package:flutter/material.dart';
import 'dart:math';

class FlyingCoinsScreen extends StatefulWidget {
  @override
  _FlyingCoinsScreenState createState() => _FlyingCoinsScreenState();
}

class _FlyingCoinsScreenState extends State<FlyingCoinsScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  List<Widget> _coins = [];
  Random _random = Random();

  late double _minX;
  late double _maxX;
  late double _minY;
  late double _maxY;

  List<String> _coinImages = [
    'images/coin1.png',
    'images/coin2.png',
    'images/coin3.png',
    // Add more image paths for each coin
  ];

  int _currentCoinIndex = 0;
  late double _startX, _startY, _endX, _endY;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(seconds: 3),
      vsync: this,
    );

    // Set min and max coordinates based on screen size
    _minX = 0;
    _maxX = MediaQuery.of(context).size.width - 100; // Adjust as needed
    _minY = 0;
    _maxY = MediaQuery.of(context).size.height - 100; // Adjust as needed
  }

  void _startCoinAnimation() {
    if (_currentCoinIndex >= _coinImages.length) {
      return;
    }

    _startX = _random.nextDouble() * (_maxX - _minX) + _minX;
    _startY = _random.nextDouble() * (_maxY - _minY) + _minY;
    _endX = _random.nextDouble() * (_maxX - _minX) + _minX;
    _endY = _random.nextDouble() * (_maxY - _minY) + _minY;

    setState(() {
      _coins.add(
        AnimatedBuilder(
          animation: _controller,
          builder: (BuildContext context, Widget? child) {
            double value = _controller.value;
            double currentX = _startX + (_endX - _startX) * value;
            double currentY = _startY + (_endY - _startY) * value;

            return Positioned(
              left: currentX,
              top: currentY,
              child: Image.asset(
            _coinImages[_currentCoinIndex],
          ),
            );
          },
         
        ),
      );
    });

    _currentCoinIndex++;
  }

  void _onBetButtonPressed() {
    if (_currentCoinIndex < _coinImages.length) {
      _controller.reset();
      _controller.forward();
      _startCoinAnimation();
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Flying Coins'),
      ),
      body: Stack(
        children: [
        
          ..._coins,
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _onBetButtonPressed,
        child: Icon(Icons.play_arrow),
      ),
    );
  }
}


