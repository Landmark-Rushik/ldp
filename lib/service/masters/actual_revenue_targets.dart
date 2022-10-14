// import 'package:flutter/material.dart';
import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'dart:math';

import 'dart:convert';
import 'dart:html' as html;

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:http_parser/http_parser.dart';
import 'package:ldp/drower.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:responsive_builder/responsive_builder.dart';
import 'package:flutter_date_pickers/flutter_date_pickers.dart';
import 'package:intl/intl.dart';
import 'package:flutter/foundation.dart' show kIsWeb;

import 'package:file_picker/file_picker.dart';
import 'package:http/http.dart' as http;

import 'package:awesome_dialog/awesome_dialog.dart';
import '/globals.dart' as globals;
import '/loaders/color_loader_3.dart';

import 'package:csv/csv.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:animated_toggle_switch/animated_toggle_switch.dart';

// import 'package:permission_handler/permission_handler.dart';

import 'package:download/download.dart';

// import 'package:flutter_switch/flutter_switch.dart';
// import 'package:playground/animated_toggle.dart';
// import 'package:get/get.dart';

class actual_revenue_targets extends StatefulWidget {
  const actual_revenue_targets({Key? key}) : super(key: key);

  @override
  State<actual_revenue_targets> createState() => _actual_revenue_targetsState();
}

class _actual_revenue_targetsState extends State<actual_revenue_targets> {
  var actual_revenue_targets_fileName = "";

  List<List<dynamic>> actual_revenue_targets_data = [];

  int value = 0;
  bool is_app_ovr = false;
  bool is_dow_Upl = false;

  String str_pera_is_app_ovr = "append";

  String str_pera_is_dow_Upl = "View";
  // String str_pera_is_app_ovr = "overwrite";

  var objFile;
  var logoBase64;
  var fileBytes;
  Map map_Response = {};
  List map_Response_get = [];

  bool is_File_selected = false;
  bool is_data_download = false;
  bool is_data_loded = false;

  String From_date = "";
  String To_date = "";

  String Data_From_date = "";
  String Data_To_date = "";

  String Selected_from_date = "";
  String Selected_to_date = "";

