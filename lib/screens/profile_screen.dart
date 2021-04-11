import 'package:flutter/material.dart';

import 'package:movie_match_profile/widgets/widgets.dart';

class ProfileScreen extends StatefulWidget {
  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

String name;
String userName;
String birthDate;
String about;
String mail;

class _ProfileScreenState extends State<ProfileScreen> {
  //Profile Editing
  var listProfile;
  //PageView Controller
  var _pageController;
  var currentPage = 0;
  var focusForm = 0;
  // Keys
  var listKey = <GlobalKey<FormState>>[];
  GlobalKey _keyName;
  GlobalKey _keyUser;
  GlobalKey _keyBirth;
  GlobalKey _keyAbout;
  GlobalKey _keyMail;
  var listController;
  //TextController
  TextEditingController _controllerName;
  TextEditingController _controllerUser;
  TextEditingController _controllerBirth;
  TextEditingController _controllerAbout;
  TextEditingController _controllerMail;
  //FocusNode
  final FocusNode _nodeName = FocusNode();
  final FocusNode _nodeUser = FocusNode();
  final FocusNode _nodeBirth = FocusNode();
  final FocusNode _nodeAbout = FocusNode();
  final FocusNode _nodeMail = FocusNode();
  final FocusNode _nodeSex = FocusNode();

  var focusNode = <FocusNode>[];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    //PageController
    _pageController = PageController(initialPage: 0);

    //keys
    _keyName = GlobalKey<FormState>();
    _keyUser = GlobalKey<FormState>();
    _keyBirth = GlobalKey<FormState>();
    _keyAbout = GlobalKey<FormState>();
    _keyMail = GlobalKey<FormState>();
    //Key List
    listKey = [
      _keyName,
      _keyUser,
      _keyBirth,
      _keyAbout,
      _keyMail,
    ];
    //Controllers
    _controllerName = TextEditingController();
    _controllerUser = TextEditingController();
    _controllerBirth = TextEditingController();
    _controllerAbout = TextEditingController();
    _controllerMail = TextEditingController();
    //controller List
    listController = [
      _controllerName,
      _controllerUser,
      _controllerBirth,
      _controllerAbout,
      _controllerMail,
    ];
    //Focus
    focusNode = [
      _nodeName,
      _nodeUser,
      _nodeBirth,
      _nodeAbout,
      _nodeMail,
      _nodeSex,
      _nodeSex,
      _nodeSex,
    ];
  }

  nextClick() async {
    if (currentPage < listProfile.length - 1) {
      if (currentPage < listKey.length) {
        if (listKey[currentPage].currentState.validate()) {
          name = _controllerName.text;
          userName = _controllerUser.text;
          birthDate = _controllerBirth.text;
          about = _controllerAbout.text;
          mail = _controllerMail.text;

          currentPage++;
          if (focusForm < focusNode.length - 1) {
            focusForm++;
          }
        }
      } else
        currentPage++;
    }
    if (currentPage == 2 || currentPage >= 5) {
      await FocusScope.of(context).requestFocus(focusNode[currentPage]);
      _pageController.animateToPage(
        currentPage,
        duration: Duration(seconds: 1),
        curve: Curves.linear,
      );
    } else if (currentPage < 5) {
      await _pageController.animateToPage(
        currentPage,
        duration: Duration(seconds: 1),
        curve: Curves.linear,
      );
      FocusScope.of(context).requestFocus(focusNode[currentPage]);
    }

    setState(() {});
  }

  backClick() async {
    if (currentPage != 0) {
      currentPage--;
      focusForm--;
    }
    await _pageController.animateToPage(
      currentPage,
      duration: Duration(seconds: 1),
      curve: Curves.linear,
    );

    FocusScope.of(context).requestFocus(focusNode[currentPage]);
    setState(() {});
  }

