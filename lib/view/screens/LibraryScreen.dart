// ignore_for_file: file_names, prefer_const_constructors, unnecessary_new, prefer_const_literals_to_create_immutables, non_constant_identifier_names, unused_element, avoid_unnecessary_containers, unused_local_variable, use_key_in_widget_constructors

import 'package:bori_app/model/BookingModel.dart';
import 'package:bori_app/model/apis/ApiResponse.dart';
import 'package:bori_app/themes/AppColors.dart';
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

final List<String> imagesList = [
  'assets/images/slide1.png',
  'assets/images/vector.png',
];
Widget appBarTitle = new Text("The Dr. R. N. Dandekar Library",
    style: TextStyle(
      fontWeight: FontWeight.w800,
      color: AppTheme.appbar_title,
      fontSize: 19.2,
    ));
Icon actionIcon = new Icon(
  Icons.search,
  color: AppTheme.appbar_title,
);

class LibraryScreen extends StatefulWidget {
  @override
  _LibraryScreenState createState() => _LibraryScreenState();
}

class _LibraryScreenState extends State<LibraryScreen> {
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
      appBar: new AppBar(
          elevation: 0,
          backgroundColor: AppTheme.AppBarTheme,
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
                    appBarTitle = new Text("The Dr. R. N. Dandekar Library",
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
          children: [
            Flexible(
              child: Container(
                // color: AppTheme.more_bg,
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
                      children: [
                        Stack(
                          //alignment:new Alignment(x, y)
                          alignment: Alignment.center,
                          children: <Widget>[
                            Stack(
                                //alignment:new Alignment(x, y)
                                alignment: Alignment.center,
                                children: <Widget>[
                                  Container(
                                    decoration: BoxDecoration(
                                        image: DecorationImage(
                                      image: AssetImage(
                                          "assets/images/rect_brown.jpg"),
                                      fit: BoxFit.cover,
                                    )),
                                    height: 163,
                                    width: 243,
                                  )
                                ]),
                            Stack(
                                //alignment:new Alignment(x, y)
                                alignment: Alignment.center,
                                children: <Widget>[
                                  Container(
                                    decoration: BoxDecoration(
                                        image: DecorationImage(
                                      image: AssetImage(
                                          "assets/images/library_img.png"),
                                      fit: BoxFit.cover,
                                    )),
                                    height: 145,
                                    width: 283,
                                  )
                                ]),
                          ],
                        ),
                        Container(
                          margin: EdgeInsets.all(10),
                          //   alignment: AlignmentDirectional.topCenter,
                          child: Text(
                            "The BORI Library, recently named after the legendary Dr. R. N. Dandekar, is internationally recognized "
                            "as a specialized library in the field of Orientology. It is a home to above 1,25,000 handpicked "
                            "books pertaining to all the aspects of Oriental Studies. About 20,000 of the books are quite rare "
                            "to find the world over.",
                            textAlign: TextAlign.justify,
                            overflow: TextOverflow.ellipsis,
                            maxLines: 40,
                            style: TextStyle(
                                color: AppTheme.deco,
                                fontSize: 16,
                                height: 1.5,
                                fontWeight: FontWeight.w400),
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.all(10),
                          //   alignment: AlignmentDirectional.topCenter,
                          child: Text(
                            "Books in over 25 Indian and European languages are housed here. Prominent "
                                "languages among them are Sanskrit, Pali, different Prakrits, Hindi, Marathi, English, French, German, "
                                "etc. The chronological range of the books spans over the early days of printing till date are "
                                "available for the benefit of scholars.",
                            textAlign: TextAlign.justify,
                            overflow: TextOverflow.ellipsis,
                            maxLines: 40,
                            style: TextStyle(
                                color: AppTheme.deco,
                                fontSize: 16,
                                height: 1.5,
                                fontWeight: FontWeight.w400),
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.all(10),
                          //   alignment: AlignmentDirectional.topCenter,
                          child: Text(
                                "The library was founded with a valuable personal collection "
                                "of about 2200 books donated by Sir Ramakrishna Gopal Bhandarkar himself. Stalwarts of the likes of "
                                "P. K. Gode, A. D. Pusalkar, S. V. Sohoni, R. N. Dandekar, P. V. Bapat and P. L. Vaidya have donated "
                                "their personal collections to the library. Volumes of esteemed national and international journals "
                                "are procured in exchange with the Annals.",
                            textAlign: TextAlign.justify,
                            overflow: TextOverflow.ellipsis,
                            maxLines: 40,
                            style: TextStyle(
                                color: AppTheme.deco,
                                fontSize: 16,
                                height: 1.5,
                                fontWeight: FontWeight.w400),
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.all(10),
                          //   alignment: AlignmentDirectional.topCenter,
                          child: Text(
                                "Today around 2,500 scholars and students visit the institute per year seeking references "
                                "for their graduate, post- graduate, doctoral and post doctoral research projects.",
                            textAlign: TextAlign.justify,
                            overflow: TextOverflow.ellipsis,
                            maxLines: 40,
                            style: TextStyle(
                                color: AppTheme.deco,
                                fontSize: 16,
                                height: 1.5,
                                fontWeight: FontWeight.w400),
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.all(10),
                          child: SvgPicture.asset(
                            "assets/images/know_more_btn.svg",
                            width: 122,
                            height: 35,
                          ),
                          alignment: Alignment.center,
                        ),
                      ],
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
