import 'package:bori_app/model/BookingModel.dart';
import 'package:bori_app/model/apis/ApiResponse.dart';
import 'package:bori_app/themes/AppColors.dart';
import 'package:bori_app/view/screens/EmblemScreen.dart';
import 'package:bori_app/view/screens/MainActivity.dart';
import 'package:bori_app/view/screens/MainActivityAbout.dart';
import 'package:bori_app/view/screens/MainActivityContact.dart';
import 'package:bori_app/view/screens/MainActivityEmblem.dart';
import 'package:bori_app/view/screens/MainActivityVideos.dart';
import 'package:bori_app/view/screens/VideoListScreen.dart';
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
bool pressed_blog = false;
bool pressed_discuss = false;
bool pressed_video = false;

final List<String> imagesList = [
  'assets/images/slide1.png',
  'assets/images/vector.png',
];
Widget appBarTitle = new Text("More",
    style: TextStyle(
      fontWeight: FontWeight.w800,
      color: AppTheme.appbar_title,
      fontSize: 19.2,
    ));
Icon actionIcon = new Icon(
  Icons.search,
  color: AppTheme.appbar_title,
);

class MoreScreen extends StatefulWidget {
  @override
  _MoreScreenState createState() => _MoreScreenState();
}

class _MoreScreenState extends State<MoreScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
  }
