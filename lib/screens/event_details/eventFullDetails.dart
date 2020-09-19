import 'package:dscnsec_app/Drawer/drawer.dart';
import 'package:dscnsec_app/screens/eventsData.dart';
import 'package:dscnsec_app/screens/featuredEventsDataForHome.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../customIcons.dart';
import '../introText.dart';
import '../screen1_home.dart';
import '../screen2_events.dart';
import '../screen3_teams.dart';
import '../screen4_about.dart';
import '../screen5_projects.dart';

TextofIntro text = TextofIntro();

class eventFullDetails extends StatefulWidget {
  var j;

  var eventType;

  eventFullDetails(this.j, this.eventType);

  @override
  State<StatefulWidget> createState() {
    return eventFullDetailsState(this.j, this.eventType);
  }
}

class eventFullDetailsState extends State<eventFullDetails> {
  double xOffset = 0.0;
  double yOffset = 0.0;
  double scalefactor = 1;
  bool isdrawerOpen = false;

  var j;

  var eventType;
  var speakers;
  var pre;

  eventFullDetailsState(this.j, this.eventType);

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    if (eventType == "up") {
      speakers = up_speakers[j].toString().split(",");
      pre = up_prerequire[j].toString().split(",");
    }
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        onWillPop: _onBackPressed,
        child: Scaffold(
            body: SafeArea(
                child: Stack(children: <Widget>[
          DrawerScreen(),
          AnimatedContainer(
            height: MediaQuery.of(context).size.height,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(isdrawerOpen ? 35.0 : 0.0),
            ),
            transform: Matrix4.translationValues(xOffset, yOffset, 0)
              ..scale(scalefactor)
              ..rotateY(isdrawerOpen ? -0.5 : 0.0),
            duration: Duration(milliseconds: 250),
            child: SingleChildScrollView(
              child: Column(
                //  mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.only(
                          topLeft: isdrawerOpen
                              ? Radius.circular(35.0)
                              : Radius.circular(0.0)),
                      color: Colors.white,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        isdrawerOpen
                            ? IconButton(
                                icon: Icon(Icons.arrow_back_ios),
                                onPressed: () {
                                  setState(() {
                                    isdrawerOpen = false;
                                    xOffset = 0.0;
                                    yOffset = 0.0;
                                    scalefactor = 1;
                                  });
                                },
                              )
                            : IconButton(
                                icon: Icon(CustomIcons.menu),
                                onPressed: () {
                                  setState(() {
                                    xOffset =
                                        MediaQuery.of(context).size.height *
                                            0.3;
                                    yOffset =
                                        MediaQuery.of(context).size.width *
                                            0.37;
                                    scalefactor = 0.6;
                                    isdrawerOpen = true;
                                  });
                                }),
                        Padding(
                          padding: EdgeInsets.only(
                              left: MediaQuery.of(context).size.width * 0.06),
                          child: Text(
                            'DSC NSEC',
                            style: TextStyle(
                              fontFamily: 'productSans',
                              fontWeight: FontWeight.w600,
                              fontSize: 22.0,
                            ),
                          ),
                        ),
                        //profile image of the user...on tap this will open account settings page
                        Padding(
                          padding: EdgeInsets.only(right: 12.0, top: 5.0),
                          child: CircleAvatar(
                            radius: 29.0,
                            child: dsclogo(),
                          ),
                        ),
                      ],
                    ),
                  ),

                  //YOUR CODE GOES HERE ->> DSC NSEC EVENTS SECTION ->
                  //FOR Upcoming Event full Details ->>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
                  if (eventType == "up")
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        //alert note (if any)
                        if (up_note[j] != "")
                          Padding(
                            padding: EdgeInsets.all(2.5),
                          ),
                        if (up_note[j] != "")
                          Container(
                            padding: EdgeInsets.fromLTRB(7, 2, 1, 2),
                            color: Colors.redAccent,
                            child: Center(
                              child: Text(
                                "${up_note[j]}",
                                style: TextStyle(
                                    fontSize: 14,
                                    fontFamily: 'productSans',
                                    color: Colors.white,
                                    fontStyle: FontStyle.italic),
                              ),
                            ),
                          ),

                        //event name
                        if (up_name[j] != "")
                          Center(
                              child: Container(
                                  padding: EdgeInsets.fromLTRB(5, 15, 5, 15),
                                  child: Text("${up_name[j]}",
                                      style: TextStyle(
                                        fontFamily: 'productSans',
                                        fontWeight: FontWeight.w600,
                                        fontSize: 25.0,
                                      )))),
                        //event banner

                        Center(
                            child: Padding(
                                padding: EdgeInsets.fromLTRB(5, 0, 5, 15),
                                child: Container(
                                    padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
                                    height: 200,
                                    width: 350,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10.0),
                                      color: Colors.white,
                                      boxShadow: [
                                        new BoxShadow(
                                          color: Colors.white,
                                          offset: new Offset(15.0, 5.0),
                                          blurRadius: 20.0,
                                        )
                                      ],
                                    ),
                                    child: Card(
                                      child: FadeInImage.assetNetwork(
                                        fadeInCurve: Curves.easeInOutCubic,
                                        fadeInDuration:
                                            const Duration(seconds: 1),
                                        placeholder:
                                            'assets/images/loading2.gif',
                                        image: up_banner[j],
                                        fit: BoxFit.cover,
                                      ),
                                    )))),