  @override
  void initState() {
    // TODO: implement initState
    DateFormat dateFormat = DateFormat("dd-MMM-yyyy");
    From_date = dateFormat.format(DateTime.now().subtract(Duration(days: 30)));
    To_date = dateFormat.format(DateTime.now().subtract(Duration(days: 0)));

    DateFormat dateFormat2 = DateFormat("yyyy-MM-dd");
    Selected_from_date =
        dateFormat2.format(DateTime.now().subtract(Duration(days: 30)));
    Selected_to_date =
        dateFormat2.format(DateTime.now().subtract(Duration(days: 0)));

    if (is_data_download == false) {
      // is_data_download = true;
      Data_View_calling();
    }
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
            Text('Actual Revenue Targets'),
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
                // Column(
                //   children: [
                //     SizedBox(
                //       height: 10,
                //     ),
                //     Text("view/upload ? ",
                //         // 'Selected : ' + str_pera_is_app_ovr,
                //         style: new TextStyle(
                //             fontSize: Main_font,
                //             color: Color.fromARGB(255, 4, 4, 4))),
                //     SizedBox(
                //       height: 10,
                //     ),

                //     is_dow_Upl
                //     ?
                //      Text("Set upload mode : ",
                //               // 'Selected : ' + str_pera_is_app_ovr,
                //               style: new TextStyle(
                //                   fontSize: Main_font,
                //                   color: Color.fromARGB(255, 4, 4, 4))):
                //                   Container(),

                //                   SizedBox(
                //       height: 10,
                //     ),

                //   ],
                // ),
                SizedBox(
                  height: 10,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("view/upload ? ",
                        // 'Selected : ' + str_pera_is_app_ovr,
                        style: new TextStyle(
                            fontSize: Main_font,
                            color: Color.fromARGB(255, 4, 4, 4))),
                    SizedBox(
                      width: 10,
                    ),
                    AnimatedToggleSwitch<bool>.dual(
                      current: is_dow_Upl,
                      first: false,
                      second: true,
                      dif: 50.0,
                      borderColor: Colors.transparent,
                      borderWidth: 5.0,
                      height: 40,
                      boxShadow: const [
                        BoxShadow(
                          color: Colors.black26,
                          spreadRadius: 1,
                          blurRadius: 2,
                          offset: Offset(0, 1.5),
                        ),
                      ],
                      onChanged: (a) => setState(() {
                        is_dow_Upl = a;

                        if (is_dow_Upl == false) {
                          str_pera_is_dow_Upl = "Upload";

                          if (is_data_download == false) {
                            Data_View_calling();
                          }
                        } else {
                          str_pera_is_dow_Upl = "Downolad";
                        }
                      }),
                      colorBuilder: (a) => a
                          ? Color.fromARGB(255, 0, 123, 255)
                          : Color.fromARGB(255, 56, 255, 1),
                      iconBuilder: (value) => value
                          ? Icon(Icons.file_upload_outlined)
                          : Icon(Icons.remove_red_eye_outlined),
                      textBuilder: (value) => value
                          ? Center(
                              child:
                                  //  Text('overwrite')
                                  Text('Upload',
                                      style: new TextStyle(
                                          fontSize: Sub_font,
                                          fontWeight: FontWeight.w600,
                                          color: Color.fromARGB(255, 4, 4, 4))),
                            )
                          : Center(
                              child:
                                  // Text('append')
                                  Text('View',
                                      style: new TextStyle(
                                          fontSize: Sub_font,
                                          fontWeight: FontWeight.w600,
                                          color: Color.fromARGB(255, 4, 4, 4))),
                            ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 10,
                ),
                is_dow_Upl
                    ? Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text("Set upload mode : ",
                              // 'Selected : ' + str_pera_is_app_ovr,
                              style: new TextStyle(
                                  fontSize: Main_font,
                                  color: Color.fromARGB(255, 4, 4, 4))),
                          SizedBox(
                            width: 10,
                          ),
                          AnimatedToggleSwitch<bool>.dual(
                            current: is_app_ovr,
                            first: false,
                            second: true,
                            dif: 50.0,
                            borderColor: Colors.transparent,
                            borderWidth: 5.0,
                            height: 40,
                            boxShadow: const [
                              BoxShadow(
                                color: Colors.black26,
                                spreadRadius: 1,
                                blurRadius: 2,
                                offset: Offset(0, 1.5),
                              ),
                            ],
                            onChanged: (b) => setState(() {
                              is_app_ovr = b;

                              if (is_app_ovr == false) {
                                str_pera_is_app_ovr = "append";
                              } else {
                                str_pera_is_app_ovr = "overwrite";
                              }
                            }),
                            colorBuilder: (b) => b ? Colors.red : Colors.green,
                            iconBuilder: (value) => value
                                ? Icon(Icons.find_replace)
                                : Icon(Icons.file_upload_outlined),
                            textBuilder: (value) => value
                                ? Center(
                                    child:
                                        //  Text('overwrite')
                                        Text('overwrite',
                                            style: new TextStyle(
                                                fontSize: Sub_font,
                                                fontWeight: FontWeight.w600,
                                                color: Color.fromARGB(
                                                    255, 4, 4, 4))),
                                  )
                                : Center(
                                    child:
                                        // Text('append')
                                        Text('append',
                                            style: new TextStyle(
                                                fontSize: Sub_font,
                                                fontWeight: FontWeight.w600,
                                                color: Color.fromARGB(
                                                    255, 4, 4, 4))),
                                  ),
                          ),
                        ],
                      )
                    : Container(),
                SizedBox(
                  height: 10,
                ),

                // AnimatedToggleSwitch<int>.size(
                //   current: value,
                //   values: [
                //     0,
                //     1,
                //   ],
                //   iconOpacity: 0.2,
                //   indicatorSize: Size.fromWidth(100),
                //   iconBuilder: (value, size) {
                //     IconData data = Icons.find_replace;
                //     if (value.isEven) data = Icons.file_upload_outlined;
                //     return Icon(data, size: min(size.width, size.height));
                //   },

                //   borderColor: value.isEven ? Colors.amber : Colors.red,
                //   colorBuilder: (i) => i.isEven ? Colors.amber : Colors.red,
                //   onChanged: (i) => setState(() => {
                //         value = i,
                //         if (i == 0)
                //           {
                //             str_pera_is_app_ovr = "append",
                //           }
                //         else
                //           {
                //             str_pera_is_app_ovr = "overwrite",
                //           }
                //       }),
                // ),
                is_dow_Upl
                    ? Padding(
                        padding: EdgeInsets.fromLTRB(20, 20, 20, 20),
                        child: Material(
                          //Wrap with Material
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(22.0)),
                          elevation: 18.0,
                          color: Color.fromARGB(255, 0, 0, 0),
                          clipBehavior: Clip.antiAlias, // Add This
                          child: MaterialButton(
                            minWidth: 350.0,
                            height: 50,
                            color: Color.fromARGB(255, 0, 0, 0),
                            child: new Text("Choose File",
                                // '   Please select actual Revenue Targets file for ' +
                                //     str_pera_is_app_ovr +
                                //     '...   ',
                                style: new TextStyle(
                                    fontSize: Main_font, color: Colors.white)),
                            onPressed: () async {
                              final result = await FilePicker.platform
                                  .pickFiles(
                                      type: FileType.custom,
                                      allowMultiple: false,
                                      withData: true,
                                      allowedExtensions: ['csv']);

                              // final myData =
                              //     await rootBundle.loadString("assets/Book1.csv");

                              if (result!.files.first != null) {
                                fileBytes = result.files.first.bytes;
                                actual_revenue_targets_fileName =
                                    result.files.first.name;
                                // print(String.fromCharCodes(fileBytes!));

                                List<List<dynamic>> csvTable =
                                    CsvToListConverter().convert(
                                        String.fromCharCodes(fileBytes!));

                                actual_revenue_targets_data = csvTable;

                                setState(() {
                                  is_File_selected = true;
                                  objFile = result.files.single;
                                  logoBase64 = result.files.first.bytes;
                                  print(result.files.first.name);
                                });
                              }
                            },
                          ),
                        ),
                      )
                    : Container(),

                // is_File_selected
                //     ? Text(
                //         "Slected file is : " +
                //             actual_revenue_targets_fileName +
                //             " for " +
                //             str_pera_is_app_ovr +
                //             '...   ',
                //         style: new TextStyle(
                //             fontSize: Main_font,
                //             color: Color.fromARGB(255, 0, 0, 0)))
                //     : Container(),