Future<bool> _willPopCallback() async {
    // await showDialog or Show add banners or whatever
    // then

   return (await
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => MainActivity()),
      ) )??false;
    // return true if the route to be popped
    // return true if the route to be popped
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
    return WillPopScope(
      onWillPop: _willPopCallback,
      child: Scaffold(
        appBar: new AppBar(
            elevation: 0,
            backgroundColor: AppTheme.AppBarTheme,
            leading: IconButton(
                icon: Icon(Icons.arrow_back_ios, color: AppTheme.appbar_title),
                onPressed: () =>
                    Navigator.of(context, rootNavigator: true).pushReplacement(
                      MaterialPageRoute(builder: (context) => MainActivity()),
                    ) //SystemNavigator.pop(),
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
                      appBarTitle = new Text("More",
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
        body: SingleChildScrollView(
          physics: NeverScrollableScrollPhysics(),
          child: new Column(
            children: [
              Container(
                // color: AppTheme.more_bg,
                decoration: BoxDecoration(
                  color: AppTheme.deco, //color: C
                ),
                child: Container(
                  //   padding: const EdgeInsets.only(bottom: 10),
                  padding: const EdgeInsets.all(10),
                  margin: const EdgeInsets.only(top: 10),
                  height: MediaQuery.of(context).size.height,
                  decoration: BoxDecoration(
                    color: AppTheme.more_bg,
                    borderRadius: new BorderRadius.only(
                      topLeft: const Radius.circular(40.0),
                      topRight: const Radius.circular(40.0),
                    ),
                  ),
                  child: Column(
                    children: [
                      OutlinedButton(
                        style: OutlinedButton.styleFrom(
                          side: BorderSide(width: 5.0, color: Colors.transparent),
                        ),
                        onPressed: () => setState(() {
                          pressed_About = !pressed_About;
                          pressed_elebrum = false;
                          pressed_contact = false;
                          pressed_blog = false;
                          pressed_discuss = false;
                          pressed_video = false;
                          Navigator.of(context, rootNavigator: false)
                              .push(
                                MaterialPageRoute(
                                    builder: (context) => MainActivityAbout()),
                              )
                              .then((value) => _refreshFirstPage());
                        }),
                        child: Stack(
                          alignment: Alignment.centerLeft,
                          children: <Widget>[
                            SvgPicture.asset(
                              "assets/images/about.svg",
                              color: pressed_About
                                  ? AppTheme.divider
                                  : AppTheme.AppBarTheme,
                            ),
                            Row(
                              // mainAxisAlignment: MainAxisAlignment.start,
    
                              children: <Widget>[
                                Padding(
                                  padding: const EdgeInsets.only(left: 50.0),
                                  child: Text(
                                    'About',
                                    style: pressed_About
                                        ? TextStyle(
                                            color: AppTheme.divider,
                                            fontWeight: FontWeight.bold)
                                        : TextStyle(
                                            color: AppTheme.AppBarTheme,
                                            fontWeight: FontWeight.bold),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      Divider(
                        color: AppTheme.divider,
                        thickness: 2,
                      ),
                      OutlinedButton(
                        style: OutlinedButton.styleFrom(
                          side: BorderSide(width: 5.0, color: Colors.transparent),
                        ),
                        onPressed: () => setState(() {
                          pressed_About = false;
                          pressed_elebrum = !pressed_elebrum;
                          pressed_contact = false;
                          pressed_blog = false;
                          pressed_discuss = false;
                          pressed_video = false;
                          Navigator.of(context, rootNavigator: false).push(
                              MaterialPageRoute(
                                  builder: (context) => MainActivityEmblem()));
                        }),
                        child: Stack(
                          alignment: Alignment.centerLeft,
                          children: <Widget>[
                            Image.asset(
                              "assets/images/emblem.png",
                              color: pressed_elebrum
                                  ? AppTheme.divider
                                  : AppTheme.AppBarTheme,
                              height: 30,
                              width: 30,
                            ),
                            Row(
                              //  mainAxisAlignment: MainAxisAlignment.start,
    
                              children: <Widget>[
                                Padding(
                                  padding: const EdgeInsets.only(left: 50.0),
                                  child: Text(
                                    'Emblem',
                                    style: pressed_elebrum
                                        ? TextStyle(
                                            color: AppTheme.divider,
                                            fontWeight: FontWeight.bold)
                                        : TextStyle(
                                            color: AppTheme.AppBarTheme,
                                            fontWeight: FontWeight.bold),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      Divider(
                        color: AppTheme.divider,
                        thickness: 2,
                      ),
                      OutlinedButton(
                        style: OutlinedButton.styleFrom(
                          side: BorderSide(width: 5.0, color: Colors.transparent),
                        ),
                        onPressed: () => setState(() {
                          pressed_About = false;
                          pressed_elebrum = false;
                          pressed_contact = false;
                          pressed_blog = false;
                          pressed_discuss = false;
                          pressed_video = !pressed_video;
                          Navigator.of(context, rootNavigator: false).push(
                              MaterialPageRoute(
                                  builder: (context) => MainActivityVideos()));
                        }),
                        child: Stack(
                          alignment: Alignment.centerLeft,
                          children: <Widget>[
                            SvgPicture.asset(
                              "assets/images/videos.svg",
                              color: pressed_video
                                  ? AppTheme.divider
                                  : AppTheme.AppBarTheme,
                            ),
                            Row(
                              //  mainAxisAlignment: MainAxisAlignment.start,
    
                              children: <Widget>[
                                Padding(
                                  padding: const EdgeInsets.only(left: 50.0),
                                  child: Text(
                                    'Videos',
                                    style: pressed_video
                                        ? TextStyle(
                                            color: AppTheme.divider,
                                            fontWeight: FontWeight.bold)
                                        : TextStyle(
                                            color: AppTheme.AppBarTheme,
                                            fontWeight: FontWeight.bold),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      Divider(
                        color: AppTheme.divider,
                        thickness: 2,
                      ),
                      OutlinedButton(
                        style: OutlinedButton.styleFrom(
                          side: BorderSide(width: 5.0, color: Colors.transparent),
                        ),
                        onPressed: () => setState(() {
                          // pressed_About = false;
                          // pressed_elebrum = false;
                          // pressed_contact = false;
                          // pressed_blog = !pressed_blog;
                          // pressed_discuss = false;
                          // pressed_video = false;
                          // Navigator.of(context, rootNavigator: false).push(
                          //     MaterialPageRoute(
                          //         builder: (context) => EmblemScreen()));
                        }),
                        child: Stack(
                          alignment: Alignment.centerLeft,
                          children: <Widget>[
                            Image.asset(
                              "assets/images/blog.png",
                              color: pressed_blog
                                  ? AppTheme.divider
                                  : AppTheme.AppBarTheme,
                              height: 30,
                              width: 30,
                            ),
                            Row(
                              //  mainAxisAlignment: MainAxisAlignment.start,
    
                              children: <Widget>[
                                Padding(
                                  padding: const EdgeInsets.only(left: 50.0),
                                  child: Text(
                                    'Blogs',
                                    style: pressed_blog
                                        ? TextStyle(
                                            color: AppTheme.divider,
                                            fontWeight: FontWeight.bold)
                                        : TextStyle(
                                            color: AppTheme.AppBarTheme,
                                            fontWeight: FontWeight.bold),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      Divider(
                        color: AppTheme.divider,
                        thickness: 2,
                      ),
                      OutlinedButton(
                        style: OutlinedButton.styleFrom(
                          side: BorderSide(width: 5.0, color: Colors.transparent),
                        ),
                        onPressed: () => setState(() {
                          // pressed_About = false;
                          // pressed_elebrum = false;
                          // pressed_contact = false;
                          // pressed_blog = false;
                          // pressed_discuss = !pressed_discuss;
                          // pressed_video = false;
                          // Navigator.of(context, rootNavigator: false).push(
                          //     MaterialPageRoute(
                          //         builder: (context) => EmblemScreen()));
                        }),
                        child: Stack(
                          alignment: Alignment.centerLeft,
                          children: <Widget>[
                            Image.asset(
                              "assets/images/meeting.png",
                              color: pressed_discuss
                                  ? AppTheme.divider
                                  : AppTheme.AppBarTheme,
                              height: 30,
                              width: 30,
                            ),
                            Row(
                              //  mainAxisAlignment: MainAxisAlignment.start,
    
                              children: <Widget>[
                                Padding(
                                  padding: const EdgeInsets.only(left: 50.0),
                                  child: Text(
                                    'Discussion Forum',
                                    style: pressed_discuss
                                        ? TextStyle(
                                            color: AppTheme.divider,
                                            fontWeight: FontWeight.bold)
                                        : TextStyle(
                                            color: AppTheme.AppBarTheme,
                                            fontWeight: FontWeight.bold),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      Divider(
                        color: AppTheme.divider,
                        thickness: 2,
                      ),
                      OutlinedButton(
                        style: OutlinedButton.styleFrom(
                          side: BorderSide(width: 5.0, color: Colors.transparent),
                        ),
                        onPressed: () => setState(() {
                          pressed_About = false;
                          pressed_elebrum = false;
                          pressed_contact = !pressed_contact;
                          pressed_blog = false;
                          pressed_discuss = false;
                          pressed_video = false;
                          Navigator.of(context, rootNavigator: false)
                              .push(
                                MaterialPageRoute(
                                    builder: (context) => MainActivityContact()),
                              )
                              .then((value) => _refreshFirstPage());
                        }),
                        child: Stack(
                          alignment: Alignment.centerLeft,
                          children: <Widget>[
                            SvgPicture.asset(
                              "assets/images/contact.svg",
                              color: pressed_contact
                                  ? AppTheme.divider
                                  : AppTheme.AppBarTheme,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: <Widget>[
                                Padding(
                                  padding: const EdgeInsets.only(left: 50.0),
                                  child: Text(
                                    'Contact',
                                    style: pressed_contact
                                        ? TextStyle(
                                            color: AppTheme.divider,
                                            fontWeight: FontWeight.bold)
                                        : TextStyle(
                                            color: AppTheme.AppBarTheme,
                                            fontWeight: FontWeight.bold),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      Divider(
                        color: AppTheme.divider,
                        thickness: 2,
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

_refreshFirstPage() {
  pressed_About = false;
  pressed_elebrum = false;
  pressed_contact = false;
  pressed_blog = false;
  pressed_discuss = false;
  pressed_video = false;
}
