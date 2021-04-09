import 'dart:async';

import 'package:flutter/material.dart';

class IndicatorPainter extends StatefulWidget {
  Color backgroundColor;
  Color indicatorColor;
  Color indicatorBackgroundColor;
  final int itemCount;
  final Widget Function(BuildContext context, int index) itemBuilder;

  IndicatorPainter({
    Key key,
    Color backgroundColor,
    Color indicatorColor,
    Color indicatorBackgroundColor,
    @required this.itemCount,
    @required this.itemBuilder,
  })  : indicatorBackgroundColor = indicatorBackgroundColor ?? Colors.grey,
        indicatorColor = indicatorColor ?? Colors.red,
        backgroundColor = backgroundColor ?? null,
        super(key: key);

  @override
  _IndicatorPainterState createState() => _IndicatorPainterState();
}

class _IndicatorPainterState extends State<IndicatorPainter>
    with TickerProviderStateMixin {
  PageController _pageController;
  AnimationController _animationController;
  Animation _animation;
  Timer timer;
  int pageCount = 0;

  Widget pageItem(context, index) {
    return AnimatedBuilder(
      animation: _pageController,
      builder: (context, child) => widget.itemBuilder(context, index),
    );
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: Duration(seconds: 1),
    )..repeat();
    _animation = CurvedAnimation(
      parent: _animationController,
      curve: Curves.linear,
    );
    _pageController = PageController(initialPage: 0);
    _animation.addListener(() {
      setState(() {});
    });

    timer = Timer.periodic(Duration(seconds: 8), (timer) {
      if (pageCount != widget.itemCount - 1) {
        pageCount++;
      } else {
        pageCount = 0;
      }
      _pageController.animateToPage(
        pageCount,
        duration: Duration(milliseconds: 600),
        curve: Curves.linear,
      );
    });
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

  @override
  void deactivate() {
    // TODO: implement deactivate
    super.deactivate();
    _animationController.dispose();
    timer.cancel();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        height: 200,
        color: widget.backgroundColor,
        child: Column(
          children: [
            Align(
              alignment: Alignment.topRight,
              child: Container(
                width: 120.0,
                height: 15.0,
                child: CustomPaint(
                  painter: PageIndicatorPaint(
                    indicatorBackgroundColor: widget.indicatorBackgroundColor,
                    indicatorColor: widget.indicatorColor,
                    pageCount: widget.itemCount,
                    scrollPage: _pageController.hasClients &&
                            _pageController.page != null
                        ? _pageController.page
                        : 0.0,
                  ),
                ),
              ),
            ),
            SizedBox(height: 30.0),
            Container(
              height: 150.0,
              child: PageView.builder(
                controller: _pageController,
                itemCount: widget.itemCount,
                itemBuilder: (context, index) => pageItem(context, index),
                onPageChanged: (page) => pageCount = page,
              ),
            )
          ],
        ),
      ),
    );
  }
}

class PageIndicatorPaint extends CustomPainter {
  final Color indicatorColor;
  final Color indicatorBackgroundColor;
  final int pageCount;
  final double scrollPage;
  double radius;
  double space;
  double thickness;

  PageIndicatorPaint({
    this.indicatorColor,
    this.indicatorBackgroundColor,
    this.pageCount,
    this.scrollPage,
    double radius,
    double space,
    double thickness,
  })  : indicatorPaint = Paint()..color = indicatorColor,
        backgroundPaint = Paint()..color = indicatorBackgroundColor,
        thickness = thickness ?? 3.0,
        space = space ?? 10.0,
        radius = radius ?? 8.0;
  final Paint indicatorPaint;
  final Paint backgroundPaint;
  @override
  void paint(Canvas canvas, Size size) {
    final Offset offset = Offset(radius, size.height / 2);
    final double totalWidth =
        (2 * pageCount * radius) + (pageCount - 1) * radius;
    _drawIndicatorBackground(canvas, offset, size);
    _drawIndicator(canvas, offset, totalWidth);
  }

  void _drawIndicator(Canvas canvas, Offset offset, double totalWidth) {
    final int pageIndexToLeft = scrollPage.round();
    final double leftDotX =
        (offset.dx - radius) + (pageIndexToLeft * ((2 * radius) + space));
    final double transitionPercent = scrollPage - pageIndexToLeft;
    final double indicatorLeftX =
        leftDotX + (transitionPercent * ((2 * radius) + space));
    final double indicatorRightX = indicatorLeftX + (2 * radius);

    canvas.drawRRect(
      RRect.fromLTRBR(
        indicatorLeftX + thickness - 1,
        0,
        indicatorRightX,
        2 * radius - thickness,
        Radius.circular(radius),
      ),
      indicatorPaint,
    );
  }

  void _drawIndicatorBackground(Canvas canvas, Offset offset, Size size) {
    for (var i = 0; i < pageCount; i++) {
      canvas.drawCircle(offset, radius - thickness, backgroundPaint);
      offset = offset.translate((2 * radius + space), 0);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    // TODO: implement shouldRepaint
    return true;
  }
}
