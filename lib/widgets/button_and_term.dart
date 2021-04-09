import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:movie_match_splash_screen/screens/screens.dart';

class ButtonNetflix extends StatefulWidget {
  @override
  _ButtonNetflixState createState() => _ButtonNetflixState();
}

class _ButtonNetflixState extends State<ButtonNetflix>
    with TickerProviderStateMixin {
  AnimationController _controller;
  AnimationController _controller2;
  Animation<double> _animation2;
  Animation<double> _animation;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 200),
    );
    _controller2 = AnimationController(
      vsync: this,
      duration: Duration(seconds: 2),
    )..forward();
    _animation = Tween<double>(begin: 1.0, end: .96).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Curves.linear,
      ),
    );
    _animation2 = Tween<double>(begin: -300.0, end: 0.0).animate(
      CurvedAnimation(
        parent: _controller2,
        curve: Curves.elasticOut,
      ),
    );
    _animation2.addListener(() {
      Future.delayed(
        Duration(seconds: 2),
        () => setState(() {}),
      );
    });
  }

  Widget _customButton(child) {
    return Transform.scale(
      scale: _animation.value,
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 40.0),
        padding: EdgeInsets.symmetric(vertical: 4.0, horizontal: 15.0),
        decoration: BoxDecoration(
          color: Colors.red,
          borderRadius: BorderRadius.circular(10.0),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Container(
              padding: EdgeInsets.all(3.0),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.white,
              ),
              child: Image.asset(
                'assets/images/netflix.png',
                width: 30.0,
              ),
            ),
            SizedBox(width: 20.0),
            Text(
              'Netflix ile bağlan',
              style: TextStyle(
                color: Colors.white,
                fontSize: 22.0,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void deactivate() {
    // TODO: implement deactivate
    super.deactivate();
    _controller.dispose();
    _controller2.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () async {
        await _controller.forward();
        _controller.reverse();
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => WelcomeScreen()));
      },
      child: AnimatedBuilder(
        animation: _animation,
        builder: (context, child) => _customButton(child),
      ),
    );
  }
}

class TermOfUse extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return RichText(
      textAlign: TextAlign.center,
      text: TextSpan(
        text: "Bağlandığınız zaman gizlilik sözleşmesini ve ",
        style: TextStyle(
          color: Colors.white,
          fontSize: 15.0,
        ),
        children: [
          TextSpan(
            text: 'Kullanım\nŞartlarını',
            style: TextStyle(
              color: Colors.white,
              fontSize: 15.0,
              decoration: TextDecoration.underline,
              decorationThickness: 2.0,
            ),
            recognizer: TapGestureRecognizer()
              ..onTap = () {
                print('şartlar');
              },
          ),
          TextSpan(
            text: " kabul etmiş olursunuz. ",
          ),
          TextSpan(
            text: 'Netflix kullanım\nhakkında',
            style: TextStyle(
              color: Colors.white,
              fontSize: 15.0,
              decoration: TextDecoration.underline,
              decorationThickness: 2.0,
            ),
            recognizer: TapGestureRecognizer()
              ..onTap = () {
                print('netflix bilgi');
              },
          ),
          TextSpan(
            text: " bilgi al",
            style: TextStyle(
              color: Colors.white,
              fontSize: 14.0,
            ),
          ),
        ],
      ),
    );
  }
}
