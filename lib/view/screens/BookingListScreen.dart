// ignore_for_file: file_names, prefer_const_constructors, use_key_in_widget_constructors, sized_box_for_whitespace, unnecessary_new, prefer_const_literals_to_create_immutables, unused_local_variable, non_constant_identifier_names, unused_element, avoid_unnecessary_containers, avoid_types_as_parameter_names

import 'package:bori_app/model/BookingModel.dart';
import 'package:bori_app/model/apis/ApiResponse.dart';
import 'package:bori_app/themes/AppColors.dart';
import 'package:bori_app/view/screens/BookingDetailsScreen.dart';
import 'package:bori_app/viewModel/BookingViewModel.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';

int _currentIndex = 0;
bool pressed_About = false;
bool pressed_elebrum = false;
bool pressed_contact = false;

List<String> images = [
  "assets/images/booking.png",
  "assets/images/booking.png",
  "assets/images/booking.png",
  "assets/images/booking.png",
  "assets/images/booking.png",
];
List<String> title = [
  "Conference Room",
  "Auditorium",
  "Amphithiter",
  "Studio",
  "Tata Hall"
];
Widget appBarTitle = new Text("Booking",
    style: TextStyle(
      fontWeight: FontWeight.w800,
      color: AppTheme.appbar_title,
      fontSize: 19.2,
    ));
Icon actionIcon = new Icon(Icons.search, color: AppTheme.appbar_title);

class BookingListScreen extends StatefulWidget {
  @override
  _BookingListScreenState createState() => _BookingListScreenState();
}

class _BookingListScreenState extends State<BookingListScreen> {
  String title_str = "";
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
      resizeToAvoidBottomInset: false, //new line

      appBar: new AppBar(
          backgroundColor: AppTheme.AppBarTheme,
          elevation: 0,
          leading: IconButton(
            icon: Icon(Icons.arrow_back_ios, color: AppTheme.appbar_title),
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
                          )),
                    );
                  } else {
                    actionIcon = new Icon(
                      Icons.search,
                      color: AppTheme.appbar_title,
                    );
                    appBarTitle = new Text("Booking",
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

      body: Container(
        child: new Column(children: [
          Flexible(
            child: Container(
              // color: AppTheme.more_bg,
              decoration: BoxDecoration(
                color: AppTheme.deco, //color: C
              ),
              child: Container(

                  //   padding: const EdgeInsets.only(bottom: 10),
                  padding: const EdgeInsets.all(20),
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
                  child: ListView.builder(
                    itemBuilder: (BuildContext, index) {
                      return Container(
                        margin: EdgeInsets.only(bottom: 20),
                        child: Column(
                          children: <Widget>[
                            Column(
                              children: [
                                Stack(
                                  //alignment:new Alignment(x, y)
                                  alignment: Alignment.topCenter,
                                  children: <Widget>[
                                    Stack(
                                        //alignment:new Alignment(x, y)
                                        alignment: Alignment.center,
                                        children: <Widget>[
                                          Stack(
                                              alignment: Alignment.center,
                                              children: <Widget>[
                                                Container(
                                                  height: 287,
                                                  decoration: BoxDecoration(
                                                    image: DecorationImage(
                                                      image: AssetImage(
                                                          "assets/images/card_brown.png"),
                                                    ),
                                                  ),
                                                  //  height: 287,width: 393,
                                                ),
                                                Container(
                                                    padding: EdgeInsets.only(
                                                        bottom: 30),
                                                    height: 287,
                                                    width: 393,
                                                    child: Align(
                                                        alignment: Alignment
                                                            .bottomCenter,
                                                        child: Text(
                                                          title[index],
                                                          style: TextStyle(
                                                              color: AppTheme
                                                                  .search_bg,
                                                              fontSize: 30,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w800),
                                                          textAlign:
                                                              TextAlign.center,
                                                        )))
                                              ])
                                        ]),
                                    Container(
                                      child: InkWell(
                                        onTap: () {
                                          Navigator.of(context).push(
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      BookingDetailsScreen(title: title[index],)));
                                        },
                                        child: Stack(
                                          //alignment:new Alignment(x, y)
                                          alignment: Alignment.topCenter,
                                          children: <Widget>[
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                  top: 12, left: 12, right: 12),

                                              child: Container(
                                                decoration: BoxDecoration(
                                                  image: DecorationImage(
                                                    image: AssetImage(
                                                        "assets/images/card_rect.png"),
                                                  ),
                                                ),
                                                height: 218,
                                              ),
                                              //  )
                                              //   ),
                                              //  ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ],
                                ),

                                Text(
                                  "Seating Capacity - 200",
                                  textAlign: TextAlign.start,
                                  style: TextStyle(
                                      letterSpacing: 0.8,
                                      color: AppTheme.AppBarTheme,
                                      fontSize: 14,
                                      fontWeight: FontWeight.w700),
                                ),
                                SizedBox(
                                  height: 1.6,
                                ),
                                Text(
                                  "Features - Integrated Sound System",
                                  textAlign: TextAlign.start,
                                  style: TextStyle(
                                      color: AppTheme.AppBarTheme,
                                      fontSize: 14,
                                      fontWeight: FontWeight.w700),
                                ),
                                SizedBox(
                                  height: 1.6,
                                ),
                                Text(
                                  "Projector, Generator Backup",
                                  textAlign: TextAlign.start,
                                  style: TextStyle(
                                      color: AppTheme.AppBarTheme,
                                      fontSize: 14,
                                      fontWeight: FontWeight.w700),
                                ),
                                SizedBox(
                                  height: 1.6,
                                ),
                                Text(
                                  "Availability - Monday to Saturday",
                                  textAlign: TextAlign.start,
                                  style: TextStyle(
                                      color: AppTheme.AppBarTheme,
                                      fontSize: 14,
                                      fontWeight: FontWeight.w700),
                                ),
                                SizedBox(
                                  height: 1.6,
                                ),
                                Text(
                                  "Rent - 10,000",
                                  textAlign: TextAlign.start,
                                  style: TextStyle(
                                      color: AppTheme.AppBarTheme,
                                      fontSize: 14,
                                      fontWeight: FontWeight.w900),
                                ),
                                Container(
                                  margin: EdgeInsets.only(top: 20),
                                  child: GestureDetector(
                                    onTap: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) =>
                                              BookingDetailsScreen(title: title[index],),
                                        ),
                                      );
                                    },
                                    child: SvgPicture.asset(
                                      "assets/images/book_btn.svg",
                                      width: 122,
                                      height: 35,
                                    ),
                                  ),
                                  alignment: Alignment.center,
                                ),

                                // leading: CircleAvatar(backgroundImage: AssetImage(images[index]),),
                              ],
                            ),
                          ],
                        ),
                      );
                    },
                    itemCount: images.length,
                    shrinkWrap: true,
                    padding: EdgeInsets.all(5),
                    scrollDirection: Axis.vertical,
                  )),
            ),
          ),
        ]),
      ),
    );
  }
}