                SizedBox(
                  height: 20,
                ),
                // is_File_selected
                //     ? Container(
                //         // color: Colors.black,
                //         decoration: BoxDecoration(
                //           // color: Color.fromARGB(255, 255, 255, 255).withOpacity(0.5),
                //           // color: Colors.white.withOpacity(0.5),
                //           color: Color.fromARGB(255, 2, 2, 2),
                //           borderRadius: BorderRadius.only(
                //             topLeft: Radius.circular(10),
                //             topRight: Radius.circular(10),
                //           ),
                //           border: Border.all(
                //             width: 2,
                //             color: Color.fromARGB(255, 0, 242, 255),
                //             style: BorderStyle.solid,
                //           ),
                //         ),
                //         child: Padding(
                //           padding: EdgeInsets.all(5),
                //           child: Row(
                //             mainAxisAlignment: MainAxisAlignment.spaceBetween,
                //             crossAxisAlignment: CrossAxisAlignment.center,
                //             children: [
                //               Text(
                //                 actual_revenue_targets_data[0][0],
                //                 style: new TextStyle(
                //                   fontSize: Main_font,
                //                   color: Color.fromARGB(255, 255, 255, 255),
                //                   fontWeight: FontWeight.w400,
                //                   // decoration: TextDecoration.underline
                //                 ),
                //               ),
                //               Text(
                //                 actual_revenue_targets_data[0][1],
                //                 style: new TextStyle(
                //                   fontSize: Main_font,
                //                   color: Color.fromARGB(255, 255, 255, 255),
                //                   fontWeight: FontWeight.w400,
                //                   // decoration: TextDecoration.underline
                //                 ),
                //               ),
                //               // Spacer(),
                //               Text(
                //                 actual_revenue_targets_data[0][2],
                //                 style: new TextStyle(
                //                   fontSize: Main_font,
                //                   color: Color.fromARGB(255, 255, 255, 255),
                //                   fontWeight: FontWeight.w400,
                //                   // decoration: TextDecoration.underline
                //                 ),
                //               ),
                //               // Spacer(),
                //               Text(
                //                 actual_revenue_targets_data[0][3],
                //                 style: new TextStyle(
                //                   fontSize: Main_font,
                //                   color: Color.fromARGB(255, 255, 255, 255),
                //                   fontWeight: FontWeight.w400,
                //                   // decoration: TextDecoration.underline
                //                 ),
                //               ),
                //             ],
                //           ),
                //         ),
                //       )
                //     : Container(),

