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

import 'package:multiselect/multiselect.dart';

// import 'package:http/http.dart' as http;

class sef extends StatefulWidget {
  const sef({Key? key}) : super(key: key);

  @override
  State<sef> createState() => _sefState();
}

class _sefState extends State<sef> {
  var objFile;
  var logoBase64;
  var fileBytes;
  Map map_Response = {};

  bool is_File_selected = false;

  String From_date = "";
  String To_date = "";

  String Selected_from_date = "";
  String Selected_to_date = "";

  int window_raqnge = 0;

  String _selectRegion = 'Select Market Region(s)';
  String str_Selected_region = "";
  List<String> selected_region = [];

// 20220911_20220911.csv

  @override
  void initState() {
    // TODO: implement initState
    DateFormat dateFormat = DateFormat("dd-MMM-yyyy");
    From_date = dateFormat.format(DateTime.now().subtract(Duration(days: 1)));
    To_date = dateFormat.format(DateTime.now().subtract(Duration(days: 1)));

    DateFormat dateFormat2 = DateFormat("yyyyMMdd");
    Selected_from_date =
        dateFormat2.format(DateTime.now().subtract(Duration(days: 1)));
    Selected_to_date =
        dateFormat2.format(DateTime.now().subtract(Duration(days: 1)));

    DateTime date = DateTime.now();
    print("weekday is ${date.weekday}");
    print("weekday is :" + (DateFormat('EEEE').format(date)));

    // if ((DateFormat('EEEE').format(date)).toString() == "Monday") {
    //   window_raqnge = 2;
    // } else {
    //   window_raqnge = 1;
    // }
    window_raqnge = 6;
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

  @override
  Widget build(BuildContext context) {
    var deviceType = getDeviceType(MediaQuery.of(context).size);

    switch (deviceType) {
      case DeviceScreenType.desktop:
        is_desktop = true;
        is_mobile = false;
        img_width = 375;
        img_height = 80;
        Main_font = 25;
        Sub_font = 20;
        card_padding = 20;
        break;
      case DeviceScreenType.tablet:
        img_width = 265;
        img_height = 60;
        Main_font = 20;
        Sub_font = 15;
        card_padding = 15;
        is_desktop = false;
        is_mobile = false;
        break;
      case DeviceScreenType.mobile:
        img_width = 300;
        img_height = 40;
        Main_font = 18;
        Sub_font = 15;
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
            Text('Star Ease Flat View'),
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
            child: Padding(
              padding: EdgeInsets.all(20),
              child: Column(
                children: [
                  Icon(
                    Icons.sell_rounded,
                    color: Colors.black,
                    size: img_height,
                  ),
                  Text(
                    "Please select date range to set corresponding file name.",
                    style: new TextStyle(
                      fontSize: Main_font,
                      color: Color.fromARGB(255, 0, 0, 0),
                      fontWeight: FontWeight.w600,
                      // decoration: TextDecoration.underline
                    ),
                  ),
                  Text(
                    "Note: This functionality will merely append to the dataset.",
                    style: new TextStyle(
                      fontSize: Main_font - 5,
                      color: Color.fromARGB(255, 0, 0, 0),
                      fontWeight: FontWeight.w400,
                      // decoration: TextDecoration.underline
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  is_mobile
                      ? Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Container(
                              width: img_width,
                              decoration: BoxDecoration(
                                color: Color.fromARGB(255, 255, 255, 255),
                                borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(25),
                                  bottomLeft: Radius.circular(25),
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
                                    firstDate: DateTime.now().subtract(
                                        Duration(days: window_raqnge)),
                                    lastDate: DateTime.now()
                                        .subtract(Duration(days: 1)),
                                  ).then((selectedDate) {
                                    if (selectedDate != null) {
                                      setState(() {
                                        From_date = DateFormat('dd-MMM-yyyy')
                                            .format(selectedDate);
                                        Selected_from_date =
                                            DateFormat('yyyyMMdd')
                                                .format(selectedDate);
                                      });
                                    }
                                  });
                                },
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Padding(
                                      padding: EdgeInsets.all(10),
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
                                        child: RawMaterialButton(
                                          onPressed: () async {
                                            await showDatePicker(
                                              context: context,
                                              initialDate: DateTime.now()
                                                  .subtract(Duration(days: 1)),
                                              firstDate: DateTime.now()
                                                  .subtract(Duration(
                                                      days: window_raqnge)),
                                              lastDate: DateTime.now()
                                                  .subtract(Duration(days: 1)),
                                            ).then((selectedDate) {
                                              if (selectedDate != null) {
                                                setState(() {
                                                  From_date =
                                                      DateFormat('dd-MMM-yyyy')
                                                          .format(selectedDate);
                                                  Selected_from_date =
                                                      DateFormat('yyyyMMdd')
                                                          .format(selectedDate);
                                                });
                                              }
                                            });
                                          },
                                          child: Icon(
                                            Icons.calendar_month_outlined,
                                            size: img_height,
                                          ),
                                          shape: new CircleBorder(),
                                          elevation: 2.0,
                                          fillColor: Colors.white,
                                          padding: const EdgeInsets.all(8.0),
                                        ),
                                      ),
                                    ),
                                    Spacer(),
                                    Column(
                                      children: [
                                        SizedBox(
                                          height: 10,
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
                                          height: 10,
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
                                          height: 10,
                                        ),
                                      ],
                                    ),
                                    Spacer(),
                                  ],
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 25,
                            ),
                            Container(
                              width: img_width,
                              decoration: BoxDecoration(
                                color: Color.fromARGB(255, 255, 255, 255),
                                borderRadius: BorderRadius.only(
                                  topRight: Radius.circular(25),
                                  bottomRight: Radius.circular(25),
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
                                    firstDate: DateTime.now().subtract(
                                        Duration(days: window_raqnge)),
                                    lastDate: DateTime.now()
                                        .subtract(Duration(days: 1)),
                                  ).then((selectedDate) {
                                    if (selectedDate != null) {
                                      setState(() {
                                        To_date = DateFormat('dd-MMM-yyyy')
                                            .format(selectedDate);
                                        Selected_to_date =
                                            DateFormat('yyyyMMdd')
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
                                    Column(
                                      children: [
                                        SizedBox(
                                          height: 10,
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
                                          height: 10,
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
                                          height: 10,
                                        ),
                                      ],
                                    ),
                                    Spacer(),
                                    Padding(
                                      padding: EdgeInsets.all(10),
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
                                        child: RawMaterialButton(
                                          onPressed: () async {
                                            await showDatePicker(
                                              context: context,
                                              initialDate: DateTime.now()
                                                  .subtract(Duration(days: 1)),
                                              firstDate: DateTime.now()
                                                  .subtract(Duration(
                                                      days: window_raqnge)),
                                              lastDate: DateTime.now()
                                                  .subtract(Duration(days: 1)),
                                            ).then((selectedDate) {
                                              if (selectedDate != null) {
                                                setState(() {
                                                  To_date =
                                                      DateFormat('dd-MMM-yyyy')
                                                          .format(selectedDate);
                                                  Selected_to_date =
                                                      DateFormat('yyyyMMdd')
                                                          .format(selectedDate);
                                                });
                                              }
                                            });
                                          },
                                          child: Icon(
                                            Icons.calendar_month_outlined,
                                            size: img_height,
                                          ),
                                          shape: new CircleBorder(),
                                          elevation: 2.0,
                                          fillColor: Colors.white,
                                          padding: const EdgeInsets.all(8.0),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        )
                      : Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Container(
                              width: img_width,
                              decoration: BoxDecoration(
                                color: Color.fromARGB(255, 255, 255, 255),
                                borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(25),
                                  bottomLeft: Radius.circular(25),
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
                                    firstDate: DateTime.now().subtract(
                                        Duration(days: window_raqnge)),
                                    lastDate: DateTime.now()
                                        .subtract(Duration(days: 1)),
                                  ).then((selectedDate) {
                                    if (selectedDate != null) {
                                      setState(() {
                                        From_date = DateFormat('dd-MMM-yyyy')
                                            .format(selectedDate);
                                        Selected_from_date =
                                            DateFormat('yyyyMMdd')
                                                .format(selectedDate);
                                      });
                                    }
                                  });
                                },
                                child: Row(
                                  // mainAxisAlignment: MainAxisAlignment.end,
                                  // crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Padding(
                                      padding: EdgeInsets.all(10),
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
                                        child: RawMaterialButton(
                                          onPressed: () async {
                                            await showDatePicker(
                                              context: context,
                                              initialDate: DateTime.now()
                                                  .subtract(Duration(days: 1)),
                                              firstDate: DateTime.now()
                                                  .subtract(Duration(
                                                      days: window_raqnge)),
                                              lastDate: DateTime.now()
                                                  .subtract(Duration(days: 1)),
                                            ).then((selectedDate) {
                                              if (selectedDate != null) {
                                                setState(() {
                                                  From_date =
                                                      DateFormat('dd-MMM-yyyy')
                                                          .format(selectedDate);
                                                  Selected_from_date =
                                                      DateFormat('yyyyMMdd')
                                                          .format(selectedDate);
                                                });
                                              }
                                            });
                                          },
                                          child: Icon(
                                            Icons.calendar_month_outlined,
                                            size: img_height,
                                          ),
                                          shape: new CircleBorder(),
                                          elevation: 2.0,
                                          fillColor: Colors.white,
                                          padding: const EdgeInsets.all(8.0),
                                        ),
                                      ),
                                    ),
                                    Spacer(),
                                    Column(
                                      children: [
                                        SizedBox(
                                          height: 10,
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
                                          height: 10,
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
                                          height: 10,
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
                                color: Color.fromARGB(255, 255, 255, 255),
                                borderRadius: BorderRadius.only(
                                  topRight: Radius.circular(25),
                                  bottomRight: Radius.circular(25),
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
                                    firstDate: DateTime.now().subtract(
                                        Duration(days: window_raqnge)),
                                    lastDate: DateTime.now()
                                        .subtract(Duration(days: 1)),
                                  ).then((selectedDate) {
                                    if (selectedDate != null) {
                                      setState(() {
                                        To_date = DateFormat('dd-MMM-yyyy')
                                            .format(selectedDate);
                                        Selected_to_date =
                                            DateFormat('yyyyMMdd')
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
                                    Column(
                                      children: [
                                        SizedBox(
                                          height: 10,
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
                                          height: 10,
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
                                          height: 10,
                                        ),
                                      ],
                                    ),
                                    Spacer(),
                                    Padding(
                                      padding: EdgeInsets.all(10),
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
                                        child: RawMaterialButton(
                                          onPressed: () async {
                                            await showDatePicker(
                                              context: context,
                                              initialDate: DateTime.now()
                                                  .subtract(Duration(days: 1)),
                                              firstDate: DateTime.now()
                                                  .subtract(Duration(
                                                      days: window_raqnge)),
                                              lastDate: DateTime.now()
                                                  .subtract(Duration(days: 1)),
                                            ).then((selectedDate) {
                                              if (selectedDate != null) {
                                                setState(() {
                                                  To_date =
                                                      DateFormat('dd-MMM-yyyy')
                                                          .format(selectedDate);
                                                  Selected_to_date =
                                                      DateFormat('yyyyMMdd')
                                                          .format(selectedDate);
                                                });
                                              }
                                            });
                                          },
                                          child: Icon(
                                            Icons.calendar_month_outlined,
                                            size: img_height,
                                          ),
                                          shape: new CircleBorder(),
                                          elevation: 2.0,
                                          fillColor: Colors.white,
                                          padding: const EdgeInsets.all(8.0),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                  // SizedBox(
                  //   height: 20,
                  // ),
                  // SizedBox(
                  //   width: 400,
                  //   child: DropdownButtonFormField<String>(
                  //     value: null,
                  //     isDense: true,
                  //     style: TextStyle(color: Colors.white),
                  //     dropdownColor: Color.fromARGB(174, 0, 0, 0),
                  //     decoration: InputDecoration(
                  //       prefixIcon: Icon(
                  //         Icons.car_repair,
                  //         color: Colors.white,
                  //       ),
                  //       hintStyle: TextStyle(color: Colors.white),
                  //       filled: true,
                  //       fillColor: Colors.black45,
                  //     ),
                  //     icon: Icon(
                  //       Icons.keyboard_double_arrow_down_rounded,
                  //       color: Colors.white,
                  //     ),
                  //     // dropdownColor: Colors.black45,
                  //     hint: Text(
                  //       _selectRegion,
                  //       style: new TextStyle(
                  //           fontSize: 15.0,
                  //           color: Color.fromARGB(255, 255, 255, 255),
                  //           fontWeight: FontWeight.w300),
                  //     ),
                  //     onChanged: (newVal) {
                  //       if (newVal == "Gujarat") {
                  //         str_Selected_region = "gj";
                  //       } else if (newVal == "Madhya Pradesh") {
                  //         str_Selected_region = "mp";
                  //       } else if (newVal == "Mumbai") {
                  //         str_Selected_region = "bom";
                  //       } else if (newVal == "Kolkata") {
                  //         str_Selected_region = "ccu";
                  //       } else if (newVal == "All Locations") {
                  //         str_Selected_region = "all_regions";
                  //       } else {
                  //         str_Selected_region = "";
                  //       }

                  //       setState(() {
                  //         _selectRegion = newVal!;
                  //       });
                  //     },
                  //     items: <String>[
                  //       'Gujarat',
                  //       'Madhya Pradesh',
                  //       'Mumbai',
                  //       'Kolkata',
                  //       'All Locations',
                  //     ].map((String value) {
                  //       //                                    'Gujarat' : "gj"
                  //       // 'Madhya Pradesh' : "mp"
                  //       // 'Mumbai' : "bom"
                  //       // 'Kolkata' : "ccu"
                  //       // 'All Locations' : "all_regions"'

                  //       return DropdownMenuItem(
                  //         value: value,
                  //         child: Text(value),
                  //       );
                  //     }).toList(),
                  //   ),
                  // ),
                  SizedBox(
                    height: 20,
                  ),
                  SizedBox(
                    width: 500,
                    child: DropDownMultiSelect(
                      onChanged: (List<String> x) {
                        setState(() {
                          is_File_selected = false;
                          selected_region = x;
                        });
                      },
                      options: globals.Region_list,
                      selectedValues: selected_region,
                      whenEmpty: 'Select Market Region(s)',
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Padding(
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
                        child: new Text(
                            '     Please select your data file     ',
                            style: new TextStyle(
                                fontSize: Main_font, color: Colors.white)),
                        onPressed: () async {
                          if (selected_region.length == 0) {
                            AwesomeDialog(
                                    // width: img_width,
                                    dismissOnTouchOutside: false,
                                    context: context,
                                    dialogType: DialogType.WARNING,
                                    animType: AnimType.TOPSLIDE,
                                    title:
                                        'Please select a resion for file upload !',
                                    desc: '',
                                    btnOkColor: Theme.of(context).primaryColor,
                                    // btnCancelOnPress: () {},
                                    btnOkOnPress: () {})
                                .show();
                          } else {
                            str_Selected_region = "";

                            List<String> selected_region_code = [];

                            print(selected_region);

                            for (int i = 0; i < selected_region.length; i++) {
                              String str_tmp = selected_region[i].toString();
                              if (str_tmp == "Gujarat") {
                                str_tmp = "gj";
                              } else if (str_tmp == "Madhya Pradesh") {
                                str_tmp = "mp";
                              } else if (str_tmp == "Mumbai") {
                                str_tmp = "bom";
                              } else if (str_tmp == "Kolkata") {
                                str_tmp = "ccu";
                              } else if (str_tmp == "All Locations") {
                                str_tmp = "all_regions";
                              } else {
                                str_tmp = "";
                              }

                              selected_region_code.add(str_tmp);
                            }

                            selected_region_code = selected_region_code..sort();

                            print(selected_region_code);

                            if (selected_region.contains("All Regions")) {
                              str_Selected_region = "all_regions";
                            } else if ((selected_region.length ==
                                    globals.Region_list.length - 1) &&
                                !selected_region.contains("All Regions")) {
                              str_Selected_region = "all_regions";
                            } else {
                              for (int i = 0;
                                  i < selected_region_code.length;
                                  i++) {
                                String str_tmp =
                                    selected_region_code[i].toString();

                                // if (str_tmp == "Gujarat") {
                                //   str_tmp = "gj";
                                // } else if (str_tmp == "Madhya Pradesh") {
                                //   str_tmp = "mp";
                                // } else if (str_tmp == "Mumbai") {
                                //   str_tmp = "bom";
                                // } else if (str_tmp == "Kolkata") {
                                //   str_tmp = "ccu";
                                // } else if (str_tmp == "All Locations") {
                                //   str_tmp = "all_regions";
                                // } else {
                                //   str_tmp = "";
                                // }

                                str_Selected_region =
                                    str_Selected_region + '_' + str_tmp;
                              }
                            }

                            if (str_Selected_region[0] == "_") {
                              str_Selected_region =
                                  str_Selected_region.substring(1);
                            }
                            print(
                                "str_Selected_region : " + str_Selected_region);

                            final result = await FilePicker.platform.pickFiles(
                                type: FileType.custom,
                                allowMultiple: false,
                                withData: true,
                                allowedExtensions: ['csv']);

                            if (result!.files.first != null) {
                              fileBytes = result.files.first.bytes;
                              var fileName = result.files.first.name;
                              print(String.fromCharCodes(fileBytes!));

                              setState(() {
                                is_File_selected = true;
                                objFile = result.files.single;
                                logoBase64 = result.files.first.bytes;
                                print(result.files.first.name);
                              });
                            }
                          }
                        },
                      ),
                    ),
                  ),
                  is_File_selected
                      ? Text(
                          "Your Selected file for Star Ease Flat is : " +
                              Selected_from_date +
                              "_" +
                              Selected_to_date +
                              "_" +
                              str_Selected_region +
                              ".csv",
                          style: new TextStyle(
                            fontSize: Sub_font,
                            color: Color.fromARGB(255, 0, 0, 0),
                            fontWeight: FontWeight.w300,
                            // decoration: TextDecoration.underline
                          ),
                        )
                      : Container(),
                  SizedBox(
                    height: 50,
                  ),
                  Padding(
                    padding: EdgeInsets.fromLTRB(20, 20, 20, 20),
                    child: Material(
                      //Wrap with Material
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(22.0)),
                      elevation: 18.0,
                      color: Color.fromARGB(255, 0, 0, 0),
                      clipBehavior: Clip.antiAlias, // Add This
                      child: MaterialButton(
                        minWidth: 450.0,
                        height: 50,
                        color: Theme.of(context).primaryColor,
                        child: new Text('SUBMIT',
                            style: new TextStyle(
                                fontSize: Main_font, color: Colors.white)),
                        onPressed: () async {
                          if (is_File_selected) {
                            File_Upload_calling();
                          } else {
                            AwesomeDialog(
                                    // width: img_width,
                                    dismissOnTouchOutside: false,
                                    context: context,
                                    dialogType: DialogType.WARNING,
                                    animType: AnimType.TOPSLIDE,
                                    title: 'Please select a file for upload !',
                                    desc: '',
                                    btnOkColor: Theme.of(context).primaryColor,
                                    // btnCancelOnPress: () {},
                                    btnOkOnPress: () {})
                                .show();
                          }

                          //          setState(() {
                          //            _isNeedHelp = true;
                          //          });
                        },
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
      drawer: drower(),
    );
  }

  File_Upload_calling() async {
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

  File_Upload_call() async {
    // stop_Loding();
    // Navigator.push(
    //   context,
    //   MaterialPageRoute(builder: (context) => dashboard()),
    // ).then((value) {});
    // var postUri = Uri.parse(globals.str_URL+"upload_csv");
    var postUri = Uri.parse(
        globals.str_URL + "api/v1/mercedes-benz/service/star_ease_flat_view");
    var request = http.MultipartRequest("POST", postUri);
    request.fields['user'] = 'blah';
    request.files.add(http.MultipartFile.fromBytes('file', fileBytes,
        filename: Selected_from_date +
            "_" +
            Selected_to_date +
            "_" +
            str_Selected_region +
            ".csv",
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
