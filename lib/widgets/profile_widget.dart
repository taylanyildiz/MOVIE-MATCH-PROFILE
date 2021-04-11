import 'package:flutter/material.dart';
import 'package:movie_match_profile/modal/profile_text.dart';

import 'package:flutter_cupertino_date_picker/flutter_cupertino_date_picker.dart';

// date time SETTINGS
const String MIN_DATETIME = '1921-03-16';
const String MAX_DATETIME = '2015-11-25';
const String INIT_DATETIME = '2010-05-17';
const String DATE_FORMAT = 'dd-MMMM-yyyy';
DateTime dateTimeCus;
var listSex = [false, false, false];
var listPrefer = [false, false, false];

class ProfileWidget extends StatefulWidget {
  final int id;
  final TextEditingController controller;
  final GlobalKey formKey;
  final FocusNode node;
  final String hintText;
  String name;
  TextInputType keyboarType;
  bool absorbing;
  bool textInput;
  bool prefer;

  ProfileWidget({
    Key key,
    this.node,
    this.absorbing = false,
    this.prefer = false,
    this.keyboarType = TextInputType.text,
    bool textInput,
    String name,
    @required this.controller,
    @required this.formKey,
    @required this.id,
    @required this.hintText,
  })  : textInput = textInput ?? true,
        name = name ?? "",
        super(key: key);

  @override
  _ProfileWidgetState createState() => _ProfileWidgetState();
}

class _ProfileWidgetState extends State<ProfileWidget> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.black,
      body: Stack(
        children: [
          Container(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  margin: EdgeInsets.fromLTRB(10.0, 80.0, 10.0, 30.0),
                  child: Text(
                    widget.id == 1 ? widget.name : profileHead[widget.id],
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 25.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                widget.textInput ? _textFormField() : _sexSelectButton(context),
                Container(
                  margin: EdgeInsets.fromLTRB(10.0, 20.0, 10.0, 0.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Icon(
                        Icons.person,
                        color: Colors.red,
                      ),
                      SizedBox(width: 5.0),
                      Text(
                        profileBody[widget.id],
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 15.0,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          widget.absorbing
              ? Positioned(
                  bottom: 50.0,
                  child: Container(
                    height: 250,
                    width: MediaQuery.of(context).size.width,
                    child: DatePickerWidget(
                      locale: DateTimePickerLocale.tr,
                      minDateTime: DateTime.parse(MIN_DATETIME),
                      maxDateTime: DateTime.parse(MAX_DATETIME),
                      initialDateTime: dateTimeCus != null
                          ? dateTimeCus
                          : DateTime.parse(INIT_DATETIME),
                      dateFormat: DATE_FORMAT,
                      pickerTheme: DateTimePickerTheme(
                        showTitle: false,
                        title: SizedBox.shrink(),
                        backgroundColor: Colors.black,
                        itemTextStyle: TextStyle(
                          color: Colors.white,
                        ),
                        pickerHeight: 200.0,
                        itemHeight: 50.0,
                      ),
                      onChange: (dateTime, selectedIndex) {
                        widget.controller.text =
                            '${dateTime.day}/${dateTime.month}/${dateTime.year}';
                        dateTimeCus = dateTime;
                      },
                      onMonthChangeStartWithFirstDate: false,
                    ),
                  ),
                )
              : SizedBox.shrink(),
        ],
      ),
    );
  }

  _textFormField() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 10.0),
      child: Form(
        key: widget.formKey,
        child: AbsorbPointer(
          absorbing: widget.absorbing,
          child: TextFormField(
            controller: widget.controller,
            cursorColor: Colors.grey,
            focusNode: !widget.absorbing ? widget.node : null,
            keyboardType: widget.keyboarType,
            autofocus: true,
            style: TextStyle(
              color: Colors.black,
              fontSize: 18.0,
              fontWeight: FontWeight.bold,
            ),
            validator: (result) {
              if (result.isEmpty) {
                return 'Boş bırakılamaz';
              } else {
                return null;
              }
            },
            decoration: InputDecoration(
              hintText: widget.hintText,
              hintStyle: TextStyle(
                color: Colors.black,
                fontSize: 16.0,
              ),
              filled: true,
              fillColor: Colors.white,
              enabledBorder: OutlineInputBorder(),
              focusedBorder: OutlineInputBorder(),
              errorBorder: OutlineInputBorder(),
              border: OutlineInputBorder(),
            ),
          ),
        ),
      ),
    );
  }

  _sexSelectButton(context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: 220.0,
      child: ListView.builder(
        padding: EdgeInsets.symmetric(horizontal: 10.0),
        physics: NeverScrollableScrollPhysics(),
        itemCount: sexList.length,
        itemBuilder: (context, index) => _sexButton(index),
      ),
    );
  }

  _sexButton(int index) {
    return GestureDetector(
      onTap: () {
        if (widget.prefer) {
          listSex = [false, false, false];
          listSex[index] = !listSex[index];
          print(listSex);
        } else if (!widget.prefer) {
          listPrefer = [false, false, false];
          listPrefer[index] = !listPrefer[index];
        }
        setState(() {});
      },
      child: AnimatedContainer(
        duration: Duration(milliseconds: 100),
        padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 15.0),
        margin: EdgeInsets.symmetric(vertical: 10.0),
        decoration: BoxDecoration(
          color: (() {
            if (widget.prefer) {
              return !listSex[index] ? Color(0xFFE6EBEF) : Colors.red;
            } else {
              return !listPrefer[index] ? Color(0xFFE6EBEF) : Colors.red;
            }
          }()),
          borderRadius: BorderRadius.circular(10.0),
        ),
        child: Text(
          !widget.prefer ? sexList[index] : preferList[index],
          style: TextStyle(
            color: (() {
              if (widget.prefer) {
                return !listSex[index] ? Colors.black : Colors.white;
              } else {
                return !listPrefer[index] ? Colors.black : Colors.white;
              }
            }()),
            fontSize: 20.0,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}
