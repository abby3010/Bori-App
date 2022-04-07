import 'package:bori_app/model/BookingModel.dart';
import 'package:bori_app/model/apis/ApiResponse.dart';
import 'package:bori_app/themes/AppColors.dart';
import 'package:bori_app/viewModel/BookingViewModel.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';

Widget appBarTitle = new Text("Mahabharata Project",
    style: TextStyle(
      
      fontWeight: FontWeight.w800,
      color: AppTheme.appbar_title,
      fontSize: 19.2,
    ));
Icon actionIcon = new Icon(
  Icons.search,
  color: AppTheme.appbar_title,
);
List<RadioModel> sampleData = <RadioModel>[];

class MahabharataProjectScreen extends StatefulWidget {
  @override
  _MahabharataProjectScreenState createState() =>
      _MahabharataProjectScreenState();
}

class _MahabharataProjectScreenState extends State<MahabharataProjectScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    sampleData.add(new RadioModel(true, 'About', ''));
    sampleData.add(new RadioModel(false, 'Details', ''));
    sampleData.add(new RadioModel(false, 'Goals', ''));
  }
  void dispose() {
    sampleData.clear();
    super.dispose();
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
      appBar: new AppBar(
          backgroundColor: AppTheme.AppBarTheme,
          elevation: 0,
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
                    actionIcon =
                        new Icon(Icons.search, color: AppTheme.appbar_title);
                    appBarTitle = new Text("Mahabharata Project",
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
                  child: new Column(children: [
                    Container(
                      height: MediaQuery.of(context).size.height / 10,
                      width: double.infinity,
                      alignment: Alignment.center,
                      child: Container(
                        child: Align(
                          alignment: Alignment.topCenter,
                          child: ListView.builder(
                            scrollDirection: Axis.horizontal,
                            shrinkWrap: true,
                            itemCount: sampleData.length,
                            itemBuilder: (BuildContext context, int index) {
                              return new InkWell(
                                //highlightColor: Colors.red,
                                onTap: () {
                                  setState(() {
                                    sampleData.forEach((element) =>
                                        element.isSelected = false);
                                    sampleData[index].isSelected = true;
                                  });
                                },
                                child: new RadioItem(sampleData[index]),
                              );
                            },
                          ),
                        ),
                      ),
                    ),
                    if (sampleData.elementAt(0).isSelected) ...[
                      Visibility(
                        visible: true,
                        child: Container(
                          margin: EdgeInsets.all(10),
                          //   alignment: AlignmentDirectional.topCenter,
                          child: Text(
                            "Mahabharata Project",
                            textAlign: TextAlign.center,
                            overflow: TextOverflow.ellipsis,
                            maxLines: 30,
                            style: TextStyle(
                                color: AppTheme.AppBarTheme,
                                fontWeight: FontWeight.w900,
                                fontSize: 18),
                          ),
                        ),
                      ),
                      Visibility(
                        visible: true,
                        child: Container(
                          margin: EdgeInsets.only(
                              top: 10, left: 10, right: 10, bottom: 10),
                          alignment: AlignmentDirectional.topCenter,
                          child: Text(
                            "Had institutions had hearts, the Mahabharata would certainly be BORI’s! A giant research project undertaken by the BORI since its inception was The Critical Edition of Mahabharata. Edited by the likes of V. S. Sukhtankar, S. K. Belvalkar, S. K. De, Prof. Dr. R. N. Dandekar, the Critical Edition enjoys the status of one of the most prestigious and appreciated editorial work of  the world. This edition was prepared with painstaking efforts of scholars for about five decades consulting 1,259 manuscripts. A comprehensive Prolegomena (Vol. I), written by V. S. Sukhtankar, brings out the material and methodology of the project.\n\nThe completed Critical Edition of the Mahabharata (18 Parvan-s; 89000+ verses in the Constituted Text, and an elaborate Critical Apparatus; 19 Volumes: No. of pages: 15000+ demi-quarto size) was released on September 22, 1966 at the hands of Dr. Sarvapalli Radhakrishnan, the then President of India.\n\nIt was a dream of the General Editors to compile an Epilogue to the Mahabharata discussing the message of the great book. As a preparatory step for the same a Cultural Index to the Mahabharata was planned. References under various heads were collected on cards numbering over 1,50,000. Two volumes of the Cultural Index have so far been published under the general editorship of Prof. M. A. Mehendale.",
                            textAlign: TextAlign.justify,
                            overflow: TextOverflow.ellipsis,
                            maxLines: 50,
                            style: TextStyle(
                                color: AppTheme.deco,
                                fontSize: 16,
                                height: 1.5,
                                fontWeight: FontWeight.w400),
                          ),
                        ),
                      ),
                    ],
                    if (sampleData.elementAt(1).isSelected) ...[
                      Visibility(
                        visible: true,
                        child: Container(
                          margin: EdgeInsets.all(10),
                          //   alignment: AlignmentDirectional.topStart,
                          child: Text(
                            "The details of the work \n published and underway:",
                            textAlign: TextAlign.center,
                            overflow: TextOverflow.ellipsis,
                            maxLines: 30,
                            style: TextStyle(
                                color: AppTheme.AppBarTheme,
                                fontWeight: FontWeight.w900,
                                fontSize: 18),
                          ),
                        ),
                      ),
                      Visibility(
                        visible: true,
                        child: Container(
                          margin: EdgeInsets.all(10),
                          alignment: AlignmentDirectional.topStart,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Text(
                                "(1) Critical Edition of the Mahabharata:",
                                textAlign: TextAlign.start,
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                    color: AppTheme.deco,
                                    fontSize: 16,
                                    fontWeight: FontWeight.w900),
                              ),
                              Text(
                                "April 1919 to September 1966; 18 Parvan-s; 89000+ verses in the Constituted Text, and an elaborate Critical Apparatus; 19 Volumes: No. of pages: 15000+ demi-quarto size\n\n",
                                textAlign: TextAlign.left,
                                overflow: TextOverflow.ellipsis,
                                maxLines: 30,
                                style: TextStyle(
                                    color: AppTheme.deco,
                                    fontSize: 16,
                                    fontWeight: FontWeight.w500),
                              ),
                              Text(
                                " (2) Critical Edition of the Harivamsha:",
                                textAlign: TextAlign.justify,
                                overflow: TextOverflow.ellipsis,
                                maxLines: 30,
                                style: TextStyle(
                                    color: AppTheme.deco,
                                    fontSize: 16,
                                    fontWeight: FontWeight.w900),
                              ),
                              Text(
                                "1966 to 1969; 4 Parvan-s; 2 Volumes; No. of pages 1711 demi-quarto size\n\n",
                                textAlign: TextAlign.left,
                                overflow: TextOverflow.ellipsis,
                                maxLines: 30,
                                style: TextStyle(
                                    color: AppTheme.deco,
                                    fontSize: 16,
                                    fontWeight: FontWeight.w500),
                              ),
                              Text(
                                " (3) Pratika Index (Index of the verse quarters):",
                                textAlign: TextAlign.justify,
                                overflow: TextOverflow.ellipsis,
                                maxLines: 30,
                                style: TextStyle(
                                    color: AppTheme.deco,
                                    fontSize: 16,
                                    fontWeight: FontWeight.w900),
                              ),
                              Text(
                                " 360000 verse quarters with appendices; 6 Volumes; 4805 pages; demi-quarto size\n\n",
                                textAlign: TextAlign.left,
                                overflow: TextOverflow.ellipsis,
                                maxLines: 30,
                                style: TextStyle(
                                    color: AppTheme.deco,
                                    fontSize: 16,
                                    fontWeight: FontWeight.w500),
                              ),
                              Text(
                                "(4) Critically constituted text of Mahabharata and Harivamsha",
                                textAlign: TextAlign.left,
                                overflow: TextOverflow.ellipsis,
                                maxLines: 30,
                                style: TextStyle(
                                    color: AppTheme.deco,
                                    fontSize: 16,
                                    fontWeight: FontWeight.w900),
                              ),
                              Text(
                                " 5 volumes; 3150 pages demi-quarto size\n\n",
                                textAlign: TextAlign.left,
                                overflow: TextOverflow.ellipsis,
                                maxLines: 30,
                                style: TextStyle(
                                    color: AppTheme.deco,
                                    fontSize: 16,
                                    fontWeight: FontWeight.w500),
                              ),
                              Text(
                                " (5) Cultural Index:",
                                textAlign: TextAlign.left,
                                overflow: TextOverflow.ellipsis,
                                maxLines: 30,
                                style: TextStyle(
                                    color: AppTheme.deco,
                                    fontSize: 16,
                                    fontWeight: FontWeight.w900),
                              ),
                              Text(
                                " (a)	1987 till date; published 2 volumes;",
                                textAlign: TextAlign.left,
                                overflow: TextOverflow.ellipsis,
                                maxLines: 30,
                                style: TextStyle(
                                    color: AppTheme.deco,
                                    fontSize: 16,
                                    fontWeight: FontWeight.w500),
                              ),
                              Text(
                                " Vol. I – 4 fascicules: Mountains, Rivers, Serpents, etc.; 400 pages; double crown size (Concise volume: pages vii+506)",
                                textAlign: TextAlign.left,
                                overflow: TextOverflow.ellipsis,
                                maxLines: 30,
                                style: TextStyle(
                                    color: AppTheme.deco,
                                    fontSize: 16,
                                    fontWeight: FontWeight.w500),
                              ),
                              Text(
                                " Vol. II – 3 fascicules: Names of Countries, Peoples, Weapons, etc.; 360 pages double crown size",
                                textAlign: TextAlign.left,
                                overflow: TextOverflow.ellipsis,
                                maxLines: 30,
                                style: TextStyle(
                                    color: AppTheme.deco,
                                    fontSize: 16,
                                    fontWeight: FontWeight.w500),
                              ),
                              Text(
                                "Vol. III – (1st fascicule in progress): Proper names",
                                textAlign: TextAlign.left,
                                overflow: TextOverflow.ellipsis,
                                maxLines: 30,
                                style: TextStyle(
                                    color: AppTheme.deco,
                                    fontSize: 16,
                                    fontWeight: FontWeight.w500),
                              ),
                              Text(
                                " (b)	Reference Cards: 1,50,000+ (15 cm X 10 cm); used 19,000+; unused 1,31,000\n\n",
                                textAlign: TextAlign.left,
                                overflow: TextOverflow.ellipsis,
                                maxLines: 30,
                                style: TextStyle(
                                    color: AppTheme.deco,
                                    fontSize: 16,
                                    fontWeight: FontWeight.w500),
                              ),
                              Text(
                                " (6) Bibliography of the Mahabharata:",
                                textAlign: TextAlign.left,
                                overflow: TextOverflow.ellipsis,
                                maxLines: 30,
                                style: TextStyle(
                                    color: AppTheme.deco,
                                    fontSize: 16,
                                    fontWeight: FontWeight.w900),
                              ),
                              Text(
                                " 6000+ entries recorded and categorized; Card Size 22 cm X 15 cm; 600 entries computerized\n\n",
                                textAlign: TextAlign.left,
                                overflow: TextOverflow.ellipsis,
                                maxLines: 30,
                                style: TextStyle(
                                    color: AppTheme.deco,
                                    fontSize: 16,
                                    fontWeight: FontWeight.w500),
                              ),
                              Text(
                                " (7) Mahabharata on CD-ROM:",
                                textAlign: TextAlign.start,
                                overflow: TextOverflow.ellipsis,
                                maxLines: 30,
                                style: TextStyle(
                                    color: AppTheme.deco,
                                    fontSize: 16,
                                    fontWeight: FontWeight.w900),
                              ),
                              Text(
                                " The Constituted Text of the Critical Edition available on the CD-ROM with lead search, phrase search, and /or lead search.",
                                textAlign: TextAlign.left,
                                overflow: TextOverflow.ellipsis,
                                maxLines: 30,
                                style: TextStyle(
                                    color: AppTheme.deco,
                                    fontSize: 16,
                                    fontWeight: FontWeight.w500),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                    if (sampleData.elementAt(2).isSelected) ...[
                      Visibility(
                        visible: true,
                        child: Container(
                          margin: EdgeInsets.only(bottom: 10),
                          //   alignment: AlignmentDirectional.topCenter,
                          child: Text(
                            "Future Plans",
                            textAlign: TextAlign.center,
                            overflow: TextOverflow.ellipsis,
                            maxLines: 30,
                            style: TextStyle(
                                color: AppTheme.AppBarTheme,
                                fontWeight: FontWeight.w900,
                                fontSize: 18),
                          ),
                        ),
                      ),
                      Visibility(
                        visible: true,
                        child: Container(
                          margin: EdgeInsets.all(10),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Text(
                                "(1) Next steps in ongoing work:",
                                textAlign: TextAlign.left,
                                overflow: TextOverflow.ellipsis,
                                maxLines: 30,
                                style: TextStyle(
                                    color: AppTheme.deco,
                                    fontSize: 16,
                                    fontWeight: FontWeight.w900),
                              ),
                              // SizedBox(height: 10,),
                              Text(
                                "- Updating of reference cards should continue.",
                                textAlign: TextAlign.left,
                                overflow: TextOverflow.ellipsis,
                                maxLines: 30,
                                style: TextStyle(
                                    color: AppTheme.deco,
                                    fontSize: 16,
                                    fontWeight: FontWeight.w500),
                              ),
                              Text(
                                "-	Compiling and editing of entries for the Cultural Index should continue.",
                                textAlign: TextAlign.left,
                                overflow: TextOverflow.ellipsis,
                                maxLines: 30,
                                style: TextStyle(
                                    color: AppTheme.deco,
                                    fontSize: 16,
                                    fontWeight: FontWeight.w500),
                              ),
                              Text(
                                " -	Printing Bibliography Data-cards according to the proforma.",
                                textAlign: TextAlign.left,
                                overflow: TextOverflow.ellipsis,
                                maxLines: 30,
                                style: TextStyle(
                                    color: AppTheme.deco,
                                    fontSize: 16,
                                    fontWeight: FontWeight.w500),
                              ),
                              Text(
                                "-	Sending letters to Libraries world over for assistance in preparation of the Bibliography of Mahābhārata.",
                                textAlign: TextAlign.left,
                                overflow: TextOverflow.ellipsis,
                                maxLines: 30,
                                style: TextStyle(
                                    color: AppTheme.deco,
                                    fontSize: 16,
                                    fontWeight: FontWeight.w500),
                              ),
                              Text(
                                "-	Complete digitization of the Bibliography.",
                                textAlign: TextAlign.left,
                                overflow: TextOverflow.ellipsis,
                                maxLines: 30,
                                style: TextStyle(
                                    color: AppTheme.deco,
                                    fontSize: 16,
                                    fontWeight: FontWeight.w500),
                              ),
                              Text(
                                "- Editing of the Bibliography.\n\n",
                                textAlign: TextAlign.left,
                                overflow: TextOverflow.ellipsis,
                                maxLines: 30,
                                style: TextStyle(
                                    color: AppTheme.deco,
                                    fontSize: 16,
                                    fontWeight: FontWeight.w500),
                              ),
                              Text(
                                "(2) Prospects of expansion:",
                                textAlign: TextAlign.left,
                                overflow: TextOverflow.ellipsis,
                                maxLines: 30,
                                style: TextStyle(
                                    color: AppTheme.deco,
                                    fontSize: 16,
                                    fontWeight: FontWeight.w900),
                              ),
                              // SizedBox(height: 10,),
                              Text(
                                "-	Translation of the Critical Edition.",
                                textAlign: TextAlign.left,
                                overflow: TextOverflow.ellipsis,
                                maxLines: 30,
                                style: TextStyle(
                                    color: AppTheme.deco,
                                    fontSize: 16,
                                    fontWeight: FontWeight.w500),
                              ),
                              Text(
                                "-	Interpretative Epilogue of Mahābhārata.",
                                textAlign: TextAlign.left,
                                overflow: TextOverflow.ellipsis,
                                maxLines: 30,
                                style: TextStyle(
                                    color: AppTheme.deco,
                                    fontSize: 16,
                                    fontWeight: FontWeight.w500),
                              ),
                              Text(
                                "- Digitization of the Critical Apparatus.",
                                textAlign: TextAlign.left,
                                overflow: TextOverflow.ellipsis,
                                maxLines: 30,
                                style: TextStyle(
                                    color: AppTheme.deco,
                                    fontSize: 16,
                                    fontWeight: FontWeight.w500),
                              ),
                              Text(
                                "- Digitization of Cultural Index.",
                                textAlign: TextAlign.left,
                                overflow: TextOverflow.ellipsis,
                                maxLines: 30,
                                style: TextStyle(
                                    color: AppTheme.deco,
                                    fontSize: 16,
                                    fontWeight: FontWeight.w500),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ]
                  ]),
                ),
              ),
            ),
          )
        ],
      )),
    );
  }
}

