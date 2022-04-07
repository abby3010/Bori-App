// ignore_for_file: file_names, prefer_const_literals_to_create_immutables, prefer_const_constructors, unnecessary_new, avoid_unnecessary_containers, unused_local_variable, use_key_in_widget_constructors

import 'package:bori_app/model/BookingModel.dart';
import 'package:bori_app/model/apis/ApiResponse.dart';
import 'package:bori_app/themes/AppColors.dart';
import 'package:bori_app/view/screens/MainActivityAdmission.dart';
import 'package:bori_app/view/screens/MainActivityBookingList.dart';
import 'package:bori_app/view/screens/MainActivityLibrary.dart';
import 'package:bori_app/view/screens/MainActivityMahabharata.dart';
import 'package:bori_app/viewModel/BookingViewModel.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';

import 'AboutScreen.dart';

int _currentIndex = 0;
final List<String> imagesList = [
  'assets/images/know.png',
  'assets/images/manuscript.png',
];

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    // SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual, overlays: []);
    super.initState();
  }

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
    final _inputController = TextEditingController();
    ApiResponse apiResponse = Provider.of<BookingViewModel>(context).response;
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.dark.copyWith(
        statusBarColor: Color.fromRGBO(100, 41, 8, 50),
        //or set color with: Color(0xFF0000FF)
        statusBarIconBrightness: Brightness.dark));
    return Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: AppTheme.more_bg,
        appBar: AppBar(
          elevation: 0,
          backgroundColor: AppTheme.AppBarTheme,
          title: Text(
            'Bhandarkar Oriental Research Institute',
            style: TextStyle(
                color: AppTheme.appbar_title,
                fontSize: 19,
                fontWeight: FontWeight.w600),
          ),
          automaticallyImplyLeading: false,
        ),
        body: Container(
            child: new Column(children: [
          Flexible(
            child: Container(
              child: Container(
                  child: Container(
                      decoration: BoxDecoration(
                        color: AppTheme.deco, //color: C
                      ),
                      child: Container(
                          //   padding: const EdgeInsets.only(bottom: 10),
                          alignment: Alignment.center,
                          padding: const EdgeInsets.only(
                            top: 10,
                            left: 10,
                            right: 10,
                          ),
                          margin: const EdgeInsets.only(top: 10),
                          decoration: BoxDecoration(
                            color: AppTheme.more_bg, //color: Colors.green,
                            borderRadius: new BorderRadius.only(
                              topLeft: const Radius.circular(40.0),
                              topRight: const Radius.circular(40.0),
                            ),
                          ),
                          child: Container(
                              child: SingleChildScrollView(
                            child: Column(children: [
                              Container(
                                margin: EdgeInsets.symmetric(horizontal: 10.0),
                                alignment: Alignment.center,
                                decoration: BoxDecoration(
                                  color: Theme.of(context)
                                      .colorScheme
                                      .secondary
                                      .withAlpha(50),
                                  borderRadius: BorderRadius.circular(30.0),
                                ),
                                child: TextField(
                                  style: TextStyle(
                                    fontSize: 14.0,
                                    color: AppTheme.AppBarTheme,
                                  ),
                                  textAlignVertical: TextAlignVertical.center,
                                  controller: _inputController,
                                  onChanged: (value) {},
                                  onSubmitted: (value) {
                                    if (value.isNotEmpty) {
                                      Provider.of<BookingViewModel>(context,
                                              listen: false)
                                          .setSelectedMedia(null);
                                      Provider.of<BookingViewModel>(context,
                                              listen: false)
                                          .fetchMediaData(value);
                                    }
                                  },
                                  decoration: InputDecoration(
                                    contentPadding: EdgeInsets.only(top: 20.0),

                                    enabledBorder: OutlineInputBorder(
                                        borderRadius:
                                            BorderRadius.circular(25.0),
                                        borderSide: BorderSide(
                                            color: AppTheme.more_bg)),
                                    focusedBorder: OutlineInputBorder(
                                        borderRadius:
                                            BorderRadius.circular(25.0),
                                        borderSide: BorderSide(
                                            color: AppTheme.more_bg)),
                                    fillColor: AppTheme.search_bg,
                                    filled: true,
                                    prefixIcon: Icon(
                                      Icons.search,
                                      color: AppTheme.AppBarTheme,
                                    ),
                                    hintText: 'Search',
                                    hintStyle: TextStyle(
                                      color: AppTheme.AppBarTheme,
                                      fontWeight: FontWeight.normal,
                                      fontSize: 14,
                                    ),

                                    // floatingLabelAlignment: FloatingLabelAlignment.center,

                                    alignLabelWithHint: true,
                                    suffixIcon: Icon(
                                      Icons.mic_none,
                                      color: AppTheme.AppBarTheme,
                                    ),
                                  ),
                                ),
                              ),
                              SingleChildScrollView(
                                  child: Container(
                                margin: EdgeInsets.only(top: 10),
                                child: Column(
                                  children: <Widget>[
                                    CarouselSlider(
                                      options: CarouselOptions(
                                        autoPlay: true,
                                        enlargeCenterPage: true,
                                        viewportFraction: 1,
                                        height:
                                            MediaQuery.of(context).size.height /
                                                5,

                                        //scrollDirection: Axis.vertical,
                                        onPageChanged: (index, reason) {
                                          setState(
                                            () {
                                              _currentIndex = index;
                                            },
                                          );
                                        },
                                      ),
                                      items: imagesList
                                          .map(
                                            (item) => Padding(
                                              padding: const EdgeInsets.only(
                                                  left: 8.0,
                                                  top: 0.0,
                                                  right: 8.0,
                                                  bottom: 0.0),
                                              child: Card(
                                                margin: EdgeInsets.only(
                                                  top: 1.0,
                                                  bottom: 1.0,
                                                ),
                                                //   elevation: 6.0,
                                                //  shadowColor: Colors.redAccent,
                                                shape: RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          30.0),
                                                ),
                                                child: ClipRRect(
                                                  borderRadius:
                                                      BorderRadius.all(
                                                    Radius.circular(30.0),
                                                  ),
                                                  child: Stack(
                                                    children: <Widget>[
                                                      GestureDetector(
                                                        onTap: () {
                                                          Navigator.of(context,
                                                                  rootNavigator:
                                                                      true)
                                                              .push(
                                                            MaterialPageRoute(
                                                              builder: (context) =>
                                                                  AboutScreen(),
                                                            ),
                                                          );
                                                        },
                                                        child: Image.asset(
                                                          item,
                                                          fit: BoxFit.fill,
                                                          width:
                                                              double.infinity,
                                                          height:
                                                              double.infinity,
                                                        ),
                                                      ),
                                                      // Center(
                                                      // child: Text(
                                                      // '${titles[_currentIndex]}',
                                                      // style: TextStyle(
                                                      // fontSize: 24.0,
                                                      // fontWeight: FontWeight.bold,
                                                      // backgroundColor: Colors.black45,
                                                      // color: Colors.white,
                                                      // ),
                                                      // ),
                                                      // ),
                                                    ],
                                                  ),
                                                ),
                                              ),
                                            ),
                                          )
                                          .toList(),
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: imagesList.map((urlOfItem) {
                                        int index =
                                            imagesList.indexOf(urlOfItem);
                                        return Container(
                                          width: 100.0,
                                          height: 2.0,
                                          margin: EdgeInsets.symmetric(
                                              vertical: 10.0, horizontal: 0.0),
                                          decoration: BoxDecoration(
                                            shape: BoxShape.rectangle,
                                            color: _currentIndex == index
                                                ? Color.fromRGBO(
                                                    100, 41, 8, 0.8)
                                                : Color.fromRGBO(
                                                    243, 204, 158, 0.3),
                                          ),
                                        );
                                      }).toList(),
                                    ),

                                    Container(
                                      color: AppTheme.more_bg,
                                      width: double.infinity,
                                      margin: EdgeInsets.only(
                                          left: 10.0,
                                          right: 10.0,
                                          top: 10.0,
                                          bottom: 5),
                                      child: Text('BORI Exclusive',
                                          style: TextStyle(
                                              fontSize: 18.0,
                                              color: AppTheme.AppBarTheme,
                                              fontWeight: FontWeight.w900),
                                          textAlign: TextAlign.left),
                                    ),
                                    Container(
                                      //  color:AppTheme.more_bg,
                                      margin: EdgeInsets.only(
                                          left: 10.0, right: 10.0, bottom: 10),
                                      decoration: BoxDecoration(
                                        color: AppTheme.more_bg,
                                      ),
                                      child: Material(
                                        color: AppTheme.more_bg,
                                        child: InkWell(
                                          onTap: () {
                                            Navigator.of(context,
                                                    rootNavigator: true)
                                                .push(
                                              MaterialPageRoute(
                                                builder: (context) =>
                                                    MainActivityMahabharata(),
                                              ),
                                            );
                                          },
                                          child: ClipRRect(
                                            borderRadius:
                                                BorderRadius.circular(20.0),
                                            child: Image.asset(
                                              'assets/images/mahabharat.png',
                                              fit: BoxFit.fitWidth,
                                              width: double.infinity,
                                              height: MediaQuery.of(context)
                                                      .size
                                                      .height /
                                                  6.5,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                    // Container(
                                    //   margin: EdgeInsets.only(left: 10.0, right: 10.0),
                                    //   child: Image.asset(
                                    //     'assets/images/manuscript.png',
                                    //     fit: BoxFit.fitWidth,
                                    //     width: double.infinity,
                                    //     height: MediaQuery
                                    //         .of(context)
                                    //         .size
                                    //         .height / 5,
                                    //   ),
                                    // ),
                                    Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Expanded(
                                            child: Material(
                                              color: AppTheme.more_bg,
                                              child: InkWell(
                                                onTap: () {
                                                  Navigator.of(context).push(
                                                      MaterialPageRoute(
                                                          builder: (context) =>
                                                              MainActivityAdmission()));
                                                },
                                                child: Column(
                                                  children: <Widget>[
                                                    //  margin: EdgeInsets.only(left:10.0,right: 10.0),
                                                    Padding(
                                                      padding:
                                                          const EdgeInsets.only(
                                                              left: 10.0,
                                                              right: 5.0),
                                                      child: Image.asset(
                                                        'assets/images/admission.png',
                                                        // width:50.0,
                                                        // height:50.0,semanticsLabel: "booking",
                                                      ),
                                                    ),

                                                    Padding(
                                                      padding:
                                                          const EdgeInsets.only(
                                                              left: 9.9,
                                                              top: 6),
                                                      child: Text(
                                                        'Admission',
                                                        textAlign:
                                                            TextAlign.center,
                                                        style: TextStyle(
                                                            fontSize: 14.0,
                                                            color: AppTheme
                                                                .AppBarTheme,
                                                            fontWeight:
                                                                FontWeight
                                                                    .w900),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                          ),
                                          Expanded(
                                            child: Material(
                                              color: AppTheme.more_bg,
                                              child: InkWell(
                                                onTap: () {
                                                  Navigator.of(context).push(
                                                      MaterialPageRoute(
                                                          builder: (context) =>
                                                              MainActivityLibrary()));
                                                },
                                                child: Column(
                                                  children: <Widget>[
                                                    //  margin: EdgeInsets.only(left:10.0,right: 10.0),

                                                    Padding(
                                                      padding:
                                                          const EdgeInsets.only(
                                                              left: 7.5,
                                                              right: 7.5),
                                                      child: Image.asset(
                                                        'assets/images/library.png',

                                                        // width:50.0,
                                                        // height:50.0,semanticsLabel: "booking",
                                                      ),
                                                    ),
                                                    Padding(
                                                      padding:
                                                          const EdgeInsets.only(
                                                              left: 9.6,
                                                              top: 6),
                                                      child: Text(
                                                        'Library',
                                                        style: TextStyle(
                                                            fontSize: 14.0,
                                                            color: AppTheme
                                                                .AppBarTheme,
                                                            fontWeight:
                                                                FontWeight
                                                                    .w900),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                          ),
                                          Expanded(
                                            child: Material(
                                              color: AppTheme.more_bg,
                                              child: InkWell(
                                                onTap: () {
                                                  Navigator.of(context).push(
                                                      MaterialPageRoute(
                                                          builder: (context) =>
                                                              MainActivityBookingList()));
                                                },
                                                child: Column(
                                                  children: <Widget>[
                                                    //  margin: EdgeInsets.only(left:10.0,right: 10.0),
                                                    Padding(
                                                      padding:
                                                          const EdgeInsets.only(
                                                              left: 5.0,
                                                              right: 10.0),
                                                      child: Image.asset(
                                                        'assets/images/booking.png',
                                                        // width:50.0,
                                                        // height:50.0,semanticsLabel: "booking",
                                                      ),
                                                    ),
                                                    Padding(
                                                      padding:
                                                          const EdgeInsets.only(
                                                              left: 6.1,
                                                              top: 6),
                                                      child: Text(
                                                        'Booking',
                                                        style: TextStyle(
                                                            fontSize: 14.0,
                                                            color: AppTheme
                                                                .AppBarTheme,
                                                            fontWeight:
                                                                FontWeight
                                                                    .w900),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                          ),
                                        ]),
                                    Container(
                                      width: double.infinity,
                                      color: AppTheme.more_bg,
                                      margin: EdgeInsets.only(
                                          left: 10.0,
                                          right: 10.0,
                                          top: 15.0,
                                          bottom: 5),
                                      child: Text('Latest Updates',
                                          style: TextStyle(
                                              fontSize: 18.0,
                                              color: AppTheme.AppBarTheme,
                                              fontWeight: FontWeight.w900),
                                          textAlign: TextAlign.left),
                                    ),
                                    Container(
                                      margin: EdgeInsets.only(
                                          left: 10.0,
                                          right: 10.0,
                                          top: 3,
                                          bottom: 5),
                                      child: ClipRRect(
                                        borderRadius:
                                            BorderRadius.circular(20.0),
                                        child: Image.asset(
                                          'assets/images/latest_update_bg.png',
                                          fit: BoxFit.fitWidth,
                                          width: double.infinity,
                                          height: MediaQuery.of(context)
                                                  .size
                                                  .height /
                                              6.5,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ))
                            ]),
                          ))))),
              //  Expanded(child: getMediaWidget(context, apiResponse)),
            ),
          )
        ])));
  }
}
