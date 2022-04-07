// ignore_for_file: file_names, prefer_const_constructors, unnecessary_new, prefer_const_literals_to_create_immutables, non_constant_identifier_names, unused_element, avoid_unnecessary_containers, unused_local_variable, use_key_in_widget_constructors

import 'package:bori_app/model/BookingModel.dart';
import 'package:bori_app/model/apis/ApiResponse.dart';
import 'package:bori_app/themes/AppColors.dart';
import 'package:bori_app/viewModel/BookingViewModel.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';

bool pressed_About = false;
bool pressed_elebrum = false;
bool pressed_contact = false;

final List<String> imagesList = [
  'assets/images/slide1.png',
  'assets/images/vector.png',
];
Widget appBarTitle = new Text("About",
    style: TextStyle(
      fontWeight: FontWeight.w800,
      color: AppTheme.appbar_title,
      fontSize: 19.2,
    ));
Icon actionIcon = new Icon(
  Icons.search,
  color: AppTheme.appbar_title,
);

class AboutScreen extends StatefulWidget {
  @override
  _AboutScreenState createState() => _AboutScreenState();
}

class _AboutScreenState extends State<AboutScreen> {
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
          elevation: 0,
          backgroundColor: AppTheme.AppBarTheme, // Status bar color
          leading: IconButton(
              icon: Icon(Icons.arrow_back_ios, color: AppTheme.appbar_title),
              onPressed: () =>
                  Navigator.of(context, rootNavigator: true).pop()),
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
                          fontSize: 19.2),
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
                      color: AppTheme.AppBarTheme,
                    );
                    appBarTitle = new Text("About",
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
                  child: Container(
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
                                      height: 237,
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
                                            "assets/images/about_detail.png"),
                                        fit: BoxFit.cover,
                                      )),
                                      height: 210,
                                      width: 282,
                                    )
                                  ]),
                            ],
                          ),
                          Container(
                            margin: EdgeInsets.all(10),
                            //   alignment: AlignmentDirectional.topCenter,

                            child: Text(
                              'The Bhandarkar Oriental Research Institute, Pune, was founded on July 6, 1917 to commemorate the '
                                  'name and the work of Ramkrishna Gopal Bhandarakar, the foremost pioneer of scientific '
                                  'Orientology in India. The Institute concerns itself with research activity in the field of '
                                  'Orientology with a vision to enlighten the world about the all-comprehensive knowledge '
                                  'generated in the East, especially, in India.',
                              textAlign: TextAlign.justify,
                              overflow: TextOverflow.ellipsis,
                              maxLines: 40,
                              style: TextStyle(
                                  color: AppTheme.deco,
                                  fontSize: 16,
                                  height: 1.4,
                                  fontWeight: FontWeight.w400,),
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.all(10),
                            //   alignment: AlignmentDirectional.topCenter,

                            child: Text(
                              'The institute has one of the largest collections of rare books and manuscripts '
                                  'spanning over 1,25,000 books and over 28,000 manuscripts collected over a period of 90 '
                                  'years covering practically every aspect of Orientology. This collection covers several '
                                  'languages and scripts such as Sanskrit, Prakrit, Indian regional languages, Classical,Asean '
                                  'and European languages.',
                              textAlign: TextAlign.justify,
                              overflow: TextOverflow.ellipsis,
                              maxLines: 40,
                              style: TextStyle(
                                color: AppTheme.deco,
                                fontSize: 16,
                                height: 1.4,
                                fontWeight: FontWeight.w400,),
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.all(10),
                            //   alignment: AlignmentDirectional.topCenter,

                            child: Text(
                              'In addition, through the pursuits of its research projects in the '
                                  'Mahabharata and Prakrit Languages it has created invaluable reference archives. '
                                  'The Institute also hosts a Manuscripts Resource and Conservation Centre under the auspices '
                                  'of the National Mission for Manuscripts, a project of the Cultural Ministry of India. '
                                  'In short, the Institute has been effectively playing the role of a very significant centre '
                                  'of Indological Studies and Research over the last nine decades.',
                              textAlign: TextAlign.justify,
                              overflow: TextOverflow.ellipsis,
                              maxLines: 40,
                              style: TextStyle(
                                color: AppTheme.deco,
                                fontSize: 16,
                                height: 1.4,
                                fontWeight: FontWeight.w400,),
                            ),
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
