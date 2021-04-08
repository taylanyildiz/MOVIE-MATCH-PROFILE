import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:movie_match_splash_screen/widgets/widgets.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with TickerProviderStateMixin {
  AnimationController _controller;
  AnimationController _controller2;
  AnimationController _controller3;
  AnimationController _controller4;
  Animation<double> _animEnd;
  Animation<double> _animbackground;
  Animation<double> _animLogo, _animLogo2, _animLogo3;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: Duration(seconds: 1),
    );
    _controller2 = AnimationController(
      vsync: this,
      duration: Duration(seconds: 1),
    );
    _controller3 = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 100),
    );

    _controller4 = AnimationController(
      vsync: this,
      duration: Duration(seconds: 1),
    );

    _controller.forward().whenComplete(() => _controller4
        .forward()
        .whenComplete(() =>
            _controller2.forward().whenComplete(() => _controller3.forward())));

    _animbackground = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Curves.easeOutExpo,
      ),
    );
    _animLogo = Tween<double>(begin: 0.0, end: 1).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Curves.linear,
      ),
    );

    _animLogo.addListener(() {
      setState(() {});
    });
    _animLogo2 = Tween<double>(begin: 1.0, end: 0.0).animate(
      CurvedAnimation(
        parent: _controller2,
        curve: Curves.easeInQuart,
      ),
    );
    _animLogo2.addListener(() {
      setState(() {});
    });
    _animLogo3 = Tween<double>(begin: 0.0, end: 0.2).animate(
      CurvedAnimation(parent: _controller4, curve: Curves.elasticOut),
    );
    _animLogo3.addListener(() {
      setState(() {});
    });

    _animEnd = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(
      CurvedAnimation(
        parent: _controller3,
        curve: Curves.elasticOut,
      ),
    );
    _animEnd.addListener(() {
      setState(() {});
    });
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
    _controller2.dispose();
    _controller3.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: Stack(
          children: [
            MovieBackground(),
            FadeTransition(
              opacity: _animbackground,
              child: Container(
                decoration: BoxDecoration(
                    gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Color(0xFFFFFBFB).withOpacity(.64),
                    Color(0xFF000000).withOpacity(.87),
                    Color(0xFF000000).withOpacity(1.0),
                  ],
                )),
              ),
            ),
            Center(
              child: Transform.scale(
                scale: _animLogo2.value,
                child: Container(
                  width: 150.0,
                  height: 150.0,
                  child: Stack(
                    children: [
                      Container(
                        width: 150.0,
                        height: 150.0,
                        child: CustomPaint(
                          painter: LogoPaint(
                            offset: _animLogo.value,
                          ),
                        ),
                      ),
                      Transform.rotate(
                        angle: _animLogo3.value,
                        alignment: Alignment.bottomRight,
                        child: Container(
                          width: 150.0,
                          height: 150.0,
                          child: CustomPaint(
                            painter: LogoPaint(
                              offset: _animLogo.value,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Transform.scale(
              scale: _animEnd.value,
              child: Center(
                child: TextPageIndicator(),
              ),
            ),
            Positioned(
              bottom: 0.0,
              child: Transform.scale(
                scale: _animEnd.value,
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  height: 250.0,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(60.0),
                      topRight: Radius.circular(60.0),
                    ),
                    color: Colors.black,
                  ),
                  child: Column(
                    children: [
                      SizedBox(height: 20.0),
                      ButtonNetflix(),
                      Spacer(),
                      TermOfUse(),
                      SizedBox(height: 10.0),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class LogoPaint extends CustomPainter {
  final Paint pathPaint;
  final double offset;
  LogoPaint({
    this.offset,
  })  : pathPaint = Paint()
          ..color = Colors.red
          ..strokeWidth = 8.0
          ..style = PaintingStyle.stroke
          ..strokeCap = StrokeCap.round,
        super();
  @override
  void paint(Canvas canvas, Size size) {
    _drawFirstRect(canvas, size);
    //_drawSecondRect(canvas, size);
  }

  void _drawFirstRect(Canvas canvas, size) {
    Path path = createPath(size);
    PathMetric pathMetric = path.computeMetrics().first;
    Path extracthPath = pathMetric.extractPath(0.0, pathMetric.length * offset);
    canvas.drawPath(extracthPath, pathPaint);
  }

  Path createPath(Size size) {
    Path path = Path();
    path.moveTo(size.width - size.height / 10.0, size.height);
    path.lineTo(size.height * .1, size.height);
    path.lineTo(size.height * .1, size.height * .1);
    path.lineTo(size.width - size.height * .1, size.height * .1);
    path.lineTo(size.width - size.height * .1, size.height);

    path.close();

    return path;
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    // TODO: implement shouldRepaint
    return true;
  }
}