class RadioModel {
  bool isSelected;
  final String buttonText;
  final String text;

  RadioModel(this.isSelected, this.buttonText, this.text);
}

class RadioItem extends StatelessWidget {
  final RadioModel _item;

  RadioItem(this._item);

  
  @override
  Widget build(BuildContext context) {
    
    return new Container(
      margin: new EdgeInsets.all(8.0),
      child: new Row(
        mainAxisSize: MainAxisSize.max,
        children: <Widget>[
          new Container(
            height: 30.0,
            width: 100.0,
            child: new Center(
              child: new Text(_item.buttonText,
                  style: new TextStyle(
                      color: _item.isSelected
                          ? Colors.white
                          : AppTheme.AppBarTheme,
                      fontWeight: FontWeight.bold,
                      fontSize: 16.0)),
            ),
            decoration: new BoxDecoration(
              color:
                  _item.isSelected ? AppTheme.AppBarTheme : Colors.transparent,
              border: new Border.all(
                  width: 2.0,
                  color: _item.isSelected
                      ? AppTheme.AppBarTheme
                      : AppTheme.AppBarTheme),
              borderRadius: const BorderRadius.all(const Radius.circular(14.0)),
            ),
          ),
          new Container(
            // margin: new EdgeInsets.only(left: 10.0),
            child:  Text(_item.text),
          )
    
          
        ],
      ),
    );
    
  }
  
}
