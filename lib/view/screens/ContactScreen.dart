// ignore_for_file: file_names, prefer_const_literals_to_create_immutables, prefer_const_constructors, unnecessary_new, avoid_unnecessary_containers, unused_local_variable, use_key_in_widget_constructors, unnecessary_this, non_constant_identifier_names, unused_element, unused_field, prefer_final_fields

import 'package:bori_app/model/BookingModel.dart';
import 'package:bori_app/model/apis/ApiResponse.dart';
import 'package:bori_app/themes/AppColors.dart';
import 'package:bori_app/viewModel/BookingViewModel.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';
import 'dart:async';
import 'package:google_maps_flutter/google_maps_flutter.dart';

int _currentIndex = 0;
bool pressed_About = false;
bool pressed_elebrum = false;
bool pressed_contact = false;

final List<String> imagesList = [
  'assets/images/slide1.png',
  'assets/images/vector.png',
];
Widget appBarTitle = new Text("Contact",
    style: TextStyle(
      fontWeight: FontWeight.w800,
      color: AppTheme.appbar_title,
      fontSize: 19.2,
    ));
Icon actionIcon = new Icon(
  Icons.search,
  color: AppTheme.appbar_title,
);

class ContactScreen extends StatefulWidget {
  @override
  _ContactScreenState createState() => _ContactScreenState();
}

class _ContactScreenState extends State<ContactScreen> {
  Completer<GoogleMapController> _controller = Completer();

  static final CameraPosition _kGooglePlex = CameraPosition(
    target: LatLng(37.42796133580664, -122.085749655962),
    zoom: 14.4746,
  );

  static final CameraPosition _kLake = CameraPosition(
      bearing: 192.8334901395799,
      target: LatLng(37.43296265331129, -122.08832357078792),
      tilt: 59.440717697143555,
      zoom: 19.151926040649414);
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
          child: Text('Please try again later!!!'),
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
      appBar: new AppBar(
          backgroundColor: AppTheme.AppBarTheme,
          elevation: 0,
          leading: IconButton(
            icon: Icon(Icons.arrow_back_ios, color: AppTheme.appbar_title),
            onPressed: () => Navigator.of(context, rootNavigator: true).pop(),
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
                      style: new TextStyle(
                        color: AppTheme.appbar_title,
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
                    appBarTitle = new Text("Contact",
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
                      child: Padding(
                        padding: const EdgeInsets.only(left: 10),
                        child: new Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    
                    children: [
                        Container(
                          margin: EdgeInsets.only(top: 30),
                          //   alignment: AlignmentDirectional.topCenter,
                          child: TextButton.icon(
                            style: TextButton.styleFrom(),
                            onPressed: () => {},
                            icon: Icon(Icons.location_pin,
                                size: 15, color: AppTheme.AppBarTheme),
                            label: Text(
                              'Bhandarkar Oriental Research Institute ',
                              style: TextStyle(
                                  fontWeight: FontWeight.w600, fontSize: 19.2),
                              textAlign: TextAlign.start,
                            ),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(left: 40),
                          child: Text(
                              "Address : 812, Shivajinagar, \nLaw College Road, Pune- 411004",
                              style: TextStyle(
                                  fontSize: 14,height: 1.8, color: AppTheme.AppBarTheme),
                              textAlign: TextAlign.start),
                        ),
                        TextButton.icon(
                          style: TextButton.styleFrom(),
                          onPressed: () => {},
                          icon: Image.asset(
                            "assets/images/google_form.png",
                            width: 16,
                            height: 16,
                            color: AppTheme.AppBarTheme,
                          ),
                          label: Text(
                            'Under the act XXI of 1860 (Reg. No. F 9/1917)',
                            style: TextStyle(fontSize: 14),
                            textAlign: TextAlign.start,
                          ),
                        ),
                        TextButton.icon(
                          style: TextButton.styleFrom(),
                          onPressed: () => {},
                          icon: Icon(
                            Icons.call,
                            size: 16,
                            color: AppTheme.AppBarTheme,
                          ),
                          label: Text(
                            '+91 - 020 - 25656932',
                            style: TextStyle(fontSize: 14),
                            textAlign: TextAlign.start,
                          ),
                        ),
                        TextButton.icon(
                          style: TextButton.styleFrom(),
                          onPressed: () => {},
                          icon: Image.asset(
                            "assets/images/flax.png",
                            width: 16,
                            height: 16,
                            color: AppTheme.AppBarTheme,
                          ),
                          label: Text(
                            '+91 - 020 - 25656932',
                            style: TextStyle(fontSize: 14),
                            textAlign: TextAlign.start,
                          ),
                        ),
                        TextButton.icon(
                          style: TextButton.styleFrom(),
                          onPressed: () => {},
                          icon: Icon(
                            Icons.email,
                            size: 16,
                            color: AppTheme.AppBarTheme,
                          ),
                          label: Text(
                            'bori1@vsnl.net',
                            style: TextStyle(fontSize: 14),
                            textAlign: TextAlign.start,
                          ),
                        ),
                        ClipRRect(
                          borderRadius: BorderRadius.circular(10),
                          child: Container(
                            height:200,
                            child:GoogleMap(
                              mapType: MapType.normal,
                              initialCameraPosition: CameraPosition(
                                target: LatLng(19.048102, 72.911602),
                                zoom: 15.0,
                              ),
                              onMapCreated: (GoogleMapController controller) {
                                _controller.complete(controller);
                              },
                            ),
                          )
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            ),
          ],
        ),
      ),
    );
  }
}
