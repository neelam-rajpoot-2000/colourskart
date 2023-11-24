import 'dart:async';
import 'dart:math';


import 'package:flutter/material.dart';






class MyGame extends StatefulWidget {
 @override
 _MyGameState createState() => _MyGameState();
}


class _MyGameState extends State<MyGame> {
 List<Image> chipColors = List.generate(200, (index) => Image(image: AssetImage(  'assets/lucky7/images/coins/one.png'))); // Generate 100 blue chips
 List<Offset> chipPositions = List.generate(
   200,
   (index) => Offset(
     Random().nextDouble(), // Random horizontal position
     Random().nextDouble(), // Random vertical position
   ),
 );
 int currentChipIndex = 0;


 Offset targetBox = Offset(150, 100); // Target box position


 @override
 Widget build(BuildContext context) {
   return Scaffold(
     appBar: AppBar(
       title: Text('Casino Game'),
     ),
     body: SingleChildScrollView(
       child: Center(
         child: Column(
           mainAxisAlignment: MainAxisAlignment.center,
           children: [
             ElevatedButton(
               onPressed: () {
                 _throwChipFromRandomPosition();
               },
               child: Text('Throw Chip'),
             ),
             SizedBox(height: 20),
             Container(
               width: 200,
                height: 200,
               decoration: BoxDecoration(
                 border: Border.all(color: Colors.black),
               ),
               child: Stack(
                 children: List.generate(chipColors.length, (index) {
                   return AnimatedPositioned(
                     duration: Duration(seconds: 1), // Animation duration
                     left: currentChipIndex > index
                         ? chipPositions[index].dx *200 // Target box width
                         : 0,
                     top: currentChipIndex > index
                         ? chipPositions[index].dy * 200 // Target box height
                         : 0,
                     child: currentChipIndex > index
                         ? ChipWidget(chipColor: chipColors[index])
                         : Container(),
                   );
                 }),
               ),
             ),
             SizedBox(height: 20),
             GestureDetector(
               onTap: () {
                 _throwChipFromRandomPosition();
               },
               child: Icon(
                 Icons.star,
                 size: 50,
                 color: Colors.yellow,
               ),
             ),
           ],
         ),
       ),
     ),
   );
 }


 void _throwChipFromRandomPosition() {
   Timer.periodic(Duration(seconds: 1), (timer) {
     if (currentChipIndex < chipColors.length) {
       setState(() {
         chipPositions[currentChipIndex] = Offset(
           Random().nextDouble(), // Random horizontal position
           Random().nextDouble(), // Random vertical position
  );
         currentChipIndex++;
       });
     } else {
       timer.cancel();
     }
   });
 }
}


class ChipWidget extends StatelessWidget {
 final Image chipColor;


 ChipWidget({required this.chipColor});


 @override
 Widget build(BuildContext context) {
   return Container(
     width: 20, // Adjust chip size as needed
     height: 20,
     decoration: BoxDecoration(
     image: DecorationImage(image: AssetImage("$chipColor")),
       shape: BoxShape.circle,
     ),
   );
 }
}

