// ignore_for_file: file_names, unnecessary_new, prefer_const_constructors, prefer_const_literals_to_create_immutables, non_constant_identifier_names, unused_element, use_key_in_widget_constructors, avoid_unnecessary_containers, avoid_print, unused_local_variable

import 'package:bori_app/model/apis/ApiResponse.dart';
import 'package:bori_app/themes/AppColors.dart';
import 'package:bori_app/view/screens/payment/BookingPayment.dart';
import 'package:bori_app/viewModel/BookingViewModel.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';

int _currentIndex = 0;
bool pressed_About = false;
bool pressed_elebrum = false;
bool pressed_contact = false;

final List<String> imagesList = [
  'assets/images/slide1.png',
  'assets/images/vector.png',
];
Icon actionIcon = new Icon(
  Icons.search,
  color: AppTheme.appbar_title,
);
Widget appBarTitle = new Text("Conference",
    style: TextStyle(
      fontWeight: FontWeight.w800,
      color: AppTheme.appbar_title,
      fontSize: 19.2,
    ));

String finalstitle = "";

class BookingDetailsScreen extends StatefulWidget {
  const BookingDetailsScreen({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  _BookingDetailsScreenState createState() => _BookingDetailsScreenState();
}

class _BookingDetailsScreenState extends State<BookingDetailsScreen> {
  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    TextEditingController name = TextEditingController();
    TextEditingController address = TextEditingController();
    TextEditingController number = TextEditingController();
    TextEditingController email = TextEditingController();
    TextEditingController date = TextEditingController();
    TextEditingController month = TextEditingController();
    TextEditingController year = TextEditingController();

    TextEditingController frmhrs = TextEditingController();
    TextEditingController frmmin = TextEditingController();
    TextEditingController tohrs = TextEditingController();
    TextEditingController tomin = TextEditingController();

    ApiResponse apiResponse = Provider.of<BookingViewModel>(context).response;
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.dark.copyWith(
        statusBarColor: Color.fromRGBO(100, 41, 8, 50),
        //or set color with: Color(0xFF0000FF)
        statusBarIconBrightness: Brightness.dark));
    return Scaffold(
      backgroundColor: AppTheme.deco,
      appBar: new AppBar(
          elevation: 0,
          backgroundColor: AppTheme.AppBarTheme,
          leading: IconButton(
            icon: Icon(Icons.arrow_back_ios, color: AppTheme.appbar_title),
            onPressed: () => Navigator.of(context).pop(),
          ),
          centerTitle: true,
          title: Text(widget.title),
          actions: <Widget>[
            new IconButton(
              icon: actionIcon,
              onPressed: () {
                setState(() {
                  if (actionIcon.icon == Icons.search) {
                    actionIcon = new Icon(Icons.close);
                    appBarTitle = new TextField(
                      style: TextStyle(
                        fontWeight: FontWeight.w800,
                        color: AppTheme.appbar_title,
                        fontSize: 19.2,
                      ),
                      decoration: new InputDecoration(
                          prefixIcon: new Icon(Icons.search,
                              color: AppTheme.appbar_title),
                          hintText: "Search...",
                          hintStyle: TextStyle(
                            fontWeight: FontWeight.w800,
                            color: AppTheme.appbar_title,
                            fontSize: 19.2,
                          )),
                    );
                  } else {
                    actionIcon = new Icon(
                      Icons.search,
                      color: AppTheme.appbar_title,
                    );
                    appBarTitle = new Text(widget.title,
                        style: TextStyle(
                          fontWeight: FontWeight.w800,
                          color: AppTheme.appbar_title,
                          fontSize: 19.2,
                        ));
                  }
                });
              },
            ),
          ]),
      body: StatefulBuilder(builder: (context, ss) {
        return new Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Flexible(
              child: Container(
                //   padding: const EdgeInsets.only(bottom: 10),
                // padding: const EdgeInsets.all(10),
                margin: const EdgeInsets.only(top: 10),
                height: MediaQuery.of(context).size.height,
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                  color: AppTheme.more_bg,
                  borderRadius: new BorderRadius.only(
                    topLeft: const Radius.circular(40.0),
                    topRight: const Radius.circular(40.0),
                  ),
                ),
                child: SingleChildScrollView(
                  child: Form(
                    key: formKey,
                    child: new Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Container(
                          padding: const EdgeInsets.only(top: 20, left: 20),
                          child: Text(
                            "Purpose for Booking*",
                            style: TextStyle(
                              fontSize: 14.0,
                              color: AppTheme.AppBarTheme,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        Container(
                          padding: const EdgeInsets.only(
                              left: 20, bottom: 20, right: 20, top: 10),
                          height: 70,
                          child: Theme(
                            data: Theme.of(context)
                                .copyWith(splashColor: Colors.transparent),
                            child: TextFormField(
                              validator: (String? value) {
                                if (value!.isEmpty) {
                                  return 'Name is Required';
                                }
                                return null;
                              },
                              controller: name,
                              autofocus: false,
                              style: TextStyle(
                                  fontSize: 14.0,
                                  color: AppTheme.AppBarTheme,
                                  fontWeight: FontWeight.w400),
                              decoration: InputDecoration(
                                filled: true,
                                fillColor: AppTheme.search_bg,
                                hintText: 'Enter Name',
                                hintStyle:
                                    TextStyle(color: AppTheme.AppBarTheme),
                                contentPadding: const EdgeInsets.only(
                                    left: 14.0, bottom: 8.0, top: 8.0),
                                enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(23.0),
                                    borderSide:
                                        BorderSide(color: AppTheme.more_bg)),
                                focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(23.0),
                                    borderSide:
                                        BorderSide(color: AppTheme.more_bg)),
                              ),
                            ),
                          ),
                        ),
                        Container(
                          padding: const EdgeInsets.only(top: 0, left: 20),
                          child: Text(
                            "Date*",
                            style: TextStyle(
                                fontSize: 14.0,
                                color: AppTheme.AppBarTheme,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                        Container(
                          child: Row(
                            children: [
                              Container(
                                padding: const EdgeInsets.only(
                                    left: 20, bottom: 20, right: 8, top: 10),
                                height: 70,
                                width: 88,
                                child: Theme(
                                  data: Theme.of(context).copyWith(
                                      splashColor: Colors.transparent),
                                  child: TextFormField(
                                    inputFormatters: <TextInputFormatter>[
                                      FilteringTextInputFormatter.allow(
                                          RegExp(r'^(3[0-1]|[012]?[0-9])')),
                                    ],
                                    validator: (String? value) {
                                      if (value!.isEmpty) {
                                        return 'Date';
                                      } else if (value.length > 2) {
                                        return "Invalid";
                                      }
                                      return null;
                                    },
                                    controller: date,
                                    keyboardType: TextInputType.datetime,
                                    autofocus: false,
                                    style: TextStyle(
                                        fontSize: 14.0,
                                        color: AppTheme.AppBarTheme,
                                        fontWeight: FontWeight.w400),
                                    decoration: InputDecoration(
                                      filled: true,
                                      fillColor: AppTheme.search_bg,
                                      hintText: 'DD',
                                      hintStyle: TextStyle(
                                          color: AppTheme.AppBarTheme),
                                      contentPadding: const EdgeInsets.only(
                                          left: 14.0, bottom: 8.0, top: 8.0),
                                      enabledBorder: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(23.0),
                                          borderSide: BorderSide(
                                              color: AppTheme.more_bg)),
                                      focusedBorder: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(23.0),
                                          borderSide: BorderSide(
                                              color: AppTheme.more_bg)),
                                    ),
                                  ),
                                ),
                              ),
                              Container(
                                alignment: Alignment.center,
                                padding: const EdgeInsets.only(
                                    left: 8, bottom: 20, right: 8, top: 10),
                                height: 70,
                                width: 76,
                                child: Theme(
                                  data: Theme.of(context).copyWith(
                                      splashColor: Colors.transparent),
                                  child: TextFormField(
                                    // inputFormatters: <TextInputFormatter>[
                                    //   FilteringTextInputFormatter.allow(
                                    //       RegExp(r'^[1-9][1-2]?$')),
                                    // ],
                                    inputFormatters: <TextInputFormatter>[
                                      FilteringTextInputFormatter.allow(
                                          RegExp(r'^(0?[1-9]|1[012])$')),
                                    ],
                                    validator: (String? value) {
                                      if (value!.isEmpty) {
                                        return 'Month';
                                      } else if (value.length > 2) {
                                        return "Invalid";
                                      }
                                      return null;
                                    },
                                    controller: month,
                                    keyboardType: TextInputType.datetime,
                                    //  textAlign: TextAlign.left,
                                    autofocus: false,
                                    style: TextStyle(
                                        fontSize: 14.0,
                                        color: AppTheme.AppBarTheme,
                                        fontWeight: FontWeight.w400),
                                    decoration: InputDecoration(
                                      filled: true,
                                      fillColor: AppTheme.search_bg,
                                      hintText: 'MM',
                                      hintStyle: TextStyle(
                                          color: AppTheme.AppBarTheme),
                                      contentPadding: const EdgeInsets.only(
                                          left: 14.0, bottom: 8.0, top: 8.0),
                                      enabledBorder: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(23.0),
                                          borderSide: BorderSide(
                                              color: AppTheme.more_bg)),
                                      focusedBorder: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(23.0),
                                          borderSide: BorderSide(
                                              color: AppTheme.more_bg)),
                                    ),
                                  ),
                                ),
                              ),
                              Container(
                                padding: const EdgeInsets.only(
                                    left: 8, bottom: 20, right: 8, top: 10),
                                height: 70,
                                width: 76,
                                child: Theme(
                                  data: Theme.of(context).copyWith(
                                      splashColor: Colors.transparent),
                                  child: TextFormField(
                                    inputFormatters: <TextInputFormatter>[
                                      FilteringTextInputFormatter.allow(
                                          RegExp(r'^([1-9][0-9]*)')),
                                    ],
                                    validator: (String? value) {
                                      if (value!.isEmpty) {
                                        return 'Year';
                                      } else if (value.length > 4) {
                                        return "Invalid";
                                      }
                                      return null;
                                    },
                                    controller: year,
                                    keyboardType: TextInputType.datetime,
                                    autofocus: false,
                                    style: TextStyle(
                                        fontSize: 14.0,
                                        color: AppTheme.AppBarTheme,
                                        fontWeight: FontWeight.w400),
                                    decoration: InputDecoration(
                                      filled: true,
                                      fillColor: AppTheme.search_bg,
                                      hintText: 'YYYY',
                                      hintStyle: TextStyle(
                                          color: AppTheme.AppBarTheme),
                                      contentPadding: const EdgeInsets.only(
                                          left: 14.0, bottom: 8.0, top: 8.0),
                                      enabledBorder: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(23.0),
                                          borderSide: BorderSide(
                                              color: AppTheme.more_bg)),
                                      focusedBorder: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(23.0),
                                          borderSide: BorderSide(
                                              color: AppTheme.more_bg)),
                                    ),
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                        Container(
                          padding: const EdgeInsets.only(top: 0, left: 20),
                          child: Text(
                            "Time slot*",
                            style: TextStyle(
                                fontSize: 14.0,
                                color: AppTheme.AppBarTheme,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                        Container(
                          child: Row(children: [
                            Container(
                              padding: const EdgeInsets.only(
                                  left: 20, bottom: 20, right: 8, top: 10),
                              height: 70,
                              width: 88,
                              child: Theme(
                                data: Theme.of(context)
                                    .copyWith(splashColor: Colors.transparent),
                                child: TextFormField(
                                  controller: frmhrs,
                                  inputFormatters: <TextInputFormatter>[
                                    FilteringTextInputFormatter.allow(
                                        RegExp(r'^(2[0-3]|[01]?[0-9])')),
                                  ],
                                  validator: (String? value) {
                                    if (value!.isEmpty) {
                                      return 'Hrs';
                                    }
                                    return null;
                                  },
                                  keyboardType: TextInputType.datetime,
                                  autofocus: false,
                                  style: TextStyle(
                                      fontSize: 14.0,
                                      color: AppTheme.AppBarTheme,
                                      fontWeight: FontWeight.w400),
                                  decoration: InputDecoration(
                                    filled: true,
                                    fillColor: AppTheme.search_bg,
                                    hintText: 'Hrs',
                                    hintStyle:
                                        TextStyle(color: AppTheme.AppBarTheme),
                                    contentPadding: const EdgeInsets.only(
                                        left: 14.0, bottom: 8.0, top: 8.0),
                                    enabledBorder: OutlineInputBorder(
                                        borderRadius:
                                            BorderRadius.circular(23.0),
                                        borderSide: BorderSide(
                                            color: AppTheme.more_bg)),
                                    focusedBorder: OutlineInputBorder(
                                        borderRadius:
                                            BorderRadius.circular(23.0),
                                        borderSide: BorderSide(
                                            color: AppTheme.more_bg)),
                                  ),
                                ),
                              ),
                            ),
                            Container(
                              padding: const EdgeInsets.only(
                                  left: 8, bottom: 20, right: 8, top: 10),
                              height: 70,
                              width: 76,
                              child: Theme(
                                data: Theme.of(context)
                                    .copyWith(splashColor: Colors.transparent),
                                child: TextFormField(
                                  controller: frmmin,
                                  inputFormatters: <TextInputFormatter>[
                                    FilteringTextInputFormatter.allow(
                                        RegExp(r'^([0-5][0-9]|[01]?[0-9])')),
                                  ],
                                  validator: (String? value) {
                                    if (value!.isEmpty) {
                                      return 'Mins';
                                    }
                                    return null;
                                  },
                                  keyboardType: TextInputType.datetime,
                                  autofocus: false,
                                  style: TextStyle(
                                      fontSize: 14.0,
                                      color: AppTheme.AppBarTheme,
                                      fontWeight: FontWeight.w400),
                                  decoration: InputDecoration(
                                    filled: true,
                                    fillColor: AppTheme.search_bg,
                                    hintText: 'Min',
                                    hintStyle:
                                        TextStyle(color: AppTheme.AppBarTheme),
                                    contentPadding: const EdgeInsets.only(
                                        left: 14.0, bottom: 8.0, top: 8.0),
                                    enabledBorder: OutlineInputBorder(
                                        borderRadius:
                                            BorderRadius.circular(23.0),
                                        borderSide: BorderSide(
                                            color: AppTheme.more_bg)),
                                    focusedBorder: OutlineInputBorder(
                                        borderRadius:
                                            BorderRadius.circular(23.0),
                                        borderSide: BorderSide(
                                            color: AppTheme.more_bg)),
                                  ),
                                ),
                              ),
                            ),
                            Container(
                                padding: EdgeInsets.only(bottom: 10),
                                child: Text(
                                  "To",
                                  style: TextStyle(
                                      color: AppTheme.AppBarTheme,
                                      fontWeight: FontWeight.normal,
                                      fontSize: 16),
                                  textAlign: TextAlign.center,
                                )),
                            Container(
                              child: Row(children: [
                                Container(
                                  padding: const EdgeInsets.only(
                                      left: 8, bottom: 20, right: 8, top: 10),
                                  height: 70,
                                  width: 76,
                                  child: Theme(
                                    data: Theme.of(context).copyWith(
                                        splashColor: Colors.transparent),
                                    child: TextFormField(
                                      keyboardType: TextInputType.number,
                                      inputFormatters: <TextInputFormatter>[
                                        FilteringTextInputFormatter.allow(
                                            RegExp(r'^(2[0-3]|[01]?[0-9])')),
                                      ],
                                      validator: (String? value) {
                                        if (value!.isEmpty) {
                                          return 'Hrs!';
                                        }
                                        return null;
                                      },
                                      controller: tohrs,
                                      autofocus: false,
                                      style: TextStyle(
                                          fontSize: 14.0,
                                          color: AppTheme.AppBarTheme,
                                          fontWeight: FontWeight.w400),
                                      decoration: InputDecoration(
                                        filled: true,
                                        fillColor: AppTheme.search_bg,
                                        hintText: 'Hrs',
                                        hintStyle: TextStyle(
                                            color: AppTheme.AppBarTheme),
                                        contentPadding: const EdgeInsets.only(
                                            left: 14.0, bottom: 8.0, top: 8.0),
                                        enabledBorder: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(23.0),
                                            borderSide: BorderSide(
                                                color: AppTheme.more_bg)),
                                        focusedBorder: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(23.0),
                                            borderSide: BorderSide(
                                                color: AppTheme.more_bg)),
                                      ),
                                    ),
                                  ),
                                ),
                                Container(
                                  padding: const EdgeInsets.only(
                                      left: 8, bottom: 20, right: 8, top: 10),
                                  height: 70,
                                  width: 76,
                                  child: Theme(
                                    data: Theme.of(context).copyWith(
                                        splashColor: Colors.transparent),
                                    child: TextFormField(
                                      keyboardType: TextInputType.number,
                                      inputFormatters: <TextInputFormatter>[
                                        FilteringTextInputFormatter.allow(
                                            RegExp(
                                                r'^([0-5][0-9]|[01]?[0-9])')),
                                      ],
                                      validator: (String? value) {
                                        if (value!.isEmpty) {
                                          return 'Mins!';
                                        }
                                        return null;
                                      },
                                      controller: tomin,
                                      autofocus: false,
                                      style: TextStyle(
                                        fontSize: 14.0,
                                        color: AppTheme.AppBarTheme,
                                        fontWeight: FontWeight.w400,
                                      ),
                                      decoration: InputDecoration(
                                        filled: true,
                                        fillColor: AppTheme.search_bg,
                                        hintText: 'Min',
                                        hintStyle: TextStyle(
                                            color: AppTheme.AppBarTheme),
                                        contentPadding: const EdgeInsets.only(
                                            left: 14.0, bottom: 8.0, top: 8.0),
                                        enabledBorder: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(23.0),
                                            borderSide: BorderSide(
                                                color: AppTheme.more_bg)),
                                        focusedBorder: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(23.0),
                                            borderSide: BorderSide(
                                                color: AppTheme.more_bg)),
                                      ),
                                    ),
                                  ),
                                ),
                              ]),
                            ),
                          ]),
                        ),
                        Container(
                          padding: const EdgeInsets.only(top: 0, left: 20),
                          child: Text(
                            "Address*",
                            style: TextStyle(
                                fontSize: 14.0,
                                color: AppTheme.AppBarTheme,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                        Container(
                          padding: const EdgeInsets.only(
                              left: 20, bottom: 20, right: 20, top: 10),
                          height: 101,
                          child: Theme(
                            data: Theme.of(context)
                                .copyWith(splashColor: Colors.transparent),
                            child: TextFormField(
                              controller: address,
                              validator: (String? value) {
                                if (value!.isEmpty) {
                                  return 'Address is required!';
                                }
                                return null;
                              },
                              minLines: 6,
                              keyboardType: TextInputType.multiline,
                              maxLines: null,
                              autofocus: false,
                              style: TextStyle(
                                  fontSize: 14.0,
                                  color: AppTheme.AppBarTheme,
                                  fontWeight: FontWeight.w400),
                              decoration: InputDecoration(
                                filled: true,
                                fillColor: AppTheme.search_bg,
                                hintText: 'Enter Address',
                                hintStyle:
                                    TextStyle(color: AppTheme.AppBarTheme),
                                contentPadding: const EdgeInsets.only(
                                    left: 14.0, bottom: 8.0, top: 8.0),
                                enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(23.0),
                                    borderSide:
                                        BorderSide(color: AppTheme.more_bg)),
                                focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(23.0),
                                    borderSide:
                                        BorderSide(color: AppTheme.more_bg)),
                              ),
                            ),
                          ),
                        ),
                        Container(
                          padding: const EdgeInsets.only(top: 0, left: 20),
                          child: Text(
                            "Contact Number*",
                            style: TextStyle(
                                fontSize: 14.0,
                                color: AppTheme.AppBarTheme,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                        Container(
                          padding: const EdgeInsets.only(
                              left: 20, bottom: 20, right: 20, top: 10),
                          height: 70,
                          child: Theme(
                            data: Theme.of(context)
                                .copyWith(splashColor: Colors.transparent),
                            child: TextFormField(
                              keyboardType: TextInputType.datetime,
                              validator: (String? value) {
                                if (value!.isEmpty) {
                                  return 'Phone is Required';
                                }else if(value.length != 10){
                                  return 'Invalid Phone Number';
                                }
                                return null;
                              },
                              controller: number,
                              autofocus: false,
                              style: TextStyle(
                                  fontSize: 14.0,
                                  color: AppTheme.AppBarTheme,
                                  fontWeight: FontWeight.w400),
                              decoration: InputDecoration(
                                filled: true,
                                fillColor: AppTheme.search_bg,
                                hintText: 'Enter Contact Number',
                                hintStyle:
                                    TextStyle(color: AppTheme.AppBarTheme),
                                contentPadding: const EdgeInsets.only(
                                    left: 14.0, bottom: 8.0, top: 8.0),
                                enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(23.0),
                                    borderSide:
                                        BorderSide(color: AppTheme.more_bg)),
                                focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(23.0),
                                    borderSide:
                                        BorderSide(color: AppTheme.more_bg)),
                              ),
                            ),
                          ),
                        ),
                        Container(
                          padding: const EdgeInsets.only(top: 0, left: 20),
                          child: Text(
                            "Email Id*",
                            style: TextStyle(
                                fontSize: 16.0,
                                color: AppTheme.AppBarTheme,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                        Container(
                          padding: const EdgeInsets.only(
                              left: 20, bottom: 20, right: 20, top: 10),
                          height: 70,
                          child: Theme(
                            data: Theme.of(context)
                                .copyWith(splashColor: Colors.transparent),
                            child: TextFormField(
                              keyboardType: TextInputType.emailAddress,
                              validator: (String? value) {
                                if (value!.isEmpty) {
                                  return 'Email is Required';
                                }
                                return null;
                              },
                              controller: email,
                              autofocus: false,
                              style: TextStyle(
                                  fontSize: 14.0,
                                  color: AppTheme.AppBarTheme,
                                  fontWeight: FontWeight.w400),
                              decoration: InputDecoration(
                                filled: true,
                                fillColor: AppTheme.search_bg,
                                hintText: 'Enter Email',
                                hintStyle:
                                    TextStyle(color: AppTheme.AppBarTheme),
                                contentPadding: const EdgeInsets.only(
                                    left: 14.0, bottom: 8.0, top: 8.0),
                                enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(23.0),
                                    borderSide:
                                        BorderSide(color: AppTheme.more_bg)),
                                focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(23.0),
                                    borderSide:
                                        BorderSide(color: AppTheme.more_bg)),
                              ),
                            ),
                          ),
                        ),
                        InkWell(
                          onTap: () {
                            if (formKey.currentState!.validate()) {
                              var fullDate =
                                  '${date.text} +"-"+${month.text}+"-"+${year.text}';
                              print(fullDate);
                              print("Full Date $fullDate");

                              print("Name ${name.text}");

                              var fromtime =
                                  '${frmhrs.text} + ":" + ${frmmin.text}';
                              print("From time $fromtime");

                              var totime =
                                  '${tohrs.text} + ":" + ${tomin.text}';
                              print("To time $totime");

                              print("Address ${address.text}");
                              print("Email ${email.text}");
                              print("phone ${number.text}");

                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => BookingPayment(
                                            name: name.text,
                                            email: email.text,
                                            address: address.text,
                                            phone: number.text,
                                            date: fullDate,
                                            fromtime: fromtime,
                                            totime: totime,
                                            fees: '10000',
                                            bookingType: widget.title,
                                          )));
                            }
                          },
                          child: Container(
                            margin: EdgeInsets.all(20),
                            child: SvgPicture.asset(
                              "assets/images/proceed_btn.svg",
                              width: 122,
                              height: 35,
                            ),
                            alignment: Alignment.center,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        );
      }),
    );
  }
}
