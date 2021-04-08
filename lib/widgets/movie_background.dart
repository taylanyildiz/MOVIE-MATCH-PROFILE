import 'package:flutter/material.dart';
import 'package:movie_match_splash_screen/src/src.dart';

class MovieBackground extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          Container(
            height: 150.0,
            child: Stack(
              children: [
                Positioned(
                  left: -10.0,
                  child: Container(
                    height: 150.0,
                    width: 600.0,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: 4,
                      itemBuilder: (context, index) {
                        return Container(
                          width: 100.0,
                          margin: EdgeInsets.only(right: 10.0),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(10.0),
                            child: Image.asset(
                              moviesList[index].imgUrl,
                              fit: BoxFit.cover,
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                )
              ],
            ),
          ),
          SizedBox(height: 10.0),
          Container(
            height: 150.0,
            child: Stack(
              children: [
                Positioned(
                  left: 20.0,
                  child: Container(
                    height: 150.0,
                    width: 600.0,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: 4,
                      itemBuilder: (context, index) {
                        return Container(
                          width: 100.0,
                          margin: EdgeInsets.only(right: 10.0),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(10.0),
                            child: Image.asset(
                              moviesList[index + 4].imgUrl,
                              fit: BoxFit.cover,
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                )
              ],
            ),
          ),
          SizedBox(height: 10.0),
          Container(
            height: 150.0,
            child: Stack(
              children: [
                Positioned(
                  left: -30.0,
                  child: Container(
                    height: 150.0,
                    width: 600.0,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: 4,
                      itemBuilder: (context, index) {
                        return Container(
                          width: 100.0,
                          margin: EdgeInsets.only(right: 10.0),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(10.0),
                            child: Image.asset(
                              moviesList[index + 8].imgUrl,
                              fit: BoxFit.cover,
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 10.0),
          Container(
            height: 150.0,
            child: Stack(
              children: [
                Positioned(
                  left: 0.0,
                  child: Container(
                    height: 150.0,
                    width: 600.0,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: 3,
                      itemBuilder: (context, index) {
                        return Container(
                          width: 100.0,
                          margin: EdgeInsets.only(right: 10.0),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(10.0),
                            child: Image.asset(
                              moviesList[index + 11].imgUrl,
                              fit: BoxFit.cover,
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
