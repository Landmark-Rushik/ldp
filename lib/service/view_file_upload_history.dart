// import 'package:flutter/material.dart';
import 'dart:convert';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:http_parser/http_parser.dart';
import 'package:ldp/drower.dart';
import 'package:responsive_builder/responsive_builder.dart';
import 'package:flutter_date_pickers/flutter_date_pickers.dart';
import 'package:intl/intl.dart';
import 'package:flutter/foundation.dart' show kIsWeb;

import 'package:file_picker/file_picker.dart';
import 'package:http/http.dart' as http;

import 'package:awesome_dialog/awesome_dialog.dart';
import '/globals.dart' as globals;
import '/loaders/color_loader_3.dart';

class view_file_upload_history extends StatefulWidget {
  const view_file_upload_history({Key? key}) : super(key: key);

  @override
  State<view_file_upload_history> createState() =>
      _view_file_upload_historyState();
}

class _view_file_upload_historyState extends State<view_file_upload_history> {
  String _selected_dataset = 'Select a dataset name';
  String str_selected_dataset = "";

  String str_url_data_set = "";

  var objFile;
  var logoBase64;
  var fileBytes;
  Map map_Response_get = {};
  bool is_data_loded = false;

  bool is_File_selected = false;

  String From_date = "";
  String To_date = "";

  String Selected_from_date = "";
  String Selected_to_date = "";

  String file_name = "";

  @override
  void initState() {
    // TODO: implement initState
    DateFormat dateFormat = DateFormat("dd-MMM-yyyy");
    From_date = dateFormat.format(DateTime.now().subtract(Duration(days: 1)));
    To_date = dateFormat.format(DateTime.now().subtract(Duration(days: 0)));

    DateFormat dateFormat2 = DateFormat("yyyy-MM-dd");
    Selected_from_date =
        dateFormat2.format(DateTime.now().subtract(Duration(days: 1)));
    Selected_to_date =
        dateFormat2.format(DateTime.now().subtract(Duration(days: 0)));

    // Data_View_calling();
  }

  bool is_open_E_dealer = false;
  bool is_open_master_dataset = false;

  double img_width = 0;
  double img_height = 0;

  double Main_font = 0;
  double Sub_font = 0;

  double card_padding = 0;
  bool is_desktop = false;
  bool is_mobile = false;

  // Map map_List_History = ["a","B,","c"];
  final List<String> entries = <String>[
    'A',
    'B',
    'C',
    'D',
    'E',
    'F',
    'G',
    'H',
    'I'
  ];

