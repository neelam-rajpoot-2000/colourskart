// import 'dart:async';
// import 'dart:convert';
// import 'dart:math';
// import 'package:http/http.dart' as http;

// import 'package:flutter/material.dart';

// import '../../Utils/api_helper.dart';
// import '../../Utils/apis.dart';

// // ignore: must_be_immutable
// class RandomCoinThroughRightSideL7 extends StatefulWidget {
//   RandomCoinThroughRightSideL7({
//     super.key,
//   });

//   @override
//   // ignore: library_private_types_in_public_api
//   _RandomCoinThroughRightSideL7State createState() =>
//       _RandomCoinThroughRightSideL7State();
// }

// class _RandomCoinThroughRightSideL7State
//     extends State<RandomCoinThroughRightSideL7>
//     with SingleTickerProviderStateMixin {
//   String cardNameImage6 = "";
//   late AnimationController _controller;
//   final List<Widget> _coins = [];
//   final Random _random = Random();
//   double _minX = 190;
//   double _maxX = 550;
//   double _minY = 140;
//   double _maxY = 250;

//   final List _coinImages = [
//     'assets/lucky7/images/coins/hundred.png',
//     'assets/lucky7/images/coins/hundred1.png',
//     'assets/lucky7/images/coins/ten.png',
//     'assets/lucky7/images/coins/one.png',
//     'assets/lucky7/images/coins/hundred.png',
//     'assets/lucky7/images/coins/fifty.png',
//     'assets/lucky7/images/coins/hundred1.png',
//     'assets/lucky7/images/coins/ten.png',
//     'assets/lucky7/images/coins/one.png',
//     'assets/lucky7/images/coins/hundred.png',
//     'assets/lucky7/images/coins/fifty.png',
//     'assets/lucky7/images/coins/hundred1.png',
//   ];

//   final int _totalCoins = 2000;
//   int _currentCoinIndex = 0;

//   @override
//   void initState() {
//     super.initState();
//     Timer.periodic(const Duration(seconds: 1), (timer) {
//       getTimedata();
//     });
//     getTimedata().then((value) => _controller =
//         AnimationController(vsync: this, duration: const Duration()));
//     _controller = AnimationController(
//       duration: const Duration(milliseconds: 600),
//       vsync: this,
//     );
//     setState(() {
//       _startCoinAnimation();
//     });
//   }

//  @override
//   void dispose() {
//     _controller.dispose();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return AnimatedSwitcher(
//       duration: Duration(milliseconds: 500),
//       child: Stack(
//         children: _coins,
//       ),
//     );
//   }

//   String autoTime = '';
//   int startTimes = 0;
//   Future getTimedata() async {
//     var url = Apis.getCardData;
//     var response = await GlobalFunction.apiGetRequestae(url);
//     var result = jsonDecode(response);
//     if (result['status'] == true) {
//       autoTime = result['data']['t1'][0]['autotime'].toString();
//       cardNameImage6 = result['data']['t1'][0]['C1'].toString();
//       startTimes = int.parse(autoTime.toString());
//       print("====>$startTimes");
//     }
//   }
// }
