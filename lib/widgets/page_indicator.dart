import 'package:flutter/material.dart';
import 'package:movie_match_splash_screen/widgets/widgets.dart';

class TextPageIndicator extends StatefulWidget {
  @override
  _TextPageIndicatorState createState() => _TextPageIndicatorState();
}

class _TextPageIndicatorState extends State<TextPageIndicator> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return IndicatorPainter(
      indicatorColor: Colors.red,
      indicatorBackgroundColor: Colors.white,
      itemCount: 4,
      itemBuilder: (context, index) {
        return Container(
          padding: EdgeInsets.symmetric(horizontal: 10.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                welComeHeadText[index],
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 25.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 20.0),
              Text(
                welComeBodyText[index],
                style: TextStyle(color: Colors.white, fontSize: 20.0),
              ),
            ],
          ),
        );
      },
    );
  }
}

final welComeHeadText = <String>[
  "Film Zevklerini Paylaş",
  "İzlediklerin Hakkında yorumlar\nyap",
  "İzlediklerinle Kendi Profilini\nyarat",
  "Film eşini bul",
];
final welComeBodyText = <String>[
  "İzlediğin filmleri paylaş,arkadaşlarının paylaştıklarını gör",
  "Sadece izlediklerin hakkında yorumlar yap başkaların yorumlarınıgör",
  "Yazmada çizmeden profilini yarat",
  "Kimlerle izlediğin filmler eşleşiyor ara bul",
];
