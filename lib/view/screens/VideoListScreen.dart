// ignore_for_file: file_names, unnecessary_new, prefer_const_constructors, avoid_unnecessary_containers, prefer_const_literals_to_create_immutables, unused_local_variable, use_key_in_widget_constructors, avoid_print, non_constant_identifier_names

import 'package:bori_app/model/apis/ApiResponse.dart';
import 'package:bori_app/themes/AppColors.dart';
import 'package:bori_app/viewModel/BookingViewModel.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';
import 'package:sleek_circular_slider/sleek_circular_slider.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:youtube_api/youtube_api.dart';

class VideoListScreen extends StatefulWidget {
  @override
  _VideoListScreenState createState() => _VideoListScreenState();
}

Widget appBarTitle = new Text("Video",
    style: TextStyle(
      fontWeight: FontWeight.w800,
      color: AppTheme.appbar_title,
      fontSize: 19.2,
    ));
Icon actionIcon = new Icon(
  Icons.search,
  color: AppTheme.appbar_title,
);

class _VideoListScreenState extends State<VideoListScreen> {
  static String api_key = 'AIzaSyAMcGrwP6bQj1Q8b9ctgefyihsOammGUoU';
  List<YouTubeVideo> results = []; //list to store the results
  YoutubeAPI yt = YoutubeAPI(api_key, type: "video");
  bool isLoaded = false;
  @override
  void initState() {
    super.initState();
    callApi(); //calling async api function to get the  data from API
  }

  callApi() async {
    try {
      results = await yt.search(
          "BhandarkarOrientalResearchInstitutepune"); //searching for videos related to HD Music
      print("***********%%%%%%%%%%%%%%%%%%%%%%%%%%%%%"); //logging results in console
      print(results); //logging results in console
      setState(() {
        isLoaded = true; //setting content as loaded
      });
    } catch (e) {
      print(
          e); //in case of any exception like no internet or problem with API log it to console
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
        backgroundColor: AppTheme.more_bg,
        appBar: new AppBar(
            backgroundColor: AppTheme.AppBarTheme,
            elevation: 0,
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
                      appBarTitle = new Text("Video",
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
        body: isLoaded
            ? SingleChildScrollView(
            child:  Container(
              child: Column(children: [
                Container(
                  // color: AppTheme.more_bg,
            
                  decoration: BoxDecoration(
                    color: AppTheme.deco, //color: C
                  ),
                  child: Container(
                    //   padding: const EdgeInsets.only(bottom: 10),
                    padding: const EdgeInsets.all(10),
                    margin: const EdgeInsets.only(top: 6),
                    height: MediaQuery.of(context).size.height,
                    width: MediaQuery.of(context).size.width,
                    decoration: BoxDecoration(
                      color: AppTheme.more_bg,
                      borderRadius: new BorderRadius.only(
                        topLeft: const Radius.circular(40.0),
                        topRight: const Radius.circular(40.0),
                      ),
                    ),
                    child: Column(
                      children: [
                        Expanded(
                          child: Container(
                            child: ListView.builder(
                              shrinkWrap: true,
                              scrollDirection: Axis.vertical,
                              itemCount: results.length,
                              itemBuilder: (BuildContext context, int index) {
                                return GestureDetector(
                                  onTap: () async {
                                    String url = results[index].url;
                                    if (await canLaunch(url)) {
                                      await launch(url);
                                    } else {
                                      throw 'Could not launch $url';
                                    }
                                  },
                                  child: (Container(
                                    padding: EdgeInsets.all(10),
                                    margin: EdgeInsets.only(top: 10),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        index == 0
                                            ? Container(
                                                child: Row(
                                                  children: [
                                                    // Text(
                                                    //   "TOP TRENDING",
                                                    //   style: TextStyle(
                                                    //       fontSize: 18,
                                                    //       fontWeight: FontWeight.bold,
                                                    //       fontFamily: "Poppins"),
                                                    // ),
                                                    // SizedBox(
                                                    //   width: 5,
                                                    // ),
                                                    // Icon(
                                                    //   Icons.whatshot,
                                                    //   color: Colors.red,
                                                    //   size: 18,
                                                    // )
                                                  ],
                                                ),
                                              )
                                            : Container(),
                                        SizedBox(
                                          height: 16,
                                        ),
                                        Container(
                                            decoration: BoxDecoration(
                                                color: AppTheme.search_bg,
                                                borderRadius:
                                                    BorderRadius.circular(10),
                                                boxShadow: [
                                                  BoxShadow(
                                                      //   offset: Offset(0, 10),
                                                      //   blurRadius: 40,
                                  
                                                      )
                                                ]),
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                ClipRRect(
                                                  borderRadius: BorderRadius.only(
                                                      topLeft:
                                                          Radius.circular(10),
                                                      topRight:
                                                          Radius.circular(10)),
                                                  child: Image.network(
                                                    results[index].thumbnail.medium.url??'',
                                                    width: MediaQuery.of(context)
                                                        .size
                                                        .width,
                                                    fit: BoxFit.cover,
                                                  ),
                                                ),
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.all(15.0),
                                                  child: Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceBetween,
                                                    children: [
                                                      Flexible(
                                                        child: Text(
                                                          results[index]
                                                              .channelTitle,
                                                          textAlign:
                                                              TextAlign.left,
                                                          style: TextStyle(
                                                              fontSize: 16,
                                                              fontWeight:
                                                                  FontWeight.bold,
                                                              fontFamily:
                                                                  "Poppins"),
                                                        ),
                                                      ),
                                                      // index == 0
                                                      //     ? Icon(
                                                      //   Icons.favorite,
                                                      //   color: Colors.red,
                                                      // )
                                                      //     : Icon(
                                                      //   Icons.favorite_border,
                                                      //   color: Colors.grey,
                                                      // )
                                                    ],
                                                  ),
                                                ),
                                                Padding(
                                                  padding: const EdgeInsets.only(
                                                      left: 15,
                                                      right: 15,
                                                      bottom: 15,
                                                      top: 10),
                                                  child: Text(
                                                    results[index].duration.toString(),
                                                    style: TextStyle(
                                                        fontSize: 14,
                                                        fontWeight:
                                                            FontWeight.w400,
                                                        fontFamily: "Poppins"),
                                                    textAlign: TextAlign.justify,
                                                  ),
                                                ),
                                              ],
                                            ))
                                      ],
                                    ),
                                  )),
                                );
                              },
                              
                            ),
                          ),
                        ),
                        
                      ],
                    ),
                  ),
                )
              ]),
            ),
              
              )
              
            : Center(
                child: SleekCircularSlider(
                  appearance: CircularSliderAppearance(
                    spinnerMode: true,
                    size: 40,
                    customColors: CustomSliderColors(
                      trackColor: Colors.brown,
                      progressBarColor: Colors.brown,
                      
                      shadowMaxOpacity: 0.0,
                      
                    ),
                  ),
                ),
              ));
  }
}
