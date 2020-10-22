import 'dart:async';
import 'dart:ui';

import 'package:LightSensor/providers/lightprovider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    super.initState();
    initPlatformState();
  }

  // Platform messages are asynchronous, so we initialize in an async method.
  Future<void> initPlatformState() async {
    var lightInfo = Provider.of<LightProvider>(context, listen: false);
    lightInfo.startListening();
  }

  @override
  Widget build(BuildContext context) {
    var deviceSize = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Color(0xFF15151F),
      body: Stack(
        children: [
          Column(
            children: [
              Consumer<LightProvider>(builder: (context, light, child) {
                return AnimatedContainer(
                    duration: Duration(milliseconds: 400),
                    curve: Curves.easeIn,
                    margin: const EdgeInsets.only(bottom: 10),
                    color: light.getColors(light.luxValue),
                    height: 350,
                    width: deviceSize.width,
                    padding: const EdgeInsets.all(70),
                    child: Image.asset(
                      'assets/images/3.jpg',
                      fit: BoxFit.fill,
                    ));
              }),
              Container(
                margin: const EdgeInsets.only(top: 20),
                height: 100,
                width: deviceSize.width,
                padding: const EdgeInsets.all(5.0),
                decoration:
                    BoxDecoration(color: Colors.white.withOpacity(0.10)),
                child: Center(child: Consumer<LightProvider>(
                  builder: (context, light, child) {
                    return Center(
                      child: new Text(
                        '${light.luxValue}',
                        style: TextStyle(
                          fontFamily: 'Prag',
                          fontWeight: FontWeight.w500,
                          fontSize: 70,
                          color: Colors.white,
                        ),
                      ),
                    );
                  },
                )),
              ),
              Row(
                children: [
                  Container(
                    width: 12.0,
                    height: 40.0,
                    color: Colors.transparent,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(right: 8.0),
                    child: Container(
                      height: 1.5,
                      width: 19,
                      color: Color(0xFFD1D1D3),
                    ),
                  ),
                  Consumer<LightProvider>(builder: (context, light, child) {
                    return Text(light.getEquivalent(light.luxValue),
                        style: TextStyle(
                            letterSpacing: 1,
                            fontFamily: 'Prag',
                            fontSize: 22,
                            color: Colors.white,
                            fontWeight: FontWeight.w400));
                  }),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class GradientPainter extends CustomPainter {
  GradientPainter({this.gradient, this.strokeWidth});
  final Gradient gradient;
  final double strokeWidth;
  final Paint paintObject = Paint();
  @override
  void paint(Canvas canvas, Size size) {
    Rect innerRect = Rect.fromLTRB(strokeWidth, strokeWidth,
        size.width + strokeWidth, size.height + strokeWidth);
    Rect outerRect = Offset.zero & size;
    paintObject.shader = gradient.createShader(outerRect);
    Path borderPath = _calculateBorderPath(outerRect, innerRect);
    canvas.drawPath(borderPath, paintObject);
  }

  Path _calculateBorderPath(Rect outerRect, Rect innerRect) {
    Path outerRectPath = Path()..addRect(outerRect);
    Path innerRectPath = Path()..addRect(innerRect);
    return Path.combine(PathOperation.difference, outerRectPath, innerRectPath);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => true;
}

class GradientBorderButtonContainer extends StatelessWidget {
  GradientBorderButtonContainer({
    @required gradient,
    @required this.child,
    this.strokeWidth = 2.5,
    this.onPressed,
  }) : this.painter =
            GradientPainter(gradient: gradient, strokeWidth: strokeWidth);
  final GradientPainter painter;
  final Widget child;
  final VoidCallback onPressed;
  final double strokeWidth;
  @override
  Widget build(BuildContext context) {
    return CustomPaint(painter: painter, child: child);
  }
}
