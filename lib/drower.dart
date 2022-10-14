import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:ldp/change_password.dart';
import 'package:ldp/dashboard.dart';
import 'package:ldp/service/uploads.dart';
import 'package:ldp/service/view_file_upload_history.dart';
import 'package:responsive_builder/responsive_builder.dart';

import 'package:flutter/foundation.dart' show kIsWeb;

import 'package:amazon_cognito_identity_dart_2/cognito.dart';
import 'globals.dart' as globals;

import 'dart:html' as html;

class drower extends StatefulWidget {
  const drower({Key? key}) : super(key: key);

  @override
  State<drower> createState() => _drowerState();
}

final userPool = CognitoUserPool(
  'ap-south-1_KOEA2NMTj',
  '2kcreqjc3tingbgkidknq1spte',
);

class _drowerState extends State<drower> {
  final cognitoUser = CognitoUser(globals.str_CognitoUser, userPool);

  @override
  Widget build(BuildContext context) {
    var deviceType = getDeviceType(MediaQuery.of(context).size);
    Size size = MediaQuery.of(context).size;
    double Screen_width = size.width > size.height ? size.height : size.width;

    double drower = 0;
    double white_bg_width = 0;
    double white_bg_height = 0;
    double drower_top_space = 0;

    switch (deviceType) {
      case DeviceScreenType.desktop:
        drower = 350;
        white_bg_width = 550;
        white_bg_height = 550;
        drower_top_space = 55;
        break;
      case DeviceScreenType.tablet:
        drower = 300;
        white_bg_width = 450;
        white_bg_height = 550;
        drower_top_space = 55;
        break;
      case DeviceScreenType.mobile:
        drower = Screen_width - 50;
        white_bg_width = 300;
        white_bg_height = 550;
        drower_top_space = 93;
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

    if (kIsWeb) {
      drower_top_space = 55;
    }
    return Padding(
      padding: EdgeInsets.fromLTRB(0, drower_top_space, 0, 0),
      child: Stack(
        children: [
          Container(
            height: size.height,
            width: drower,
            decoration: new BoxDecoration(
              image: DecorationImage(
                image: AssetImage("assets/img/menu_bg_4.jpg"),
                fit: BoxFit.fitHeight,
                // image: AssetImage("assets/img/main_bg.png"),
                // fit: BoxFit.fitHeight,

                // colorFilter: ColorFilter.mode(
                //     Colors.white.withOpacity(0.5), BlendMode.dstATop),
              ),

              // image: new DecorationImage(
              //     fit: BoxFit.cover,
              //     image: Image.asset('assets/img/1.png'),
              //     // image: new NetworkImage('http://3.110.226.63/lis_plus_2_0/public/assets/images/background-img.jpg')
              //         )
            ),
          ),
          SingleChildScrollView(
            child: Container(
              height: size.height + drower_top_space,
              width: drower,
              // color: Color.fromARGB(255, 255, 255, 255),
              // color: Color.fromARGB(103, 254, 254, 254),
              child: Column(
                children: [
                  SizedBox(
                    height: 60,
                    child: TextButton(
                      onPressed: () {
                        // Navigator.pop(context, true);
                        // Navigator.push(
                        //   context,
                        //   MaterialPageRoute(builder: (context) => dashboard()),
                        // ).then((value) {});

                        Navigator.pop(context, true);
                        Navigator.pushNamed(context, '/dashboard');
                      },
                      child: Row(
                        children: [
                          SizedBox(
                            width: 10.0,
                          ),
                          Icon(
                            Icons.dashboard_rounded,
                            color: Color.fromARGB(255, 0, 0, 0),
                          ),
                          SizedBox(
                            width: 5.0,
                          ),
                          Text(
                            'Dashboard',
                            style: new TextStyle(
                                fontSize: 15.0,
                                color: Color.fromARGB(255, 0, 0, 0),
                                fontWeight: FontWeight.w600),
                          ),
                        ],
                      ),
                    ),
                  ),
                  // ExpansionTile(
                  //   title: Row(
                  //     children: [
                  //       Icon(
                  //         Icons.account_tree_rounded,
                  //         color: Color.fromARGB(255, 0, 0, 0),
                  //       ),
                  //       SizedBox(
                  //         width: 5.0,
                  //       ),
                  //       Text(
                  //         'Pre Sales',
                  //         style: new TextStyle(
                  //             fontSize: 15.0,
                  //             color: Color.fromARGB(255, 0, 0, 0),
                  //             fontWeight: FontWeight.w600),
                  //       ),
                  //     ],
                  //   ),
                  //   // controlAffinity: ListTileControlAffinity.trailing,
                  //   // trailing: Spacer(),
                  //   subtitle: Text(
                  //     '     Pre-Sales controls',
                  //     style: new TextStyle(
                  //         fontSize: 12.0,
                  //         color: Color.fromARGB(255, 0, 0, 0),
                  //         fontWeight: FontWeight.w500),
                  //   ),

                  //   children: <Widget>[
                  //     ListTile(
                  //       title: TextButton(
                  //         onPressed: () {
                  //           Navigator.push(
                  //             context,
                  //             MaterialPageRoute(
                  //                 builder: (context) => dashboard()),
                  //           ).then((value) {});
                  //         },
                  //         child: Row(
                  //           children: [
                  //             SizedBox(
                  //               width: 5.0,
                  //             ),
                  //             Icon(Icons.dashboard_customize_outlined),
                  //             Text(
                  //               '  Dashboard',
                  //               style: TextStyle(
                  //                   fontSize: 12.0,
                  //                   color: Color.fromARGB(255, 0, 0, 0),
                  //                   fontWeight: FontWeight.w500),
                  //             ),
                  //           ],
                  //         ),
                  //         style: TextButton.styleFrom(
                  //           primary: Color.fromARGB(255, 3, 3, 3),
                  //           onSurface: Color.fromARGB(255, 255, 107, 107),
                  //           // backgroundColor: Color.fromARGB(255, 255, 255, 255),
                  //           // backgroundColor: Colors.amber,
                  //           // textStyle: const TextStyle(
                  //           //     fontSize: 24, fontStyle: FontStyle.italic)
                  //         ),
                  //       ),
                  //     ),
                  //     // ListTile(
                  //     //     title: Text(
                  //     //   '     Dashboard',
                  //     //   style: new TextStyle(
                  //     //       fontSize: 12.0,
                  //     //       color: Color.fromARGB(255, 0, 0, 0),
                  //     //       fontWeight: FontWeight.w600),
                  //     // )),
                  //     ListTile(
                  //       title: TextButton(
                  //         onPressed: () {
                  //           Navigator.push(
                  //             context,
                  //             MaterialPageRoute(
                  //                 builder: (context) => uploads()),
                  //           ).then((value) {});
                  //         },
                  //         child: Row(
                  //           children: [
                  //             SizedBox(
                  //               width: 5.0,
                  //             ),
                  //             Icon(Icons.new_label_outlined),
                  //             Text(
                  //               '  New Lead',
                  //               style: TextStyle(
                  //                   fontSize: 12.0,
                  //                   color: Color.fromARGB(255, 0, 0, 0),
                  //                   fontWeight: FontWeight.w500),
                  //             ),
                  //           ],
                  //         ),
                  //         style: TextButton.styleFrom(
                  //           primary: Color.fromARGB(255, 3, 3, 3),
                  //           onSurface: Color.fromARGB(255, 255, 107, 107),
                  //           // backgroundColor: Color.fromARGB(255, 255, 255, 255),
                  //           // backgroundColor: Colors.amber,
                  //           // textStyle: const TextStyle(
                  //           //     fontSize: 24, fontStyle: FontStyle.italic)
                  //         ),
                  //       ),
                  //     ),
                  //     // ListTile(
                  //     //     title: Text(
                  //     //   '     New Lead',
                  //     //   style: new TextStyle(
                  //     //       fontSize: 12.0,
                  //     //       color: Color.fromARGB(255, 0, 0, 0),
                  //     //       fontWeight: FontWeight.w600),
                  //     // )),
                  //     ListTile(
                  //       title: TextButton(
                  //         onPressed: () {
                  //           Navigator.push(
                  //             context,
                  //             MaterialPageRoute(
                  //                 builder: (context) => uploads()),
                  //           ).then((value) {});
                  //         },
                  //         child: Row(
                  //           children: [
                  //             SizedBox(
                  //               width: 5.0,
                  //             ),
                  //             Icon(Icons.message_outlined),
                  //             Text(
                  //               '  Follow-up',
                  //               style: TextStyle(
                  //                   fontSize: 12.0,
                  //                   color: Color.fromARGB(255, 0, 0, 0),
                  //                   fontWeight: FontWeight.w500),
                  //             ),
                  //           ],
                  //         ),
                  //         style: TextButton.styleFrom(
                  //           primary: Color.fromARGB(255, 3, 3, 3),
                  //           onSurface: Color.fromARGB(255, 255, 107, 107),
                  //           // backgroundColor: Color.fromARGB(255, 255, 255, 255),
                  //           // backgroundColor: Colors.amber,
                  //           // textStyle: const TextStyle(
                  //           //     fontSize: 24, fontStyle: FontStyle.italic)
                  //         ),
                  //       ),
                  //     ),
                  //     // ListTile(
                  //     //     title: Text(
                  //     //   '     Follow-up',
                  //     //   style: new TextStyle(
                  //     //       fontSize: 12.0,
                  //     //       color: Color.fromARGB(255, 0, 0, 0),
                  //     //       fontWeight: FontWeight.w600),
                  //     // )),

                  //     ListTile(
                  //       title: TextButton(
                  //         onPressed: () {
                  //           Navigator.push(
                  //             context,
                  //             MaterialPageRoute(
                  //                 builder: (context) => uploads()),
                  //           ).then((value) {});
                  //         },
                  //         child: Row(
                  //           children: [
                  //             SizedBox(
                  //               width: 5.0,
                  //             ),
                  //             Icon(Icons.drive_eta_outlined),
                  //             Text(
                  //               '  Generate - TD',
                  //               style: TextStyle(
                  //                   fontSize: 12.0,
                  //                   color: Color.fromARGB(255, 0, 0, 0),
                  //                   fontWeight: FontWeight.w500),
                  //             ),
                  //           ],
                  //         ),
                  //         style: TextButton.styleFrom(
                  //           primary: Color.fromARGB(255, 3, 3, 3),
                  //           onSurface: Color.fromARGB(255, 255, 107, 107),
                  //           // backgroundColor: Color.fromARGB(255, 255, 255, 255),
                  //           // backgroundColor: Colors.amber,
                  //           // textStyle: const TextStyle(
                  //           //     fontSize: 24, fontStyle: FontStyle.italic)
                  //         ),
                  //       ),
                  //     ),
                  //     // ListTile(
                  //     //     title: Text(
                  //     //   '     Generate - TD',
                  //     //   style: new TextStyle(
                  //     //       fontSize: 12.0,
                  //     //       color: Color.fromARGB(255, 0, 0, 0),
                  //     //       fontWeight: FontWeight.w600),
                  //     // )),
                  //   ],
                  // ),
                  // SizedBox(
                  //   height: 60,
                  //   child: TextButton(
                  //     onPressed: () {
                  //       Navigator.push(
                  //         context,
                  //         MaterialPageRoute(builder: (context) => dashboard()),
                  //       ).then((value) {});
                  //     },
                  //     child: Row(
                  //       children: [
                  //         SizedBox(
                  //           width: 10.0,
                  //         ),
                  //         Icon(
                  //           Icons.auto_graph_rounded,
                  //           color: Color.fromARGB(255, 0, 0, 0),
                  //         ),
                  //         SizedBox(
                  //           width: 5.0,
                  //         ),
                  //         Text(
                  //           'Sales',
                  //           style: new TextStyle(
                  //               fontSize: 15.0,
                  //               color: Color.fromARGB(255, 0, 0, 0),
                  //               fontWeight: FontWeight.w600),
                  //         ),
                  //       ],
                  //     ),
                  //   ),
                  // ),
                  ExpansionTile(
                    title: Row(
                      children: [
                        Icon(
                          Icons.car_repair_outlined,
                          color: Color.fromARGB(255, 0, 0, 0),
                        ),
                        SizedBox(
                          width: 5.0,
                        ),
                        Text(
                          'Service',
                          style: new TextStyle(
                              fontSize: 15.0,
                              color: Color.fromARGB(255, 0, 0, 0),
                              fontWeight: FontWeight.w600),
                        ),
                      ],
                    ),
                    subtitle: Text(
                      '    service control',
                      style: new TextStyle(
                          fontSize: 12.0,
                          color: Color.fromARGB(255, 0, 0, 0),
                          fontWeight: FontWeight.w500),
                    ),
                    children: <Widget>[
                      ListTile(
                        title: TextButton(
                          onPressed: () {
                            // Navigator.pop(context, true);
                            // Navigator.push(
                            //   context,
                            //   MaterialPageRoute(
                            //       builder: (context) => uploads()),
                            // ).then((value) {});

                            Navigator.pop(context, true);
                            Navigator.pushNamed(context, '/uploads');
                          },
                          child: Row(
                            children: [
                              SizedBox(
                                width: 5.0,
                              ),
                              Icon(Icons.upload),
                              Text(
                                '  Uploads',
                                style: TextStyle(
                                    fontSize: 12.0,
                                    color: Color.fromARGB(255, 0, 0, 0),
                                    fontWeight: FontWeight.w500),
                              ),
                            ],
                          ),
                          style: TextButton.styleFrom(
                            primary: Color.fromARGB(255, 3, 3, 3),
                            onSurface: Color.fromARGB(255, 255, 107, 107),
                            // backgroundColor: Color.fromARGB(255, 255, 255, 255),
                            // backgroundColor: Colors.amber,
                            // textStyle: const TextStyle(
                            //     fontSize: 24, fontStyle: FontStyle.italic)
                          ),
                        ),
                      ),
                      ListTile(
                        title: TextButton(
                          onPressed: () {
                            // Navigator.pop(context, true);
                            // Navigator.push(
                            //   context,
                            //   MaterialPageRoute(
                            //       builder: (context) =>
                            //           view_file_upload_history()),
                            // ).then((value) {});

                            Navigator.pop(context, true);
                            Navigator.pushNamed(
                                context, '/view_file_upload_history');
                          },
                          child: Row(
                            children: [
                              SizedBox(
                                width: 5.0,
                              ),
                              Icon(Icons.history_outlined),
                              Text(
                                '  Uploads History',
                                style: TextStyle(
                                    fontSize: 12.0,
                                    color: Color.fromARGB(255, 0, 0, 0),
                                    fontWeight: FontWeight.w500),
                              ),
                            ],
                          ),
                          style: TextButton.styleFrom(
                            primary: Color.fromARGB(255, 3, 3, 3),
                            onSurface: Color.fromARGB(255, 255, 107, 107),
                            // backgroundColor: Color.fromARGB(255, 255, 255, 255),
                            // backgroundColor: Colors.amber,
                            // textStyle: const TextStyle(
                            //     fontSize: 24, fontStyle: FontStyle.italic)
                          ),
                        ),
                      ),
                    ],
                  ),
                  // SizedBox(
                  //   height: 60,
                  //   child: TextButton(
                  //     onPressed: () {
                  //       Navigator.push(
                  //         context,
                  //         MaterialPageRoute(builder: (context) => dashboard()),
                  //       ).then((value) {});
                  //     },
                  //     child: Row(
                  //       children: [
                  //         SizedBox(
                  //           width: 10.0,
                  //         ),
                  //         Icon(
                  //           Icons.settings,
                  //           color: Color.fromARGB(255, 0, 0, 0),
                  //         ),
                  //         SizedBox(
                  //           width: 5.0,
                  //         ),
                  //         Text(
                  //           'Setting',
                  //           style: new TextStyle(
                  //               fontSize: 15.0,
                  //               color: Color.fromARGB(255, 0, 0, 0),
                  //               fontWeight: FontWeight.w600),
                  //         ),
                  //       ],
                  //     ),
                  //   ),
                  // ),
                  SizedBox(
                    height: 60,
                    child: TextButton(
                      onPressed: () async {
                        // await cognitoUser.signOut();

                        // Navigator.pushNamedAndRemoveUntil(
                        //     context, '/', (_) => false);

                        // Navigator.pop(context, true);
                        // Navigator.push(
                        //   context,
                        //   MaterialPageRoute(
                        //       builder: (context) => change_password()),
                        // ).then((value) {});

                        Navigator.pop(context, true);
                        Navigator.pushNamed(context, '/change_password');
                      },
                      child: Row(
                        children: [
                          SizedBox(
                            width: 10.0,
                          ),
                          Icon(
                            Icons.change_circle_outlined,
                            color: Color.fromARGB(255, 0, 0, 0),
                          ),
                          SizedBox(
                            width: 5.0,
                          ),
                          Text(
                            'Change Password',
                            style: new TextStyle(
                                fontSize: 15.0,
                                color: Color.fromARGB(255, 0, 0, 0),
                                fontWeight: FontWeight.w600),
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 60,
                    child: TextButton(
                      onPressed: () async {
                        await cognitoUser.signOut();

                        globals.str_token = "";

                        final text = globals.logger_file.toString();

// prepare
                        final bytes = utf8.encode(text);
                        final blob = html.Blob([bytes]);
                        final url = html.Url.createObjectUrlFromBlob(blob);
                        // final anchor = html.document.createElement('a')
                        //     as html.AnchorElement
                        //   ..href = url
                        //   ..style.display = 'none'
                        //   ..download = 'some_name.txt';
                        // html.document.body?.children.add(anchor);

// download
//                         anchor.click();

// // cleanup
//                         html.document.body?.children.remove(anchor);
//                         html.Url.revokeObjectUrl(url);

                        // html.AnchorElement(
                        //     href: "data:text/plain;charset=utf-8," +
                        //         globals.logger)
                        //   ..setAttribute("download", "logger.txt")
                        //   ..click();

                        globals.loggerfile.d("Logout succssful...");
                        print(globals.logger);
                        print("==================");

                        // print(globals.logger_file);

                        var blob1 =
                            html.Blob([globals.logger], 'text/plain', 'native');

                        // var anchorElement = html.AnchorElement(
                        //   href: html.Url.createObjectUrlFromBlob(blob1)
                        //       .toString(),
                        // )
                        //   ..setAttribute("download", "logger.txt")
                        //   ..click();

                        Navigator.pushNamedAndRemoveUntil(
                            context, '/', (_) => false);
                        // Navigator.push(
                        //   context,
                        //   MaterialPageRoute(builder: (context) => dashboard()),
                        // ).then((value) {});
                      },
                      child: Row(
                        children: [
                          SizedBox(
                            width: 10.0,
                          ),
                          Icon(
                            Icons.logout_outlined,
                            color: Color.fromARGB(255, 0, 0, 0),
                          ),
                          SizedBox(
                            width: 5.0,
                          ),
                          Text(
                            'Logout',
                            style: new TextStyle(
                                fontSize: 15.0,
                                color: Color.fromARGB(255, 0, 0, 0),
                                fontWeight: FontWeight.w600),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