  @override
  Widget build(BuildContext context) {
    var deviceType = getDeviceType(MediaQuery.of(context).size);
    Size size = MediaQuery.of(context).size;
    double Screen_width = size.width > size.height ? size.height : size.width;

    switch (deviceType) {
      case DeviceScreenType.desktop:
        is_desktop = true;
        is_mobile = false;
        img_width = 375;
        img_height = 40;
        Main_font = 20;
        Sub_font = 15;
        card_padding = 20;
        break;
      case DeviceScreenType.tablet:
        img_width = 245;
        img_height = 30;
        Main_font = 18;
        Sub_font = 14;
        card_padding = 15;
        is_desktop = false;
        is_mobile = false;
        break;
      case DeviceScreenType.mobile:
        img_width = 200;
        img_height = 25;
        Main_font = 15;
        Sub_font = 12;
        card_padding = 12;
        is_desktop = false;
        is_mobile = true;
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

    // if (kIsWeb) {
    //   // running on the web!
    //   is_desktop = true;
    //   is_mobile = false;
    // } else {
    //   // NOT running on the web! You can check for additional platforms here.
    //   is_desktop = false;
    //   is_mobile = true;
    // }

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
            Text('File Upload History'),
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
          Padding(
            padding: EdgeInsets.fromLTRB(10, 10, 10, 0),
            child: Column(
              children: [
                Center(
                  child: Card(
                      color: Colors.white.withOpacity(0.5),
                      // color: Theme.of(context).primaryColor.withOpacity(0.3),
                      // color: Color.fromARGB(255, 36, 145, 184).withOpacity(0.5),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(20),
                          topRight: Radius.circular(20),
                        ),
                      ),
                      child: Column(
                        children: [
                          SizedBox(
                            height: 5,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text(
                                "History of " + str_selected_dataset,
                                textAlign: TextAlign.center,
                                style: new TextStyle(
                                  fontSize: Main_font,
                                  color: Color.fromARGB(255, 0, 0, 0),
                                  fontWeight: FontWeight.w600,
                                  // decoration: TextDecoration.underline
                                ),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 5,
                          )
                        ],
                      )),
                ),

                Expanded(
                  // height: 400,
                  child: ListView.builder(
                      itemCount: map_Response_get.keys.length,
                      itemBuilder: (BuildContext context, int index) {
                        String str = map_Response_get.keys
                            .toList()[
                                map_Response_get.keys.length - (index + 1)]
                            .toString();
                        final values = str.split('/');
                        print(values.length);
                        print(values[values.length - 1]);

                        file_name = values[values.length - 1];

                        String fname = file_name.toString();
                        String time = map_Response_get[
                                    map_Response_get.keys.toList()[
                                        map_Response_get.keys.length -
                                            (index + 1)]]["ResponseMetadata"]
                                ["HTTPHeaders"]["last-modified"]
                            .toString();

                        return Padding(
                          padding: const EdgeInsets.all(3),
                          child: Container(
                            decoration: BoxDecoration(
                              // color: Color.fromARGB(255, 255, 255, 255).withOpacity(0.5),
                              // color: Colors.white.withOpacity(0.5),
                              color: Color.fromARGB(255, 255, 255, 255),
                              borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(5),
                                topRight: Radius.circular(5),
                              ),
                              border: Border.all(
                                width: 1,
                                color: Color.fromARGB(255, 0, 0, 0),
                                style: BorderStyle.solid,
                              ),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(5),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  // Text("File Name : " + file_name),
                                  // Text("Last Modified At : " + time),

                                  Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      SizedBox(
                                        height: 3,
                                      ),
                                      Text(
                                        file_name,
                                        style: TextStyle(
                                            fontSize: Sub_font,
                                            color: Color.fromARGB(255, 0, 0, 0),
                                            fontWeight: FontWeight.bold),
                                      ),
                                      SizedBox(
                                        height: 3,
                                      ),
                                      Text(
                                        "File Name",
                                        style: TextStyle(
                                            fontSize: Sub_font - 3,
                                            color: Color.fromARGB(255, 0, 0, 0),
                                            fontWeight: FontWeight.normal),
                                      ),
                                      SizedBox(
                                        height: 3,
                                      ),
                                    ],
                                  ),

                                  Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment: CrossAxisAlignment.end,
                                    children: [
                                      SizedBox(
                                        height: 3,
                                      ),
                                      Text(
                                        time,
                                        style: TextStyle(
                                            fontSize: Sub_font,
                                            color: Color.fromARGB(255, 0, 0, 0),
                                            fontWeight: FontWeight.bold),
                                      ),
                                      SizedBox(
                                        height: 3,
                                      ),
                                      Text(
                                        "Last Modified At",
                                        style: TextStyle(
                                            fontSize: Sub_font - 3,
                                            color: Color.fromARGB(255, 0, 0, 0),
                                            fontWeight: FontWeight.normal),
                                      ),
                                      SizedBox(
                                        height: 3,
                                      ),
                                    ],
                                  ),

                                  // RichText(
                                  //   text: TextSpan(
                                  //     text: 'File Name : ',
                                  //     style: TextStyle(
                                  //         fontSize: Sub_font,
                                  //         fontWeight: FontWeight.normal),
                                  //     children: <TextSpan>[
                                  //       TextSpan(
                                  //           text: fname,
                                  //           style: TextStyle(
                                  //               fontSize: Sub_font,
                                  //               fontWeight: FontWeight.bold)),
                                  //       // TextSpan(text: ' world!'),
                                  //     ],
                                  //   ),
                                  // ),

                                  // RichText(
                                  //   text: TextSpan(
                                  //     text: time,
                                  //     style: TextStyle(
                                  //         fontSize: Sub_font,
                                  //         fontWeight: FontWeight.bold),
                                  //     children: <TextSpan>[
                                  //       TextSpan(
                                  //           text: ' : Last Modified At',
                                  //           style: TextStyle(
                                  //               fontSize: Sub_font,
                                  //               fontWeight: FontWeight.normal)),
                                  //       // TextSpan(text: ' world!'),
                                  //     ],
                                  //   ),
                                  // ),
                                ],
                              ),
                            ),
                          ),
                        );
                      }),
                ),

                // is_data_loded
                //     ? Expanded(
                //         child: ListView.builder(
                //             // padding: const EdgeInsets.all(8),
                //             itemCount: map_Response_get.keys.length,
                //             itemBuilder: (BuildContext context, int index) {
                //               String str = map_Response_get.keys
                //                   .toList()[index]
                //                   .toString();
                //               final values = str.split('/');
                //               print(values.length);
                //               print(values[values.length - 1]);

                //               file_name = values[values.length - 1];

                //               return Padding(
                //                 padding: const EdgeInsets.all(3),
                //                 child: Container(
                //                   // height: 25,
                //                   decoration: BoxDecoration(
                //                     // color: Color.fromARGB(255, 255, 255, 255).withOpacity(0.5),
                //                     // color: Colors.white.withOpacity(0.5),
                //                     color: Color.fromARGB(255, 255, 255, 255),
                //                     borderRadius: BorderRadius.only(
                //                       topLeft: Radius.circular(5),
                //                       topRight: Radius.circular(5),
                //                     ),
                //                     border: Border.all(
                //                       width: 1,
                //                       color: Color.fromARGB(255, 0, 0, 0),
                //                       style: BorderStyle.solid,
                //                     ),
                //                   ),

                //                   child: Row(
                //                     // mainAxisAlignment:
                //                     //     MainAxisAlignment.spaceBetween,
                //                     crossAxisAlignment:
                //                         CrossAxisAlignment.center,
                //                     children: [
                //                       Expanded(
                //                         child: is_mobile
                //                             ? Column(
                //                                 mainAxisAlignment:
                //                                     MainAxisAlignment.center,
                //                                 crossAxisAlignment:
                //                                     CrossAxisAlignment.start,
                //                                 children: [
                //                                   Padding(
                //                                     padding: EdgeInsets.all(5),
                //                                     child: Expanded(
                //                                       child: Column(
                //                                         mainAxisAlignment:
                //                                             MainAxisAlignment
                //                                                 .center,
                //                                         crossAxisAlignment:
                //                                             CrossAxisAlignment
                //                                                 .start,
                //                                         children: [
                //                                           Text(
                //                                             // "20220723_20220724.csv",
                //                                             file_name,
                //                                             style:
                //                                                 new TextStyle(
                //                                               fontSize:
                //                                                   Main_font,
                //                                               color: Color
                //                                                   .fromARGB(255,
                //                                                       0, 0, 0),
                //                                               fontWeight:
                //                                                   FontWeight
                //                                                       .w800,
                //                                               // decoration: TextDecoration.underline
                //                                             ),
                //                                           ),
                //                                           SizedBox(
                //                                             height: 3,
                //                                           ),
                //                                           Text(
                //                                             "File Name",
                //                                             style:
                //                                                 new TextStyle(
                //                                               fontSize:
                //                                                   Sub_font,
                //                                               color: Color
                //                                                   .fromARGB(
                //                                                       255,
                //                                                       96,
                //                                                       96,
                //                                                       96),
                //                                               fontWeight:
                //                                                   FontWeight
                //                                                       .w400,
                //                                               // decoration: TextDecoration.underline
                //                                             ),
                //                                           ),
                //                                         ],
                //                                       ),
                //                                     ),
                //                                   ),
                //                                   // SizedBox(
                //                                   //   height: 3,
                //                                   // ),

                //                                   Padding(
                //                                     padding: EdgeInsets.all(5),
                //                                     child: Column(
                //                                       mainAxisAlignment:
                //                                           MainAxisAlignment
                //                                               .center,
                //                                       crossAxisAlignment:
                //                                           CrossAxisAlignment
                //                                               .start,
                //                                       children: [
                //                                         Text(
                //                                           // createdDate,

                //                                           // "25-07-2022 03:35:48",
                //                                           map_Response_get[map_Response_get
                //                                                           .keys
                //                                                           .toList()[index]]["ResponseMetadata"]
                //                                                       [
                //                                                       "HTTPHeaders"]
                //                                                   [
                //                                                   "last-modified"]
                //                                               .toString(),

                //                                           style: new TextStyle(
                //                                             fontSize: Main_font,
                //                                             color:
                //                                                 Color.fromARGB(
                //                                                     255,
                //                                                     0,
                //                                                     0,
                //                                                     0),
                //                                             fontWeight:
                //                                                 FontWeight.w400,
                //                                             // decoration: TextDecoration.underline
                //                                           ),
                //                                         ),
                //                                         SizedBox(
                //                                           height: 3,
                //                                         ),
                //                                         Text(
                //                                           "Last Modified At",
                //                                           style: new TextStyle(
                //                                             fontSize: Sub_font,
                //                                             color:
                //                                                 Color.fromARGB(
                //                                                     255,
                //                                                     96,
                //                                                     96,
                //                                                     96),
                //                                             fontWeight:
                //                                                 FontWeight.w400,
                //                                             // decoration: TextDecoration.underline
                //                                           ),
                //                                         ),
                //                                       ],
                //                                     ),
                //                                   ),
                //                                 ],
                //                               )
                //                             : Row(
                //                                 mainAxisAlignment:
                //                                     MainAxisAlignment
                //                                         .spaceBetween,
                //                                 crossAxisAlignment:
                //                                     CrossAxisAlignment.center,
                //                                 children: [
                //                                   Padding(
                //                                     padding: EdgeInsets.all(5),
                //                                     child: Expanded(
                //                                       child: Column(
                //                                         mainAxisAlignment:
                //                                             MainAxisAlignment
                //                                                 .center,
                //                                         crossAxisAlignment:
                //                                             CrossAxisAlignment
                //                                                 .start,
                //                                         children: [
                //                                           Text(
                //                                             // "20220723_20220724.csv",
                //                                             file_name,
                //                                             style:
                //                                                 new TextStyle(
                //                                               fontSize:
                //                                                   Main_font,
                //                                               color: Color
                //                                                   .fromARGB(255,
                //                                                       0, 0, 0),
                //                                               fontWeight:
                //                                                   FontWeight
                //                                                       .w800,
                //                                               // decoration: TextDecoration.underline
                //                                             ),
                //                                           ),
                //                                           SizedBox(
                //                                             height: 3,
                //                                           ),
                //                                           Text(
                //                                             "File Name",
                //                                             style:
                //                                                 new TextStyle(
                //                                               fontSize:
                //                                                   Sub_font,
                //                                               color: Color
                //                                                   .fromARGB(
                //                                                       255,
                //                                                       96,
                //                                                       96,
                //                                                       96),
                //                                               fontWeight:
                //                                                   FontWeight
                //                                                       .w400,
                //                                               // decoration: TextDecoration.underline
                //                                             ),
                //                                           ),
                //                                         ],
                //                                       ),
                //                                     ),
                //                                   ),
                //                                   // SizedBox(
                //                                   //   height: 3,
                //                                   // ),

                //                                   Padding(
                //                                     padding: EdgeInsets.all(5),
                //                                     child: Column(
                //                                       mainAxisAlignment:
                //                                           MainAxisAlignment
                //                                               .center,
                //                                       crossAxisAlignment:
                //                                           CrossAxisAlignment
                //                                               .end,
                //                                       children: [
                //                                         Text(
                //                                           // createdDate,

                //                                           // "25-07-2022 03:35:48",
                //                                           map_Response_get[map_Response_get
                //                                                           .keys
                //                                                           .toList()[index]]["ResponseMetadata"]
                //                                                       [
                //                                                       "HTTPHeaders"]
                //                                                   [
                //                                                   "last-modified"]
                //                                               .toString(),

                //                                           style: new TextStyle(
                //                                             fontSize: Main_font,
                //                                             color:
                //                                                 Color.fromARGB(
                //                                                     255,
                //                                                     0,
                //                                                     0,
                //                                                     0),
                //                                             fontWeight:
                //                                                 FontWeight.w400,
                //                                             // decoration: TextDecoration.underline
                //                                           ),
                //                                         ),
                //                                         SizedBox(
                //                                           height: 3,
                //                                         ),
                //                                         Text(
                //                                           "Last Modified At",
                //                                           style: new TextStyle(
                //                                             fontSize: Sub_font,
                //                                             color:
                //                                                 Color.fromARGB(
                //                                                     255,
                //                                                     96,
                //                                                     96,
                //                                                     96),
                //                                             fontWeight:
                //                                                 FontWeight.w400,
                //                                             // decoration: TextDecoration.underline
                //                                           ),
                //                                         ),
                //                                       ],
                //                                     ),
                //                                   ),
                //                                 ],
                //                               ),
                //                       ),
                //                       // Container(
                //                       //   height: 120,
                //                       //   decoration: BoxDecoration(
                //                       //     // color: Color.fromARGB(255, 255, 255, 255).withOpacity(0.5),
                //                       //     // color: Colors.white.withOpacity(0.5),
                //                       //     color: Color.fromARGB(255, 153, 212, 247),
                //                       //     borderRadius: BorderRadius.only(
                //                       //       topLeft: Radius.circular(25),
                //                       //       bottomLeft: Radius.circular(25),
                //                       //     ),
                //                       //     // border: Border.all(
                //                       //     //   width: 2,
                //                       //     //   color: Color.fromARGB(255, 0, 0, 0),
                //                       //     //   style: BorderStyle.solid,
                //                       //     // ),
                //                       //   ),
                //                       //   child: Padding(
                //                       //     padding: EdgeInsets.all(5),
                //                       //     child: Column(
                //                       //       mainAxisAlignment:
                //                       //           MainAxisAlignment.center,
                //                       //       crossAxisAlignment:
                //                       //           CrossAxisAlignment.center,
                //                       //       children: [
                //                       //         Text(
                //                       //           // "SIF",
                //                       //           _selected_dataset,
                //                       //           style: new TextStyle(
                //                       //             fontSize: Main_font,
                //                       //             color:
                //                       //                 Color.fromARGB(255, 0, 0, 0),
                //                       //             fontWeight: FontWeight.w400,
                //                       //             // decoration: TextDecoration.underline
                //                       //           ),
                //                       //         ),
                //                       //         SizedBox(
                //                       //           height: 3,
                //                       //         ),
                //                       //         Text(
                //                       //           "File Type",
                //                       //           style: new TextStyle(
                //                       //             fontSize: Sub_font,
                //                       //             color: Color.fromARGB(
                //                       //                 255, 96, 96, 96),
                //                       //             fontWeight: FontWeight.w400,
                //                       //             // decoration: TextDecoration.underline
                //                       //           ),
                //                       //         ),
                //                       //       ],
                //                       //     ),
                //                       //   ),
                //                       // ),
                //                     ],
                //                   ),

                //                   // height: 50,
                //                   // color: Colors.amber[colorCodes[index]],
                //                   // child: Center(child: Text('Entry ${entries[index]}')),
                //                 ),
                //               );
                //             }))
                //     : Container(),
                SizedBox(
                  width: 10,
                ),
                Text(
                  str_selected_dataset +
                      " of Total Record : " +
                      map_Response_get.keys.length.toString(),
                  textAlign: TextAlign.center,
                  maxLines: 2,
                  style: new TextStyle(
                    fontSize: Main_font,
                    color: Color.fromARGB(255, 0, 0, 0),
                    fontWeight: FontWeight.w400,
                    // decoration: TextDecoration.underline
                  ),
                ),
                Card(
                  color: Colors.white.withOpacity(0.5),
                  // color: Theme.of(context).primaryColor.withOpacity(0.3),
                  // color: Color.fromARGB(255, 36, 145, 184).withOpacity(0.5),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(20),
                      topRight: Radius.circular(20),
                    ),
                  ),
                  child: Column(
                    children: [
                      SizedBox(
                        height: 10,
                      ),
                      SizedBox(
                        width: img_width + 180,
                        child: DropdownButtonFormField<String>(
                          value: null,
                          isDense: true,
                          style: TextStyle(color: Colors.white),
                          dropdownColor: Color.fromARGB(174, 0, 0, 0),
                          decoration: InputDecoration(
                            prefixIcon: Icon(
                              Icons.car_repair,
                              color: Colors.white,
                            ),
                            hintStyle: TextStyle(color: Colors.white),
                            filled: true,
                            fillColor: Colors.black45,
                          ),
                          icon: Icon(
                            Icons.keyboard_double_arrow_down_rounded,
                            color: Colors.white,
                          ),
                          // dropdownColor: Colors.black45,
                          hint: Text(
                            _selected_dataset,
                            style: new TextStyle(
                                fontSize: 15.0,
                                color: Color.fromARGB(255, 255, 255, 255),
                                fontWeight: FontWeight.w300),
                          ),
                          onChanged: (newVal) {
                            setState(() {
                              _selected_dataset = newVal!;
                            });
                          },
                          items: <String>[
                            'service_invoice_flat_view',
                            'star_ease_flat_view',
                            'warranty_claims',
                            'vehicle_models',
                            'invoice_number_prefix_to_location_mapping',
                            'per_ro_targets',
                            'revenue_targets',
                            'aspirational_per_ro_targets',
                            'aspirational_revenue_targets',
                            // 'Group Landmark1',
                            // 'Mercedes-Benz1',
                            // 'Honda1',
                            // 'Volkswagen1',
                            // 'Renault1',
                            // 'Jeep1',
                            // 'Group Landmark2',
                            // 'Mercedes-Benz2',
                            // 'Honda2',
                            // 'Volkswagen2',
                            // 'Renault2',
                            // 'Jeep2',
                          ].map((String value) {
                            return DropdownMenuItem(
                              value: value,
                              child: Text(value),
                            );
                          }).toList(),
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          SizedBox(
                            width: 10,
                          ),
                          Container(
                            width: img_width - 50,
                            decoration: BoxDecoration(
                              color: Color.fromARGB(255, 255, 255, 255),
                              borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(20),
                                bottomLeft: Radius.circular(20),
                              ),
                              border: Border.all(
                                width: 2,
                                color: Color.fromARGB(255, 0, 0, 0),
                                style: BorderStyle.solid,
                              ),
                            ),
                            child: MaterialButton(
                              onPressed: () async {
                                await showDatePicker(
                                  context: context,
                                  initialDate: DateTime.now()
                                      .subtract(Duration(days: 1)),
                                  firstDate: DateTime.now()
                                      .subtract(Duration(days: 365)),
                                  lastDate: DateTime.now()
                                      .subtract(Duration(days: 1)),
                                ).then((selectedDate) {
                                  if (selectedDate != null) {
                                    setState(() {
                                      From_date = DateFormat('dd-MMM-yyyy')
                                          .format(selectedDate);
                                      Selected_from_date =
                                          DateFormat('yyyy-MM-dd')
                                              .format(selectedDate);
                                    });
                                  }
                                });
                              },
                              child: Row(
                                // mainAxisAlignment: MainAxisAlignment.end,
                                // crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  SizedBox(
                                    width: 5,
                                  ),
                                  Padding(
                                    padding: EdgeInsets.fromLTRB(0, 5, 0, 5),
                                    child: Icon(
                                      Icons.calendar_month_outlined,
                                      size: img_height,
                                    ),
                                  ),
                                  Spacer(),
                                  // SizedBox(
                                  //   width: 5,
                                  // ),
                                  Column(
                                    children: [
                                      SizedBox(
                                        height: 5,
                                      ),
                                      Text(
                                        "From Date",
                                        style: new TextStyle(
                                          fontSize: Main_font,
                                          color: Color.fromARGB(255, 0, 0, 0),
                                          fontWeight: FontWeight.w600,
                                          // decoration: TextDecoration.underline
                                        ),
                                      ),
                                      SizedBox(
                                        height: 5,
                                      ),
                                      Text(
                                        From_date,
                                        style: new TextStyle(
                                          fontSize: Main_font,
                                          color: Color.fromARGB(255, 0, 0, 0),
                                          fontWeight: FontWeight.w400,
                                          // decoration: TextDecoration.underline
                                        ),
                                      ),
                                      SizedBox(
                                        height: 5,
                                      ),
                                    ],
                                  ),
                                  Spacer(),
                                ],
                              ),
                            ),
                          ),
                          SizedBox(
                            width: 15,
                          ),
                          Container(
                            width: img_width - 50,
                            decoration: BoxDecoration(
                              color: Color.fromARGB(255, 255, 255, 255),
                              borderRadius: BorderRadius.only(
                                topRight: Radius.circular(20),
                                bottomRight: Radius.circular(20),
                              ),
                              border: Border.all(
                                width: 2,
                                color: Color.fromARGB(255, 0, 0, 0),
                                style: BorderStyle.solid,
                              ),
                            ),
                            child: MaterialButton(
                              onPressed: () async {
                                await showDatePicker(
                                  context: context,
                                  initialDate: DateTime.now()
                                      .subtract(Duration(days: 1)),
                                  firstDate: DateTime.now()
                                      .subtract(Duration(days: 6)),
                                  lastDate: DateTime.now()
                                      .subtract(Duration(days: 1)),
                                ).then((selectedDate) {
                                  if (selectedDate != null) {
                                    setState(() {
                                      To_date = DateFormat('dd-MMM-yyyy')
                                          .format(selectedDate);
                                      Selected_to_date =
                                          DateFormat('yyyy-MM-dd')
                                              .format(selectedDate);
                                    });
                                  }
                                });
                              },
                              child: Row(
                                // mainAxisAlignment: MainAxisAlignment.end,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Spacer(),
                                  // SizedBox(
                                  //   width: 5,
                                  // ),
                                  Column(
                                    children: [
                                      SizedBox(
                                        height: 5,
                                      ),
                                      Text(
                                        "To Date",
                                        style: new TextStyle(
                                          fontSize: Main_font,
                                          color: Color.fromARGB(255, 0, 0, 0),
                                          fontWeight: FontWeight.w600,
                                          // decoration: TextDecoration.underline
                                        ),
                                      ),
                                      SizedBox(
                                        height: 5,
                                      ),
                                      Text(
                                        To_date,
                                        style: new TextStyle(
                                          fontSize: Main_font,
                                          color: Color.fromARGB(255, 0, 0, 0),
                                          fontWeight: FontWeight.w400,
                                          // decoration: TextDecoration.underline
                                        ),
                                      ),
                                      SizedBox(
                                        height: 5,
                                      ),
                                    ],
                                  ),
                                  Spacer(),
                                  // SizedBox(
                                  //   width: 5,
                                  // ),
                                  Padding(
                                    padding: EdgeInsets.fromLTRB(0, 5, 0, 5),
                                    child: Icon(
                                      Icons.calendar_month_outlined,
                                      size: img_height,
                                    ),
                                  ),
                                  SizedBox(
                                    width: 5,
                                  ),
                                ],
                              ),
                            ),
                          ),
                          SizedBox(
                            width: 10,
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          // SizedBox(
                          //   width: 10,
                          // ),
                          // Icon(
                          //   Icons.miscellaneous_services,
                          //   color: Colors.black,
                          //   size: img_height,
                          // ),
                          // SizedBox(
                          //   width: 10,
                          // ),
                          // Icon(
                          //   Icons.sell_rounded,
                          //   color: Colors.black,
                          //   size: img_height,
                          // ),
                          // SizedBox(
                          //   width: 10,
                          // ),
                          // Icon(
                          //   Icons.security,
                          //   color: Colors.black,
                          //   size: img_height,
                          // ),

                          SizedBox(
                            width: 10,
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Container(
                        width: img_width,
                        decoration: BoxDecoration(
                          color: Color.fromARGB(255, 255, 255, 255),
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(20),
                            bottomLeft: Radius.circular(20),
                            bottomRight: Radius.circular(20),
                            topRight: Radius.circular(20),
                          ),
                          border: Border.all(
                            width: 3,
                            color: Color.fromARGB(255, 0, 0, 0),
                            style: BorderStyle.solid,
                          ),
                        ),
                        child: MaterialButton(
                          onPressed: () async {
                            // if (is_data_download == false) {
                            // is_data_download = true;
                            Data_View_calling();
                            // }
                          },
                          child: Row(
                            // mainAxisAlignment: MainAxisAlignment.end,
                            // crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              SizedBox(
                                width: 10,
                              ),
                              Padding(
                                padding: EdgeInsets.fromLTRB(0, 5, 0, 5),
                                child: Container(
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
                                  child: Icon(
                                    Icons.remove_red_eye_outlined,
                                    size: img_height,
                                  ),
                                ),
                              ),
                              Spacer(),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  SizedBox(
                                    height: 5,
                                  ),
                                  Text(
                                    "View services\nfile upload history",
                                    textAlign: TextAlign.center,
                                    style: new TextStyle(
                                      fontSize: Main_font,
                                      color: Color.fromARGB(255, 0, 0, 0),
                                      fontWeight: FontWeight.w600,
                                      // decoration: TextDecoration.underline
                                    ),
                                  ),
                                  SizedBox(
                                    height: 5,
                                  ),
                                ],
                              ),
                              Spacer(),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                    ],
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

  Data_View_calling() async {
    if (_selected_dataset == "Select a dataset name") {
      AwesomeDialog(
              // width: img_width,
              dismissOnTouchOutside: false,
              context: context,
              dialogType: DialogType.WARNING,
              animType: AnimType.TOPSLIDE,
              title: 'Please select dataset first !',
              desc: '',
              btnOkColor: Theme.of(context).primaryColor,
              // btnCancelOnPress: () {},
              btnOkOnPress: () {})
          .show();
    } else {
      //  'per_ro_targets',
      //  'revenue_targets',
      //  'aspirational_per_ro_targets',
      //  'aspirational_revenue_targets',

      if (_selected_dataset == "per_ro_targets" ||
          _selected_dataset == "revenue_targets" ||
          _selected_dataset == "aspirational_per_ro_targets" ||
          _selected_dataset == "aspirational_revenue_targets") {
        str_url_data_set =
            "describe_mb_service_group_landmark_raw_bucket_objects";
      } else {
        str_url_data_set = "describe_mb_service_edealer_raw_bucket_objects";
      }

      print('Data view call');
      var result = await Connectivity().checkConnectivity();

      if (result == ConnectivityResult.mobile ||
          result == ConnectivityResult.wifi ||
          result == ConnectivityResult.ethernet) {
        globals.str_loding = "Loading...";
        start_Loding();
        Data_View_call();
      } else {
        AwesomeDialog(
                // width: img_width,
                dismissOnTouchOutside: false,
                context: context,
                dialogType: DialogType.WARNING,
                animType: AnimType.TOPSLIDE,
                title: 'No Internet Conectivity ... !',
                desc:
                    'You are not connected to the internet.\nInternet conection required.',
                btnOkColor: Theme.of(context).primaryColor,
                // btnCancelOnPress: () {},
                btnOkOnPress: () {})
            .show();
      }
    }
  }

  Data_View_call() async {
    // Data_From_date = From_date;
    // Data_To_date = To_date;
    // // /api/v1/mercedes-benz/service/invoice_number_prefix_to_actual_revenue_targets
    // var postUri = Uri.parse(
    //     globals.str_URL+"api/v1/mercedes-benz/service/invoice_number_prefix_to_actual_revenue_targets");
    // var request = http.MultipartRequest("GET", postUri);
    // // request.files.add(http.MultipartFile.fromBytes('file', fileBytes,
    // //     filename: actual_revenue_targets_fileName,
    // //     contentType: MediaType('multipart', 'form-data')));

    // /api/v1/mercedes-benz/service/invoice_number_prefix_to_actual_revenue_targets

    // http://13.235.82.222:1337/api/v1/
    // http://43.204.214.177:5000/api/v1/

    // http://13.235.82.222:1337/api/v1/mercedes-benz/service/describe_mb_service_edealer_raw_bucket_objects?
    // dataset_name=service_invoice_flat_view&last_modified_begin_date=2022-08-13&last_modified_end_date=2022-09-13

    // http://43.204.214.177:5000/api/v1/mercedes-benz/service/describe_mb_service_edealer_raw_bucket_objects?
    // dataset_name=service_invoice_flat_view&last_modified_begin_date=2022-09-12&last_modified_end_date=2022-09-13

    // http://13.235.82.222:1337/api/v1/mercedes-benz/service/describe_mb_service_edealer_raw_bucket_objects?
    // dataset_name=service_invoice_flat_view&last_modified_begin_date=20220912&last_modified_end_date=2022-09-13

    var postUri = Uri.parse(globals.str_URL +
        "api/v1/mercedes-benz/service/" +
        str_url_data_set +
        "?dataset_name=" +
        _selected_dataset +
        "&last_modified_begin_date=" +
        Selected_from_date +
        "&last_modified_end_date=" +
        Selected_to_date);

    print(postUri);

    var request = http.MultipartRequest("GET", postUri);
    // request.files.add(http.MultipartFile.fromBytes('file', fileBytes,
    //     filename: actual_revenue_targets_fileName,
    //     contentType: MediaType('multipart', 'form-data')));

    try {
      http.Response response =
          await http.Response.fromStream(await request.send());

      print("Result: ${response.statusCode}");
      print("Response: ${response}");

      String str_statuscode = response.statusCode.toString();
      // print('${str_statuscode[0]}');
      String chk_Statuscode = '${str_statuscode[0]}';
      print("chk_Statuscode : " + chk_Statuscode.toString());

      map_Response_get = json.decode(response.body);
      // print(map_Response_get1);

      // map_Response_get = map_Response_get1;
      print(map_Response_get);

      if (chk_Statuscode != "1" &&
          chk_Statuscode != "2" &&
          chk_Statuscode != "3" &&
          chk_Statuscode != "4") {
        stop_Loding();
        AwesomeDialog(
            dismissOnTouchOutside: false,
            context: context,
            dialogType: DialogType.ERROR,
            animType: AnimType.TOPSLIDE,
            title: "Server not responding.",
            desc: 'Please try after again.',
            btnOkColor: Theme.of(context).primaryColor,
            // btnCancelOnPress: () {},
            btnOkOnPress: () {
              // logout();

              setState(() {});
            }).show();
      } else if (chk_Statuscode == "4") {
        stop_Loding();
        AwesomeDialog(
            dismissOnTouchOutside: false,
            context: context,
            dialogType: DialogType.ERROR,
            animType: AnimType.TOPSLIDE,
            title: "",
            desc: map_Response_get["msg"],
            btnOkColor: Theme.of(context).primaryColor,
            // btnCancelOnPress: () {},
            btnOkOnPress: () {
              // logout();

              setState(() {});
            }).show();
      } else if (chk_Statuscode == "2") {
        stop_Loding();

        str_selected_dataset = _selected_dataset;

        // map_Response_get[map_Response_get.keys.toList()[0]];

        // map_Response_get[map_Response_get.keys.toList()[0]]["ResponseMetadata"]["HTTPHeaders"]["last-modified"];

        setState(() {
          is_data_loded = true;
        });
        // if (map_Response_get.length == 0) {
        //   // is_data_download = false;
        //   // is_data_loded = false;
        //   AwesomeDialog(
        //       // width: img_width,
        //       dismissOnTouchOutside: false,
        //       context: context,
        //       dialogType: DialogType.WARNING,
        //       animType: AnimType.TOPSLIDE,
        //       title: "No Record found on your selected date",
        //       desc: 'Please select date range properly!',
        //       btnOkColor: Theme.of(context).primaryColor,
        //       // btnCancelOnPress: () {},
        //       btnOkOnPress: () {
        //         // logout();

        //         setState(() {
        //           is_File_selected = false;
        //         });
        //       }).show();
        // } else {
        //   setState(() {
        //     // is_data_download = true;
        //     // is_data_loded = true;
        //     // print(map_Response_get[0]["invoice_number_prefix"]);
        //   });
        // }
      } else {
        stop_Loding();
        AwesomeDialog(
            dismissOnTouchOutside: false,
            context: context,
            dialogType: DialogType.ERROR,
            animType: AnimType.TOPSLIDE,
            title: response.statusCode.toString() + " Server not responding.",
            desc: 'Please try after again.',
            btnOkColor: Theme.of(context).primaryColor,
            // btnCancelOnPress: () {},
            btnOkOnPress: () {
              // logout();

              setState(() {});
            }).show();
      }
    } on Exception catch (_) {
      print('never reached');
      stop_Loding();

      bool is_web = false;
      kIsWeb() {
        is_web = true;
      }

      AwesomeDialog(
          // width: img_width,
          dismissOnTouchOutside: false,
          context: context,
          dialogType: DialogType.ERROR,
          animType: AnimType.TOPSLIDE,
          title: "Server not responding.",
          desc: 'Please try after again.',
          btnOkColor: Theme.of(context).primaryColor,
          // btnCancelOnPress: () {},
          btnOkOnPress: () {
            // logout();

            setState(() {});
          }).show();
    }
  }

  void start_Loding() {
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (_) => WillPopScope(
        onWillPop: () async => false,
        child: AlertDialog(
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(32.0))),
          content: Stack(
            children: <Widget>[
              Image.asset(
                // 'images/img_vw_logo.png',
                'assets/img/loding_logo/loding_logo.png',
                width: 70,
                height: 70,
                // fit: BoxFit.scaleDown,
              ),
              Row(
                // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  ColorLoader3(
                    radius: 35.0,
                    dotRadius: 6.0,
                  ),

                  // ColorLoader2(),

                  // Text('Heartbeat'),
                  SizedBox(width: 20.0),

                  Flexible(
                    child: Container(
                      // padding: EdgeInsets.all(15.0),
                      // padding: EdgeInsets.only(top: 10.0, bottom: 10.0),
                      decoration: BoxDecoration(
                        // color: Colors.black12,
                        // color: Color.fromRGBO(19, 38, 89, 0.2),
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(32.0),
                          topRight: Radius.circular(32.0),
                          bottomLeft: Radius.circular(32.0),
                          bottomRight: Radius.circular(32.0),
                        ),
                      ),

                      // child: JumpingText('Login...'),
                      child: RichText(
                        text: TextSpan(
                          // Note: Styles for TextSpans must be explicitly defined.
                          // Child text spans will inherit styles from parent
                          // style: new TextStyle(
                          //   fontSize: 20.0,
                          //   color: Theme.of(context).primaryColor,
                          // ),
                          children: <TextSpan>[
                            TextSpan(
                                text: globals.str_loding,
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 20.0,
                                    color: Color.fromRGBO(19, 38, 89, 1.0))),
                            TextSpan(
                                text: '\nPlease wait...',
                                style: TextStyle(
                                    fontWeight: FontWeight.normal,
                                    fontSize: 15.0,
                                    color: Color.fromRGBO(19, 38, 89, 1.0))),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  void stop_Loding() {
    Navigator.of(context).pop();
  }
}