                // AnimatedToggle(
                //   values: ['English', 'Arabic'],
                //   onToggleCallback: (value) {
                //     setState(() {
                //       _toggleValue = value;
                //     });
                //   },
                //   buttonColor: const Color(0xFF0A3157),
                //   backgroundColor: const Color(0xFFB5C1CC),
                //   textColor: const Color(0xFFFFFFFF),
                // ),
                is_dow_Upl
                    ? Container()
                    : is_data_download
                        ? Expanded(
                            child: ListView.builder(
                                // padding: const EdgeInsets.all(8),
                                itemCount: map_Response_get.length + 1,
                                itemBuilder: (BuildContext context, int index) {
                                  List<Widget> row_widgets = [];

                                  if (index == 0) {
                                    row_widgets.add(
                                      Container(
                                        width: 70,
                                        height: 55,
                                        color: Colors.black,
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Text(
                                              " index ",
                                              textAlign: TextAlign.center,
                                              style: new TextStyle(
                                                fontSize: Sub_font,
                                                color: Color.fromARGB(
                                                    255, 255, 255, 255),
                                                fontWeight: FontWeight.w400,
                                                // decoration: TextDecoration.underline
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    );
                                  } else {
                                    row_widgets.add(
                                      Container(
                                        width: 70,
                                        // color: Colors.amber,
                                        child: Text(
                                          (index).toString(),
                                          textAlign: TextAlign.center,
                                          style: new TextStyle(
                                            fontSize: Sub_font,
                                            color: Color.fromARGB(255, 0, 0, 0),
                                            fontWeight: FontWeight.w400,
                                            // decoration: TextDecoration.underline
                                          ),
                                        ),
                                      ),
                                    );
                                  }

                                  for (int i = 0;
                                      i <
                                          map_Response_get[0]
                                              .keys
                                              .toList()
                                              .length;
                                      i++) {
                                    if (index == 0) {
                                      row_widgets.add(
                                        Expanded(
                                          child: Container(
                                            height: 55,
                                            color: Colors.black,
                                            child: Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                Text(
                                                  // map_Response_get[index]
                                                  //     ["invoice_number_prefix"],
                                                  (map_Response_get[0]
                                                          .keys
                                                          .toList()[i])
                                                      .toString(),
                                                  textAlign: TextAlign.center,
                                                  style: new TextStyle(
                                                    fontSize: Sub_font,
                                                    color: Color.fromARGB(
                                                        255, 255, 255, 255),
                                                    fontWeight: FontWeight.w400,
                                                    // decoration: TextDecoration.underline
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      );
                                    } else {
                                      row_widgets.add(
                                        Expanded(
                                          child: Container(
                                            // color: Colors.amber,
                                            child: Text(
                                              // map_Response_get[index]
                                              //     ["invoice_number_prefix"],
                                              (map_Response_get[index - 1][
                                                      map_Response_get[0]
                                                          .keys
                                                          .toList()[i]
                                                          .toString()])
                                                  .toString(),
                                              textAlign: TextAlign.center,
                                              style: new TextStyle(
                                                fontSize: Sub_font,
                                                color: Color.fromARGB(
                                                    255, 0, 0, 0),
                                                fontWeight: FontWeight.w400,
                                                // decoration: TextDecoration.underline
                                              ),
                                            ),
                                          ),
                                        ),
                                      );
                                    }
                                  }
                                  return Padding(
                                    padding: const EdgeInsets.all(3),
                                    child: Container(
                                      // height: 25,
                                      decoration: BoxDecoration(
                                        // color: Color.fromARGB(255, 255, 255, 255).withOpacity(0.5),
                                        // color: Colors.white.withOpacity(0.5),
                                        color:
                                            Color.fromARGB(255, 255, 255, 255)
                                                .withOpacity(0.2),
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
                                        padding: EdgeInsets.all(5),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceEvenly,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          children: row_widgets,
                                        ),
                                      ),
                                    ),
                                  );
                                }),
                          )
                        : Container(),

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
                      is_dow_Upl
                          ? Container()
                          : Text(
                              "Total number of record : " +
                                  map_Response_get.length.toString() +
                                  "\n(Date Range : " +
                                  Data_From_date +
                                  " to " +
                                  Data_To_date +
                                  ")",
                              textAlign: TextAlign.center,
                              style: new TextStyle(
                                fontSize: Main_font,
                                color: Color.fromARGB(255, 0, 0, 0),
                                fontWeight: FontWeight.w400,
                                // decoration: TextDecoration.underline
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
                          is_dow_Upl
                              ?

                              // For Upload...
                              is_File_selected
                                  ? Container(
                                      width: img_width,
                                      decoration: BoxDecoration(
                                        color:
                                            Color.fromARGB(255, 255, 255, 255),
                                        borderRadius: BorderRadius.only(
                                          topRight: Radius.circular(20),
                                          bottomRight: Radius.circular(20),
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
                                          File_Upload_calling();
                                        },
                                        child: Row(
                                          // mainAxisAlignment: MainAxisAlignment.end,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          children: [
                                            Spacer(),
                                            Column(
                                              children: [
                                                SizedBox(
                                                  height: 5,
                                                ),
                                                Text(
                                                  "Upload\nactual\nRevenue Targets",
                                                  textAlign: TextAlign.center,
                                                  style: new TextStyle(
                                                    fontSize: Main_font,
                                                    color: Color.fromARGB(
                                                        255, 0, 0, 0),
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
                                            Padding(
                                              padding: EdgeInsets.fromLTRB(
                                                  0, 5, 0, 5),
                                              child: Container(
                                                padding: EdgeInsets.all(10),
                                                decoration: new BoxDecoration(
                                                    shape: BoxShape.circle,
                                                    gradient: LinearGradient(
                                                        begin: Alignment
                                                            .bottomCenter,
                                                        end:
                                                            Alignment.topCenter,
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
                                                  Icons.upload,
                                                  size: img_height,
                                                ),
                                              ),
                                            ),
                                            SizedBox(
                                              width: 10,
                                            ),
                                          ],
                                        ),
                                      ),
                                    )
                                  : Container()
                              :
                              // For Download....
                              Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Container(
                                      width: img_width,
                                      decoration: BoxDecoration(
                                        color:
                                            Color.fromARGB(255, 255, 255, 255),
                                        borderRadius: BorderRadius.only(
                                          topLeft: Radius.circular(20),
                                          bottomLeft: Radius.circular(20),
                                        ),
                                        border: Border.all(
                                          width: 1,
                                          color: Color.fromARGB(255, 0, 0, 0),
                                          style: BorderStyle.solid,
                                        ),
                                      ),
                                      child: MaterialButton(
                                        onPressed: () async {
                                          is_data_loded = false;

                                          // await showDatePicker(
                                          //     context: context,
                                          //     initialDate: DateTime.now()
                                          //         .subtract(Duration(days: 30)),
                                          //     firstDate: DateTime.now()
                                          //         .subtract(
                                          //             Duration(days: 365)),
                                          //     lastDate: DateTime.now()
                                          //         .subtract(Duration(days: 0)),
                                          //     builder: (context, child) {
                                          //       return Theme(
                                          //         data: ThemeData.dark()
                                          //             .copyWith(
                                          //                 colorScheme: const ColorScheme
                                          //                         .dark(
                                          //                     onPrimary: Colors
                                          //                         .black, // selected text color
                                          //                     onSurface: Colors
                                          //                         .amberAccent, // default text color
                                          //                     primary: Colors
                                          //                         .amberAccent // circle color
                                          //                     ),
                                          //                 dialogBackgroundColor:
                                          //                     Colors.black54,
                                          //                 textButtonTheme:
                                          //                     TextButtonThemeData(
                                          //                         style: TextButton
                                          //                             .styleFrom(
                                          //                                 textStyle: const TextStyle(
                                          //                                     color: Colors
                                          //                                         .amber,
                                          //                                     fontWeight: FontWeight
                                          //                                         .normal,
                                          //                                     fontSize:
                                          //                                         12,
                                          //                                     fontFamily:
                                          //                                         'Quicksand'),
                                          //                                 primary: Color.fromARGB(
                                          //                                     255,
                                          //                                     32,
                                          //                                     255,
                                          //                                     7), // color of button's letters
                                          //                                 backgroundColor: Colors
                                          //                                     .black54, // Background color
                                          //                                 shape: RoundedRectangleBorder(
                                          //                                     side: const BorderSide(color: Colors.transparent, width: 1, style: BorderStyle.solid),
                                          //                                     borderRadius: BorderRadius.circular(50))))),
                                          //         child: child!,
                                          //       );
                                          //     }).then((selectedDate) {
                                          //   if (selectedDate != null) {
                                          //     setState(() {
                                          //       From_date =
                                          //           DateFormat('dd-MMM-yyyy')
                                          //               .format(selectedDate);
                                          //       Selected_from_date =
                                          //           DateFormat('yyyy-MM-dd')
                                          //               .format(selectedDate);
                                          //     });
                                          //   }
                                          // });

                                          await showDatePicker(
                                            context: context,
                                            initialDate: DateTime.now()
                                                .subtract(Duration(days: 30)),
                                            firstDate: DateTime.now()
                                                .subtract(Duration(days: 365)),
                                            lastDate: DateTime.now()
                                                .subtract(Duration(days: 0)),
                                          ).then((selectedDate) {
                                            if (selectedDate != null) {
                                              setState(() {
                                                From_date =
                                                    DateFormat('dd-MMM-yyyy')
                                                        .format(selectedDate);
                                                Selected_from_date =
                                                    DateFormat('yyyy-MM-dd')
                                                        .format(selectedDate);
                                              });
                                            }
                                          });
                                        },
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          children: [
                                            Padding(
                                              padding: EdgeInsets.all(10),
                                              child: Container(
                                                // padding: EdgeInsets.all(10),
                                                // decoration: new BoxDecoration(
                                                //     shape: BoxShape.circle,
                                                //     gradient: LinearGradient(
                                                //         begin: Alignment.bottomCenter,
                                                //         end: Alignment.topCenter,
                                                //         stops: [
                                                //           0.0,
                                                //           0.5,
                                                //           1.0
                                                //         ],
                                                //         colors: [
                                                //           Colors.white,
                                                //           Colors.white,
                                                //           Colors.grey
                                                //         ])),
                                                child: Icon(
                                                  Icons.calendar_month_outlined,
                                                  size: img_height,
                                                ),
                                              ),
                                            ),
                                            Spacer(),
                                            Column(
                                              children: [
                                                SizedBox(
                                                  height: 5,
                                                ),
                                                Text(
                                                  "From Date",
                                                  style: new TextStyle(
                                                    fontSize: Main_font,
                                                    color: Color.fromARGB(
                                                        255, 0, 0, 0),
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
                                                    color: Color.fromARGB(
                                                        255, 0, 0, 0),
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
                                      width: 25,
                                    ),
                                    Container(
                                      width: img_width,
                                      decoration: BoxDecoration(
                                        color:
                                            Color.fromARGB(255, 255, 255, 255),
                                        borderRadius: BorderRadius.only(
                                          topRight: Radius.circular(20),
                                          bottomRight: Radius.circular(20),
                                        ),
                                        border: Border.all(
                                          width: 1,
                                          color: Color.fromARGB(255, 0, 0, 0),
                                          style: BorderStyle.solid,
                                        ),
                                      ),
                                      child: MaterialButton(
                                        onPressed: () async {
                                          is_data_loded = false;
                                          await showDatePicker(
                                            context: context,
                                            initialDate: DateTime.now()
                                                .subtract(Duration(days: 0)),
                                            firstDate: DateTime.now()
                                                .subtract(Duration(days: 365)),
                                            lastDate: DateTime.now()
                                                .subtract(Duration(days: 0)),
                                          ).then((selectedDate) {
                                            if (selectedDate != null) {
                                              setState(() {
                                                To_date =
                                                    DateFormat('dd-MMM-yyyy')
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
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          children: [
                                            Spacer(),
                                            Column(
                                              children: [
                                                SizedBox(
                                                  height: 5,
                                                ),
                                                Text(
                                                  "To Date",
                                                  style: new TextStyle(
                                                    fontSize: Main_font,
                                                    color: Color.fromARGB(
                                                        255, 0, 0, 0),
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
                                                    color: Color.fromARGB(
                                                        255, 0, 0, 0),
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
                                            Padding(
                                              padding: EdgeInsets.all(10),
                                              child: Container(
                                                // padding: EdgeInsets.all(10),
                                                // decoration: new BoxDecoration(
                                                //     shape: BoxShape.circle,
                                                //     gradient: LinearGradient(
                                                //         begin: Alignment.bottomCenter,
                                                //         end: Alignment.topCenter,
                                                //         stops: [
                                                //           0.0,
                                                //           0.5,
                                                //           1.0
                                                //         ],
                                                //         colors: [
                                                //           Colors.white,
                                                //           Colors.white,
                                                //           Colors.grey
                                                //         ])),
                                                child: Icon(
                                                  Icons.calendar_month_outlined,
                                                  size: img_height,
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                          SizedBox(
                            width: 15,
                          ),
                          SizedBox(
                            width: 10,
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      is_dow_Upl
                          ? Container()
                          : is_data_loded
                              ? Container(
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
                                      width: 2,
                                      color: Color.fromARGB(255, 0, 0, 0),
                                      style: BorderStyle.solid,
                                    ),
                                  ),
                                  child: MaterialButton(
                                    onPressed: () async {
                                      List<List<dynamic>> rows = [];
                                      List<dynamic> row = [];
                                      for (int i = 0;
                                          i <
                                              map_Response_get[0]
                                                  .keys
                                                  .toList()
                                                  .length;
                                          i++) {
                                        row.add(map_Response_get[0]
                                            .keys
                                            .toList()[i]
                                            .toString());
                                      }
                                      print(row);
                                      rows.add(row);
                                      for (int i = 0;
                                          i < map_Response_get.length;
                                          i++) {
                                        List<dynamic> row = [];
                                        for (int j = 0;
                                            j <
                                                map_Response_get[0]
                                                    .keys
                                                    .toList()
                                                    .length;
                                            j++) {
                                          row.add(map_Response_get[i][
                                              map_Response_get[0]
                                                  .keys
                                                  .toList()[j]
                                                  .toString()]);
                                        }
                                        rows.add(row);
                                      }

                                      print(rows);

                                      String csv = const ListToCsvConverter()
                                          .convert(rows);

                                      if (kIsWeb) {
                                        print(csv);

                                        globals.str_csv_file = csv;

                                        html.AnchorElement(
                                            href:
                                                "data:text/plain;charset=utf-8,$csv")
                                          ..setAttribute("download",
                                              "actual_revenue_targets.csv")
                                          ..click();
                                      } else {
                                        if (await Permission.storage
                                            .request()
                                            .isGranted) {
                                          final String path =
                                              (await getApplicationDocumentsDirectory())
                                                  .path;
                                          final String filename_withPath =
                                              '$path/actual_revenue_targets.csv';
                                          print(filename_withPath);
                                          final File file =
                                              File(filename_withPath);
                                          File writtenFile =
                                              await file.writeAsString(csv);
                                          print(writtenFile);
                                        } else {
                                          Map<Permission, PermissionStatus>
                                              statuses = await [
                                            Permission.storage,
                                          ].request();
                                        }
                                      }
                                    },
                                    child: Row(
                                      // mainAxisAlignment: MainAxisAlignment.end,
                                      // crossAxisAlignment: CrossAxisAlignment.center,
                                      children: [
                                        SizedBox(
                                          width: 10,
                                        ),
                                        Padding(
                                          padding:
                                              EdgeInsets.fromLTRB(0, 5, 0, 5),
                                          child: Container(
                                            padding: EdgeInsets.all(10),
                                            decoration: new BoxDecoration(
                                                shape: BoxShape.circle,
                                                gradient: LinearGradient(
                                                    begin:
                                                        Alignment.bottomCenter,
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
                                              Icons.download,
                                              size: img_height,
                                            ),
                                          ),
                                        ),
                                        Spacer(),
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          children: [
                                            SizedBox(
                                              height: 5,
                                            ),
                                            Text(
                                              "Download\nactual\nRevenue Targets",
                                              textAlign: TextAlign.center,
                                              style: new TextStyle(
                                                fontSize: Main_font,
                                                color: Color.fromARGB(
                                                    255, 0, 0, 0),
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
                                )
                              : Container(
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
                                          padding:
                                              EdgeInsets.fromLTRB(0, 5, 0, 5),
                                          child: Container(
                                            padding: EdgeInsets.all(10),
                                            decoration: new BoxDecoration(
                                                shape: BoxShape.circle,
                                                gradient: LinearGradient(
                                                    begin:
                                                        Alignment.bottomCenter,
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
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          children: [
                                            SizedBox(
                                              height: 5,
                                            ),
                                            Text(
                                              "View Actual\nRevenue Targets",
                                              textAlign: TextAlign.center,
                                              style: new TextStyle(
                                                fontSize: Main_font,
                                                color: Color.fromARGB(
                                                    255, 0, 0, 0),
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
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          SizedBox(
                            width: 10,
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          is_dow_Upl
                              ? is_File_selected
                                  ? Flexible(
                                      child: Text(
                                        "You can Upload Actual Revenue Targets (" +
                                            actual_revenue_targets_fileName +
                                            ") using mode : " +
                                            str_pera_is_app_ovr,
                                        textAlign: TextAlign.center,
                                        maxLines: 2,
                                        style: new TextStyle(
                                          fontSize: Main_font,
                                          color: Color.fromARGB(255, 0, 0, 0),
                                          fontWeight: FontWeight.w400,
                                          // decoration: TextDecoration.underline
                                        ),
                                      ),
                                    )
                                  : Flexible(
                                      child: Text(
                                        "You can Upload Actual Revenue Targets after select file...",
                                        textAlign: TextAlign.center,
                                        maxLines: 2,
                                        style: new TextStyle(
                                          fontSize: Main_font,
                                          color: Color.fromARGB(255, 0, 0, 0),
                                          fontWeight: FontWeight.w400,
                                          // decoration: TextDecoration.underline
                                        ),
                                      ),
                                    )
                              : is_data_download
                                  ? Flexible(
                                      child: Text(
                                        "You can Download Actual Revenue Targets",
                                        textAlign: TextAlign.center,
                                        maxLines: 2,
                                        style: new TextStyle(
                                          fontSize: Main_font,
                                          color: Color.fromARGB(255, 0, 0, 0),
                                          fontWeight: FontWeight.w400,
                                          // decoration: TextDecoration.underline
                                        ),
                                      ),
                                    )
                                  : Flexible(
                                      child: Text(
                                        "You can Download Actual Revenue Targets after load data...",
                                        textAlign: TextAlign.center,
                                        maxLines: 2,
                                        style: new TextStyle(
                                          fontSize: Main_font,
                                          color: Color.fromARGB(255, 0, 0, 0),
                                          fontWeight: FontWeight.w400,
                                          // decoration: TextDecoration.underline
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
                    ],
                  ),
                ),

                // is_File_selected
                //     ? SingleChildScrollView(
                //         child: Table(
                //           // Border.all(
                //           //       width: 2,
                //           //       color: Color.fromARGB(255, 0, 242, 255),
                //           //       style: BorderStyle.solid,
                //           //     ),
                //           border: TableBorder.all(
                //             width: 1,
                //             // color: Color.fromARGB(255, 0, 242, 255),
                //             style: BorderStyle.solid,
                //           ),
                //           children:
                //               actual_revenue_targets_data.map((item) {
                //             return TableRow(
                //                 children: item.map((row) {
                //               return Container(
                //                 child: Padding(
                //                   padding: const EdgeInsets.all(8.0),
                //                   child: Text(
                //                     row.toString(),
                //                     textAlign: TextAlign.center,
                //                   ),
                //                 ),
                //               );
                //             }).toList());
                //           }).toList(),
                //         ),
                //       )
                //     // Expanded(
                //     //     child: ListView.builder(
                //     //         // padding: const EdgeInsets.all(8),
                //     //         itemCount: actual_revenue_targets_data.length - 1,
                //     //         itemBuilder: (BuildContext context, int index) {
                //     //           return Padding(
                //     //             padding: const EdgeInsets.all(3),
                //     //             child: Container(
                //     //               // height: 25,
                //     //               decoration: BoxDecoration(
                //     //                 // color: Color.fromARGB(255, 255, 255, 255).withOpacity(0.5),
                //     //                 // color: Colors.white.withOpacity(0.5),
                //     //                 color: Color.fromARGB(255, 255, 255, 255),
                //     //                 borderRadius: BorderRadius.only(
                //     //                   topLeft: Radius.circular(5),
                //     //                   topRight: Radius.circular(5),
                //     //                 ),
                //     //                 border: Border.all(
                //     //                   width: 1,
                //     //                   color: Color.fromARGB(255, 0, 0, 0),
                //     //                   style: BorderStyle.solid,
                //     //                 ),
                //     //               ),

                //     //               child: Expanded(
                //     //                 child: Padding(
                //     //                   padding: EdgeInsets.all(5),
                //     //                   child: Row(
                //     //                     mainAxisAlignment:
                //     //                         MainAxisAlignment.spaceBetween,
                //     //                     crossAxisAlignment:
                //     //                         CrossAxisAlignment.center,
                //     //                     children: [
                //     //                       Text(
                //     //                         actual_revenue_targets_data[index + 1][0],
                //     //                         style: new TextStyle(
                //     //                           fontSize: Main_font,
                //     //                           color:
                //     //                               Color.fromARGB(255, 0, 0, 0),
                //     //                           fontWeight: FontWeight.w400,
                //     //                           // decoration: TextDecoration.underline
                //     //                         ),
                //     //                       ),
                //     //                       Text(
                //     //                         actual_revenue_targets_data[index + 1][1],
                //     //                         style: new TextStyle(
                //     //                           fontSize: Main_font,
                //     //                           color:
                //     //                               Color.fromARGB(255, 0, 0, 0),
                //     //                           fontWeight: FontWeight.w400,
                //     //                           // decoration: TextDecoration.underline
                //     //                         ),
                //     //                       ),
                //     //                       // Spacer(),
                //     //                       Text(
                //     //                         actual_revenue_targets_data[index + 1][2],
                //     //                         style: new TextStyle(
                //     //                           fontSize: Main_font,
                //     //                           color:
                //     //                               Color.fromARGB(255, 0, 0, 0),
                //     //                           fontWeight: FontWeight.w400,
                //     //                           // decoration: TextDecoration.underline
                //     //                         ),
                //     //                       ),
                //     //                       // Spacer(),
                //     //                       Text(
                //     //                         actual_revenue_targets_data[index + 1][3],
                //     //                         style: new TextStyle(
                //     //                           fontSize: Main_font,
                //     //                           color:
                //     //                               Color.fromARGB(255, 0, 0, 0),
                //     //                           fontWeight: FontWeight.w400,
                //     //                           // decoration: TextDecoration.underline
                //     //                         ),
                //     //                       ),
                //     //                     ],
                //     //                   ),
                //     //                 ),
                //     //               ),

                //     //               // height: 50,
                //     //               // color: Colors.amber[colorCodes[index]],
                //     //               // child: Center(child: Text('Entry ${entries[index]}')),
                //     //             ),
                //     //           );
                //     //         }))
                //     : Container(),
              ],
            ),
          ),
        ],
      ),
      drawer: drower(),
    );
  }

  File_Upload_calling() async {
    if (is_File_selected) {
      print('btn_Login_call');
      var result = await Connectivity().checkConnectivity();

      if (result == ConnectivityResult.mobile ||
          result == ConnectivityResult.wifi ||
          result == ConnectivityResult.ethernet) {
        globals.str_loding = "File Uploading...";
        start_Loding();
        File_Upload_call();
      } else {
        AwesomeDialog(
                //width: img_width,
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
    } else {
      AwesomeDialog(
              // width: img_width,
              dismissOnTouchOutside: false,
              context: context,
              dialogType: DialogType.WARNING,
              animType: AnimType.TOPSLIDE,
              title: 'Please select actual Revenue Targets for ' +
                  str_pera_is_app_ovr +
                  '.',
              desc: '',
              btnOkColor: Theme.of(context).primaryColor,
              // btnCancelOnPress: () {},
              btnOkOnPress: () {})
          .show();
    }
  }

  File_Upload_call() async {
    // /api/v1/mercedes-benz/service/invoice_number_prefix_to_actual_revenue_targets
    var postUri = Uri.parse(globals.str_URL +
        "api/v1/mercedes-benz/service/revenue_targets?write_mode=" +
        str_pera_is_app_ovr +
        "&targets_type=actual");
    var request = http.MultipartRequest("POST", postUri);
    request.files.add(http.MultipartFile.fromBytes('file', fileBytes,
        filename: actual_revenue_targets_fileName,
        contentType: MediaType('multipart', 'form-data')));

    try {
      http.Response response =
          await http.Response.fromStream(await request.send());

      print("Result: ${response.statusCode}");
      print("Response: ${response}");

      String str_statuscode = response.statusCode.toString();
      // print('${str_statuscode[0]}');
      String chk_Statuscode = '${str_statuscode[0]}';
      print("chk_Statuscode : " + chk_Statuscode.toString());

      map_Response = json.decode(response.body);
      print(map_Response);

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
            desc: map_Response["msg"],
            btnOkColor: Theme.of(context).primaryColor,
            // btnCancelOnPress: () {},
            btnOkOnPress: () {
              // logout();

              setState(() {
                is_File_selected = false;
              });
            }).show();
      } else if (chk_Statuscode == "2") {
        stop_Loding();

        AwesomeDialog(
            dismissOnTouchOutside: false,
            context: context,
            dialogType: DialogType.SUCCES,
            animType: AnimType.TOPSLIDE,
            title: "File Uploaded Successfully...",
            desc: map_Response["msg"],
            btnOkColor: Theme.of(context).primaryColor,
            // btnCancelOnPress: () {},
            btnOkOnPress: () {
              // logout();

              setState(() {
                is_File_selected = false;
                is_dow_Upl = false;
                Data_View_calling();
              });
            }).show();
      } else {
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
      }
    } on Exception catch (_) {
      print('never reached');
      stop_Loding();
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

  Data_View_calling() async {
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

  Data_View_call() async {
    Data_From_date = From_date;
    Data_To_date = To_date;
    // // /api/v1/mercedes-benz/service/invoice_number_prefix_to_actual_revenue_targets
    // var postUri = Uri.parse(
    //     globals.str_URL+"api/v1/mercedes-benz/service/invoice_number_prefix_to_actual_revenue_targets");
    // var request = http.MultipartRequest("GET", postUri);
    // // request.files.add(http.MultipartFile.fromBytes('file', fileBytes,
    // //     filename: actual_revenue_targets_fileName,
    // //     contentType: MediaType('multipart', 'form-data')));

    // /api/v1/mercedes-benz/service/invoice_number_prefix_to_actual_revenue_targets
    var postUri = Uri.parse(globals.str_URL +
        "api/v1/mercedes-benz/service/revenue_targets?targets_type=actual&start_month=" +
        Selected_from_date +
        "&end_month=" +
        Selected_to_date);
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

      final map_Response_get1 = json.decode(response.body);
      // print(map_Response_get1);

      map_Response_get = map_Response_get1;
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
            desc: map_Response["msg"],
            btnOkColor: Theme.of(context).primaryColor,
            // btnCancelOnPress: () {},
            btnOkOnPress: () {
              // logout();

              setState(() {});
            }).show();
      } else if (chk_Statuscode == "2") {
        stop_Loding();

        // final map_Response_get1 = json.decode(response.body);
        // print(map_Response_get1);

        // map_Response_get = map_Response_get1;

        if (map_Response_get.length == 0) {
          is_data_download = false;
          is_data_loded = false;
          AwesomeDialog(
              // width: img_width,
              dismissOnTouchOutside: false,
              context: context,
              dialogType: DialogType.WARNING,
              animType: AnimType.TOPSLIDE,
              title: "No Record found on your selected date",
              desc: 'Please select date range properly!',
              btnOkColor: Theme.of(context).primaryColor,
              // btnCancelOnPress: () {},
              btnOkOnPress: () {
                // logout();

                setState(() {
                  is_File_selected = false;
                });
              }).show();
        } else {
          setState(() {
            is_data_download = true;
            is_data_loded = true;
            // print(map_Response_get[0]["invoice_number_prefix"]);
          });
        }
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