  Future<List<Widget>> profilePages() async {
    listProfile = [
      ProfileWidget(
        formKey: listKey[0],
        controller: _controllerName,
        id: 0,
        hintText: 'İsmin',
        node: focusNode[0],
      ),
      ProfileWidget(
        formKey: listKey[1],
        controller: _controllerUser,
        id: 1,
        hintText: 'Kullanıcı adın',
        name: "Selam ${name},\nkullanıcı adın ne olsun?",
        node: focusNode[1],
      ),
      ProfileWidget(
        formKey: listKey[2],
        controller: _controllerBirth,
        id: 2,
        absorbing: true,
        hintText: 'Doğum günün',
        keyboarType: TextInputType.datetime,
      ),
      ProfileWidget(
        formKey: listKey[3],
        controller: _controllerAbout,
        id: 3,
        hintText: 'Film zevklerimiz uyuşsun yeter',
        node: focusNode[3],
      ),
      ProfileWidget(
        formKey: listKey[4],
        controller: _controllerMail,
        id: 4,
        hintText: 'e-posta',
        keyboarType: TextInputType.emailAddress,
        node: focusNode[4],
      ),
      ProfileWidget(
        id: 5,
        textInput: false,
        node: focusNode[5],
      ),
      ProfileWidget(
        id: 6,
        textInput: false,
        prefer: true,
      ),
    ];
    return listProfile;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset:
          currentPage == 2 || currentPage >= 5 ? false : true,
      appBar: AppBar(
        backgroundColor: Colors.black,
        elevation: 0.0,
        leading: currentPage != 0
            ? IconButton(
                icon: Icon(Icons.arrow_back_ios),
                color: Colors.white,
                onPressed: () => backClick(),
              )
            : SizedBox.shrink(),
      ),
      backgroundColor: Colors.black,
      body: SafeArea(
        child: Stack(
          alignment: Alignment.center,
          children: [
            FutureBuilder<List<Widget>>(
              future: profilePages(),
              builder: (context, constraint) {
                if (constraint.hasData) {
                  return PageView.builder(
                    controller: _pageController,
                    physics: NeverScrollableScrollPhysics(),
                    onPageChanged: (page) {
                      currentPage = page;
                      print(currentPage);
                      setState(() {});
                    },
                    itemCount: constraint.data.length,
                    itemBuilder: (context, index) {
                      return constraint.data[index];
                    },
                  );
                } else {
                  return Text(
                    'Error',
                    style: TextStyle(
                      color: Colors.white,
                    ),
                  );
                }
              },
            ),
            Positioned(
              top: 0.0,
              child: Container(
                height: 10.0,
                width: MediaQuery.of(context).size.width,
                color: Colors.white,
                child: CustomPaint(
                  painter: SliderIndicator(
                    sliderColor: Colors.orange,
                    backgroundColor: Colors.grey,
                    offset: currentPage * 1.0,
                  ),
                ),
              ),
            ),
            Positioned(
              bottom: 10.0,
              width: MediaQuery.of(context).size.width * .95,
              child: MaterialButton(
                color: Colors.red,
                textColor: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(5.0),
                ),
                child: Text(
                  'Devam et',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 17.0,
                  ),
                ),
                onPressed: () => nextClick(),
              ),
            )
          ],
        ),
      ),
    );
  }
}

class SliderIndicator extends CustomPainter {
  final Color backgroundColor;
  final Color sliderColor;
  final Paint paintIndicator;
  final Paint paintBackground;
  final double offset;
  SliderIndicator({
    @required this.offset,
    @required this.backgroundColor,
    @required this.sliderColor,
  })  : paintIndicator = Paint()
          ..color = sliderColor
          ..strokeCap = StrokeCap.round
          ..style = PaintingStyle.stroke
          ..strokeWidth = 10.0,
        paintBackground = Paint()
          ..color = backgroundColor
          ..strokeCap = StrokeCap.square
          ..style = PaintingStyle.stroke
          ..strokeWidth = 10.0;
  @override
  void paint(Canvas canvas, Size size) {
    _drawBackground(canvas, size);
    _drawSliderIndicator(canvas, size);
  }

  void _drawBackground(Canvas canvas, Size size) {
    Path path = Path();
    path.moveTo(0.0, size.height / 2);
    path.lineTo(size.width, size.height / 2);
    canvas.drawPath(path, paintBackground);
  }

  void _drawSliderIndicator(Canvas canvas, Size size) {
    final int pageIndexToLeft = offset.round();
    final double leftDotX =
        (0.0) + (pageIndexToLeft * ((2 * 10) + size.width / 9));
    final double transitionPercent = offset - pageIndexToLeft;
    final double indicatorLeftX =
        leftDotX + (transitionPercent * ((2 * 10) + 10));
    final double indicatorRightX = indicatorLeftX + (2 * 10);

    canvas.drawRRect(
      RRect.fromLTRBR(
        0.0,
        size.height / 2,
        indicatorRightX,
        0.0,
        Radius.circular(10.0),
      ),
      paintIndicator,
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
