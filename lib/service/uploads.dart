import 'package:flutter/material.dart';

import 'package:ldp/drower.dart';
import 'package:ldp/service/e_dealer/sef.dart';
import 'package:ldp/service/e_dealer/sif.dart';
import 'package:ldp/service/e_dealer/wc.dart';
import 'package:ldp/service/masters/actual_per_ro_targets.dart';
import 'package:ldp/service/masters/actual_revenue_targets.dart';
import 'package:ldp/service/masters/aspirational_per_ro_targets.dart';
import 'package:ldp/service/masters/aspirational_revenue_targets.dart';
import 'package:ldp/service/masters/location_mapping.dart';
import 'package:ldp/service/masters/models_mapping.dart';
import 'package:responsive_builder/responsive_builder.dart';

class uploads extends StatefulWidget {
  const uploads({Key? key}) : super(key: key);

  @override
  State<uploads> createState() => _uploadsState();
}

class _uploadsState extends State<uploads> {
  bool is_open_E_dealer = false;
  bool is_open_master_dataset = false;

  @override
  Widget build(BuildContext context) {
    var deviceType = getDeviceType(MediaQuery.of(context).size);

    double img_width = 0;
    double img_height = 0;

    double Main_font = 0;
    double Sub_font = 0;

    double card_padding = 0;
    bool is_desktop = false;

    switch (deviceType) {
      case DeviceScreenType.desktop:
        is_desktop = true;
        img_width = 100;
        img_height = 100;
        Main_font = 25;
        Sub_font = 20;
        card_padding = 20;
        break;
      case DeviceScreenType.tablet:
        img_width = 80;
        img_height = 80;
        Main_font = 20;
        Sub_font = 15;
        card_padding = 15;
        is_desktop = false;
        break;
      case DeviceScreenType.mobile:
        img_width = 60;
        img_height = 60;
        Main_font = 18;
        Sub_font = 15;
        card_padding = 12;
        is_desktop = false;
        break;
      case DeviceScreenType.Mobile:
        // TODO: Handle this case.
        break;
      case DeviceScreenType.Tablet:
        // TODO: Handle this case.
        break;
      case DeviceScreenType.Desktop:
        // TODO: Handle this case.
        break;
      case DeviceScreenType.Watch:
        // TODO: Handle this case.
        break;
      case DeviceScreenType.watch:
        // TODO: Handle this case.
        break;
    }

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Row(
          children: [
            is_desktop
                ? Image.asset(
                    'assets/img/logo-white.png',
                    fit: BoxFit.cover,
                    height: 40,
                  )
                : Container(),
            Spacer(),
            Text('Uploads'),
            Spacer(),
            // IconButton(
            //   icon: Icon(Icons.manage_accounts_outlined),
            //   onPressed: () => {},
            // ),
          ],
        ),
      ),
      body: Stack(
        children: [
          Container(
            decoration: new BoxDecoration(
              image: DecorationImage(
                image: AssetImage("assets/img/main_bg.png"),
                fit: BoxFit.cover,
                // colorFilter: ColorFilter.mode(
                //     Colors.white.withOpacity(0.5), BlendMode.dstATop),
              ),
            ),
          ),
          SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: EdgeInsets.all(card_padding),
                  child: Container(
                    // height: 550,
                    decoration: BoxDecoration(
                      color: Color.fromARGB(132, 255, 255, 255),
                      borderRadius: BorderRadius.only(
                        topRight: Radius.circular(80),
                        topLeft: Radius.circular(80),
                      ),
                      border: Border.all(
                        width: 2,
                        color: Color.fromARGB(255, 0, 0, 0),
                        style: BorderStyle.solid,
                      ),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        SizedBox(
                          height: card_padding,
                        ),
                        Container(
                            padding: EdgeInsets.all(10),
                            decoration: new BoxDecoration(
                                shape: BoxShape.circle,
                                gradient: LinearGradient(
                                    begin: Alignment.bottomCenter,
                                    end: Alignment.topCenter,
                                    stops: [
                                      0.0,
                                      0.5,
                                      1.0
                                    ],
                                    colors: [
                                      Colors.white,
                                      Colors.white,
                                      Colors.grey
                                    ])),
                            child: RawMaterialButton(
                              onPressed: () {},
                              child: Padding(
                                padding: EdgeInsets.all(20),
                                child: Image.asset(
                                  'assets/img/figma/E_dealer.png',
                                  fit: BoxFit.cover,
                                  height: img_height,
                                ),
                              ),
                              shape: new CircleBorder(),
                              elevation: 2.0,
                              fillColor: Colors.white,
                              padding: const EdgeInsets.all(18.0),
                            )),
                        SizedBox(
                          height: 5,
                        ),
                        Text(
                          "E-Dealer",
                          style: new TextStyle(
                              fontSize: Main_font,
                              color: Color.fromARGB(255, 0, 0, 0),
                              fontWeight: FontWeight.w600,
                              decoration: TextDecoration.underline),
                        ),
                        // SizedBox(
                        //   height: 5,
                        // ),
                        // Container(
                        //   height: 2,
                        //   width: 300,
                        //   color: Color.fromARGB(255, 0, 0, 0),
                        // ),

                        SizedBox(
                          height: 20,
                        ),

                        // Container(
                        //   height: 2,
                        //   width: 100,
                        //   color: Color.fromARGB(255, 0, 0, 0),
                        // ),

                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                MaterialButton(
                                  height: 50.0,
                                  textColor: Color.fromARGB(255, 0, 0, 0),
                                  child: Row(
                                    children: [
                                      Icon(
                                        Icons.miscellaneous_services,
                                        color: Colors.black,
                                      ),
                                      SizedBox(
                                        width: 10,
                                      ),
                                      Text(
                                        "Service Invoice Flat View",
                                        style: new TextStyle(
                                            fontSize: Sub_font,
                                            color: Color.fromARGB(255, 0, 0, 0),
                                            fontWeight: FontWeight.w400),
                                      ),
                                    ],
                                  ),
                                  onPressed: () => {
                                    // Navigator.push(
                                    //   context,
                                    //   MaterialPageRoute(
                                    //       builder: (context) => sif()),
                                    // ).then((value) {})

                                    Navigator.pushNamed(context, '/sif')
                                  },
                                  splashColor: Theme.of(context).primaryColor,
                                ),
                                // SizedBox(
                                //   height: 5,
                                // ),
                                // Container(
                                //   height: 1,
                                //   width: img_width * 2,
                                //   color: Color.fromARGB(255, 0, 0, 0),
                                // ),
                                SizedBox(
                                  height: 5,
                                ),
                                MaterialButton(
                                  height: 50.0,
                                  textColor: Color.fromARGB(255, 0, 0, 0),
                                  child: Row(
                                    children: [
                                      Icon(
                                        Icons.sell_rounded,
                                        color: Colors.black,
                                      ),
                                      SizedBox(
                                        width: 10,
                                      ),
                                      Text(
                                        "Star Ease Flat View",
                                        style: new TextStyle(
                                            fontSize: Sub_font,
                                            color: Color.fromARGB(255, 0, 0, 0),
                                            fontWeight: FontWeight.w400),
                                      ),
                                    ],
                                  ),
                                  onPressed: () => {
                                    // Navigator.push(
                                    //   context,
                                    //   MaterialPageRoute(
                                    //       builder: (context) => sef()),
                                    // ).then((value) {})
                                    Navigator.pushNamed(context, '/sef')
                                  },
                                  splashColor: Theme.of(context).primaryColor,
                                ),
                                // SizedBox(
                                //   height: 5,
                                // ),
                                // Container(
                                //   height: 1,
                                //   width: img_width * 2,
                                //   color: Color.fromARGB(255, 0, 0, 0),
                                // ),
                                SizedBox(
                                  height: 5,
                                ),
                                MaterialButton(
                                  height: 50.0,
                                  textColor: Color.fromARGB(255, 0, 0, 0),
                                  child: Row(
                                    children: [
                                      Icon(
                                        Icons.security,
                                        color: Colors.black,
                                      ),
                                      SizedBox(
                                        width: 10,
                                      ),
                                      Text(
                                        "Warranty Claims",
                                        style: new TextStyle(
                                            fontSize: Sub_font,
                                            color: Color.fromARGB(255, 0, 0, 0),
                                            fontWeight: FontWeight.w400),
                                      ),
                                    ],
                                  ),
                                  onPressed: () => {
                                    // Navigator.push(
                                    //   context,
                                    //   MaterialPageRoute(
                                    //       builder: (context) => wc()),
                                    // ).then((value) {})

                                    Navigator.pushNamed(context, '/wc')
                                  },
                                  splashColor: Theme.of(context).primaryColor,
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                              ],
                            ),
                          ],
                        ),

                        // RawMaterialButton(
                        //   onPressed: () {},
                        //   child: Padding(
                        //     padding: EdgeInsets.all(20),
                        //     child: Row(
                        //       children: [
                        //         Icon(
                        //           Icons.miscellaneous_services,
                        //         ),
                        //         Text('Service Invoice Flat View'),
                        //       ],
                        //     ),
                        //   ),
                        //   // shape: new CircleBorder(),
                        //   elevation: 2.0,
                        //   fillColor: Colors.white,
                        //   padding: const EdgeInsets.all(18.0),
                        // )
                      ],
                    ),
                  ),
                ),
                // Spacer(),
                Padding(
                  padding: EdgeInsets.all(card_padding),
                  child: Container(
                    // height: 550,
                    decoration: BoxDecoration(
                      color: Color.fromARGB(132, 255, 255, 255),
                      borderRadius: BorderRadius.only(
                        // topRight: Radius.circular(80),
                        bottomLeft: Radius.circular(80),
                        bottomRight: Radius.circular(80),
                      ),
                      border: Border.all(
                        width: 2,
                        color: Color.fromARGB(255, 0, 0, 0),
                        style: BorderStyle.solid,
                      ),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        SizedBox(
                          height: card_padding,
                        ),
                        Container(
                            padding: EdgeInsets.all(10),
                            decoration: new BoxDecoration(
                                shape: BoxShape.circle,
                                gradient: LinearGradient(
                                    begin: Alignment.bottomCenter,
                                    end: Alignment.topCenter,
                                    stops: [
                                      0.0,
                                      0.5,
                                      1.0
                                    ],
                                    colors: [
                                      Colors.white,
                                      Colors.white,
                                      Colors.grey
                                    ])),
                            child: RawMaterialButton(
                              onPressed: () {},
                              child: Padding(
                                padding: EdgeInsets.all(20),
                                child: Image.asset(
                                  'assets/img/figma/Master_Datasets.png',
                                  fit: BoxFit.cover,
                                  height: img_height,
                                ),
                              ),
                              shape: new CircleBorder(),
                              elevation: 2.0,
                              fillColor: Colors.white,
                              padding: const EdgeInsets.all(18.0),
                            )),
                        SizedBox(
                          height: 5,
                        ),
                        Text(
                          "Master Dataset",
                          style: new TextStyle(
                              fontSize: Main_font,
                              color: Color.fromARGB(255, 0, 0, 0),
                              fontWeight: FontWeight.w600,
                              decoration: TextDecoration.underline),
                        ),
                        // SizedBox(
                        //   height: 5,
                        // ),
                        // Container(
                        //   height: 2,
                        //   width: 300,
                        //   color: Color.fromARGB(255, 0, 0, 0),
                        // ),

                        SizedBox(
                          height: 20,
                        ),

                        // Container(
                        //   height: 2,
                        //   width: 100,
                        //   color: Color.fromARGB(255, 0, 0, 0),
                        // ),

                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                MaterialButton(
                                  height: 50.0,
                                  textColor: Color.fromARGB(255, 0, 0, 0),
                                  child: Row(
                                    children: [
                                      // Spacer(),
                                      Icon(
                                        Icons.location_on_outlined,
                                        color: Colors.black,
                                      ),
                                      SizedBox(
                                        width: 10,
                                      ),
                                      Text(
                                        "Location Mapping",
                                        style: new TextStyle(
                                            fontSize: Sub_font,
                                            color: Color.fromARGB(255, 0, 0, 0),
                                            fontWeight: FontWeight.w400),
                                      ),
                                      // Spacer(),
                                    ],
                                  ),
                                  onPressed: () => {
                                    // Navigator.push(
                                    //   context,
                                    //   MaterialPageRoute(
                                    //       builder: (context) =>
                                    //           location_mapping()),
                                    // ).then((value) {})

                                    Navigator.pushNamed(
                                        context, '/location_mapping')
                                  },
                                  splashColor: Theme.of(context).primaryColor,
                                ),
                                // SizedBox(
                                //   height: 5,
                                // ),
                                // Container(
                                //   height: 1,
                                //   width: img_width * 2,
                                //   color: Color.fromARGB(255, 0, 0, 0),
                                // ),
                                SizedBox(
                                  height: 5,
                                ),
                                MaterialButton(
                                  height: 50.0,
                                  textColor: Color.fromARGB(255, 0, 0, 0),
                                  child: Row(
                                    children: [
                                      Icon(
                                        Icons.ac_unit_rounded,
                                        color: Colors.black,
                                      ),
                                      SizedBox(
                                        width: 10,
                                      ),
                                      Text(
                                        "Models Mapping",
                                        style: new TextStyle(
                                            fontSize: Sub_font,
                                            color: Color.fromARGB(255, 0, 0, 0),
                                            fontWeight: FontWeight.w400),
                                      ),
                                    ],
                                  ),
                                  onPressed: () => {
                                    // Navigator.push(
                                    //   context,
                                    //   MaterialPageRoute(
                                    //       builder: (context) =>
                                    //           models_mapping()),
                                    // ).then((value) {})

                                    Navigator.pushNamed(
                                        context, '/models_mapping')
                                  },
                                  splashColor: Theme.of(context).primaryColor,
                                ),
                                // SizedBox(
                                //   height: 5,
                                // ),
                                // Container(
                                //   height: 1,
                                //   width: img_width * 2,
                                //   color: Color.fromARGB(255, 0, 0, 0),
                                // ),
                                SizedBox(
                                  height: 5,
                                ),
                                MaterialButton(
                                  height: 50.0,
                                  textColor: Color.fromARGB(255, 0, 0, 0),
                                  child: Row(
                                    children: [
                                      Icon(
                                        Icons.track_changes_rounded,
                                        color: Colors.black,
                                      ),
                                      SizedBox(
                                        width: 10,
                                      ),
                                      Text(
                                        "Actual Revenue Targets",
                                        style: new TextStyle(
                                            fontSize: Sub_font,
                                            color: Color.fromARGB(255, 0, 0, 0),
                                            fontWeight: FontWeight.w400),
                                      ),
                                    ],
                                  ),
                                  onPressed: () => {
                                    // Navigator.push(
                                    //   context,
                                    //   MaterialPageRoute(
                                    //       builder: (context) =>
                                    //           actual_revenue_targets()),
                                    // ).then((value) {})

                                    Navigator.pushNamed(
                                        context, '/actual_revenue_targets')
                                  },
                                  splashColor: Theme.of(context).primaryColor,
                                ),
                                SizedBox(
                                  height: 5,
                                ),
                                MaterialButton(
                                  height: 50.0,
                                  textColor: Color.fromARGB(255, 0, 0, 0),
                                  child: Row(
                                    children: [
                                      Icon(
                                        Icons.transgender_sharp,
                                        color: Colors.black,
                                      ),
                                      SizedBox(
                                        width: 10,
                                      ),
                                      Text(
                                        "Aspirational Revenue Targets",
                                        style: new TextStyle(
                                            fontSize: Sub_font,
                                            color: Color.fromARGB(255, 0, 0, 0),
                                            fontWeight: FontWeight.w400),
                                      ),
                                    ],
                                  ),
                                  onPressed: () => {
                                    // Navigator.push(
                                    //   context,
                                    //   MaterialPageRoute(
                                    //       builder: (context) =>
                                    //           aspirational_revenue_targets()),
                                    // ).then((value) {})

                                    Navigator.pushNamed(context,
                                        '/aspirational_revenue_targets')
                                  },
                                  splashColor: Theme.of(context).primaryColor,
                                ),
                                // SizedBox(
                                //   height: 5,
                                // ),
                                // Container(
                                //   height: 1,
                                //   width: img_width * 2,
                                //   color: Color.fromARGB(255, 0, 0, 0),
                                // ),
                                SizedBox(
                                  height: 5,
                                ),
                                MaterialButton(
                                  height: 50.0,
                                  textColor: Color.fromARGB(255, 0, 0, 0),
                                  child: Row(
                                    children: [
                                      Icon(
                                        Icons.track_changes_rounded,
                                        color: Colors.black,
                                      ),
                                      SizedBox(
                                        width: 10,
                                      ),
                                      Text(
                                        "Actual Per RO Targets",
                                        style: new TextStyle(
                                            fontSize: Sub_font,
                                            color: Color.fromARGB(255, 0, 0, 0),
                                            fontWeight: FontWeight.w400),
                                      ),
                                    ],
                                  ),
                                  onPressed: () => {
                                    // Navigator.push(
                                    //   context,
                                    //   MaterialPageRoute(
                                    //       builder: (context) =>
                                    //           actual_per_ro_targets()),
                                    // ).then((value) {})

                                    Navigator.pushNamed(
                                        context, '/actual_per_ro_targets')
                                  },
                                  splashColor: Theme.of(context).primaryColor,
                                ),
                                SizedBox(
                                  height: 5,
                                ),
                                MaterialButton(
                                  height: 50.0,
                                  textColor: Color.fromARGB(255, 0, 0, 0),
                                  child: Row(
                                    children: [
                                      Icon(
                                        Icons.transgender_sharp,
                                        color: Colors.black,
                                      ),
                                      SizedBox(
                                        width: 10,
                                      ),
                                      Text(
                                        "Aspirational Per RO Targets",
                                        style: new TextStyle(
                                            fontSize: Sub_font,
                                            color: Color.fromARGB(255, 0, 0, 0),
                                            fontWeight: FontWeight.w400),
                                      ),
                                    ],
                                  ),
                                  onPressed: () => {
                                    // Navigator.push(
                                    //   context,
                                    //   MaterialPageRoute(
                                    //       builder: (context) =>
                                    //           aspirational_per_ro_targets()),
                                    // ).then((value) {})

                                    Navigator.pushNamed(
                                        context, '/aspirational_per_ro_targets')
                                  },
                                  splashColor: Theme.of(context).primaryColor,
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                              ],
                            ),
                          ],
                        ),

                        // RawMaterialButton(
                        //   onPressed: () {},
                        //   child: Padding(
                        //     padding: EdgeInsets.all(20),
                        //     child: Row(
                        //       children: [
                        //         Icon(
                        //           Icons.miscellaneous_services,
                        //         ),
                        //         Text('Service Invoice Flat View'),
                        //       ],
                        //     ),
                        //   ),
                        //   // shape: new CircleBorder(),
                        //   elevation: 2.0,
                        //   fillColor: Colors.white,
                        //   padding: const EdgeInsets.all(18.0),
                        // )
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
      drawer: drower(),
    );
  }
}
