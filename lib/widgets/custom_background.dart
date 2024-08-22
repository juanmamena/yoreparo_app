import 'dart:math';

import 'package:flutter/material.dart';

class CustomBackground extends StatelessWidget {
  const CustomBackground({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    var boxDecoration = BoxDecoration(
        gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            stops: [
          0.2,
          0.8
        ],
            colors: [
          const Color.fromARGB(255, 13, 72, 160),
          const Color.fromARGB(255, 6, 43, 99)
        ]));

    return Stack(
      children: [
        Container(
          decoration: boxDecoration,
        ),
        Positioned(top: -100, left: -30, child: _PinkBox())
      ],
    );
  }
}

class _PinkBox extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Transform.rotate(
      angle: -pi / 5,
      child: Container(
        width: 390,
        height: 390,
        decoration: BoxDecoration(
            color: Colors.lightBlue,
            borderRadius: BorderRadius.circular(80),
            gradient: LinearGradient(colors: [
              Color.fromRGBO(58, 193, 234, 0.998),
              Color.fromRGBO(120, 210, 238, 0.996),
            ])),
      ),
    );
  }
}