                        //date time venue mode
                        if (up_date[j] != "")
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Container(
                                  padding: EdgeInsets.fromLTRB(0, 0, 0, 5),
                                  width: 30,
                                  child: Icon(
                                    Icons.event,
                                    color: Colors.blueAccent,
                                  )),
                              Container(
                                width: 115,
                                padding: EdgeInsets.fromLTRB(5, 0, 0, 5),
                                child: Text(
                                  " Event Date  :",
                                  style: TextStyle(
                                      fontSize: 18,
                                      fontFamily: 'productSans',
                                      color: Colors.grey[600]),
                                ),
                              ),
                              Container(
                                width: 160,
                                padding: EdgeInsets.fromLTRB(5, 0, 5, 5),
                                child: Text(
                                  "${up_date[j]}",
                                  style: TextStyle(
                                      fontSize: 18, fontFamily: 'productSans'),
                                ),
                              ),
                            ],
                          ),
                        if (up_time[j] != "")
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Container(
                                  padding: EdgeInsets.fromLTRB(0, 0, 0, 5),
                                  width: 30,
                                  child: Icon(
                                    Icons.timelapse,
                                    color: Colors.blueAccent,
                                  )),
                              Container(
                                width: 115,
                                padding: EdgeInsets.fromLTRB(5, 0, 0, 5),
                                child: Text(
                                  " Event Time  :",
                                  style: TextStyle(
                                      fontSize: 18,
                                      fontFamily: 'productSans',
                                      color: Colors.grey[600]),
                                ),
                              ),
                              Container(
                                width: 160,
                                padding: EdgeInsets.fromLTRB(5, 0, 5, 5),
                                child: Text(
                                  "${up_time[j]}",
                                  style: TextStyle(
                                      fontSize: 18, fontFamily: 'productSans'),
                                ),
                              ),
                            ],
                          ),

                        if (up_mode[j] != "")
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Container(
                                  padding: EdgeInsets.fromLTRB(0, 0, 0, 5),
                                  width: 30,
                                  child: Icon(
                                    Icons.graphic_eq,
                                    color: Colors.blueAccent,
                                  )),
                              Container(
                                width: 115,
                                padding: EdgeInsets.fromLTRB(5, 0, 0, 5),
                                child: Text(
                                  "Event Mode :",
                                  style: TextStyle(
                                      fontSize: 18,
                                      fontFamily: 'productSans',
                                      color: Colors.grey[600]),
                                ),
                              ),
                              Container(
                                width: 160,
                                padding: EdgeInsets.fromLTRB(5, 0, 5, 5),
                                child: Text(
                                  "${up_mode[j]}",
                                  style: TextStyle(
                                      fontSize: 18, fontFamily: 'productSans'),
                                ),
                              ),
                            ],
                          ),

                        if (up_location[j] != "")
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Container(
                                  padding: EdgeInsets.fromLTRB(0, 0, 0, 5),
                                  width: 30,
                                  child: Icon(
                                    Icons.location_on,
                                    color: Colors.blueAccent,
                                  )),
                              Container(
                                width: 115,
                                padding: EdgeInsets.fromLTRB(3, 0, 0, 5),
                                child: Text(
                                  "Event Venue :",
                                  style: TextStyle(
                                      fontSize: 18,
                                      fontFamily: 'productSans',
                                      color: Colors.grey[600]),
                                ),
                              ),
                              Container(
                                width: 160,
                                padding: EdgeInsets.fromLTRB(5, 0, 5, 5),
                                child: Text(
                                  "${up_location[j]}",
                                  style: TextStyle(
                                      fontSize: 18, fontFamily: 'productSans'),
                                ),
                              ),
                            ],
                          ),

