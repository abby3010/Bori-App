// ignore_for_file: unnecessary_new, file_names, prefer_const_constructors, avoid_unnecessary_containers, prefer_const_literals_to_create_immutables, use_key_in_widget_constructors, non_constant_identifier_names, unused_local_variable, unused_element

import 'package:bori_app/model/BookingModel.dart';
import 'package:bori_app/model/apis/ApiResponse.dart';
import 'package:bori_app/themes/AppColors.dart';
import 'package:bori_app/view/screens/payment/AdmissionPayment.dart';
import 'package:bori_app/viewModel/BookingViewModel.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
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
Widget appBarTitle = new Text("Admission",
    style: TextStyle(
      fontWeight: FontWeight.w800,
      color: AppTheme.appbar_title,
      fontSize: 19.2,
    ));
Icon actionIcon = new Icon(
  Icons.search,
  color: AppTheme.appbar_title,
);

class AdmissionScreen extends StatefulWidget {
  @override
  _AdmissionScreenState createState() => _AdmissionScreenState();
}

class _AdmissionScreenState extends State<AdmissionScreen> {
  String dropdownValue = 'Mahabharata';
  String FeeValue = '2400';
  final formKey = GlobalKey<FormState>();
  // List<String> spinnerItems = [
  //   'Mahabharata',
  // ];
  List<String> valueItems = [
    '2400',
  ];
  Widget getMediaWidget(BuildContext context, ApiResponse apiResponse) {
    List<BookingModel>? mediaList = apiResponse.data as List<BookingModel>?;
    switch (apiResponse.status) {
      case Status.LOADING:
        return Center(child: CircularProgressIndicator());
      case Status.COMPLETED:
        return Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Expanded(
              flex: 8, child: Text("Child home"),
              // child: PlayerListWidget(mediaList!, (BookingModel media) {
              //   Provider.of<BookingViewModel>(context, listen: false)
              //       .setSelectedMedia(media);
              // }),
            ),
            Expanded(
              flex: 2,
              child: Align(
                alignment: Alignment.bottomCenter,
                // child: PlayerWidget(
                //   function: () {
                //     setState(() {});
                //   },
                // ),
              ),
            ),
          ],
        );
      case Status.ERROR:
        return Center(
          child: Text('Please try again latter!!!'),
        );
      case Status.INITIAL:
      default:
        return Center(
          child: Text('Search the song by Artist'),
        );
    }
  }

  @override
  Widget build(BuildContext context) {
    TextEditingController name = TextEditingController();
    TextEditingController email = TextEditingController();
    TextEditingController phone = TextEditingController();
    TextEditingController address = TextEditingController();
    TextEditingController age = TextEditingController();
    String? _chosenValue;

    ApiResponse apiResponse = Provider.of<BookingViewModel>(context).response;
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.dark.copyWith(
        statusBarColor: Color.fromRGBO(100, 41, 8, 50),
        //or set color with: Color(0xFF0000FF)
        statusBarIconBrightness: Brightness.dark));
    return Scaffold(
      appBar: new AppBar(
          elevation: 0,
          backgroundColor: AppTheme.AppBarTheme,
          leading: IconButton(
            icon: Icon(Icons.arrow_back_ios, color: Colors.white),
            onPressed: () => Navigator.of(context).pop(),
          ),
          centerTitle: true,
          title: appBarTitle,
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
                          ),
                        ));
                  } else {
                    actionIcon = new Icon(
                      Icons.search,
                      color: AppTheme.appbar_title,
                    );
                    appBarTitle = new Text("Admission",
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
      body: Form(
        key: formKey,
        child: Container(
          child: new Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Flexible(
                  child: Container(
                    // color: AppTheme.more_bg
                    decoration: BoxDecoration(
                      color: AppTheme.deco, //color: C
                    ),
                    child: Container(
                      //   padding: const EdgeInsets.only(bottom: 10),
                      padding: const EdgeInsets.all(10),
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
                        child: new Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Container(
                              padding: const EdgeInsets.only(top: 20, left: 20),
                              child: Text(
                                "Name*",
                                style: TextStyle(
                                    fontSize: 14.0,
                                    color: AppTheme.AppBarTheme,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                            Container(
                              padding: const EdgeInsets.only(
                                left: 20,
                                bottom: 20,
                                right: 20,
                                top: 10,
                              ),
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
                                  keyboardType: TextInputType.name,
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
                                      left: 14.0,
                                      bottom: 8.0,
                                      top: 8.0,
                                    ),
                                    enabledBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(23.0),
                                      borderSide: BorderSide(
                                        color: AppTheme.more_bg,
                                      ),
                                    ),
                                    focusedBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(23.0),
                                      borderSide: BorderSide(
                                        color: AppTheme.more_bg,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            Container(
                              padding: const EdgeInsets.only(top: 0, left: 20),
                              child: Text(
                                "Email*",
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
                                  keyboardType: TextInputType.number,
                                  validator: (String? value) {
                                    if (value!.isEmpty) {
                                      return 'Phone is Required';
                                    }
                                    else if(value.length != 10){
                                      return 'Invalid Phone Number';
                                    }
                                    return null;
                                  },
                                  controller: phone,
                                  autofocus: false,
                                  style: TextStyle(
                                    fontSize: 14.0,
                                    color: AppTheme.AppBarTheme,
                                    fontWeight: FontWeight.w400,
                                  ),
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
                                      borderSide: BorderSide(
                                        color: AppTheme.more_bg,
                                      ),
                                    ),
                                    focusedBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(23.0),
                                      borderSide: BorderSide(
                                        color: AppTheme.more_bg,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
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
                              height: 70,
                              child: Theme(
                                data: Theme.of(context)
                                    .copyWith(splashColor: Colors.transparent),
                                child: TextFormField(
                                  validator: (String? value) {
                                    if (value!.isEmpty) {
                                      return "Please enter Address!";
                                    }
                                  },
                                  controller: address,
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
                              padding: const EdgeInsets.only(top: 0, left: 20),
                              child: Text(
                                "Age*",
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
                                  inputFormatters: <TextInputFormatter>[
                                    FilteringTextInputFormatter.allow(
                                        RegExp(r'^(0?[1-9]|[1-9][0-9]|[1][1-9][1-9])$')),
                                  ],
                                  validator: (String? value) {
                                    if (value!.isEmpty) {
                                      return "Please enter Age!";
                                    }
                                    return null;
                                  },
                                  keyboardType: TextInputType.number,
                                  controller: age,
                                  autofocus: false,
                                  style: TextStyle(
                                      fontSize: 14.0,
                                      color: AppTheme.AppBarTheme,
                                      fontWeight: FontWeight.w400),
                                  decoration: InputDecoration(
                                    filled: true,
                                    fillColor: AppTheme.search_bg,
                                    hintText: 'Enter Age',
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
                              padding: const EdgeInsets.only(top: 0, left: 20),
                              child: Text(
                                "Course*",
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
                                child: StatefulBuilder(
                                  builder: (context, ss) {
                                    return DropdownButtonFormField(
                                      decoration: InputDecoration(
                                        filled: true,
                                        fillColor: AppTheme.search_bg,
                                        contentPadding: const EdgeInsets.only(
                                          left: 14.0,
                                          bottom: 8.0,
                                          top: 8.0,
                                          right: 20,
                                        ),
                                        enabledBorder: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(23.0),
                                          borderSide: BorderSide(
                                            color: AppTheme.more_bg,
                                          ),
                                        ),
                                        focusedBorder: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(23.0),
                                          borderSide: BorderSide(
                                            color: AppTheme.more_bg,
                                          ),
                                        ),
                                      ),
                                      validator: (value) => value == null
                                          ? "Select a Category"
                                          : _chosenValue,
                                      dropdownColor: AppTheme.more_bg,
                                      value: _chosenValue,
                                      onChanged: (String? newValue) {
                                        ss(
                                          () {
                                            _chosenValue = newValue;
                                          },
                                        );
                                      },
                                      //Mahabharata
                                      items: <String>["Mahabharata"]
                                          .map<DropdownMenuItem<String>>(
                                              (String value) {
                                        return DropdownMenuItem<String>(
                                          value: value,
                                          child: Text(
                                            value,
                                            style: TextStyle(
                                              color: Colors.black,
                                            ),
                                          ),
                                        );
                                      }).toList(),
                                      hint: Text(
                                        "Select",
                                        style: TextStyle(
                                          color: AppTheme.AppBarTheme,
                                        ),
                                      ),
                                    );
                                  },
                                ),
                              ),
                            ),
                            Container(
                              margin: EdgeInsets.only(left: 20),
                              child: Text(
                                dropdownValue + ' Course Fee  -  ₹' + FeeValue,
                                style: TextStyle(
                                  fontSize: 16,
                                  color: AppTheme.AppBarTheme,
                                ),
                              ),
                            ),
                            InkWell(
                              onTap: () {
                                if (formKey.currentState!.validate()) {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => AdmissionPayment(
                                        fees: FeeValue,
                                        name: name.text,
                                        email: email.text,
                                        phone: phone.text,
                                        address: address.text,
                                        age: age.text,
                                        course: "Mahabharata",
                                      ),
                                    ),
                                  );
                                }
                              },
                              child: Container(
                                margin: EdgeInsets.all(30),
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
              ]),
        ),
      ),
    );
  }
}
