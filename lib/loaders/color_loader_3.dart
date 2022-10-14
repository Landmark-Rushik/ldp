import "package:flutter/material.dart";
import 'dart:math';

import 'package:ldp/globals.dart' as globals;

class ColorLoader3 extends StatefulWidget {
  final double radius;
  final double dotRadius;

  // ColorLoader3({this.radius = 30.0, this.dotRadius = 3.0});
  ColorLoader3({this.radius = 25.0, this.dotRadius = 10.0});

  @override
  _ColorLoader3State createState() => _ColorLoader3State();
}

class _ColorLoader3State extends State<ColorLoader3>
    with SingleTickerProviderStateMixin {
  late Animation<double> animation_rotation;
  late Animation<double> animation_radius_in;
  late Animation<double> animation_radius_out;
  late AnimationController controller;

  late double radius;
  late double dotRadius;

  @override
  void initState() {
    super.initState();

    radius = widget.radius;
    dotRadius = widget.dotRadius;

    print(dotRadius);

    controller = AnimationController(
        lowerBound: 0.0,
        upperBound: 1.0,
        // duration: const Duration(milliseconds: 3000),
        duration: const Duration(milliseconds: 2500),
        vsync: this);

    animation_rotation = Tween(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: controller,
        curve: Interval(0.0, 1.0, curve: Curves.linear),
      ),
    );

    animation_radius_in = Tween(begin: 1.0, end: 0.0).animate(
      CurvedAnimation(
        parent: controller,
        curve: Interval(0.75, 1.0, curve: Curves.elasticIn),
      ),
    );

    animation_radius_out = Tween(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: controller,
        curve: Interval(0.0, 0.25, curve: Curves.elasticOut),
      ),
    );

    controller.addListener(() {
      setState(() {
        if (controller.value >= 0.75 && controller.value <= 1.0)
          radius = widget.radius * animation_radius_in.value;
        else if (controller.value >= 0.0 && controller.value <= 0.25)
          radius = widget.radius * animation_radius_out.value;
      });
    });

    controller.addStatusListener((status) {
      if (status == AnimationStatus.completed) {}
    });

    controller.repeat();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      // width: 100.0,
      // height: 100.0,
      width: 70.0,
      height: 70.0,
      //color: Colors.black12,
      child: globals.is_loding_logo
          ? new Center(
              child: new RotationTransition(
                turns: animation_rotation,
                child: new Container(
                  // color: Colors.limeAccent,
                  child: new Center(
                    child: Stack(
                      children: <Widget>[
                        // new Image.asset(
                        //     'assets/img/loding_logo/loding_logo.png',
                        //     width: 70,
                        //     height: 70,
                        //     // fit: BoxFit.scaleDown,
                        //   ),
                        // new Transform.translate(
                        //   offset: Offset(.0, 0.0),
                        //   // offset: Offset(
                        //   //   radius * cos(0.0),
                        //   //   radius * sin(0.0),
                        //   // ),
                        // child: Image.asset(
                        //   'assets/img/loding_logo/loding_logo.png',
                        //   width: 70,
                        //   height: 70,
                        //   // fit: BoxFit.scaleDown,
                        // ),
                        // child: Dot(
                        //   radius: radius,
                        //   color: Colors.black87,
                        //   // color: Color.fromRGBO(19, 38, 89, 1.0),
                        // ),
                        // ),
                        new Transform.translate(
                          // child: Dot(
                          //   radius: dotRadius,
                          //   color: Colors.black87,
                          // ),

                          child: new ClipRRect(
                            borderRadius: new BorderRadius.circular(10.0),
                            child: Image.asset(
                              // globals.str_loding_logo,
                              'assets/img/loding_logo/L_logo_2.png',

                              width: 15,
                              height: 15,
                              fit: BoxFit.scaleDown,

                              color: Colors.black87,
                              // color: Colors.amber,
                              colorBlendMode: BlendMode.plus,
                              // color: Colors.black87,
                              // colorBlendMode: BlendMode.plus,
                            ),
                          ),

                          offset: Offset(
                            radius * cos(0.0),
                            radius * sin(0.0),
                          ),
                        ),
                        new Transform.translate(
                          // child: Dot(
                          //   radius: dotRadius,
                          //   color: Colors.deepblack87,
                          // ),

                          child: new ClipRRect(
                            borderRadius: new BorderRadius.circular(10.0),
                            child: Image.asset(
                              // globals.str_loding_logo,
                              'assets/img/loding_logo/L_logo_3.png',
                              width: 15,
                              height: 15,
                              fit: BoxFit.scaleDown,

                              color: Colors.black87,
                              // color: Colors.deepOrangeAccent,
                              colorBlendMode: BlendMode.plus,
                              // color: Colors.deepblack87,
                              // colorBlendMode: BlendMode.plus,
                            ),
                          ),

                          offset: Offset(
                            radius * cos(0.0 + 1 * pi / 3),
                            radius * sin(0.0 + 1 * pi / 3),
                          ),
                        ),
                        new Transform.translate(
                          // child: Dot(
                          //   radius: dotRadius,
                          //   color: Colors.pinkAccent,
                          // ),

                          child: new ClipRRect(
                            borderRadius: new BorderRadius.circular(10.0),
                            child: Image.asset(
                              // globals.str_loding_logo,
                              'assets/img/loding_logo/L_logo_4.png',
                              width: 15,
                              height: 15,
                              fit: BoxFit.scaleDown,

                              color: Colors.black87,
                              // color: Colors.pinkAccent,
                              colorBlendMode: BlendMode.plus,
                              // color: Colors.pinkAccent,
                              // colorBlendMode: BlendMode.plus,
                            ),
                          ),

                          offset: Offset(
                            radius * cos(0.0 + 2 * pi / 3),
                            radius * sin(0.0 + 2 * pi / 3),
                          ),
                        ),
                        new Transform.translate(
                          // child: Dot(
                          //   radius: dotRadius,
                          //   color: Colors.purple,
                          // ),

                          child: new ClipRRect(
                            borderRadius: new BorderRadius.circular(10.0),
                            child: Image.asset(
                              // globals.str_loding_logo,
                              'assets/img/loding_logo/L_logo_5.png',
                              width: 15,
                              height: 15,
                              fit: BoxFit.scaleDown,

                              color: Colors.black87,
                              // color: Colors.purple,
                              colorBlendMode: BlendMode.plus,
                              // color: Colors.purple,
                              // colorBlendMode: BlendMode.plus,
                            ),
                          ),

                          offset: Offset(
                            radius * cos(0.0 + 3 * pi / 3),
                            radius * sin(0.0 + 3 * pi / 3),
                          ),
                        ),
                        new Transform.translate(
                          // child: Dot(
                          //   radius: dotRadius,
                          //   color: Colors.yellow,
                          // ),

                          child: new ClipRRect(
                            borderRadius: new BorderRadius.circular(10.0),
                            child: Image.asset(
                              // globals.str_loding_logo,
                              'assets/img/loding_logo/L_logo_6.png',
                              width: 15,
                              height: 15,
                              fit: BoxFit.scaleDown,

                              color: Colors.black87,
                              // color: Colors.yellow,
                              colorBlendMode: BlendMode.plus,
                              // color: Colors.yellow,
                              // colorBlendMode: BlendMode.plus,
                            ),
                          ),

                          offset: Offset(
                            radius * cos(0.0 + 4 * pi / 3),
                            radius * sin(0.0 + 4 * pi / 3),
                          ),
                        ),
                        // new Transform.translate(

                        //   // child: Dot(
                        //   //   radius: dotRadius,
                        //   //   color: Colors.lightGreen,
                        //   // ),

                        //   child: new ClipRRect(
                        //     borderRadius: new BorderRadius.circular(10.0),
                        //     child: Image.asset(
                        //       // globals.str_loding_logo,
                        //       'assets/img/loding_logo/L_logo_7.png',
                        //       width: 15,
                        //       height: 15,
                        //       fit: BoxFit.scaleDown,

                        //       color: Colors.black87,
                        //       // color: Colors.lightGreen,
                        //       colorBlendMode: BlendMode.plus,
                        //       // color: Colors.lightGreen,
                        //       // colorBlendMode: BlendMode.plus,
                        //     ),
                        //   ),

                        //   offset: Offset(
                        //     radius * cos(0.0 + 5 * pi / 3),
                        //     radius * sin(0.0 + 5 * pi / 3),
                        //   ),
                        // ),
                        new Transform.translate(
                          // child: Dot(
                          //   radius: dotRadius,
                          //   color: Colors.black87,
                          // ),

                          child: new ClipRRect(
                            borderRadius: new BorderRadius.circular(10.0),
                            child: Image.asset(
                              // globals.str_loding_logo,
                              'assets/img/loding_logo/L_logo_8.png',
                              width: 15,
                              height: 15,
                              fit: BoxFit.scaleDown,

                              color: Colors.black87,
                              // color: Colors.orangeAccent,
                              colorBlendMode: BlendMode.plus,
                              // color: Colors.black87,
                              // colorBlendMode: BlendMode.plus,
                            ),
                          ),
                          offset: Offset(
                            radius * cos(0.0 + 5 * pi / 3),
                            radius * sin(0.0 + 5 * pi / 3),
                          ),
                        ),
                        // new Transform.translate(

                        //   // child: Dot(
                        //   //   radius: dotRadius,
                        //   //   color: Colors.black87,
                        //   // ),

                        //   child: new ClipRRect(
                        //     borderRadius: new BorderRadius.circular(10.0),
                        //     child: Image.asset(
                        //       // globals.str_loding_logo,
                        //       'assets/img/loding_logo/L_logo_9.png',
                        //       width: 15,
                        //       height: 15,
                        //       fit: BoxFit.scaleDown,

                        //       color: Colors.black87,
                        //       // color: Colors.blueAccent,
                        //       colorBlendMode: BlendMode.plus,
                        //     ),
                        //   ),
                        //   offset: Offset(
                        //     radius * cos(0.0 + 7 * pi / 3),
                        //     radius * sin(0.0 + 7 * pi / 3),
                        //   ),
                        // ),
                      ],
                    ),
                  ),
                ),
              ),
            )
          : new Center(
              child: new RotationTransition(
                turns: animation_rotation,
                child: new Container(
                  // color: Colors.limeAccent,
                  child: new Center(
                    child: Stack(
                      children: <Widget>[
                        // new Image.asset(
                        //     'assets/img/loding_logo/loding_logo.png',
                        //     width: 70,
                        //     height: 70,
                        //     // fit: BoxFit.scaleDown,
                        //   ),
                        // new Transform.translate(
                        //   offset: Offset(.0, 0.0),
                        //   // offset: Offset(
                        //   //   radius * cos(0.0),
                        //   //   radius * sin(0.0),
                        //   // ),
                        // child: Image.asset(
                        //   'assets/img/loding_logo/loding_logo.png',
                        //   width: 70,
                        //   height: 70,
                        //   // fit: BoxFit.scaleDown,
                        // ),
                        // child: Dot(
                        //   radius: radius,
                        //   color: Colors.black87,
                        //   // color: Color.fromRGBO(19, 38, 89, 1.0),
                        // ),
                        // ),
                        new Transform.translate(
                          child: Dot(
                            radius: dotRadius,
                            color: Colors.amber,
                          ),

                          // child: new ClipRRect(
                          //   borderRadius: new BorderRadius.circular(10.0),
                          //   child: Image.asset(
                          //     // globals.str_loding_logo,
                          //     'assets/img/loding_logo/L_logo_2.png',

                          //     width: 15,
                          //     height: 15,
                          //     fit: BoxFit.scaleDown,
                          //     color: Colors.black87,
                          //     colorBlendMode: BlendMode.plus,
                          //     // color: Colors.black87,
                          //     // colorBlendMode: BlendMode.plus,
                          //   ),
                          // ),

                          offset: Offset(
                            radius * cos(0.0),
                            radius * sin(0.0),
                          ),
                        ),
                        new Transform.translate(
                          child: Dot(
                            radius: dotRadius,
                            color: Colors.deepOrangeAccent,
                          ),

                          // child: new ClipRRect(
                          //   borderRadius: new BorderRadius.circular(10.0),
                          //   child: Image.asset(
                          //     // globals.str_loding_logo,
                          //     'assets/img/loding_logo/L_logo_3.png',
                          //     width: 15,
                          //     height: 15,
                          //     fit: BoxFit.scaleDown,
                          //     color: Colors.black87,
                          //     colorBlendMode: BlendMode.plus,
                          //     // color: Colors.deepblack87,
                          //     // colorBlendMode: BlendMode.plus,
                          //   ),
                          // ),

                          offset: Offset(
                            radius * cos(0.0 + 1 * pi / 3),
                            radius * sin(0.0 + 1 * pi / 3),
                          ),
                        ),
                        new Transform.translate(
                          child: Dot(
                            radius: dotRadius,
                            color: Colors.pinkAccent,
                          ),

                          // child: new ClipRRect(
                          //   borderRadius: new BorderRadius.circular(10.0),
                          //   child: Image.asset(
                          //     // globals.str_loding_logo,
                          //     'assets/img/loding_logo/L_logo_4.png',
                          //     width: 15,
                          //     height: 15,
                          //     fit: BoxFit.scaleDown,
                          //     color: Colors.black87,
                          //     colorBlendMode: BlendMode.plus,
                          //     // color: Colors.pinkAccent,
                          //     // colorBlendMode: BlendMode.plus,
                          //   ),
                          // ),

                          offset: Offset(
                            radius * cos(0.0 + 2 * pi / 3),
                            radius * sin(0.0 + 2 * pi / 3),
                          ),
                        ),
                        new Transform.translate(
                          child: Dot(
                            radius: dotRadius,
                            color: Colors.purple,
                          ),

                          // child: new ClipRRect(
                          //   borderRadius: new BorderRadius.circular(10.0),
                          //   child: Image.asset(
                          //     // globals.str_loding_logo,
                          //     'assets/img/loding_logo/L_logo_5.png',
                          //     width: 15,
                          //     height: 15,
                          //     fit: BoxFit.scaleDown,
                          //     color: Colors.black87,
                          //     colorBlendMode: BlendMode.plus,
                          //     // color: Colors.purple,
                          //     // colorBlendMode: BlendMode.plus,
                          //   ),
                          // ),

                          offset: Offset(
                            radius * cos(0.0 + 3 * pi / 3),
                            radius * sin(0.0 + 3 * pi / 3),
                          ),
                        ),
                        new Transform.translate(
                          child: Dot(
                            radius: dotRadius,
                            color: Colors.yellow,
                          ),

                          // child: new ClipRRect(
                          //   borderRadius: new BorderRadius.circular(10.0),
                          //   child: Image.asset(
                          //     // globals.str_loding_logo,
                          //     'assets/img/loding_logo/L_logo_6.png',
                          //     width: 15,
                          //     height: 15,
                          //     fit: BoxFit.scaleDown,
                          //     color: Colors.black87,
                          //     colorBlendMode: BlendMode.plus,
                          //     // color: Colors.yellow,
                          //     // colorBlendMode: BlendMode.plus,
                          //   ),
                          // ),

                          offset: Offset(
                            radius * cos(0.0 + 4 * pi / 3),
                            radius * sin(0.0 + 4 * pi / 3),
                          ),
                        ),
                        new Transform.translate(
                          child: Dot(
                            radius: dotRadius,
                            color: Colors.lightGreen,
                          ),

                          // child: new ClipRRect(
                          //   borderRadius: new BorderRadius.circular(10.0),
                          //   child: Image.asset(
                          //     // globals.str_loding_logo,
                          //     'assets/img/loding_logo/L_logo_7.png',
                          //     width: 15,
                          //     height: 15,
                          //     fit: BoxFit.scaleDown,
                          //     color: Colors.black87,
                          //     colorBlendMode: BlendMode.plus,
                          //     // color: Colors.lightGreen,
                          //     // colorBlendMode: BlendMode.plus,
                          //   ),
                          // ),

                          offset: Offset(
                            radius * cos(0.0 + 5 * pi / 3),
                            radius * sin(0.0 + 5 * pi / 3),
                          ),
                        ),
                        // new Transform.translate(
                        //   child: Dot(
                        //     radius: dotRadius,
                        //     color: Colors.orangeAccent,
                        //   ),

                        //   // child: new ClipRRect(
                        //   //   borderRadius: new BorderRadius.circular(10.0),
                        //   //   child: Image.asset(
                        //   //     // globals.str_loding_logo,
                        //   //     'assets/img/loding_logo/L_logo_8.png',
                        //   //     width: 15,
                        //   //     height: 15,
                        //   //     fit: BoxFit.scaleDown,
                        //   //     color: Colors.black87,
                        //   //     colorBlendMode: BlendMode.plus,
                        //   //     // color: Colors.black87,
                        //   //     // colorBlendMode: BlendMode.plus,
                        //   //   ),
                        //   // ),

                        //   offset: Offset(
                        //     radius * cos(0.0 + 6 * pi / 3),
                        //     radius * sin(0.0 + 6 * pi / 3),
                        //   ),
                        // ),
                        // new Transform.translate(
                        //   child: Dot(
                        //     radius: dotRadius,
                        //     color: Colors.blueAccent,
                        //   ),

                        //   // child: new ClipRRect(
                        //   //   borderRadius: new BorderRadius.circular(10.0),
                        //   //   child: Image.asset(
                        //   //     // globals.str_loding_logo,
                        //   //     'assets/img/loding_logo/L_logo_9.png',
                        //   //     width: 15,
                        //   //     height: 15,
                        //   //     fit: BoxFit.scaleDown,
                        //   //     color: Colors.black87,
                        //   //     colorBlendMode: BlendMode.plus,
                        //   //   ),
                        //   // ),

                        //   offset: Offset(
                        //     radius * cos(0.0 + 7 * pi / 3),
                        //     radius * sin(0.0 + 7 * pi / 3),
                        //   ),
                        // ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
    );
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }
}

class Dot extends StatelessWidget {
  final double? radius;
  final Color? color;

  Dot({this.radius, this.color});

  @override
  Widget build(BuildContext context) {
    return new Center(
      child: Container(
        width: radius,
        height: radius,
        decoration: BoxDecoration(color: color, shape: BoxShape.circle),
      ),
    );
  }
}