//description
                        if (up_desc[j] != "")
                          Container(
                            padding: EdgeInsets.fromLTRB(5, 15, 5, 2),
                            child: Text(
                              "About Event",
                              style: TextStyle(
                                  fontSize: 22,
                                  fontFamily: 'productSans',
                                  color: Colors.grey[600]),
                            ),
                          ),
                        if (up_desc[j] != "")
                          Container(
                            padding: EdgeInsets.fromLTRB(5, 0, 5, 10),
                            child: Text(
                              "${up_desc[j]}",
                              style: TextStyle(
                                  fontSize: 16,
                                  fontFamily: 'productSans',
                                  color: Colors.blue),
                            ),
                          ),

                        //prior knowledge
                        Container(
                          padding: EdgeInsets.fromLTRB(5, 5, 5, 0),
                          child: Text(
                            "Prerequisites",
                            style: TextStyle(
                                fontSize: 22,
                                fontFamily: 'productSans',
                                color: Colors.grey[600]),
                          ),
                        ),
                        if (up_prerequire[j] != "")
                          for (int i = 0; i < pre.length; i++)
                            Container(
                              padding: EdgeInsets.fromLTRB(5, 0, 5, 0),
                              child: Chip(
                                label: Text(
                                  "${pre[i]}",
                                  style: TextStyle(
                                      fontSize: 17,
                                      fontFamily: 'productSans',
                                      color: Colors.grey[600]),
                                ),
                              ),
                            ),
                        if (up_prerequire[j] == "")
                          Container(
                            padding: EdgeInsets.fromLTRB(5, 0, 5, 0),
                            child: Chip(
                              label: Text(
                                "No prior knowledge is required.",
                                style: TextStyle(
                                    fontSize: 17,
                                    fontFamily: 'productSans',
                                    color: Colors.grey[600]),
                              ),
                            ),
                          ),
                        //speakers
                        if (up_speakers[j] != "")
                          Container(
                            padding: EdgeInsets.fromLTRB(5, 15, 5, 0),
                            child: Text(
                              "Our Speakers",
                              style: TextStyle(
                                  fontSize: 22,
                                  fontFamily: 'productSans',
                                  color: Colors.grey[600]),
                            ),
                          ),
                        if (up_speakers[j] != "")
                          for (int i = 0; i < speakers.length; i++)
                            Container(
                              padding: EdgeInsets.fromLTRB(5, 0, 5, 0),
                              child: Chip(
                                label: Text(
                                  "${speakers[i]}",
                                  style: TextStyle(
                                      fontSize: 17,
                                      fontFamily: 'productSans',
                                      color: Colors.grey[600]),
                                ),
                              ),
                            ),
                        //registration details
                        Container(
                          padding: EdgeInsets.fromLTRB(5, 15, 5, 0),
                          child: Text(
                            "Event Registration",
                            style: TextStyle(
                                fontSize: 23,
                                fontFamily: 'productSans',
                                color: Colors.grey[600]),
                          ),
                        ),
                        if (up_regstatus[j] == "" ||
                            up_reglink[j] == "") //stay tuned message
                          Column(
                            children: [
                              Container(
                                padding: EdgeInsets.fromLTRB(5, 5, 5, 0),
                                child: Text(
                                  "Registration for this event will begin shorty.",
                                  style: TextStyle(
                                      fontSize: 17,
                                      fontFamily: 'productSans',
                                      color: Colors.lightBlue),
                                ),
                              ),
                              Container(
                                padding: EdgeInsets.fromLTRB(5, 0, 5, 5),
                                child: Text(
                                  "Stay tuned!",
                                  style: TextStyle(
                                      fontSize: 19,
                                      fontFamily: 'productSans',
                                      color: Colors.lightBlue),
                                ),
                              ),
                              Container(
                                  padding: EdgeInsets.fromLTRB(5, 5, 5, 25),
                                  child: Icon(
                                    Icons.insert_emoticon,
                                    color: Colors.amber,
                                    size: 45,
                                  )),
                            ],
                          ),
                        if (up_regstatus[j] != "" && up_reglink[j] != "")
                          Column(
                            children: [
                              if (up_regstatus[j].toString().toLowerCase() ==
                                  "closed")
                                Column(
                                  children: [
                                    Container(
                                        padding:
                                            EdgeInsets.fromLTRB(5, 10, 5, 0),
                                        child: Icon(
                                          Icons.sentiment_dissatisfied,
                                          color: Colors.redAccent,
                                          size: 45,
                                        )),
                                    Container(
                                      padding: EdgeInsets.fromLTRB(5, 5, 5, 25),
                                      child: Text(
                                        "Registration for this event has been Closed.",
                                        style: TextStyle(
                                            fontSize: 17,
                                            fontFamily: 'productSans',
                                            color: Colors.redAccent),
                                      ),
                                    ),
                                  ],
                                ),
                              if (up_regstatus[j].toString().toLowerCase() ==
                                  "open")
                                Column(
                                  children: [
                                    Container(
                                        padding:
                                            EdgeInsets.fromLTRB(5, 10, 5, 5),
                                        child: Icon(
                                          Icons.event_available,
                                          color: Colors.teal,
                                          size: 45,
                                        )),
                                    Container(
                                      padding: EdgeInsets.fromLTRB(5, 0, 5, 5),
                                      child: Text(
                                        "Last Date of Registration : ${up_lastreg[j]}",
                                        style: TextStyle(
                                            fontSize: 15,
                                            fontFamily: 'productSans',
                                            color: Colors.pinkAccent),
                                      ),
                                    ),
                                    Container(
                                        padding:
                                            EdgeInsets.fromLTRB(5, 5, 5, 25),
                                        child: RaisedButton.icon(
                                          color: Colors.blueAccent,
                                            elevation: 3,
                                            onPressed: () {},
                                            icon: Icon(Icons.done_outline,color: Colors.white,),
                                            label: Text("Register Now!", style: TextStyle(
                                                fontSize: 15,
                                                fontFamily: 'productSans',
                                                color: Colors.white),))),
                                  ],
                                ),
                            ],
                          )
                      ],
                    ),

                  //FOR Past Event Details ->>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
                  if (eventType == "past")
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "$eventType\n\nEvent Number-$j",
                          style: TextStyle(
                              fontSize: 25, fontFamily: 'Google-Sans'),
                        ),
                      ],
                    ),
                ],
              ),
            ),
          ),
        ]))));
  }

  //App Exit Alert Function
  Future<bool> _onBackPressed() {
    return showDialog(
        context: context,
        builder: (context) => AlertDialog(
              title: Center(
                child: Text(
                  "Where to Go!",
                  style: TextStyle(fontFamily: "productSans"),
                ),
              ),
              actions: [
                Center(
                  child: FlatButton.icon(
                      onPressed: () => Navigator.of(context).pushReplacement(
                          MaterialPageRoute(
                              builder: (context) => HomeScreen())),
                      icon: Icon(
                        Icons.home,
                        color: Colors.blue,
                        size: 30,
                      ),
                      label: Text(
                        "Home",
                        style: TextStyle(fontFamily: "productSans"),
                      )),
                ),
                Center(
                  child: FlatButton.icon(
                      onPressed: () => Navigator.of(context).pushReplacement(
                          MaterialPageRoute(
                              builder: (context) => screen2_events())),
                      icon: Icon(
                        Icons.event_available,
                        color: Colors.blue,
                      ),
                      label: Text(
                        "Events",
                        style: TextStyle(fontFamily: "productSans"),
                      )),
                ),
                Center(
                  child: FlatButton.icon(
                      onPressed: () => Navigator.of(context).pushReplacement(
                          MaterialPageRoute(
                              builder: (context) => ProjectPage())),
                      icon: Icon(
                        Icons.lightbulb_outline,
                        color: Colors.blue,
                        size: 28,
                      ),
                      label: Text(
                        "Projects",
                        style: TextStyle(fontFamily: "productSans"),
                      )),
                ),
                Center(
                  child: FlatButton.icon(
                      onPressed: () => Navigator.of(context).pushReplacement(
                          MaterialPageRoute(builder: (context) => teams())),
                      icon: Icon(
                        Icons.people,
                        color: Colors.blue,
                      ),
                      label: Text(
                        "Our Teams",
                        style: TextStyle(fontFamily: "productSans"),
                      )),
                ),
                Center(
                  child: FlatButton.icon(
                      onPressed: () => Navigator.of(context).pushReplacement(
                          MaterialPageRoute(builder: (context) => about())),
                      icon: Icon(
                        Icons.info_outline,
                        color: Colors.blue,
                      ),
                      label: Text(
                        "About Us",
                        style: TextStyle(fontFamily: "productSans"),
                      )),
                ),
                Container(
                  padding: EdgeInsets.only(bottom: 15),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Center(
                        child: FlatButton.icon(
                            onPressed: () => Navigator.pop(context, true),
                            icon: Icon(
                              Icons.exit_to_app,
                              color: Colors.green,
                            ),
                            label: Text(
                              "Exit App",
                              style: TextStyle(fontFamily: "productSans"),
                            ))),
                    Center(
                        child: FlatButton.icon(
                            onPressed: () => Navigator.pop(context, false),
                            icon: Icon(
                              Icons.clear,
                              color: Colors.red,
                            ),
                            label: Text(
                              "Close",
                              style: TextStyle(fontFamily: "productSans"),
                            )))
                  ],
                )
              ],
            ));
  }

  // DSC NSEC LOGO
  Widget dsclogo() {
    var assetImage = AssetImage("assets/images/dsclogo.png");
    var image = Image(
      image: assetImage,
      height: 100,
      width: 100,
    );
    return Container(
      child: image,
      margin: EdgeInsets.all(0),
    );
  }
}